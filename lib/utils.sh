# Helper functions

export ASDF_PHP_PLUGIN_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

# TODO: Replace with an asdf variable once asdf starts providing the plugin name
# as a variable
export ASDF_PHP_PLUGIN_NAME=$(basename "$ASDF_PHP_PLUGIN_DIR")
plugin_name() {
  printf "%s\n" "$ASDF_PHP_PLUGIN_NAME"
}

asdf_data_dir() {
  printf "%s\n" "${ASDF_DATA_DIR:-$HOME/.asdf}"
}

export ASDF_PHP_CACHE_DIR="$(asdf_data_dir)/tmp/$ASDF_PHP_PLUGIN_NAME/cache"

# Colors
colored() {
  local color="$1" text="$2"
  printf "\033[%sm%s\033[39;49m\n" "$color" "$text"
}

export RED=31 GREEN=32 YELLOW=33 BLUE=34 MAGENTA=35 CYAN=36

die() {
  >&2 echo "$@"
  exit 1
}

delete_on_exit() {
  trap "rm -rf $@" EXIT
}

phpbuild_wrapped() {
  "$ASDF_PHP_PLUGIN_DIR/lib/commands/command-phpbuild.bash" "$@"
}

install_icu4c() {
  local source_url="$1"
  local dest_dir="$2"

  if [ -d "$dest_dir" ]; then
    return
  fi

  local tmp_dir="$ASDF_PHP_CACHE_DIR/.icu-build-$(dirname "$dest_dir")"

  rm -rf $tmp_dir
  mkdir -p "$tmp_dir"

  {
    cd "$tmp_dir"
    curl -s -Lo "icu4c.tgz" "$source_url"
    tar zxf "icu4c.tgz"
    cd icu/source
    ./configure --prefix="$dest_dir"
    make
    make install
  }

  rm -rf $tmp_dir
}
