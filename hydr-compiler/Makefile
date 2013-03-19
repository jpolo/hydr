# Haxe compiler Makefile
#
#  - use 'make' to build all
#  - use 'make haxe' to build only the compiler (not the libraries)
#  - if you want to build quickly, install 'ocamlopt.opt' and change CAMLOPT=ocamlopt.top
#
#  Windows users :
#  - use 'make -f Makefile.win' to build for Windows
#  - use 'make MSVC=1 -f Makefile.win' to build for Windows with OCaml/MSVC
#

###  Boostrap (do not change)
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SOURCE_DIR=$(ROOT_DIR)/src/$(CONFIG)/ocaml
SOURCE_PROJECT=$(SOURCE_DIR)/$(NAME)

TARGET_DIR=$(ROOT_DIR)/target
COMPILE_DIR=$(TARGET_DIR)/compile
INSTALL_DIR=/usr

export HAXE_LIBRARY_PATH=$(ROOT_DIR)/std

#========================
#  User Configuration
#========================
NAME=hydr
CONFIG=main

#========================
#  Rules
#========================
all: compile

compile: compile_libs compile_compiler

compile_libs:
	make -C $(SOURCE_DIR)/$(NAME) compile_libs
	
compile_compiler:
	make -C $(SOURCE_DIR)/$(NAME) compile_compiler

install:
	cp haxe $(INSTALL_DIR)/bin/haxe
	rm -rf $(INSTALL_DIR)/lib/haxe
	mkdir $(INSTALL_DIR)/lib/haxe
	cp -r std $(INSTALL_DIR)/lib/haxe
	mkdir $(INSTALL_DIR)/lib/haxe/lib
	chmod 777 $(INSTALL_DIR)/lib/haxe/lib
	cp std/tools/haxelib/haxelib.sh $(INSTALL_DIR)/bin/haxelib
	cp std/tools/haxedoc/haxedoc.sh $(INSTALL_DIR)/bin/haxedoc
	chmod +x $(INSTALL_DIR)/bin/haxelib
	chmod +x $(INSTALL_DIR)/bin/haxedoc
	
uninstall:
	rm -rf $(INSTALL_DIR)/bin/haxe $(INSTALL_DIR)/bin/haxelib $(INSTALL_DIR)/lib/haxe
	
export:
	cp haxe*.exe doc/CHANGES.txt $(EXPORT)
	rsync -a --exclude .svn --exclude *.n --exclude std/libs --delete std $(EXPORT)

clean: clean_libs clean_compiler

clean_libs:
	make -C $(SOURCE_DIR)/extlib clean
	make -C $(SOURCE_DIR)/extc clean
	make -C $(SOURCE_DIR)/neko clean
	make -C $(SOURCE_DIR)/zip clean
	make -C $(SOURCE_DIR)/java clean
	make -C $(SOURCE_DIR)/swf clean
	make -C $(SOURCE_DIR)/xml-light clean

clean_compiler:
	make -C $(SOURCE_DIR)/hydr clean
	rm -f $(EXEC)
	rm -f $(EXEC).opt
	rm -rf $(COMPILE_DIR)
