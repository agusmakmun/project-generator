#!/bin/bash

args="$1";
name="$2";
base_path="/home/agaust/.pgen"
templates_path="/home/agaust/.pgen/templates"

# print help
if [[ $# -eq 0 ]] || [ $args == '-h' ] || [ $args == 'help' ]; then
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

# setup pgen as to terminal shortcut command
if [ $args == '-i' ] || [ $args == 'install' ]; then
  echo "installing pgen...";
  rsync -av --exclude='demo/' --exclude='.git/' . $base_path;
  echo "";
  echo "creating a bin..."
  sudo cp pgen.sh /bin/pgen;
  echo "pgen successfully installed..."
fi

# create a django project
if [ $args == "-p" ] || [ $args == "project" ]; then

  virtualenv --python=/usr/bin/python3 env-$name;
  cd env-$name && source bin/activate;

  pip install Django;
  django-admin startproject $name;

  cp $templates_path/gitignore $name/.gitignore;
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

  cp $templates_path/pypirc $name/.pypirc;
  cp $templates_path/gitignore $name/.gitignore;
  cp $templates_path/MANIFEST.in $name;
  cp $templates_path/LICENSE $name;
  cp $templates_path/push.sh $name;

  cd $name && git init . && echo $name > README.md;
  pip freeze > requirements.txt;
  echo '' > $name/__init__.py;
fi
