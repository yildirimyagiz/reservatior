import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/job_service.dart';
import 'package:reservatior/shared/repositories/job_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final jobServiceProvider = Provider<JobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return JobService(dioClient);
});

final jobRepositoryProvider = Provider<JobRepository>((ref) {
  final service = ref.watch(jobServiceProvider);
  return JobRepositoryImpl(service);
});

final jobListProvider = FutureProvider.autoDispose<List<Job>>((ref) async {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getAll();
});

final jobCreateProvider = StateProvider<Job?>((ref) => null);
final jobUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final jobDeleteProvider = StateProvider<String?>((ref) => null);
final jobLoadingProvider = StateProvider<bool>((ref) => false);
