all: Amod00Bmod00Hello.cmo
	ocamlc *.cmo Driver.ml -o Driver.exe

Amod.cmo:
	ocamlc -w -49 -c -no-alias-deps Amod.ml

Amod00Bmod.cmo: Amod.cmo
	ocamlc -w -49 -c -no-alias-deps Amod00Bmod.ml

Amod00Bmod00Hello.cmo: Amod00Bmod.cmo
	ocamlc -c -no-alias-deps Amod00Bmod00Hello.ml

clean:
	rm *.cmo;
	rm *.cmi;
	rm *.exe;
