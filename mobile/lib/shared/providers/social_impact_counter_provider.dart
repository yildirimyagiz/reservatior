import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/social_impact_counter_service.dart';
import 'package:reservatior/shared/repositories/social_impact_counter_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final socialImpactCounterServiceProvider = Provider<SocialImpactCounterService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SocialImpactCounterService(dioClient);
});

final socialImpactCounterRepositoryProvider = Provider<SocialImpactCounterRepository>((ref) {
  final service = ref.watch(socialImpactCounterServiceProvider);
  return SocialImpactCounterRepositoryImpl(service);
});

final socialImpactCounterListProvider = FutureProvider.autoDispose<List<SocialImpactCounter>>((ref) async {
  final repository = ref.watch(socialImpactCounterRepositoryProvider);
  return repository.getAll();
});

final socialImpactCounterCreateProvider = StateProvider<SocialImpactCounter?>((ref) => null);
final socialImpactCounterUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final socialImpactCounterDeleteProvider = StateProvider<String?>((ref) => null);
final socialImpactCounterLoadingProvider = StateProvider<bool>((ref) => false);
