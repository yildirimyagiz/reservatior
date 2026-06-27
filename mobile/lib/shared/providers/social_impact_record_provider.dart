import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/social_impact_record_service.dart';
import 'package:reservatior/shared/repositories/social_impact_record_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final socialImpactRecordServiceProvider = Provider<SocialImpactRecordService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SocialImpactRecordService(dioClient);
});

final socialImpactRecordRepositoryProvider = Provider<SocialImpactRecordRepository>((ref) {
  final service = ref.watch(socialImpactRecordServiceProvider);
  return SocialImpactRecordRepositoryImpl(service);
});

final socialImpactRecordListProvider = FutureProvider.autoDispose<List<SocialImpactRecord>>((ref) async {
  final repository = ref.watch(socialImpactRecordRepositoryProvider);
  return repository.getAll();
});

final socialImpactRecordCreateProvider = StateProvider<SocialImpactRecord?>((ref) => null);
final socialImpactRecordUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final socialImpactRecordDeleteProvider = StateProvider<String?>((ref) => null);
final socialImpactRecordLoadingProvider = StateProvider<bool>((ref) => false);
