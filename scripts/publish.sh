#!/usr/bin/env bash
set -e

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_DIR="$( cd "${SCRIPTS_DIR}" && cd .. && pwd )"

if [[ -f "${PROJECT_DIR}/.env" ]]; then
  set -o allexport
  source "${PROJECT_DIR}/.env"
  set +o allexport
fi

cd "${PROJECT_DIR}"
PACKAGE_VERSION=$(node -p -e "require('./package.json').version")

if [ -n "$(git status --porcelain)" ]; then
  echo "Your directory is in a dirty state, unable to publish (please ensure files are commited)"
  exit 1
fi

if [ $(git tag -l "v${PACKAGE_VERSION}") ]; then
  echo "${PACKAGE_VERSION} already exists. Did you forget to version bump?"
  exit 1
fi

git push

yarn global add vsce
vsce package
vsce publish

git tag "v${PACKAGE_VERSION}"
git push --tags
