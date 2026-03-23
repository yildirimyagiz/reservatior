import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_client.dart';

/// Global DioClient provider - used across all feature providers
final dioClientProvider = Provider<DioClient>((ref) => DioClient());
