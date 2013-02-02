
# How to Build Hibari Doc

ADOC is a documentation environment using AsciiDoc as core component.
ADOC makes it easy to construct AsciiDoc documentation system.
ADOC can make single HTML, chunked HTML, PDF from one plain text data.
ADOC supports English and Japanese.

See http://www.methods.co.nz/asciidoc/ for further details.


## Install ADOC environment

### Linux - Ubuntu 12.10

1. install git deb package

```shell-script
$ sudo apt-get install git-core
```

2. install the following deb packages for ADOC

```shell-script
$ sudo apt-get install imagemagick asciidoc dia graphviz mscgen dblatex w3m
```


### Linux - Fedora 17

1. install git rpm package

```shell-script
$ sudo yum install git
```

2. install the following rpm packages for ADOC

```shell-script
$ sudo yum install ImageMagick asciidoc dia graphviz mscgen dblatex w3m
```


### Mac OS X - 10.8

Note:
As of Feb 2013, installing dia with this recipe is not likely to succeed.

1. install brew (http://mxcl.github.com/homebrew/)
2. install git brew package

```shell-script
$ brew install git
```

3. install the following brew packages for ADOC

```shell-script
$ brew install imagemagick asciidoc graphviz mscgen w3m
$ curl -O https://raw.github.com/mxcl/homebrew/a2d4d9d832/Library/Formula/dia.rb
$ mv dia.rb /usr/local/Library/Formula
$ brew install dia
```


## Download Hibari's documentation repository

```shell-script
$ git clone git://github.com/hibari/hibari-doc.git
```


## Build Hibari's documentation guides

```shell-script
$ cd hibari-doc/src/hibari
$ make clean -OR- make realclean
$ make
```

HTML documentation is written in the `./public_html` directory.


## Build Hibari's website pages

```shell-script
$ cd hibari-doc/src/hibari/website
$ make clean -OR- make realclean
$ make
```

HTML documentation is written in the `./public_html` directory.


## NOTES

The above recipe was tested on the following platforms:

- Ubuntu 12.10 using asciidoc 8.6.7
- Fedora 17 using asciidoc 8.4.5


### lang-ja.conf

A fake `lang-ja.conf` file will be needed to compile the
Japanese(ja) documents.

```shell-script
$ cd /etc/asciidoc/
$ sudo ln -s lang-en.conf lang-ja.conf
```

### a2x throws an exception

- If a2x throws an exception on `shell_copy`, apply the following
  patch. (Tested on Mac OS X 10.6.7 using asciidoc 8.6.4)

```python
diff -r -u 8.6.4-orig/bin/a2x.py 8.6.4/bin/a2x.py
--- 8.6.4-orig/bin/a2x.py	2011-04-24 00:50:26.000000000 +0900
+++ 8.6.4/bin/a2x.py	2011-04-24 00:35:55.000000000 +0900
@@ -156,7 +156,10 @@
 def shell_copy(src, dst):
     verbose('copying "%s" to "%s"' % (src,dst))
     if not OPTIONS.dry_run:
-        shutil.copy(src, dst)
+        try:
+            shutil.copy(src, dst)
+        except shutil.Error:
+            return

 def shell_rm(path):
     if not os.path.exists(path):
Only in 8.6.4/etc/asciidoc: lang-ja.conf
```
