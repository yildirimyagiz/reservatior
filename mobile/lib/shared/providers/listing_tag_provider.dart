import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/listing_tag_service.dart';
import 'package:reservatior/shared/repositories/listing_tag_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final listingTagServiceProvider = Provider<ListingTagService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ListingTagService(dioClient);
});

final listingTagRepositoryProvider = Provider<ListingTagRepository>((ref) {
  final service = ref.watch(listingTagServiceProvider);
  return ListingTagRepositoryImpl(service);
});

final listingTagListProvider = FutureProvider.autoDispose<List<ListingTag>>((ref) async {
  final repository = ref.watch(listingTagRepositoryProvider);
  return repository.getAll();
});

final listingTagCreateProvider = StateProvider<ListingTag?>((ref) => null);
final listingTagUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final listingTagDeleteProvider = StateProvider<String?>((ref) => null);
final listingTagLoadingProvider = StateProvider<bool>((ref) => false);
