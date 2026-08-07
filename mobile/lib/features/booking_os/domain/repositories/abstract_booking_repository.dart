import 'package:reservatior/shared/models/booking.dart';
import 'package:reservatior/shared/models/pricing_rule.dart';
import 'package:reservatior/shared/models/facility.dart';
import 'package:reservatior/shared/models/facility_block.dart';

abstract class AbstractBookingRepository {
  Future<List<Booking>> getBookings({
    int page,
    int limit,
    String? orgId,
    String? status,
  });

  Future<Booking> getBookingById(String id);

  Future<List<PricingRule>> getPricingRules({
    int page,
    int limit,
    String? listingId,
  });

  Future<PricingRule> getPricingRuleById(String id);

  Future<List<Facility>> getFacilities({
    int page,
    int limit,
    String? orgId,
  });

  Future<Facility> getFacilityById(String id);

  Future<List<FacilityBlock>> getFacilityBlocks({
    int page,
    int limit,
    String? facilityId,
  });

  Future<FacilityBlock> getFacilityBlockById(String id);

  Future<Map<String, dynamic>> getBookingStats(String orgId);

  Future<Map<String, dynamic>> checkAvailability({
    required String propertyId,
    required String startDate,
    required String endDate,
  });

  Future<Map<String, dynamic>> calculatePrice({
    required String propertyId,
    required String startDate,
    required String endDate,
    int adults,
    int children,
  });
}
