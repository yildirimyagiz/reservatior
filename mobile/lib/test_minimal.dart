import 'package:flutter_riverpod/flutter_riverpod.dart';

// Test provider definition
final testProvider = Provider<int>((ref) => 42);

void main() {
  print('Test provider: $testProvider');
}
