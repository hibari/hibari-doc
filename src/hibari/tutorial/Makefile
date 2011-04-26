
ASCIIDOC_PATH = ../../../make
include $(ASCIIDOC_PATH)/asciidoc.mk

all: html slidy

html: public-html-hack

public-html-hack:
	mkdir -p ./public_html/images
	(cd ./public_html && ln -sf ../misc-codes ./)

##
## TODO: Update ascidoc setup instructions to include the
## sourcecode-highlight (http://www.gnu.org/software/src-highlite/) package
##
slidy: html ./public_html/hibari-tutorial.en.html ./public_html/hibari-tutorial.ja.html ./public_html/ubf-tutorial.en.html

./public_html/hibari-tutorial.en.html: public-html-hack hibari-tutorial.en.txt
	cp -f hibari-tutorial.en.txt ./public_html/hibari-tutorial.en.txt
	(cd public_html && asciidoc --backend slidy hibari-tutorial.en.txt)

./public_html/hibari-tutorial.en.html: public-html-hack hibari-tutorial.ja.txt
	cp -f hibari-tutorial.ja.txt ./public_html/hibari-tutorial.ja.txt
	(cd public_html && asciidoc --backend slidy hibari-tutorial.ja.txt)

./public_html/ubf-tutorial.en.html: public-html-hack ubf-tutorial.en.txt
	cp -f ubf-tutorial.en.txt ./public_html/ubf-tutorial.en.txt
	(cd public_html && asciidoc --backend slidy ubf-tutorial.en.txt)
