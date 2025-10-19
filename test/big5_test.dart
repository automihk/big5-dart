import 'package:dart3_big5/big5.dart';
import 'package:test/test.dart';

void main() {
  test('decode some bytes of with big5 encoded', () {
    expect(Big5.decode([173, 68, 166, 184]), "胖次");
    expect(
        Big5.decode([
          27,
          91,
          49,
          59,
          51,
          49,
          109,
          166,
          226,
          189,
          88,
          180,
          250,
          184,
          213,
          27,
          91,
          48,
          109
        ]),
        "\x1b[1;31m色碼測試\x1b[0m");
  });
  test('encode some bytes of with big5 encoded', () {
    expect(Big5.encode("胖次"), [173, 68, 166, 184]);
    expect(Big5.encode("\x1b[1;31m色碼測試\x1b[0m"), [
      27,
      91,
      49,
      59,
      51,
      49,
      109,
      166,
      226,
      189,
      88,
      180,
      250,
      184,
      213,
      27,
      91,
      48,
      109
    ]);
  });

  test('encode and decode character 告', () {
    // Test for the specific character '告' that was not converting correctly
    const String gaoChar = '告';
    const List<int> gaoBytes = [167, 105]; // 0xA769
    
    // Test encoding
    expect(Big5.encode(gaoChar), gaoBytes);
    
    // Test decoding
    expect(Big5.decode(gaoBytes), gaoChar);
    
    // Test round-trip
    expect(Big5.decode(Big5.encode(gaoChar)), gaoChar);
  });

  test('encode and decode additional fixed characters', () {
    // Test characters that were missing from decode table
    
    // 祢 (U+7962) - was encoding to [157, 234] but not decoding back
    const String nieChar = '祢';
    const List<int> nieBytes = [157, 234]; // 0x9DEA
    expect(Big5.encode(nieChar), nieBytes);
    expect(Big5.decode(nieBytes), nieChar);
    expect(Big5.decode(Big5.encode(nieChar)), nieChar);
    
    // 麽 (U+9EBD) - was encoding to [154, 172] but not decoding back  
    const String meChar = '麽';
    const List<int> meBytes = [154, 172]; // 0x9AAC
    expect(Big5.encode(meChar), meBytes);
    expect(Big5.decode(meBytes), meChar);
    expect(Big5.decode(Big5.encode(meChar)), meChar);
    
    // 却 (U+5374) - was encoding to [250, 210] but not decoding back
    const String queChar = '却';
    const List<int> queBytes = [250, 210]; // 0xFAD2
    expect(Big5.encode(queChar), queBytes);
    expect(Big5.decode(queBytes), queChar);
    expect(Big5.decode(Big5.encode(queChar)), queChar);
  });

  test('verify working traditional character variants', () {
    // Test characters that work correctly (traditional forms)
    
    // 為 (traditional form) - should work
    const String weiChar = '為';
    expect(Big5.decode(Big5.encode(weiChar)), weiChar);
    
    // 麼 (traditional form) - should work  
    const String moChar = '麼';
    expect(Big5.decode(Big5.encode(moChar)), moChar);
    
    // 顏 (traditional form) - should work
    const String yanChar = '顏';
    expect(Big5.decode(Big5.encode(yanChar)), yanChar);
  });
}

