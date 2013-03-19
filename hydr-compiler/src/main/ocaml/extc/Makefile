CFLAGS = -I zlib
LIBS = -I ../extlib

all: bytecode native

bytecode: extc_stubs.obj
	ocamlc -a -o extc.cma $(LIBS) extc.ml

native: extc_stubs.obj
	ocamlopt -a -o extc.cmxa $(LIBS) extc.ml

extc_stubs.obj: extc_stubs.c
	ocamlc $(CFLAGS) extc_stubs.c

clean:
	rm -f $(wildcard *.cmo) $(wildcard *.cmx) $(wildcard *.o) $(wildcard *.cmi) $(wildcard *.cma) $(wildcard *.cmxa) $(wildcard *.a) $(wildcard *.lib) $(wildcard *.obj)
