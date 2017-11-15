#!/bin/bash

args="$1";
name="$2";
templates_path="/home/agaust/.pgen/templates"

# print help if whithout arguments
if [[ $# -eq 0 ]] ; then
  echo "
  >_ pgen (Project Generator)

  $ pgen.sh <type> <project_name>

  * create a django project
  $ pgen.sh -p myjangoproject
  $ pgen.sh project mydjangoproject

  * create a python plugin
  $ pgen.sh -l myplugin
  $ pgen.sh plugin myplugin
  ";
  exit 1
fi

# create a django project
if [ $args == "-p" ] || [ $args == "project" ]; then

  virtualenv --python=/usr/bin/python3 env-$name;
  cd env-$name && source bin/activate;

  pip install Django;
  django-admin startproject $name;

  cp $templates_path/.gitignore $name;
  cp $templates_path/LICENSE $name;
  cp $templates_path/push.sh $name;

  cd $name && git init . && echo $name > README.md;
  pip freeze > requirements.txt
fi

# create a django plugin
if [ $args == "-l" ] || [ $args == "plugin" ]; then

  virtualenv --python=/usr/bin/python3 env-$name;
  cd env-$name && source bin/activate;
  mkdir -p $name/$name;

  cp $templates_path/.pypirc $name;
  cp $templates_path/.gitignore $name;
  cp $templates_path/MANIFEST.in $name;
  cp $templates_path/LICENSE $name;
  cp $templates_path/push.sh $name;

  cd $name && git init . && echo $name > README.md;
  pip freeze > requirements.txt;
  echo '' > $name/__init__.py;
fi
