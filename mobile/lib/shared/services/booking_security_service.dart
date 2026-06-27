import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/booking_security.dart';

class BookingSecurityService {
  final DioClient _dioClient;
  BookingSecurityService(this._dioClient);

  // Bookings with Security
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
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (listingId != null) 'listingId': listingId,
      if (contactId != null) 'contactId': contactId,
      if (status != null) 'status': status,
      if (ownershipVerified != null) 'ownershipVerified': ownershipVerified,
      if (verificationStatus != null) 'verificationStatus': verificationStatus,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
    };
    final response = await _dioClient.get(ApiEndpoints.bookings, queryParameters: queryParams);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getBookingById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.bookings}/$id');
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> createBooking({
    required String orgId,
    required String listingId,
    required String startDate,
    required String endDate,
    String? contactId,
    int? adults,
    int? children,
    String? notes,
  }) async {
    final data = {
      'orgId': orgId,
      'listingId': listingId,
      'startDate': startDate,
      'endDate': endDate,
      if (contactId != null) 'contactId': contactId,
      if (adults != null) 'adults': adults,
      if (children != null) 'children': children,
      if (notes != null) 'notes': notes,
    };
    final response = await _dioClient.post(ApiEndpoints.bookings, data: data);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateBooking(String id, Map<String, dynamic> data) async {
    final response = await _dioClient.patch('${ApiEndpoints.bookings}/$id', data: data);
    return response.data as Map<String, dynamic>;
  }

  Future<void> deleteBooking(String id) async {
    await _dioClient.delete('${ApiEndpoints.bookings}/$id');
  }

  // Status Management
  Future<Map<String, dynamic>> updateBookingStatus(String id, String status, {String? notes}) async {
    final data = {
      'status': status,
      if (notes != null) 'notes': notes,
    };
    final response = await _dioClient.patch('${ApiEndpoints.bookings}/$id/status', data: data);
    return response.data as Map<String, dynamic>;
  }

  // Ownership Verification
  Future<PropertyOwnershipVerification> verifyOwnership(String id, {
    required String propertyId,
    String? verificationMethod,
    List<dynamic>? documents,
    String? notes,
  }) async {
    final data = {
      'propertyId': propertyId,
      if (verificationMethod != null) 'verificationMethod': verificationMethod,
      if (documents != null) 'documents': documents,
      if (notes != null) 'notes': notes,
    };
    final response = await _dioClient.post('${ApiEndpoints.bookings}/$id/verify-ownership', data: data);
    return PropertyOwnershipVerification.fromJson(response.data['data']);
  }

  Future<PropertyOwnershipVerification> getOwnershipVerification(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.bookings}/$id/ownership-verification');
    return PropertyOwnershipVerification.fromJson(response.data['data']);
  }

  // Security Screening
  Future<BookingSecurityScreening> createSecurityScreening(String id, {
    String? riskLevel,
    double? riskScore,
    bool? manualReviewRequired,
    Map<String, dynamic>? screeningMetadata,
    String? notes,
  }) async {
    final data = {
      if (riskLevel != null) 'riskLevel': riskLevel,
      if (riskScore != null) 'riskScore': riskScore,
      if (manualReviewRequired != null) 'manualReviewRequired': manualReviewRequired,
      if (screeningMetadata != null) 'screeningMetadata': screeningMetadata,
      if (notes != null) 'notes': notes,
    };
    final response = await _dioClient.post('${ApiEndpoints.bookings}/$id/security-screening', data: data);
    return BookingSecurityScreening.fromJson(response.data['data']);
  }

  Future<List<BookingSecurityScreening>> getSecurityScreenings(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.bookings}/$id/security-screenings');
    final data = response.data['data'] as List;
    return data.map((json) => BookingSecurityScreening.fromJson(json)).toList();
  }

  Future<BookingSecurityScreening> updateSecurityScreening(String id, String screeningId, {
    String? screeningStatus,
    double? riskScore,
    String? manualReviewNotes,
  }) async {
    final data = {
      if (screeningStatus != null) 'screeningStatus': screeningStatus,
      if (riskScore != null) 'riskScore': riskScore,
      if (manualReviewNotes != null) 'manualReviewNotes': manualReviewNotes,
    };
    final response = await _dioClient.patch('${ApiEndpoints.bookings}/$id/security-screenings/$screeningId', data: data);
    return BookingSecurityScreening.fromJson(response.data['data']);
  }

  // Security Status
  Future<Map<String, dynamic>> getSecurityStatus(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.bookings}/$id/security-status');
    return response.data as Map<String, dynamic>;
  }

  // Guest Review
  Future<Map<String, dynamic>> createGuestReview(String id, {
    required double rating,
    required String comment,
    Map<String, dynamic>? aspects,
  }) async {
    final data = {
      'rating': rating,
      'comment': comment,
      if (aspects != null) 'aspects': aspects,
    };
    final response = await _dioClient.post('${ApiEndpoints.bookings}/$id/guest-review', data: data);
    return response.data as Map<String, dynamic>;
  }

  // Analytics
  Future<Map<String, dynamic>> getBookingAnalytics({
    String? orgId,
    String? propertyId,
    String? dateFrom,
    String? dateTo,
  }) async {
    final queryParams = {
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
    };
    final response = await _dioClient.get('${ApiEndpoints.bookings}/analytics', queryParameters: queryParams);
    return response.data as Map<String, dynamic>;
  }

  // Risk Assessment
  Future<List<Map<String, dynamic>>> getHighRiskBookings({
    String? orgId,
    double? riskThreshold,
    int? limit,
  }) async {
    final queryParams = {
      if (orgId != null) 'orgId': orgId,
      if (riskThreshold != null) 'riskThreshold': riskThreshold,
      if (limit != null) 'limit': limit,
    };
    final response = await _dioClient.get('${ApiEndpoints.bookings}/high-risk', queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((item) => item as Map<String, dynamic>).toList();
  }

  // Bulk Operations
  Future<List<Map<String, dynamic>>> bulkUpdateStatus(List<String> ids, String status, {String? notes}) async {
    final data = {
      'ids': ids,
      'status': status,
      if (notes != null) 'notes': notes,
    };
    final response = await _dioClient.patch('${ApiEndpoints.bookings}/bulk-status', data: data);
    final responseData = response.data['data'] as List;
    return responseData.map((item) => item as Map<String, dynamic>).toList();
  }

  Future<List<PropertyOwnershipVerification>> bulkVerifyOwnership(List<String> ids, {
    required String propertyId,
    required String verificationMethod,
    String? notes,
  }) async {
    final data = {
      'ids': ids,
      'propertyId': propertyId,
      'verificationMethod': verificationMethod,
      if (notes != null) 'notes': notes,
    };
    final response = await _dioClient.post('${ApiEndpoints.bookings}/bulk-verify-ownership', data: data);
    final responseData = response.data['data'] as List;
    return responseData.map((json) => PropertyOwnershipVerification.fromJson(json)).toList();
  }

  // Reports
  Future<void> exportBookings({
    String? format,
    String? orgId,
    String? status,
    String? dateFrom,
    String? dateTo,
    bool? includeSecurityScreening,
  }) async {
    final queryParams = {
      if (format != null) 'format': format,
      if (orgId != null) 'orgId': orgId,
      if (status != null) 'status': status,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
      if (includeSecurityScreening != null) 'includeSecurityScreening': includeSecurityScreening,
    };
    await _dioClient.get('${ApiEndpoints.bookings}/export', queryParameters: queryParams);
  }

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
  }) async {
    final queryParams = {
      'query': query,
      if (orgId != null) 'orgId': orgId,
      if (status != null) 'status': status,
      if (propertyId != null) 'propertyId': propertyId,
      if (contactId != null) 'contactId': contactId,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
      if (riskLevel != null) 'riskLevel': riskLevel,
      if (verificationStatus != null) 'verificationStatus': verificationStatus,
    };
    final response = await _dioClient.get('${ApiEndpoints.bookings}/search', queryParameters: queryParams);
    return response.data as Map<String, dynamic>;
  }

  // Calendar View
  Future<Map<String, dynamic>> getBookingCalendar({
    String? propertyId,
    String? month,
    String? year,
    bool? includeSecurityStatus,
  }) async {
    final queryParams = {
      if (propertyId != null) 'propertyId': propertyId,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (includeSecurityStatus != null) 'includeSecurityStatus': includeSecurityStatus,
    };
    final response = await _dioClient.get('${ApiEndpoints.bookings}/calendar', queryParameters: queryParams);
    return response.data as Map<String, dynamic>;
  }

  // Availability & Pricing
  Future<Map<String, dynamic>> checkPropertyAvailability(String propertyId, String startDate, String endDate) async {
    final queryParams = {
      'startDate': startDate,
      'endDate': endDate,
    };
    final response = await _dioClient.get('${ApiEndpoints.properties}/$propertyId/availability', queryParameters: queryParams);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getBookingPrice(String propertyId, String startDate, String endDate, int adults, int children) async {
    final queryParams = {
      'startDate': startDate,
      'endDate': endDate,
      'adults': adults,
      'children': children,
    };
    final response = await _dioClient.get('${ApiEndpoints.properties}/$propertyId/pricing', queryParameters: queryParams);
    return response.data as Map<String, dynamic>;
  }
}
