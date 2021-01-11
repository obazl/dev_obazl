# flat namespaces

In these two examples, we have hierarchical OCaml namespaces
implemented in a flat filesystem namespace. That is, all
implementation files are in the same directory; the namespace
hierarchy is encoded in the file names.

## troubleshooting

**`Error: Unbound module`**

* Check the spelling of the file names, especially the underscores and capitalization.
* Check the spelling of the aliases in the files - if you rename a module, don't forget to rename it in alias expressions, as well as renaming its file.
* On the command line, dependencies must be listed in dependency-order.
  E.g. if Alpha.ml says `module Beta = Alpha__Beta`, then
  Alpha_Beta.cmo must precede Alpha.cmo in the command line.
