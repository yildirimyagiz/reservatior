import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/escrow_account.dart';

final adminEscrowAccountsProvider = FutureProvider<List<EscrowAccount>>((
  ref,
) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/escrow-account');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => EscrowAccount.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
