// -*- Doc -*-
// vim: set syntax=asciidoc:

//
// Copyright (c) 2005-2010 Gemini Mobile Technologies, Inc.  All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

Hibari README Page
==================

Hibari is a distributed, high availability key-value data store that
focuses on the "C"onsistency and "A"vailability aspects of Brewer's
CAP Theorem.

This README is the first step to download, to build, and to install
Hibari. Read the link:webpage-CHANGELOG.html[CHANGELOG] page for a
full list of additions, changes, and bug fixes.

CAUTION: This information plus further detailed instructions has not
yet been added to link:hibari-developer-guide.en.html[Hibari
Developer's Guide].

TIP: Go back to the link:http://hibari.sourceforge.net/[Home] page,
the link:webpage-FAQ.html[FAQ] page, the
link:http://sourceforge.net/projects/hibari/[Project] page, or the
link:http://sourceforge.net/projects/hibari/support[Support] page.

== Hibari - To Download

_basic recipe_

------

1. Get, setup, and install a Linux environment.  If not already,
   please make sure to have the 'openssl-devel' package installed on
   your linux system.  OpenSSL is required by Hibari (and before
   configure and build of your erlang system).

   NOTE: Hibari has been developed and tested primarily on RedHat,
   CentOS, and Fedora Linux distributions.  Hibari has been tested
   most recently with "Red Hat Enterprise Linux Server release 5.3".

   NOTE: Hibari should port easily to other Linux distributions.
   Support for the MacXOS and FreeBSD operation systems is planned.

   NOTE: "yum install openssl-devel" will work on most RedHat, CentOS,
   and Fedora Linux systems.

2. Get and install Git
   http://git-scm.com/

   NOTE: Hibari requires git version 1.7.x or newer.  Hibari has been
   tested most recently with git version 1.7.1.1.

3. Download the 'bom.sh' tool and then download Hibari

    $ mkdir -p ~/work/hibari
    $ cd ~/work/hibari
    $ git clone git://hibari.git.sourceforge.net/gitroot/hibari/bom .
    $ env BOM_GIT=git://hibari.git.sourceforge.net/gitroot/hibari/ \
      ./bom.sh co src/top/hibari/GDSS

  NOTE: The Bill of Materials (BOM) system is a way to manage the
  builds of heterougeneous products with shared components using GIT,
  GIT-SVN, SVN, or CVS.  BOM maintains hierarchical dependencies
  between modules stored in a source code repository.  BOM is
  implemented using bash, make, and other UNIX tools.

  NOTE: The bom.sh commands 'diff' and 'status' can be used to check
  the differences and status of all components, respectively.  Type
  './bom.sh help' for further information.

  NOTE: The BOM system was originally developed by Gemini Mobile
  Technologies as an in-house tool to build and to package it's own
  commercial products.  BOM as been open-sourced as one of the helper
  tools for Hibari.
------

TIP: If you don't have Git installed, your firewall/proxy blocks the
Git protocol, or you simply prefer to download all of the Hibari Git
repositories at once, download the latest snapshot
_(hibari-snapshot.tar.gz)_ of Hibari's Git repositories from the
link:http://sourceforge.net/projects/hibari/files/[Files] page.

== Hibari - To Build

_basic recipe_

------
1. Get and install an erlang system
   http://www.erlang.org

   NOTE: Hibari requires Erlang/OTP R13B01 or newer.  Hibari has been
   tested most recently with Erlang/OTP R13B04.  Support for
   Erlang/OTP R14A is planned.

   NOTE: Patching your erlang system is _STRONGLY_ recommended.
   Hibari's Erlang/OTP patches are mirrored on SourceForge
   (git://hibari.git.sourceforge.net/gitroot/hibari/patches).

2. Change to your working directory and create the toplevel Makefile
   $ cd ~/work/hibari
   $ ./bom.sh make

3. Build Hibari
   $ make ERL=/usr/local/hibari/ert/R13B04/bin/erl
     OR
   $ make ERL=/usr/local/hibari/ert/R13B04/bin/erl DEBUG="+debug_info"

   NOTE: Please specify the path to your erlang system's erl
   executable.

   NOTE: DEBUG="+debug_info" will produce DEBUG enabled beam files.

4. Run the unit tests
   $ make ERL=/usr/local/hibari/ert/R13B04/bin/erl test
------

TIP: If you need help to download, to build, and to install your
erlang system, please see the link:webpage-README-ERL.html[Erlang/OTP
README] page for information.

== Hibari - To Build

_optional features_

------
A. Run unit test for one module.

   $ make ERL=/usr/local/hibari/ert/R13B04/bin/erl \
     DEBUG="+debug_info" \
     -C src/erl-apps/gdss__HEAD/src check

B. Clean one module

   $ make ERL=/usr/local/hibari/ert/R13B04/bin/erl \
     DEBUG="+debug_info" \
     -C src/erl-apps/gdss__HEAD/src clean

C. Rebuild one module

   $ make ERL=/usr/local/hibari/ert/R13B04/bin/erl \
     DEBUG="+debug_info" \
     -C src/erl-apps/gdss__HEAD/src

D. Generate EDocs for one module

   $ make ERL=/usr/local/hibari/ert/R13B04/bin/erl \
     DEBUG="+debug_info" \
     -C src/erl-apps/gdss__HEAD/src edoc

E. Run dialyzer for one module (and it dependencies)

   $ make ERL=/usr/local/hibari/ert/R13B04/bin/erl \
     DEBUG="+debug_info" \
     -C src/erl-apps/gdss__HEAD/src run-dialyzer

   NOTE: Dialyzer will not work unless all beam files have been
   compiled with debug information.
------


== Hibari - To Install

_basic recipe_

------
1. If not already, please make sure to have the UNIX 'compress' tool
   installed on your linux system.  The 'compress' tool is required by
   Hibari's installer.

   NOTE: "yum install compress" will work on most RedHat, CentOS,
   and Fedora Linux systems.

2. Change to your working directory and then the pkg directory
   $ cd ~/work/hibari
   $ cd ./pkg

3. Review and modify necessary installation defaults.
   $ vi gifCustom.gdss.cfg
   $ vi gifDefaults.gdss.cfg

   NOTE: Unless your erlang system is already installed under
   /usr/local/hibari/ert/R13B04, a change to the 'gERLANG_TOP_DIR'
   setting in the gifCustom.gdss.cfg file is required.

   NOTE: By default, the installer will create a new user named
   'hibari' and install Hibari under the /usr/local/hibari/gdss
   directory.  The installer will add the init script /etc/init.d/gdss
   and will setup cronjobs to rotate Hibari's log files.

3. Install Hibari
   $ sudo ./installer-gdss.sh -o silent

4. Start Hibari and provision a standalone server
   $ sudo /etc/init.d/gdss start
   $ sudo /etc/init.d/gdss provision-standalone

   NOTE: Open Hibari's web admin page in your favorite browser
   (http://localhost:23080/)
------

NOTE: Please setup sudo access before attempting to install Hibari (or
login as root to install Hibari).

Please check the link:hibari-sysadmin-guide.en.html[Hibari System
Administrator's Guide] for further information.
