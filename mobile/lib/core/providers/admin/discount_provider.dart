import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/discount.dart';

final adminDiscountsProvider = FutureProvider<List<Discount>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/discount');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Discount.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    print('Error fetching discounts: $e');
    return [];
  }
});
