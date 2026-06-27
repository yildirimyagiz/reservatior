import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/report_service.dart';
import 'package:reservatior/shared/repositories/report_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final reportServiceProvider = Provider<ReportService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReportService(dioClient);
});

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  final service = ref.watch(reportServiceProvider);
  return ReportRepositoryImpl(service);
});

final reportListProvider = FutureProvider.autoDispose<List<Report>>((ref) async {
  final repository = ref.watch(reportRepositoryProvider);
  return repository.getAll();
});

final reportCreateProvider = StateProvider<Report?>((ref) => null);
final reportUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final reportDeleteProvider = StateProvider<String?>((ref) => null);
final reportLoadingProvider = StateProvider<bool>((ref) => false);
