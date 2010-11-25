from setuptools import setup, find_packages
from easydeb import version as VERSION
setup(
    name = "easydeb",
    version = VERSION,
    packages = find_packages(exclude=['bin']),  
    scripts = ['bin/easy-deb','bin/update-pypi'],
    package_data = {
        'easydeb': ['template/copy/*', 'template/*.template'],
	},
    install_requires = ["setuptools >= 0.6a0"],
    author = "Vincenzo Di Massa",
    author_email = "hawk.it@tiscali.it",
    description = "Tool for automatically creating python modules packages", 
    license = "GPL",
    keywords = "python, ubuntu, debian, package, distribute",
    url = "http://easy-deb.sf.net",
    long_description = """ ==========
=easy-deb=
==========

FEATURES
========

    * Packages python modules
        * from source distribution files
        * from urls
        * from PyPI records
    * handles dependencies
    * intstalls modules into eggs (from setuptools)
    * can activate or deactivate an installed egg (add or remove from sys.path)
    * handles a database of dependencies

=======================
=easy_deb instructions=
=======================

SYNOPSIS
========
    easy-deb:
    ^^^^^^^^^^
    Type
    $ easy-deb -h
    for usage and options synopsis:
  
        usage: easy-deb [options] (pypi-modulename | archive-file-name| url)

        options:
          -h, --help            show this help message and exit
          -v VERSIONS, --python-versions=VERSIONS
                                Coma separated list of python versions to package for.
                                E.g.: -v 2.3,2.4
          -d DEPS, --debian-deps=DEPS
                                Standard debian dependency string. %v is replaced with
                                python version
          -b BDEPS, --debian-build-deps=BDEPS
                                Standard debian dependency string. %v is replaced with
                                python version
          -f FIND_LINKS, --find-links=FIND_LINKS
                                Additionnal links to scan
          -D DEST_DIR, --dest-dir=DEST_DIR
                                Distribution downloaded into file
          -c, --common-dir      Install to commond dir from where tree linking is done
          -a, --arch-dep        Build arch dep packages
          -u, --update-database
                                Update the database of python modules options
    update-pypi:
    ^^^^^^^^^^^^^
    Type
    $ update-pypi -h
    for usage and options synopsis:
        
        usage: update-pypi [options] (module-name | show | update)

        options:
          -h, --help    show this help message and exit
          -a, --add     Add egg to sys.path
          -r, --remove  Add egg to sys.path
  
USAGE
=====
    easy-deb: this tool will create a debian source package into a
    deb-pkg-<modulename> directory.
    To compile the source package use the standard debian tools (debuild or
    "fakeroot debian/rules binary")

    update-pypi: this script is used to enable and disable installed egg (you can
    enable/disable all eggs
    ing the removing the All package). Enabled eggs are on sys.path, disabled eggs
    must be pkg_resource.require() before you can import from them.

EXAMPLE
=======
    To install module "graph":

    $ easy-deb -v2.4 graph -D /tmp/
    $ cd /tmp/deb-pkg-graph0.4/graph-0.4
    $ fakeroot debian/rules binary
    $ sudo dpkg -i ../*.deb

    $ update-pypi -a graph

""",
    
)
