import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/review.dart';

final adminReviewsProvider = FutureProvider<List<Review>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/review');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Review.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    print('Error fetching reviews: $e');
    return [];
  }
});
