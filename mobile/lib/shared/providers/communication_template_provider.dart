import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/communication_template_service.dart';
import 'package:reservatior/shared/repositories/communication_template_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final communicationTemplateServiceProvider = Provider<CommunicationTemplateService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CommunicationTemplateService(dioClient);
});

final communicationTemplateRepositoryProvider = Provider<CommunicationTemplateRepository>((ref) {
  final service = ref.watch(communicationTemplateServiceProvider);
  return CommunicationTemplateRepositoryImpl(service);
});

final communicationTemplateListProvider = FutureProvider.autoDispose<List<CommunicationTemplate>>((ref) async {
  final repository = ref.watch(communicationTemplateRepositoryProvider);
  return repository.getAll();
});

final communicationTemplateCreateProvider = StateProvider<CommunicationTemplate?>((ref) => null);
final communicationTemplateUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final communicationTemplateDeleteProvider = StateProvider<String?>((ref) => null);
final communicationTemplateLoadingProvider = StateProvider<bool>((ref) => false);
