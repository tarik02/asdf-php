#! /usr/bin/env bash

set -eu -o pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utils.sh"

: "${ASDF_PHP_PHPBUILD_HOME=$ASDF_PHP_PLUGIN_DIR/.php-build}"
: "${ASDF_PHP_PHPBUILD_REPOSITORY=https://github.com/php-build/php-build.git}"

ensure_updated_project() {
  local pull_exit_code=0 output=

  if ! [ -d "$ASDF_PHP_PHPBUILD_HOME" ]; then
    printf "Cloning php-build...\n"
    git clone "$ASDF_PHP_PHPBUILD_REPOSITORY" "$ASDF_PHP_PHPBUILD_HOME"
  else
    printf "Trying to update php-build..."
    output=$(git -C "$ASDF_PHP_PHPBUILD_HOME" pull origin master 2>&1) || pull_exit_code=$?

    if [ "$pull_exit_code" != 0 ]; then
      printf "\n%s\n\n" "$output" >&2
      printf "$(colored $RED ERROR): Pulling the php-build repository exited with code %s\n" "$pull_exit_code" >&2
      printf "Please check if the git repository at %s doesn't have any changes or anything\nthat might not allow a git pull\n" "$ASDF_PHP_PHPBUILD_HOME" >&2
      exit $pull_exit_code
    fi

    printf " ok\n"
  fi
}

ensure_updated_project
