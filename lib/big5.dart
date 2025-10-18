/// A Dart library for Big5 character encoding and decoding.
/// 
/// This library provides utilities to encode and decode text using the Big5
/// character encoding, commonly used for Traditional Chinese text.
/// It also provides comparison methods for proper Chinese text collation.
library big5;

import 'package:collection/collection.dart';

part 'table.dart';

/// A utility class for Big5 character encoding operations.
///
/// This class provides static methods to encode, decode, and compare
/// strings using the Big5 character encoding standard.
class Big5 {
  /// Compares two strings using Big5 encoding for proper Chinese collation.
  ///
  /// This method first encodes both strings to Big5 byte arrays and then
  /// compares them byte by byte. This ensures proper sorting order for
  /// Chinese characters according to Big5 encoding standards.
  ///
  /// Parameters:
  /// - [a]: The first string to compare
  /// - [b]: The second string to compare
  ///
  /// Returns:
  /// - A negative integer if [a] comes before [b]
  /// - Zero if [a] and [b] are equal
  /// - A positive integer if [a] comes after [b]
  ///
  /// Example:
  /// ```dart
  /// final result = Big5.compare("中文", "文字");
  /// if (result < 0) {
  ///   print("中文 comes before 文字");
  /// }
  /// ```
  static int compare(String a, String b) {
    final _a = encode(a);
    final _b = encode(b);
    if (const ListEquality().equals(_a, _b)) {
      return 0;
    }
    final _aLen = _a.length;
    final _bLen = _b.length;
    if (_aLen == _bLen) {
      for (int index = 0; index < _aLen; index++) {
        final _aVal = _a[index];
        final _bVal = _b[index];
        if (_aVal == _bVal) continue;
        return _aVal.compareTo(_bVal);
      }
    }
    return _aLen.compareTo(_bLen);
  }

  /// Decodes a list of Big5 encoded bytes to a Unicode string.
  ///
  /// Takes a list of integers representing Big5 encoded bytes and converts
  /// them back to their original Unicode string representation.
  ///
  /// Parameters:
  /// - [src]: A list of integers representing Big5 encoded bytes
  ///
  /// Returns:
  /// - The decoded Unicode string
  ///
  /// Example:
  /// ```dart
  /// final bytes = [173, 68, 166, 184];
  /// final decoded = Big5.decode(bytes);
  /// print(decoded); // "胖次"
  /// ```
  static String decode(List<int> src) {
    return _big5TransformDecode(src);
  }

  /// Encodes a Unicode string to a list of Big5 encoded bytes.
  ///
  /// Takes a Unicode string and converts it to its Big5 encoded byte
  /// representation. This is useful for storing or transmitting Chinese
  /// text in systems that expect Big5 encoding.
  ///
  /// Parameters:
  /// - [src]: The Unicode string to encode
  ///
  /// Returns:
  /// - A list of integers representing the Big5 encoded bytes
  ///
  /// Example:
  /// ```dart
  /// final encoded = Big5.encode("胖次");
  /// print(encoded); // [173, 68, 166, 184]
  /// ```
  static List<int> encode(String src) {
    return _big5TransformEncode(src);
  }

  static String _big5TransformDecode(List<int> src) {
    var r = 0;
    var size = 0;
    var nDst = '';

    void write(input) => nDst += String.fromCharCode(input);

    for (var nSrc = 0; nSrc < src.length; nSrc += size) {
      var c0 = src[nSrc];
      if (c0 < 0x80) {
        r = c0;
        size = 1;
      } else if (0x81 <= c0 && c0 < 0xFF) {
        if (nSrc + 1 >= src.length) {
          r = RUNE_ERROR;
          size = 1;
          write(r);
          continue;
        }
        var c1 = src[nSrc + 1];
        r = 0xfffd;
        size = 2;

        var i = c0 * 16 * 16 + c1;
        var s = _decodeMap[i];
        if (s != null) {
          write(s);
          continue;
        }
      } else {
        r = RUNE_ERROR;
        size = 1;
      }
      write(r);
      continue;
    }
    return nDst;
  }

  static List<int> _big5TransformEncode(String src) {
    var runes = Runes(src).toList();

    var r = 0;
    var size = 0;
    List<int> dst = [];

    void write2(int r) {
      dst.add(r >> 8);
      dst.add(r % 256);
    }

    for (var nSrc = 0; nSrc < runes.length; nSrc += size) {
      r = runes[nSrc];

      // Decode a 1-byte rune.
      if (r < RUNE_SELF) {
        size = 1;
        dst.add(r);
        continue;
      } else {
        // Decode a multi-byte rune.
        // TODO handle some error
        size = 1;
      }

      if (r >= RUNE_SELF) {
        if (encode0Low <= r && r < encode0High) {
          var encoded = _encode0[r - encode0Low];
          if (encoded != null) {
            r = encoded;
            if (r != 0) {
              write2(r);
              continue;
            }
          }
        } else if (encode1Low <= r && r < encode1High) {
          var encoded = _encode1[r - encode1Low];
          if (encoded != null) {
            r = encoded;
            if (r != 0) {
              write2(r);
              continue;
            }
          }
        } else if (encode2Low <= r && r < encode2High) {
          var encoded = _encode2[r - encode2Low];
          if (encoded != null) {
            r = encoded;
            if (r != 0) {
              write2(r);
              continue;
            }
          }
        } else if (encode3Low <= r && r < encode3High) {
          var encoded = _encode3[r - encode3Low];
          if (encoded != null) {
            r = encoded;
            if (r != 0) {
              write2(r);
              continue;
            }
          }
        } else if (encode4Low <= r && r < encode4High) {
          var encoded = _encode4[r - encode4Low];
          if (encoded != null) {
            r = encoded;
            if (r != 0) {
              write2(r);
              continue;
            }
          }
        } else if (encode5Low <= r && r < encode5High) {
          var encoded = _encode5[r - encode5Low];
          if (encoded != null) {
            r = encoded;
            if (r != 0) {
              write2(r);
              continue;
            }
          }
        } else if (encode6Low <= r && r < encode6High) {
          var encoded = _encode6[r - encode6Low];
          if (encoded != null) {
            r = encoded;
            if (r != 0) {
              write2(r);
              continue;
            }
          }
        } else if (encode7Low <= r && r < encode7High) {
          var encoded = _encode7[r - encode7Low];
          if (encoded != null) {
            r = encoded;
            if (r != 0) {
              write2(r);
              continue;
            }
          }
        }
        // TODO handle err
        break;
      }
    }
    return dst;
  }
}
