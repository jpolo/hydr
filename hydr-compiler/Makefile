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
DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SOURCE_DIR=src/main/ocaml
SOURCE_PROJECT=$(SOURCE_DIR)/$(NAME)
SOURCE_STD_DIR=src/main/hydr

TARGET_DIR=target
COMPILE_DIR=$(TARGET_DIR)/compile
DIST_DIR=$(TARGET_DIR)/dist
INSTALL_DIR=/usr
INSTALL_LIB_DIR=$(INSTALL_DIR)/lib/$(NAME)
INSTALL_BIN_DIR=$(INSTALL_DIR)/bin

export HYDR_HOME=$(realpath $(DIST_DIR))
export HYDR_DEBUG=1

#========================
#  User Configuration
#========================
NAME=hydr
EXEC=$(NAME)c

#========================
#  Rules
#========================
all: dist

dist: target_dir dependencies compile
	@cp -u $(COMPILE_DIR)/$(EXEC) $(DIST_DIR)/bin/$(EXEC)
	@cp -ru $(SOURCE_STD_DIR)/* $(DIST_DIR)/std

compile:
	@echo "Compiling $(NAME)..."
	@make -C $(SOURCE_DIR)/$(NAME) compile_compiler
	
dependencies:
	@echo "Compiling dependencies..."
	@make -sC $(SOURCE_DIR)/$(NAME) compile_libs

install:
	#create install lib & bin
	rm -rf $(INSTALL_LIB_DIR)
	mkdir -p $(INSTALL_LIB_DIR)/lib
	
	cp -r $(HYDR_STD_PATH) $(INSTALL_LIB_DIR)
	cp $(NAME) $(INSTALL_BIN_DIR)/$(NAME)
	#cp std/tools/haxelib/haxelib.sh $(INSTALL_BIN_DIR)/haxelib
	#cp std/tools/haxedoc/haxedoc.sh $(INSTALL_BIN_DIR)/haxedoc
	
	chmod 777 $(INSTALL_LIB_DIR)/lib
	chmod +x $(INSTALL_BIN_DIR)/$(NAME) $(INSTALL_BIN_DIR)/haxelib $(INSTALL_BIN_DIR))/haxedoc
	
uninstall:
	rm -rf $(INSTALL_BIN_DIR)/$(NAME) $(INSTALL_BIN_DIR)/haxelib $(INSTALL_BIN_DIR))/haxedoc $(INSTALL_LIB_DIR)/lib/$(NAME)
	
export:
	cp $(NAME)*.exe doc/CHANGES.txt $(EXPORT)
	rsync -a --exclude .svn --exclude *.n --exclude std/libs --delete std $(EXPORT)

test:
	@cp -ru $(SOURCE_STD_DIR)/* $(DIST_DIR)/std
	$(DIST_DIR)/bin/$(EXEC) project/compile_test.hyml

clean: clean_dependencies clean_compiler

clean_dependencies:
	make -C $(SOURCE_DIR)/extlib clean
	make -C $(SOURCE_DIR)/extc clean
	make -C $(SOURCE_DIR)/neko clean
	make -C $(SOURCE_DIR)/zip clean
	make -C $(SOURCE_DIR)/java clean
	make -C $(SOURCE_DIR)/swf clean
	make -C $(SOURCE_DIR)/xml-light clean

clean_compiler:
	make -C $(SOURCE_DIR)/$(NAME) clean
	@rm -f $(EXEC)
	@rm -rf $(COMPILE_DIR)
	
target_dir:
	@mkdir -p $(COMPILE_DIR)
	@rm -rf $(DIST_DIR)
	@mkdir -p $(DIST_DIR)
	@mkdir -p $(DIST_DIR)/bin
	@mkdir -p $(DIST_DIR)/std
	@mkdir -p $(DIST_DIR)/addons
