import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/organization_service.dart';
import 'package:reservatior/shared/repositories/organization_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final organizationServiceProvider = Provider<OrganizationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OrganizationService(dioClient);
});

final organizationRepositoryProvider = Provider<OrganizationRepository>((ref) {
  final service = ref.watch(organizationServiceProvider);
  return OrganizationRepositoryImpl(service);
});

final organizationListProvider = FutureProvider.autoDispose<List<Organization>>((ref) async {
  final repository = ref.watch(organizationRepositoryProvider);
  return repository.getAll();
});

final organizationCreateProvider = StateProvider<Organization?>((ref) => null);
final organizationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final organizationDeleteProvider = StateProvider<String?>((ref) => null);
final organizationLoadingProvider = StateProvider<bool>((ref) => false);
