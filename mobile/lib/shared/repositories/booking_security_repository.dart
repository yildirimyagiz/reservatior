import 'package:reservatior/shared/models/booking_security.dart';
import 'package:reservatior/shared/services/booking_security_service.dart';

abstract class BookingSecurityRepository {
  Future<Map<String, dynamic>> getBookings({
    int page, 
    int limit, 
    String? orgId,
    String? listingId,
    String? contactId,
    String? status,
    bool? ownershipVerified,
    String? verificationStatus,
    String? startDate,
    String? endDate,
  });
  Future<Map<String, dynamic>> getBookingById(String id);
  Future<Map<String, dynamic>> createBooking({
    required String orgId,
    required String listingId,
    required String startDate,
    required String endDate,
    String? contactId,
    int? adults,
    int? children,
    String? notes,
  });
  Future<Map<String, dynamic>> updateBooking(String id, Map<String, dynamic> data);
  Future<void> deleteBooking(String id);
  
  // Status Management
  Future<Map<String, dynamic>> updateBookingStatus(String id, String status, {String? notes});
  
  // Ownership Verification
  Future<PropertyOwnershipVerification> verifyOwnership(String id, {
    required String propertyId,
    String? verificationMethod,
    List<dynamic>? documents,
    String? notes,
  });
  Future<PropertyOwnershipVerification> getOwnershipVerification(String id);
  
  // Security Screening
  Future<BookingSecurityScreening> createSecurityScreening(String id, {
    String? riskLevel,
    double? riskScore,
    bool? manualReviewRequired,
    Map<String, dynamic>? screeningMetadata,
    String? notes,
  });
  Future<List<BookingSecurityScreening>> getSecurityScreenings(String id);
  Future<BookingSecurityScreening> updateSecurityScreening(String id, String screeningId, {
    String? screeningStatus,
    double? riskScore,
    String? manualReviewNotes,
  });
  
  // Security Status
  Future<Map<String, dynamic>> getSecurityStatus(String id);
  
  // Guest Review
  Future<Map<String, dynamic>> createGuestReview(String id, {
    required double rating,
    required String comment,
    Map<String, dynamic>? aspects,
  });
  
  // Analytics
  Future<Map<String, dynamic>> getBookingAnalytics({
    String? orgId,
    String? propertyId,
    String? dateFrom,
    String? dateTo,
  });
  
  // Risk Assessment
  Future<List<Map<String, dynamic>>> getHighRiskBookings({
    String? orgId,
    double? riskThreshold,
    int? limit,
  });
  
  // Bulk Operations
  Future<List<Map<String, dynamic>>> bulkUpdateStatus(List<String> ids, String status, {String? notes});
  Future<List<PropertyOwnershipVerification>> bulkVerifyOwnership(List<String> ids, {
    required String propertyId,
    required String verificationMethod,
    String? notes,
  });
  
  // Reports
  Future<void> exportBookings({
    String? format,
    String? orgId,
    String? status,
    String? dateFrom,
    String? dateTo,
    bool? includeSecurityScreening,
  });
  
  // Search and Filter
  Future<Map<String, dynamic>> searchBookings(String query, {
    String? orgId,
    String? status,
    String? propertyId,
    String? contactId,
    String? dateFrom,
    String? dateTo,
    String? riskLevel,
    String? verificationStatus,
  });
  
  // Calendar View
  Future<Map<String, dynamic>> getBookingCalendar({
    String? propertyId,
    String? month,
    String? year,
    bool? includeSecurityStatus,
  });
  
  // Availability & Pricing
  Future<Map<String, dynamic>> checkPropertyAvailability(String propertyId, String startDate, String endDate);
  Future<Map<String, dynamic>> getBookingPrice(String propertyId, String startDate, String endDate, int adults, int children);
}

class BookingSecurityRepositoryImpl implements BookingSecurityRepository {
  final BookingSecurityService _service;
  BookingSecurityRepositoryImpl(this._service);

  @override
  Future<Map<String, dynamic>> getBookings({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    String? listingId,
    String? contactId,
    String? status,
    bool? ownershipVerified,
    String? verificationStatus,
    String? startDate,
    String? endDate,
  }) {
    return _service.getBookings(
      page: page,
      limit: limit,
      orgId: orgId,
      listingId: listingId,
      contactId: contactId,
      status: status,
      ownershipVerified: ownershipVerified,
      verificationStatus: verificationStatus,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<Map<String, dynamic>> getBookingById(String id) => _service.getBookingById(id);

  @override
  Future<Map<String, dynamic>> createBooking({
    required String orgId,
    required String listingId,
    required String startDate,
    required String endDate,
    String? contactId,
    int? adults,
    int? children,
    String? notes,
  }) {
    return _service.createBooking(
      orgId: orgId,
      listingId: listingId,
      startDate: startDate,
      endDate: endDate,
      contactId: contactId,
      adults: adults,
      children: children,
      notes: notes,
    );
  }

  @override
  Future<Map<String, dynamic>> updateBooking(String id, Map<String, dynamic> data) => 
    _service.updateBooking(id, data);

  @override
  Future<void> deleteBooking(String id) => _service.deleteBooking(id);

  @override
  Future<Map<String, dynamic>> updateBookingStatus(String id, String status, {String? notes}) => 
    _service.updateBookingStatus(id, status, notes: notes);

  @override
  Future<PropertyOwnershipVerification> verifyOwnership(String id, {
    required String propertyId,
    String? verificationMethod,
    List<dynamic>? documents,
    String? notes,
  }) {
    return _service.verifyOwnership(
      id,
      propertyId: propertyId,
      verificationMethod: verificationMethod,
      documents: documents,
      notes: notes,
    );
  }

  @override
  Future<PropertyOwnershipVerification> getOwnershipVerification(String id) => 
    _service.getOwnershipVerification(id);

  @override
  Future<BookingSecurityScreening> createSecurityScreening(String id, {
    String? riskLevel,
    double? riskScore,
    bool? manualReviewRequired,
    Map<String, dynamic>? screeningMetadata,
    String? notes,
  }) {
    return _service.createSecurityScreening(
      id,
      riskLevel: riskLevel,
      riskScore: riskScore,
      manualReviewRequired: manualReviewRequired,
      screeningMetadata: screeningMetadata,
      notes: notes,
    );
  }

  @override
  Future<List<BookingSecurityScreening>> getSecurityScreenings(String id) => 
    _service.getSecurityScreenings(id);

  @override
  Future<BookingSecurityScreening> updateSecurityScreening(String id, String screeningId, {
    String? screeningStatus,
    double? riskScore,
    String? manualReviewNotes,
  }) {
    return _service.updateSecurityScreening(
      id,
      screeningId,
      screeningStatus: screeningStatus,
      riskScore: riskScore,
      manualReviewNotes: manualReviewNotes,
    );
  }

  @override
  Future<Map<String, dynamic>> getSecurityStatus(String id) => _service.getSecurityStatus(id);

  @override
  Future<Map<String, dynamic>> createGuestReview(String id, {
    required double rating,
    required String comment,
    Map<String, dynamic>? aspects,
  }) {
    return _service.createGuestReview(
      id,
      rating: rating,
      comment: comment,
      aspects: aspects,
    );
  }

  @override
  Future<Map<String, dynamic>> getBookingAnalytics({
    String? orgId,
    String? propertyId,
    String? dateFrom,
    String? dateTo,
  }) {
    return _service.getBookingAnalytics(
      orgId: orgId,
      propertyId: propertyId,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getHighRiskBookings({
    String? orgId,
    double? riskThreshold,
    int? limit,
  }) {
    return _service.getHighRiskBookings(
      orgId: orgId,
      riskThreshold: riskThreshold,
      limit: limit,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> bulkUpdateStatus(List<String> ids, String status, {String? notes}) => 
    _service.bulkUpdateStatus(ids, status, notes: notes);

  @override
  Future<List<PropertyOwnershipVerification>> bulkVerifyOwnership(List<String> ids, {
    required String propertyId,
    required String verificationMethod,
    String? notes,
  }) {
    return _service.bulkVerifyOwnership(
      ids,
      propertyId: propertyId,
      verificationMethod: verificationMethod,
      notes: notes,
    );
  }

  @override
  Future<void> exportBookings({
    String? format,
    String? orgId,
    String? status,
    String? dateFrom,
    String? dateTo,
    bool? includeSecurityScreening,
  }) {
    return _service.exportBookings(
      format: format,
      orgId: orgId,
      status: status,
      dateFrom: dateFrom,
      dateTo: dateTo,
      includeSecurityScreening: includeSecurityScreening,
    );
  }

  @override
  Future<Map<String, dynamic>> searchBookings(String query, {
    String? orgId,
    String? status,
    String? propertyId,
    String? contactId,
    String? dateFrom,
    String? dateTo,
    String? riskLevel,
    String? verificationStatus,
  }) {
    return _service.searchBookings(
      query,
      orgId: orgId,
      status: status,
      propertyId: propertyId,
      contactId: contactId,
      dateFrom: dateFrom,
      dateTo: dateTo,
      riskLevel: riskLevel,
      verificationStatus: verificationStatus,
    );
  }

  @override
  Future<Map<String, dynamic>> getBookingCalendar({
    String? propertyId,
    String? month,
    String? year,
    bool? includeSecurityStatus,
  }) {
    return _service.getBookingCalendar(
      propertyId: propertyId,
      month: month,
      year: year,
      includeSecurityStatus: includeSecurityStatus,
    );
  }

  @override
  Future<Map<String, dynamic>> checkPropertyAvailability(String propertyId, String startDate, String endDate) => 
    _service.checkPropertyAvailability(propertyId, startDate, endDate);

  @override
  Future<Map<String, dynamic>> getBookingPrice(String propertyId, String startDate, String endDate, int adults, int children) => 
    _service.getBookingPrice(propertyId, startDate, endDate, adults, children);
}
