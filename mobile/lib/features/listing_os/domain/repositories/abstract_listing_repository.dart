import 'package:reservatior/shared/models/listing.dart';
import 'package:reservatior/shared/models/listing_channel.dart';
import 'package:reservatior/shared/models/listing_tag.dart';

abstract class AbstractListingRepository {
  Future<List<Listing>> getListings({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  });

  Future<Listing> getListingById(String id);

  Future<Listing> createListing(Listing listing);

  Future<Listing> updateListing(String id, Listing listing);

  Future<void> deleteListing(String id);

  Future<List<ListingChannel>> getListingChannels({
    int page,
    int limit,
    String? orgId,
    String? listingId,
  });

  Future<List<ListingTag>> getListingTags({
    int page,
    int limit,
    String? orgId,
    String? listingId,
  });
}
