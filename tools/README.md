# tools

* Source `demos/tools/aliases`. This will give you an alias `bl` that
  will browse the command log.

* Copy `user.bazelrc` to `demos/.private`. It will be loaded by `.bazelrc`.
  Anything in `demos/.private` is private; do not put it under version control.

* If you are using `bazelisk` you can pin a particular version of
  Bazel by copying `bazelversion` to `demos/.bazelversion` and editing
  to taste.

* `demos/tools/wss` is a simple shell script that will print the
  `external` directory that Bazel uses to store external repositories.
