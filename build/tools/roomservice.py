#!/usr/bin/env python
import os
import sys
import urllib2
import json
import re
import netrc, base64
from xml.etree import ElementTree

product = sys.argv[1];
local_manifests_dir = ".repo/local_manifests"
dependency_filename = 'ev.dependencies'
repositories = []
local_manifests = []

if len(sys.argv) > 2:
    depsonly = sys.argv[2]
else:
    depsonly = None

try:
    device = product[product.index("_") + 1:]
except:
    device = product

if not depsonly:
    print "Device %s not found. Attempting to retrieve device repository from Evervolv Github (http://github.com/Evervolv)." % device

try: # Convert from depreciated format
    if not os.path.isdir(local_manifests_dir):
        os.makedirs(local_manifests_dir)
    if os.path.exists(".repo/local_manifest.xml"):
        os.rename(".repo/local_manifest.xml", os.path.join(local_manifests_dir, "deprecated_manifest.xml"))
except OSError as e:
    print "Fatal: %s" % e
    sys.exit()

# list the currently existing manifests
local_manifests = os.listdir(local_manifests_dir)

try:
    authtuple = netrc.netrc().authenticators("api.github.com")

    if authtuple:
        githubauth = base64.encodestring('%s:%s' % (authtuple[0], authtuple[2])).replace('\n', '')
    else:
        githubauth = None
except:
    githubauth = None

def add_auth(githubreq):
    if githubauth:
        githubreq.add_header("Authorization","Basic %s" % githubauth)

page = 1
while not depsonly:
    githubreq = urllib2.Request("https://api.github.com/users/Evervolv/repos?per_page=100&page=%d" % page)
    add_auth(githubreq)
    result = json.loads(urllib2.urlopen(githubreq).read())
    if len(result) == 0:
        break
    for res in result:
        repositories.append(res)
    page = page + 1

def exists_in_tree(lm, repository):
    for child in lm.getchildren():
        if child.attrib['name'].endswith(repository):
            return True
    return False

# in-place prettyprint formatter
def indent(elem, level=0):
    i = "\n" + level*"  "
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + "  "
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
        for elem in elem:
            indent(elem, level+1)
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
    else:
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i

def get_from_manifest(devicename):
    for manifest in local_manifests:
        try:
            lm = ElementTree.parse(os.path.join(local_manifests_dir, manifest))
            lm = lm.getroot()
        except:
            lm = ElementTree.Element("manifest")

        for localpath in lm.findall("project"):
            if re.search("android_device_.*_%s$" % device, localpath.get("name")):
                return localpath.get("path")

    # Devices originally from AOSP are in the main manifest...
    try:
        mm = ElementTree.parse(".repo/manifest.xml")
        mm = mm.getroot()
    except:
        mm = ElementTree.Element("manifest")

    for localpath in mm.findall("project"):
        if re.search("android_device_.*_%s$" % device, localpath.get("name")):
            return localpath.get("path")

    return None

def is_in_manifest(projectname):
    for manifest in local_manifests:
        try:
            lm = ElementTree.parse(os.path.join(local_manifests_dir, manifest))
            lm = lm.getroot()
        except:
            lm = ElementTree.Element("manifest")

        for localpath in lm.findall("project"):
            if localpath.get("name") == projectname:
                return 1

    return None

def add_to_manifest(repositories):
    for repository in repositories:
        if 'dep_type' in repository:
            dep_manifest = os.path.join(local_manifests_dir, repository['dep_type'] + ".xml")
        else:
            print 'dep_type not found, assuming device tree, otherwise please update your ev.dependencies config'
            dep_manifest = os.path.join(local_manifests_dir, "device.xml")
        try:
            lm = ElementTree.parse(dep_manifest)
            lm = lm.getroot()
        except:
            lm = ElementTree.Element("manifest")

        repo_name = repository['repository']
        repo_target = repository['target_path']
        if exists_in_tree(lm, repo_name):
            print '%s already exists' % (repo_name)
            continue

        print 'Adding dependency: %s -> %s' % (repo_name, repo_target)
        project = ElementTree.Element("project", attrib = {
            "path": repo_target, "name": "%s" % repo_name
            })

        if 'branch' in repository:
            project.set('revision',repository['branch'])
        else:
            print("Using default branch for %s" % repo_name)

        lm.append(project)

        indent(lm, 0)
        raw_xml = ElementTree.tostring(lm)
        raw_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' + raw_xml

        f = open(dep_manifest, 'w')
        f.write(raw_xml)
        f.close()

def fetch_repos(repos):
    '''Adds repo to manifest and syncs'''

    fetch_list = []
    for r in repos:
        if not is_in_manifest('%s' % r.get('repository')):
            fetch_list.append(r)

    if fetch_list:
        add_to_manifest(fetch_list)
        repo_paths = ' '.join([ r.get('target_path') for r in fetch_list ])
        print 'Syncing', repo_paths
        os.system('repo sync --force-sync %s' % repo_paths)

def fetch_children(repos):
    '''Locate any device dependencies'''

    children = []
    for r in repos:
        if r.get('dep_type') == 'device':
            try:
                with open(os.path.join(r.get('target_path'),dependency_filename)) as f:
                    #print r.get('target_path')
                    children.extend(json.load(f))
            except IOError:
                continue
    fetch_repos(children)
    return children

def fetch_vendors(repo_path):
    '''Add the proper vendor dependency'''

    vendor = repo_path.split('/')[1]
    vendor_repos = [
        {
            'target_path': 'vendor/%s' % vendor,
            'repository' : 'android_vendor_%s' % vendor,
            'dep_type'   : 'vendor'
        },
    ]
    fetch_repos(vendor_repos)

def fetch_dependencies(repo_path):
    '''Add any and all dependencies found'''

    dependencies = []

    try:
        with open(os.path.join(repo_path,dependency_filename)) as f:
            dependencies = json.load(f)
    except IOError as e:
        print e

    # Fetch toplevel dependencies
    fetch_repos(dependencies)

    # Locate any extra dependencies
    children = dependencies
    while True:
        children = fetch_children(children)
        if not children:
            break

    # Fetch vendor dependencies
    fetch_vendors(repo_path)

if depsonly:
    repo_path = get_from_manifest(device)
    if repo_path:
        fetch_dependencies(repo_path)
    else:
        print "Trying dependencies-only mode on a non-existing device tree?"

    sys.exit()

else:
    for repository in repositories:
        repo_name = repository['name']
        if repo_name.startswith("android_device_") and repo_name.endswith("_" + device):
            print "Found repository: %s" % repository['name']
            manufacturer = repo_name.replace("android_device_", "").replace("_" + device, "")

            repo_path = "device/%s/%s" % (manufacturer, device)

            add_to_manifest([{'repository':repo_name,
                              'target_path':repo_path,
                              'dep_type':'device'}])

            print "Syncing repository to retrieve project."
            os.system('repo sync --force-sync %s' % repo_path)
            print "Repository synced!"

            fetch_dependencies(repo_path)
            print "Done"
            sys.exit()

print "Repository for %s not found in the Evervolv Github repository list. If this is in error, you may need to manually add it to your local_manifests." % device
