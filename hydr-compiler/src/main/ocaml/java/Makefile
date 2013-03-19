all:
	ocamlopt -g -I ../extlib -a -o java.cmxa jData.mli jReader.ml
	
clean:
	rm -rf $(wildcard *.cmxa) $(wildcard *.cm[xio]) $(wildcard *.lib) $(wildcard *.a) $(wildcard *.obj) $(wildcard *.o)