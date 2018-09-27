#!/bin/bash
#
# Lints all files that have changed
# Author: Mike Moore
# https://blog.yo1.dog/linting-changed-files-only/
# 

# check if we are in a git repo
isInGitMsg="$(git rev-parse --is-inside-work-tree)"  
retval=$?

if [ "$isInGitMsg" != "true" ]  
then  
  echo -n "$isInGitMsg" >&2
  exit $retval
fi;

# get the files that we should lint
files="$(  
  {
    # NOTE: the file paths returned are relative to the git root despite the current working directory
    # list all files that have changed (but not staged)
    git diff --name-only --diff-filter=ACMRTUXB;

    # list all files that have changed (and staged)
    git diff --name-only --diff-filter=ACMRTUXB --cached;

    # list all untracked (new) files
    git ls-files --others --exclude-standard;
  } |
    # only lint files that end with .js
    grep '\.js$' |
    # remove duplicate files
    sort -u
)"

if [ -z "$files" ]  
then  
  echo "No files"
fi

# cd up to the git root
# example: if we are in {gitRoot}/fu/bar/ then cd ../../
cd "$(git rev-parse --show-cdup)"

# get the current working directory (now git root) absolute path
cwd="$(pwd)"

# escape sed special chars and add trailing slash
# we will use this with sed below
sedCWD="$(echo $cwd | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')\/"


# lint files
# this assumes you have a .eslintrc config file at the git root
# yarn run lint --config .eslintrc.json $files |  
yarn run eslint $files --fix |  
  # eslint displays the absolute path for each file which is annoying
  # lets trim that so they are relative to the git root
  sed "s/^$sedCWD//"

# use the return value of the eslint command (first command in the pipeline)
exit ${PIPESTATUS[0]}  