import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/tax_record_service.dart';
import 'package:reservatior/shared/repositories/tax_record_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final taxRecordServiceProvider = Provider<TaxRecordService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TaxRecordService(dioClient);
});

final taxRecordRepositoryProvider = Provider<TaxRecordRepository>((ref) {
  final service = ref.watch(taxRecordServiceProvider);
  return TaxRecordRepositoryImpl(service);
});

final taxRecordListProvider = FutureProvider.autoDispose<List<TaxRecord>>((ref) async {
  final repository = ref.watch(taxRecordRepositoryProvider);
  return repository.getAll();
});

final taxRecordCreateProvider = StateProvider<TaxRecord?>((ref) => null);
final taxRecordUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final taxRecordDeleteProvider = StateProvider<String?>((ref) => null);
final taxRecordLoadingProvider = StateProvider<bool>((ref) => false);
