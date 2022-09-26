# asdf-php (php-build)

[PHP](https://www.php.net) plugin based on [php-build](https://github.com/php-build/php-build) for asdf version manager

_Inspired by [asdf-community/asdf-php](https://github.com/asdf-community/asdf-php)_

## Prerequirements

Check the [.github/workflows/workflow.yml](.github/workflows/workflow.yml) for
dependencies, paths, and environment variables needed to install the latest PHP
version. To be honest, supporting a major version other than the latest without
any extra work from the user is an endless endeavor that won't ever really work
too well. It's not that we don't support them at all, but it's almost impossible
for us to support them.

## Installation

```bash
asdf plugin-add php https://github.com/Tarik02/asdf-php.git
```

## Note

- Composer is installed alongside PHP.
- XDebug is installed by default.
- Additional extensions can be installed using
    ```bash
    pecl install redis
    pecl install imagick

    echo "extension=redis.so
    extension=imagick.so" > $(asdf where php)/conf.d/php.ini
    ```

## Usage

Check [asdf](https://github.com/asdf-vm/asdf) readme for instructions on how to
install & manage versions.

## Global Composer Dependencies

Composer is installed globally by default. To use it, you'll need to reshim:

```shell
composer global require friendsofphp/php-cs-fixer
asdf reshim
php-cs-fixer --version
```

## License

Licensed under the
[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).
