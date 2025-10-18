import 'package:big5/big5.dart';

/// Example demonstrating basic usage of the Big5 package
void main() {
  print('=== Big5 Encoding/Decoding Example ===');
  
  // Example 1: Basic encoding and decoding
  final String originalText = '胖次';
  print('Original text: $originalText');
  
  // Encode to Big5 bytes
  final List<int> encoded = Big5.encode(originalText);
  print('Encoded bytes: $encoded');
  
  // Decode back to string
  final String decoded = Big5.decode(encoded);
  print('Decoded text: $decoded');
  print('Encoding/decoding successful: ${originalText == decoded}');
  
  print('\n=== String Comparison Example ===');
  
  // Example 2: String comparison using Big5 encoding
  final List<String> chineseWords = ['中文', '文字', '測試', '編碼'];
  print('Original order: $chineseWords');
  
  // Sort using Big5 comparison
  chineseWords.sort(Big5.compare);
  print('Sorted by Big5: $chineseWords');
  
  print('\n=== Custom Class Example ===');
  
  // Example 3: Using Big5 comparison in custom classes
  final List<ChineseItem> items = [
    ChineseItem(id: 1, name: '中文'),
    ChineseItem(id: 2, name: '文字'),
    ChineseItem(id: 3, name: '測試'),
    ChineseItem(id: 4, name: '編碼'),
  ];
  
  print('Before sorting:');
  items.forEach(print);
  
  items.sort();
  
  print('\nAfter sorting with Big5 comparison:');
  items.forEach(print);
  
  print('\n=== Comparison Results ===');
  
  // Example 4: Direct comparison results
  final String word1 = '中文';
  final String word2 = '文字';
  final int comparisonResult = Big5.compare(word1, word2);
  
  print('Comparing "$word1" and "$word2":');
  if (comparisonResult < 0) {
    print('"$word1" comes before "$word2"');
  } else if (comparisonResult > 0) {
    print('"$word1" comes after "$word2"');
  } else {
    print('"$word1" and "$word2" are equal');
  }
}

/// Example class showing how to integrate Big5 comparison
class ChineseItem implements Comparable<ChineseItem> {
  ChineseItem({required this.id, required this.name});
  
  final int id;
  final String name;
  
  @override
  int compareTo(ChineseItem other) {
    return Big5.compare(name, other.name);
  }
  
  @override
  String toString() => 'ChineseItem(id: $id, name: "$name")';
}