#! /bin/bash

set -e

if [ -z ${JEKYLL_ENV+x} ]
then 
  echo "JEKYLL_ENV is not set"
  exit 1;
else 
  echo "JEKYLL_ENV is set to $JEKYLL_ENV"
fi

function main {
	build
}

function build { 
	echo "building site"
	bundle exec jekyll build 
}

main