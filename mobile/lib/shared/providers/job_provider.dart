import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/job_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Job Providers

final JobServiceProvider = Provider<JobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return JobService(dioClient);
});

// List Provider
final jobProvider = FutureProvider.autoDispose<List<Job>>((ref) async {
  final service = ref.watch(JobServiceProvider);
  return service.getJobs();
});

// Create Provider
final JobCreateProvider = FutureProvider.autoDispose<Job>((ref) async {
  final service = ref.watch(JobServiceProvider);
  return service.createJob(Job());
});

// Update Provider  
final JobUpdateProvider = FutureProvider.autoDispose<Job>((ref) async {
  final service = ref.watch(JobServiceProvider);
  final state = ref.watch(JobUpdateStateProvider);
  if (state['id'] != null && state['job'] != null) {
    return service.updateJob(state['id'], state['job']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final JobDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(JobServiceProvider);
  final state = ref.watch(JobDeleteStateProvider);
  if (state != null) {
    return service.deleteJob(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final JobUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final JobDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final JobLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(jobProvider);
  final createAsync = ref.watch(JobCreateProvider);
  final updateAsync = ref.watch(JobUpdateProvider);
  final deleteAsync = ref.watch(JobDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
