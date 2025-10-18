# dart3_big5

[![Pub Package](https://img.shields.io/pub/v/dart3_big5.svg)](https://pub.dev/packages/dart3_big5)
[![Dart SDK](https://badgen.net/pub/sdk-version/dart3_big5)](https://pub.dev/packages/dart3_big5)

A Dart 3+ compatible package that provides encoding and decoding methods for Big5 character encoding. This package is useful for working with traditional Chinese text and legacy systems that use Big5 encoding.

## Features

- **Encode**: Convert Unicode strings to Big5 byte arrays
- **Decode**: Convert Big5 byte arrays to Unicode strings  
- **Compare**: Compare strings using Big5 encoding for proper Chinese collation
- **Pure Dart**: Works on all platforms (Flutter, web, server, desktop)
- **Null Safety**: Fully compatible with Dart 3.0+ and null safety

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  dart3_big5: ^0.1.0
```

Then run:

```bash
dart pub get
```

## Usage

### Basic Encoding and Decoding

```dart
import 'package:dart3_big5/big5.dart';

void main() {
  // Encode a string to Big5 bytes
  final String text = "胖次";
  final List<int> encoded = Big5.encode(text);
  print(encoded); // [173, 68, 166, 184]

  // Decode Big5 bytes back to string
  final List<int> bytes = [173, 68, 166, 184];
  final String decoded = Big5.decode(bytes);
  print(decoded); // "胖次"
}
```

### String Comparison with Big5 Encoding

The package provides a `compare` method for proper Chinese text collation:

```dart
import 'package:dart3_big5/big5.dart';

void main() {
  final String str1 = "中文";
  final String str2 = "文字";
  
  final int result = Big5.compare(str1, str2);
  // Returns: -1, 0, or 1 (same as String.compareTo)
  
  if (result == 0) {
    print("Strings are equal");
  } else if (result < 0) {
    print("$str1 comes before $str2");
  } else {
    print("$str1 comes after $str2");
  }
}
```

### Using with Custom Models

You can use Big5 comparison in your own classes:

```dart
import 'package:dart3_big5/big5.dart';

class ChineseItem implements Comparable<ChineseItem> {
  ChineseItem({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  int compareTo(ChineseItem other) {
    return Big5.compare(name, other.name);
  }

  @override
  String toString() => 'ChineseItem(id: $id, name: $name)';
}

void main() {
  final items = [
    ChineseItem(id: 1, name: "中文"),
    ChineseItem(id: 2, name: "文字"),
    ChineseItem(id: 3, name: "測試"),
  ];
  
  // Sort using Big5 encoding
  items.sort();
  
  for (final item in items) {
    print(item);
  }
}
```

## API Reference

### `Big5.encode(String text)`

Converts a Unicode string to a list of Big5 encoded bytes.

- **Parameters**: `text` - The Unicode string to encode
- **Returns**: `List<int>` - The Big5 encoded bytes
- **Example**: `Big5.encode("中文")` returns `[164, 164, 164, 229]`

### `Big5.decode(List<int> bytes)`

Converts a list of Big5 encoded bytes to a Unicode string.

- **Parameters**: `bytes` - The Big5 encoded bytes to decode
- **Returns**: `String` - The decoded Unicode string
- **Example**: `Big5.decode([164, 164, 164, 229])` returns `"中文"`

### `Big5.compare(String a, String b)`

Compares two strings using Big5 encoding for proper Chinese collation.

- **Parameters**: 
  - `a` - First string to compare
  - `b` - Second string to compare
- **Returns**: `int` - Comparison result (-1, 0, or 1)
- **Example**: `Big5.compare("中文", "文字")` returns comparison result

## Compatibility

- **Dart SDK**: Requires Dart 3.0.0 or higher
- **Platforms**: All platforms supported by Dart (Flutter, web, server, desktop)
- **Null Safety**: Fully null-safe

## Use Cases

This package is particularly useful for:

- Legacy system integration that uses Big5 encoding
- Processing traditional Chinese text files
- Maintaining compatibility with older Chinese systems
- Proper Chinese text sorting and comparison
- Text processing for Taiwan and Hong Kong systems

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Special thanks to @abc873693 for fixes and improvements
