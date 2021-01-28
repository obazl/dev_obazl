# emulating namespaces with obazl

* case 0: demonstrates submodule interdependencies, sticky deps, mulitiple namespaces in on package.

* case 1: ns module generated, contains only alias equations. no resolver module needed

* case 2: ns module generated, with user-provided footer. no resolver needed

* case 3: user provides ns main module with same name as ns. must
  include pseudo-recursive alias equations. obazl will use the user
  file as main ns module. resolver module generated to resolve the
  pseudo-recursive equations.

* case 4: user provides ns main module with different name. obazl will copy the
  user-provided file to the ns name.  resolver module generated.

Cases 5-7: cross-package namespaces! a namespace can contain
  submodules in different packages. Note that in these cases we do not
  need ns-init, since we depend on modules from other packages (who
  have their own ns-init).

* case 5: generated ns module with submodules from case 1.

* case 6: generated ns module with user-supplied footer, with submodules from case 1.

* case 7: user-provided ns module, with submodules from case 1.

* case 8: nested/chained namespace modules

* degenerate case: package contains a module with same name as ns,
  but not included within the namespace. won't compile.