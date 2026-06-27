import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mortgage_pre_approval_service.dart';
import 'package:reservatior/shared/repositories/mortgage_pre_approval_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mortgagePreApprovalServiceProvider = Provider<MortgagePreApprovalService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MortgagePreApprovalService(dioClient);
});

final mortgagePreApprovalRepositoryProvider = Provider<MortgagePreApprovalRepository>((ref) {
  final service = ref.watch(mortgagePreApprovalServiceProvider);
  return MortgagePreApprovalRepositoryImpl(service);
});

final mortgagePreApprovalListProvider = FutureProvider.autoDispose<List<MortgagePreApproval>>((ref) async {
  final repository = ref.watch(mortgagePreApprovalRepositoryProvider);
  return repository.getAll();
});

final mortgagePreApprovalCreateProvider = StateProvider<MortgagePreApproval?>((ref) => null);
final mortgagePreApprovalUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mortgagePreApprovalDeleteProvider = StateProvider<String?>((ref) => null);
final mortgagePreApprovalLoadingProvider = StateProvider<bool>((ref) => false);
