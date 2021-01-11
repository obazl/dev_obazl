# ns separator

These simple examples demonstrate that the standard ns separator,
double underscore `__`, is optional. The only requirement is that the
module name be legal. The [syntax](http://caml.inria.fr/pub/docs/manual-ocaml/names.html#module-name) is:

```
capitalized-ident	::=	 (A … Z) { letter ∣  0 … 9 ∣  _ ∣  ' }
```