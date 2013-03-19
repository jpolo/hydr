all:
	ocamlopt -I ../extlib -a -o neko.cmxa nast.ml nxml.ml binast.ml nbytecode.ml ncompile.ml

clean:
	rm -rf $(wildcard *.cmxa) $(wildcard *.cm[xi]) $(wildcard *.lib) $(wildcard *.a) $(wildcard *.obj) $(wildcard *.o)