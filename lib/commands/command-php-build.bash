#! /usr/bin/env bash

set -eu -o pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utils.sh"

: "${ASDF_PHP_PHPBUILD_HOME=$ASDF_PHP_PLUGIN_DIR/.php-build}"
: "${ASDF_PHP_CONCURRENCY=$(((${ASDF_CONCURRENCY:-1} + 1) / 2))}"

# php-build environment variables being overriden by asdf-php
export PHP_BUILD_CACHE_PATH="${PHP_BUILD_CACHE_PATH:-$ASDF_PHP_CACHE_DIR/php-build}"

if [[ "${ASDF_PHP_CONCURRENCY-}" =~ ^[0-9]+$ ]]; then
  export MAKE_OPTS="${MAKE_OPTS:-} -j$ASDF_PHP_CONCURRENCY"
  export PHP_MAKE_OPTS="${PHP_MAKE_OPTS:-} -j$ASDF_PHP_CONCURRENCY"
fi

phpbuild="${ASDF_PHP_PHPBUILD:-$ASDF_PHP_PHPBUILD_HOME/bin/php-build}"
args=()

if ! [ -x "$phpbuild" ]; then
  printf "Binary for php-build not found\n"

  if ! [ "${ASDF_PHP_PHPBUILD-}" ]; then
    printf "Are you sure it was installed? Try running \`asdf %s update-php-build\` to do a local update or install\n" "$(plugin_name)"
  fi

  exit 1
fi

if [ "${ASDF_PHP_VERBOSE_INSTALL-}" ]; then
  args+=(-v)
fi

exec "$phpbuild" ${args+"${args[@]}"} "$@"
