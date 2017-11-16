pgen - (Project Generator)
===========================

> Project generator to generate some files or directories
> used for Django project or Pypi project.


Install
---------

1. Clone or download this project.
2. Edit the `templates/` like `pypirc`, author of `LICENSE`, etc.
3. Edit `base_path` and `templates_path` inside `pgen.sh`.
4. Setup installation which following:

```
./pgen.sh -i

# or

./pgen.sh install
```


Usage
---------

```
$ pgen -h                   # print help
$ pgen help                 # or

$ pgen -p projectname       # create a django project with virtualenv
$ pgen project projectname  # or

$ pgen -l pluginname        # create a pypi project with virtualenv
$ pgen plugin pluginname    # or
```
