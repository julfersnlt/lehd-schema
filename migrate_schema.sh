#!/usr/bin/env bash

public_schema_source_path=$1
git_schema_source_path=$2
schema_destination=./src

# clean initial directory
rm -r $schema_destination/*

git init
git add --all
git commit -m "initial commit" --quiet

for dir in ${public_schema_source_path}/*/; do
  schema_version="$(basename $dir)"

  # validate that the schema is in semver-ish form (e.g. v1.2 or V1.2.0)
  if ! [[ $schema_version =~ ^v[0-9]+\.[0-9]+ || $schema_version =~ ^V[0-9]+\.[0-9]+ ]]; then
    continue
  fi

  echo "Processing ${schema_version}..."

  # copy all the git schema files to the src directory, may not exist for some release candidates
  cp $git_schema_source_path/formats/$schema_version/* $schema_destination -r 2> /dev/null

  # copy all the public schema files to the src directory
  cp $dir/* $schema_destination -r

  # rm any binary zips
  rm $schema_destination/*.zip 2> /dev/null

  # rm any generated files
  rm $schema_destination/*.pdf 2> /dev/null
  rm $schema_destination/*.html 2> /dev/null

  # add to git
  git add --all
  git commit -m "migrate ${schema_version} schema files" --quiet

  # tag
  git tag -a ${schema_version} -m "${schema_version}"

  # clean
  rm -r $schema_destination/*
done

# reset the last set of schema files
git reset --hard HEAD
