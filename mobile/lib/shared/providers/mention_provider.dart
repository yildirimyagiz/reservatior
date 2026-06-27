import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mention_service.dart';
import 'package:reservatior/shared/repositories/mention_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mentionServiceProvider = Provider<MentionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MentionService(dioClient);
});

final mentionRepositoryProvider = Provider<MentionRepository>((ref) {
  final service = ref.watch(mentionServiceProvider);
  return MentionRepositoryImpl(service);
});

final mentionListProvider = FutureProvider.autoDispose<List<Mention>>((ref) async {
  final repository = ref.watch(mentionRepositoryProvider);
  return repository.getAll();
});

final mentionCreateProvider = StateProvider<Mention?>((ref) => null);
final mentionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mentionDeleteProvider = StateProvider<String?>((ref) => null);
final mentionLoadingProvider = StateProvider<bool>((ref) => false);
