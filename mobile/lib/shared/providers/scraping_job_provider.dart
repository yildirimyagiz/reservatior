import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/scraping_job_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ScrapingJob Providers

final ScrapingJobServiceProvider = Provider<ScrapingJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ScrapingJobService(dioClient);
});

// List Provider
final scrapingJobProvider = FutureProvider.autoDispose<List<ScrapingJob>>((ref) async {
  final service = ref.watch(ScrapingJobServiceProvider);
  return service.getScrapingJobs();
});

// Create Provider
final ScrapingJobCreateProvider = FutureProvider.autoDispose<ScrapingJob>((ref) async {
  final service = ref.watch(ScrapingJobServiceProvider);
  return service.createScrapingJob(ScrapingJob());
});

// Update Provider  
final ScrapingJobUpdateProvider = FutureProvider.autoDispose<ScrapingJob>((ref) async {
  final service = ref.watch(ScrapingJobServiceProvider);
  final state = ref.watch(ScrapingJobUpdateStateProvider);
  if (state['id'] != null && state['scraping_job'] != null) {
    return service.updateScrapingJob(state['id'], state['scraping_job']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ScrapingJobDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ScrapingJobServiceProvider);
  final state = ref.watch(ScrapingJobDeleteStateProvider);
  if (state != null) {
    return service.deleteScrapingJob(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ScrapingJobUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ScrapingJobDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ScrapingJobLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(scrapingJobProvider);
  final createAsync = ref.watch(ScrapingJobCreateProvider);
  final updateAsync = ref.watch(ScrapingJobUpdateProvider);
  final deleteAsync = ref.watch(ScrapingJobDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
