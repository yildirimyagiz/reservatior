import 'package:reservatior/core/utils/result.dart';
import 'package:reservatior/shared/models/models.dart';

abstract class AbstractFinanceRepository {
  Future<Result<List<EscrowAccount>>> getEscrowAccounts({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
  });

  Future<Result<EscrowAccount>> getEscrowAccountById(String id);

  Future<Result<EscrowAccount>> createEscrowAccount(EscrowAccount account);

  Future<Result<EscrowAccount>> updateEscrowAccount(
      String id, EscrowAccount account);

  Future<Result<void>> deleteEscrowAccount(String id);

  Future<Result<List<EscrowDispute>>> getEscrowDisputes({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
  });

  Future<Result<EscrowDispute>> getEscrowDisputeById(String id);

  Future<Result<List<EscrowRelease>>> getEscrowReleases({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
  });

  Future<Result<EscrowRelease>> getEscrowReleaseById(String id);

  Future<Result<List<Payout>>> getPayouts({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
  });

  Future<Result<Payout>> getPayoutById(String id);

  Future<Result<List<LedgerEntry>>> getLedgerEntries({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
  });

  Future<Result<LedgerEntry>> getLedgerEntryById(String id);

  Future<Result<List<FinancialRecord>>> getFinancialRecords({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
  });

  Future<Result<FinancialRecord>> getFinancialRecordById(String id);
}
