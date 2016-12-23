#! /bin/bash

set -e

if [ -z ${DEPLOY_REPO+x} ]
then 
  DEPLOY_REPO=`git config --get remote.origin.url`
  echo "DEPLOY_REPO is not set, using available remote url $DEPLOY_REPO"
else 
  echo "DEPLOY_REPO is set to $DEPLOY_REPO"
fi

if [ -z ${DEPLOY_BRANCH+x} ]
then 
  DEPLOY_BRANCH="gh-pages"
  echo "DEPLOY_BRANCH is not set, using default $DEPLOY_BRANCH" 
else 
  echo "DEPLOY_BRANCH is set to $DEPLOY_BRANCH"
fi

if [ -z ${BUILD_TARGET+x} ]
then
  BUILD_TARGET="_site" 
  echo "BUILD_TARGET is not set, using default $BUILD_TARGET" 
else 
  echo "BUILD_TARGET is set to $BUILD_TARGET"
fi

if [ -z ${GH_TOKEN+x} ]
then 
  echo "GH_TOKEN is not set, using default credentials"
  DEPLOY_REPO_CREDENTIALS=DEPLOY_REPO
else 
  echo "GH_TOKEN is set updating REPO_URL"
  TMP_URL = `echo $DEPLOY_REPO | sed "s/https:\/\///"`
  DEPLOY_REPO_CREDENTIALS= "https://$GH_TOKEN@${TMP_URL}"
fi

function main {
	prepare
	build
}

function update {
  echo "updating deploy branch $DEPLOY_BRANCH from $DEPLOY_REPO in $BUILD_TARGET"
  cd $BUILD_TARGET;git pull;cd ..;
}

function install { 
	echo "cloning deploy branch $DEPLOY_BRANCH from $DEPLOY_REPO in $BUILD_TARGET"
  git clone --depth 1 $DEPLOY_REPO --branch $DEPLOY_BRANCH --single-branch $BUILD_TARGET 
}

function prepare { 
	echo "cleaning $BUILD_TARGET folder"
	if [ -d "$BUILD_TARGET/.git" ]
  then
    update
  else
    install 
  fi 
}

function build { 
	echo "building site"
	bundle exec jekyll build 
}

main