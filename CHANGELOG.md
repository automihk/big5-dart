## [0.0.1] - 2018/05/26

* add decode method

## [0.0.2] - 2018/05/26

* remote some comments that make flutter fmt failed.

## [0.0.3] - 2018/05/26

* add encode method

## [0.1.1] - 2025/10/19

* **BUGFIX**: Fixed missing decode table entries causing round-trip conversion failures
* Added missing decode entries for characters: 祢 (U+7962), 麽 (U+9EBD), 却 (U+5374), 告 (U+544A)
* Characters now properly encode and decode in both directions
* Added comprehensive tests to prevent regression of character conversion issues
* Improved error handling for unsupported character variants

## [0.1.0] - 2025/10/18

* **BREAKING CHANGE**: Upgraded to Dart 3.0+ with null safety support
* Converted from Flutter plugin to pure Dart package for better compatibility
* Updated deprecated String constructors to modern syntax
* Replaced custom list equality with built-in collection equality
* Added comprehensive API documentation with examples
* Improved README with detailed usage instructions and examples
* Fixed all null safety issues for compatibility with modern Dart versions
* Removed Flutter dependency - now works on all Dart platforms (web, server, desktop, mobile)

## [0.0.4] - 2019/08/06

* upgrade minimum dart sdk to 2.1.0
* improve decode performance in long word