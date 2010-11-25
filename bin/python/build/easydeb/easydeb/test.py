import glob

versions= [re.sub('/usr/bin/python', '', v) for v in glob.glob('/usr/bin/python*')[1:]]

def f(a,d,f):
    print (d[2:])

os.path.walk('.', f ,'')

def test():
    i=0
    while True:
        yield i
        i+=1

exit

#import distutils.core
#d=distutils.core.run_setup("setup.py")
#d.metadata.get_fullname()

exit

import sys, os, glob, shutil
import pkg_resources
import easy_install
req = "setuptools>="+"0.6a0"
pkg_resources.require(req)

from setuptools.package_index import PackageIndex
from setuptools.command.easy_install import main
from setuptools.archive_util import unpack_archive

requirement=pkg_resources.Requirement.parse("graph")
index=PackageIndex()
index.find_packages(requirement)
found=None

for dist in index.package_pages.get(requirement.key, ()):
    if dist in requirement:
        found=dist
 
