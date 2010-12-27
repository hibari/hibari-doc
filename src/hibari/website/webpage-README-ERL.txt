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

Erlang/OTP README Page
======================

This README is the first step to download, to build, and to install
your own Erlang/OTP system.

CAUTION: This information plus further detailed instructions has not
yet been added to link:hibari-developer-guide.en.html[Hibari
Developer's Guide].

TIP: Go back to the link:webpage-README.html[Hibari README] page.

== Erlang/OTP - To Download

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

3. Change to your working directory and then download Hibari's
   Erlang/OTP patches.

   $ mkdir -p ~/work/hibari
   $ cd ~/work/hibari
   $ git clone git://hibari.git.sourceforge.net/gitroot/hibari/patches

4. Download the source code for your erlang system
   http://www.erlang.org/download.html

   $ mkdir -p ~/work
   $ cd ~/work
   $ wget http://www.erlang.org/download/otp_src_R13B04.tar.gz

   NOTE: Hibari requires Erlang/OTP R13B01 or newer.  Hibari has been
   tested most recently with Erlang/OTP R13B04.  Support for
   Erlang/OTP R14A is planned.

5. Untar the source code for your erlang system and then apply
   Hibari's Erlang/OTP patches.

   $ cd ~/work
   $ tar -xzf otp_src_R13B04.tar.gz
   $ cd otp_src_R13B04
   $ chmod ug+w ./erts/emulator/beam/io.c
   $ for i in ../hibari/patches/*.patch ; do patch -p2 < $i; done
------

TIP: If you don't have Git installed, your firewall/proxy blocks the
Git protocol, or you simply prefer to download all of the Hibari Git
repositories at once, download the latest snapshot
_(hibari-snapshot.tar.gz)_ of Hibari's Git repositories from the
link:http://sourceforge.net/projects/hibari/files/[Files] page.

== Erlang/OTP - To Build

_basic recipe_

------
1. Change to your working directory and configure Erlang/OTP
   $ cd ~/work/otp_src_R13B04
   $ ./configure --prefix=/usr/local/hibari/ert/R13B04

2. Build Erlang/OTP
   $ cd ~/work/otp_src_R13B04
   $ make
------

== Erlang/OTP - To Install

_basic recipe_

------
1. Install Erlang/OTP
   $ cd ~/work/otp_src_R13B04
   $ sudo make install
------

NOTE: Please setup sudo access before attempting to install Erlang/OTP
(or login as root to install Erlang/OTP).

== Linux

=== Debian - Lenny

Depending on your needs, the following additional instructions for
Debian users may help with the setup of your environment *before*
building Erlang/OTP and/or Hibari.

-----
1. setup /etc/apt/sources.lists

  deb http://ftp.debian.org/debian/ unstable main
  deb-src http://ftp.debian.org/debian/ unstable main

2. Create /etc/apt/preferences with the following contents:

  Package: git-core
  Pin: release a=unstable
  Pin-Priority: 1002

  Package: git
  Pin: release a=unstable
  Pin-Priority: 1002

  Package: fop
  Pin: release a=unstable
  Pin-Priority: 1002

  Package: libbatik-java
  Pin: release a=unstable
  Pin-Priority: 1002

  Package: java-wrappers
  Pin: release a=unstable
  Pin-Priority: 1002

  Package: *
  Pin: release a=stable
  Pin-Priority: 1001

  Package: *
  Pin: release a=testing
  Pin-Priority: 60

  Package: *
  Pin: release a=unstable
  Pin-Priority: 50

3. Install additional stable packages

  apt-get install autoconf
  apt-get install g++
  apt-get install gawk
  apt-get install gcc
  apt-get install libncurses5-dev
  apt-get install libssl-dev
  apt-get install libtool
  apt-get install make
  apt-get install ncompress
  apt-get install openssl
  apt-get install unixodbc-dev

4. Install additional unstable packages

  apt-get -t testing install fop
  apt-get -t unstable install git-core
-----

NOTE: Please setup the appropriate source urls depending on your needs
and location.
