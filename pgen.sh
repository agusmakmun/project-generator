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

# install pgen as to terminal shortcut command
if [ $args == '-i' ] || [ $args == 'install' ]; then
  echo "[i] installing pgen...";
  rsync -av --exclude='demo/' --exclude='.git/' . $base_path;
  echo "";
  echo "[+] creating a bin..."
  sudo cp pgen.sh /bin/pgen;
  echo "[i] pgen successfully installed..."
fi

# create a django project
if [ $args == "-p" ] || [ $args == "project" ]; then

  echo "[+] creating env-$name";
  virtualenv --python=/usr/bin/python3 env-$name;
  cd env-$name && source bin/activate;

  pip install Django;
  django-admin startproject $name;

  echo "[+] creating templates/base.html";
  mkdir -p $name/templates/;
  touch $name/templates/base.html;

  echo "[+] creating staticfiles..."
  mkdir -p $name/static/css/;
  touch $name/static/css/style.css;

  echo "[+] collecting the latest jquery..."
  mkdir -p $name/static/js/;
  wget -O $name/static/js/jquery.min.js http://code.jquery.com/jquery-latest.min.js;

  echo "[+] creating files for .gitignore, LICENSE, push.sh"
  cp $templates_path/gitignore $name/.gitignore;
  cp $templates_path/LICENSE $name;
  cp $templates_path/push.sh $name;

  echo "[+] creating initial .git, README.md, and requirements.txt"
  cd $name && git init . && echo $name > README.md;
  pip freeze > requirements.txt;

  echo "[i] successfully created django project in 'env-$name'";
fi

# create a django plugin
if [ $args == "-l" ] || [ $args == "plugin" ]; then

  echo "[+] creating env-$name";
  virtualenv --python=/usr/bin/python3 env-$name;
  cd env-$name && source bin/activate;

  echo "[+] creating the project name for $name";
  mkdir -p $name/$name;

  echo "[+] creating files for .pypirc, .gitignore, MANIFEST.in, LICENSE, push.sh";
  cp $templates_path/pypirc $name/.pypirc;
  cp $templates_path/gitignore $name/.gitignore;
  cp $templates_path/MANIFEST.in $name;
  cp $templates_path/LICENSE $name;
  cp $templates_path/push.sh $name;

  echo "[+] creating initial .git, README.md, and requirements.txt"
  cd $name && git init . && echo $name > README.md;
  pip freeze > requirements.txt;
  touch $name/__init__.py;

  echo "[i] successfully created pypi project in 'env-$name'";
fi
