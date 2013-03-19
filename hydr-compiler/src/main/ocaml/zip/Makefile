all:
	ocamlopt -g -I ../extlib -I ../extc -a -o zip.cmxa zlib.mli zlib.ml zip.mli zip.ml
	
clean:
	rm -f $(wildcard *.cmo) $(wildcard *.cmx) $(wildcard *.o) $(wildcard *.cmi) $(wildcard *.cma) $(wildcard *.cmxa) $(wildcard *.a) $(wildcard *.lib) $(wildcard *.obj)