
##
## Copyright (c) 2005-2010 Gemini Mobile Technologies, Inc.  All rights reserved.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##

ASCIIDOC_PATH = ../../../make
include $(ASCIIDOC_PATH)/asciidoc.mk

all: html

html: public-html-hack

public-html-hack:
	mkdir -p ./public_html/images
	(cd ./public_html/images && ln -sf ../../images-other/*.svg ./)
	(cd ./public_html/images && ln -sf ../../images-other/*.png ./)
	(cd ./public_html && ln -sf ../misc-files ./)
	(cd ./public_html && ln -sf ../misc-codes ./)
	(cd ./public_html && ln -sf ../misc-screenshots ./)
