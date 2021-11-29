#!/usr/bin/env bash

############################################################
# Help                                                     #
############################################################
help() {
  # Display help
  echo "Generate an index page to be deployed into the ../dist directory"
  echo
  echo "Purpose: this script will fill in an environment variable which allows"
  echo "for the dynamic generation of an index.html page on github. It is not"
  echo "intended to be run manually but rather as a part of the build process."
  echo
  echo "Syntax: generate_index.sh [-r <user/repo string>]"
  echo "options:"
  echo "h     Print this Help."
  echo "r     Generate an index file for this repos gh-pages branch."
  echo
  echo "Example:"
  echo "./generate_index.sh -r username/repositoryname"
  echo
}

############################################################
# Process the input options. Add options as needed.        #
############################################################
# No arguments
if [[ $# -eq 0 ]]; then
  help
  exit 1
fi

# Parse arguments
while getopts ":hr:" option; do
  case $option in
  h) # display help
    help
    exit 1
    ;;
  r) # Enter a schema version
    repository=$OPTARG ;;
  \?) # Invalid option
    echo "Error: invalid argument"
    echo
    help
    exit 1
    ;;
  esac
done

export REPOSITORY=$repository
envsubst < index.tmpl > ../dist/index.html
cp pygment_trac.css > ../dist
cp style.css > ../dist
