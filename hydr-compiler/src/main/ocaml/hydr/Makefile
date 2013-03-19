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
SOURCE_DIR=$(shell dirname $(DIR))
SOURCE_PROJECT_DIR=$(DIR)
ROOT_DIR=$(realpath $(SOURCE_DIR)/../../..)
TARGET_DIR=$(ROOT_DIR)/target

COMPILE_DIR=$(TARGET_DIR)/compile
INSTALL_DIR=/usr

#========================
#  User Configuration
#========================
NAME=hydr
CONFIG=main
SOURCES=ast.ml lexer.mll type.ml common.ml genxml.ml parser.ml typecore.ml optimizer.ml typeload.ml codegen.ml \
	gencommon.ml genas3.ml gencpp.ml genjs.ml genneko.ml genphp.ml genswf8.ml genswf9.ml genswf.ml genjava.ml gencs.ml \
	interp.ml typer.ml matcher.ml dce.ml main.ml
EXEC=$(NAME)

#========================
#  User Compiler & Tools
#========================
CAMLC=ocamlc
CAMLOPT=ocamlopt
CAMLDEP=ocamldep
CAMLLEX=ocamllex
CAMLYACC=ocamlyacc
CAML4O=camlp4o

#========================
#  User Libs
#========================
CUSTOM=-custom
LIBS=$(WITHSTR) $(WITHUNIX) $(WITHADDONS) $(WITHNATIVE)

WITHSTR =str.cma
WITHUNIX=unix.cma
WITHADDONS=$(SOURCE_DIR)/extlib/extLib.cmxa $(SOURCE_DIR)/xml-light/xml-light.cmxa $(SOURCE_DIR)/swf/swf.cmxa \
	$(SOURCE_DIR)/extc/extc.cmxa $(SOURCE_DIR)/neko/neko.cmxa $(SOURCE_DIR)/java/java.cmxa $(SOURCE_DIR)/zip/zip.cmxa
WITHNATIVE=-cclib $(SOURCE_DIR)/extc/extc_stubs.o -cclib -lz

###  Compiler & Tools
PP=-pp $(CAML4O)
INCLUDES=-I $(SOURCE_DIR)/extc -I $(SOURCE_DIR)/extlib \
  -I $(SOURCE_DIR)/swf -I $(SOURCE_DIR)/neko -I $(SOURCE_DIR)/zip \
  -I $(SOURCE_DIR)/xml-light -I $(SOURCE_DIR)/java \
  -I $(COMPILE_DIR)
CAMLCFLAGS=
CAMLOPTFLAGS=$(PP) $(INCLUDES) -g

SOURCES1=$(SOURCES:.mly=.ml)
SOURCES2=$(SOURCES1:.mll=.ml)
OBJS=$(SOURCES2:.ml=.cmo)
OBJS_OPT=$(SOURCES2:.ml=.cmx)

CC=$(CAMLC) $(CAMLCFLAGS)
CCOPT=$(CAMLOPT) $(CAMLOPTFLAGS)
EXTENSION=

#========================
#  Rules
#========================
all: compile

compile: compile_libs compile_compiler

$(EXEC): $(OBJS)
	$(CC) $(CUSTOM) -o $(EXEC) $(LIBS) $(OBJS)

$(EXEC).opt: compile_dir $(OBJS_OPT)
	$(CCOPT) -o $(TARGET_DIR)/$(EXEC) $(LIBS:.cma=.cmxa) $(OBJS_OPT)
	
compile_dir:
	@mkdir -p $(COMPILE_DIR)

compile_libs:
	make -C $(SOURCE_DIR)/extlib opt
	make -C $(SOURCE_DIR)/extc native
	make -C $(SOURCE_DIR)/neko
	make -C $(SOURCE_DIR)/java
	make -C $(SOURCE_DIR)/zip
	make -C $(SOURCE_DIR)/swf
	make -C $(SOURCE_DIR)/xml-light xml-light.cmxa
	
compile_compiler: $(EXEC).opt

# SUFFIXES
.PHONY: compile

.SUFFIXES: .ml .mli .cmo .cmi .cmx .mll .mly

.ml.cmo:
	$(CC) -c $<

.mli.cmi:
	$(CC) -c $<

.ml.cmx:
	$(CCOPT) -c $<

.mll.cmo:
	$(CAMLLEX) $<
	$(CC) -c $*.ml

.mll.cmx:
	$(CAMLLEX) $<
	$(CCOPT) -c $*.ml

.mly.cmo:
	$(CAMLYACC) $<
	$(CC) -c $*.mli
	$(CC) -c $*.ml

.mly.cmx:
	$(CAMLYACC) $<
	$(CCOPT) -c $*.mli
	$(CCOPT) -c $*.ml

.mly.cmi:
	$(CAMLYACC) $<
	$(CC) -c $*.mli

.mll.ml:
	$(CAMLLEX) $<

.mly.ml:
	$(CAMLYACC) $<

clean:
	rm -f *.cm[iox] *.o *~ .*~ #*# 
	rm -f lexer.ml

dependencies: 
	$(CAMLDEP) $(PP) *.ml *.ml[il] > $(COMPILE_DIR)/dependencies

include Dependencies
