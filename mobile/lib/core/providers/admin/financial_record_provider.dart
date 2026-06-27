import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/financial_record.dart';

final adminFinancialRecordsProvider = FutureProvider<List<FinancialRecord>>((
  ref,
) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/financial-record');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => FinancialRecord.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
