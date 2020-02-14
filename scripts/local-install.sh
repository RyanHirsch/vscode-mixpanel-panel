#!/usr/bin/env bash
set -e

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_DIR="$( cd "${SCRIPTS_DIR}" && cd .. && pwd )"
EXTENSIONS_DIR="${HOME}/.vscode"

if [[ -f "${PROJECT_DIR}/.env" ]]; then
  set -o allexport
  source "${PROJECT_DIR}/.env"
  set +o allexport
fi


if [[ -d "${HOME}/.vscode-insiders" ]]
then
  VSCODE_DIR="${HOME}/.vscode-insiders"
  echo "Installing to VS Code Insiders"
else
  if [[ -d "${HOME}/.vscode" ]]
  then
    VSCODE_DIR="${HOME}/.vscode"
    echo "Installing to standard VS Code"
  else
    echo "Failed to find your VS Code install"
    exit 1
  fi
fi

cd "${PROJECT_DIR}"
# vsce package

EXTENSION_DIR="${VSCODE_DIR}/extensions"

# cp -R "${PROJECT_DIR}/snippets" "${EXTENSION_DIR}"
