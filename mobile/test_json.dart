import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('/Users/os2026/Downloads/Reservatior/mobile/assets/translations/tr.json');
  try {
    jsonDecode(file.readAsStringSync());
    print('tr.json is valid');
  } catch (e) {
    print('tr.json error: $e');
  }
}
