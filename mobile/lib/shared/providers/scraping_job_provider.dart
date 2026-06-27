import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/scraping_job_service.dart';
import 'package:reservatior/shared/repositories/scraping_job_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final scrapingJobServiceProvider = Provider<ScrapingJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ScrapingJobService(dioClient);
});

final scrapingJobRepositoryProvider = Provider<ScrapingJobRepository>((ref) {
  final service = ref.watch(scrapingJobServiceProvider);
  return ScrapingJobRepositoryImpl(service);
});

final scrapingJobListProvider = FutureProvider.autoDispose<List<ScrapingJob>>((ref) async {
  final repository = ref.watch(scrapingJobRepositoryProvider);
  return repository.getAll();
});

final scrapingJobCreateProvider = StateProvider<ScrapingJob?>((ref) => null);
final scrapingJobUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final scrapingJobDeleteProvider = StateProvider<String?>((ref) => null);
final scrapingJobLoadingProvider = StateProvider<bool>((ref) => false);
