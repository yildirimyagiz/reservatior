import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/ownership_verification.dart';

class OwnershipVerificationService {
  final DioClient _dioClient;
  OwnershipVerificationService(this._dioClient);

  // Ownership Verifications
  Future<PropertyOwnershipVerification> getOwnershipVerificationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.ownershipVerifications}/$id');
    return PropertyOwnershipVerification.fromJson(response.data['data']);
  }

  Future<List<PropertyOwnershipVerification>> getOwnershipVerifications({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    String? propertyId,
    String? currentOwnerId,
    String? verificationStatus,
    String? verificationMethod,
    bool? priorityVerification,
    String? dateFrom,
    String? dateTo,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (currentOwnerId != null) 'currentOwnerId': currentOwnerId,
      if (verificationStatus != null) 'verificationStatus': verificationStatus,
      if (verificationMethod != null) 'verificationMethod': verificationMethod,
      if (priorityVerification != null) 'priorityVerification': priorityVerification,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
    };
    final response = await _dioClient.get(ApiEndpoints.ownershipVerifications, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyOwnershipVerification.fromJson(json)).toList();
  }

  Future<PropertyOwnershipVerification> createOwnershipVerification({
    required String propertyId,
    required String orgId,
    String? currentOwnerId,
    required String verificationMethod,
    bool? priorityVerification,
    String? verificationNotes,
    Map<String, dynamic>? supportingDocuments,
    Map<String, dynamic>? ownershipHistory,
    String? legalDescription,
    String? parcelNumber,
    String? jurisdiction,
    DateTime? recordingDate,
    Map<String, dynamic>? chainOfCustody,
    Map<String, dynamic>? verificationMetadata,
  }) async {
    final data = {
      'propertyId': propertyId,
      'orgId': orgId,
      if (currentOwnerId != null) 'currentOwnerId': currentOwnerId,
      'verificationMethod': verificationMethod,
      if (priorityVerification != null) 'priorityVerification': priorityVerification,
      if (verificationNotes != null) 'verificationNotes': verificationNotes,
      if (supportingDocuments != null) 'supportingDocuments': supportingDocuments,
      if (ownershipHistory != null) 'ownershipHistory': ownershipHistory,
      if (legalDescription != null) 'legalDescription': legalDescription,
      if (parcelNumber != null) 'parcelNumber': parcelNumber,
      if (jurisdiction != null) 'jurisdiction': jurisdiction,
      if (recordingDate != null) 'recordingDate': recordingDate.toIso8601String(),
      if (chainOfCustody != null) 'chainOfCustody': chainOfCustody,
      if (verificationMetadata != null) 'verificationMetadata': verificationMetadata,
    };
    final response = await _dioClient.post(ApiEndpoints.ownershipVerifications, data: data);
    return PropertyOwnershipVerification.fromJson(response.data['data']);
  }

  Future<PropertyOwnershipVerification> updateOwnershipVerification(String id, {
    OwnershipVerificationStatus? verificationStatus,
    String? verifiedBy,
    DateTime? expiresAt,
    String? rejectionReason,
    String? governmentTransactionId,
    double? aiConfidenceScore,
    bool? manualReviewRequired,
    bool? priorityVerification,
    String? verificationNotes,
    Map<String, dynamic>? supportingDocuments,
    Map<String, dynamic>? verificationMetadata,
  }) async {
    final data = {
      if (verificationStatus != null) 'verificationStatus': verificationStatus.name,
      if (verifiedBy != null) 'verifiedBy': verifiedBy,
      if (expiresAt != null) 'expiresAt': expiresAt.toIso8601String(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      if (governmentTransactionId != null) 'governmentTransactionId': governmentTransactionId,
      if (aiConfidenceScore != null) 'aiConfidenceScore': aiConfidenceScore,
      if (manualReviewRequired != null) 'manualReviewRequired': manualReviewRequired,
      if (priorityVerification != null) 'priorityVerification': priorityVerification,
      if (verificationNotes != null) 'verificationNotes': verificationNotes,
      if (supportingDocuments != null) 'supportingDocuments': supportingDocuments,
      if (verificationMetadata != null) 'verificationMetadata': verificationMetadata,
    };
    final response = await _dioClient.patch('${ApiEndpoints.ownershipVerifications}/$id', data: data);
    return PropertyOwnershipVerification.fromJson(response.data['data']);
  }

  Future<void> deleteOwnershipVerification(String id) async {
    await _dioClient.delete('${ApiEndpoints.ownershipVerifications}/$id');
  }

  // Verification Processing
  Future<PropertyOwnershipVerification> verifyOwnership(String id, {
    String? verifiedBy,
    String? governmentTransactionId,
    double? aiConfidenceScore,
    String? verificationNotes,
    Map<String, dynamic>? verificationMetadata,
  }) async {
    final data = {
      if (verifiedBy != null) 'verifiedBy': verifiedBy,
      if (governmentTransactionId != null) 'governmentTransactionId': governmentTransactionId,
      if (aiConfidenceScore != null) 'aiConfidenceScore': aiConfidenceScore,
      if (verificationNotes != null) 'verificationNotes': verificationNotes,
      if (verificationMetadata != null) 'verificationMetadata': verificationMetadata,
    };
    final response = await _dioClient.post('${ApiEndpoints.ownershipVerifications}/$id/verify', data: data);
    return PropertyOwnershipVerification.fromJson(response.data['data']);
  }

  Future<PropertyOwnershipVerification> rejectOwnership(String id, {
    required String rejectionReason,
    String? verifiedBy,
    String? verificationNotes,
  }) async {
    final data = {
      'rejectionReason': rejectionReason,
      if (verifiedBy != null) 'verifiedBy': verifiedBy,
      if (verificationNotes != null) 'verificationNotes': verificationNotes,
    };
    final response = await _dioClient.post('${ApiEndpoints.ownershipVerifications}/$id/reject', data: data);
    return PropertyOwnershipVerification.fromJson(response.data['data']);
  }

  // Document Management
  Future<OwnershipVerificationDocument> uploadDocument(String verificationId, {
    required String type,
    required String url,
    String? status,
  }) async {
    final data = {
      'verificationId': verificationId,
      'type': type,
      'url': url,
      if (status != null) 'status': status,
    };
    final response = await _dioClient.post('${ApiEndpoints.ownershipVerifications}/$verificationId/documents', data: data);
    return OwnershipVerificationDocument.fromJson(response.data['data']);
  }

  Future<List<OwnershipVerificationDocument>> getDocuments(String verificationId) async {
    final response = await _dioClient.get('${ApiEndpoints.ownershipVerifications}/$verificationId/documents');
    final data = response.data['data'] as List;
    return data.map((json) => OwnershipVerificationDocument.fromJson(json)).toList();
  }

  Future<OwnershipVerificationDocument> updateDocument(String verificationId, String documentId, {
    String? type,
    String? url,
    String? status,
  }) async {
    final data = {
      if (type != null) 'type': type,
      if (url != null) 'url': url,
      if (status != null) 'status': status,
    };
    final response = await _dioClient.patch('${ApiEndpoints.ownershipVerifications}/$verificationId/documents/$documentId', data: data);
    return OwnershipVerificationDocument.fromJson(response.data['data']);
  }

  Future<void> deleteDocument(String verificationId, String documentId) async {
    await _dioClient.delete('${ApiEndpoints.ownershipVerifications}/$verificationId/documents/$documentId');
  }

  // AI Analysis
  Future<Map<String, dynamic>> analyzeOwnership(String id, {
    Map<String, dynamic>? documents,
    Map<String, dynamic>? propertyData,
    Map<String, dynamic>? ownerData,
  }) async {
    final data = {
      if (documents != null) 'documents': documents,
      if (propertyData != null) 'propertyData': propertyData,
      if (ownerData != null) 'ownerData': ownerData,
    };
    final response = await _dioClient.post('${ApiEndpoints.ownershipVerifications}/$id/analyze', data: data);
    return response.data as Map<String, dynamic>;
  }

  // Government Integration
  Future<Map<String, dynamic>> checkGovernmentRecords(String id, {
    String? jurisdiction,
    String? parcelNumber,
    String? legalDescription,
  }) async {
    final queryParams = {
      if (jurisdiction != null) 'jurisdiction': jurisdiction,
      if (parcelNumber != null) 'parcelNumber': parcelNumber,
      if (legalDescription != null) 'legalDescription': legalDescription,
    };
    final response = await _dioClient.get('${ApiEndpoints.ownershipVerifications}/$id/government-check', queryParameters: queryParams);
    return response.data as Map<String, dynamic>;
  }

  // Blockchain Verification
  Future<Map<String, dynamic>> verifyOnBlockchain(String id, {
    Map<String, dynamic>? ownershipData,
    Map<String, dynamic>? transactionData,
  }) async {
    final data = {
      if (ownershipData != null) 'ownershipData': ownershipData,
      if (transactionData != null) 'transactionData': transactionData,
    };
    final response = await _dioClient.post('${ApiEndpoints.ownershipVerifications}/$id/blockchain-verify', data: data);
    return response.data as Map<String, dynamic>;
  }

  // Bulk Operations
  Future<List<PropertyOwnershipVerification>> bulkUpdateVerifications(List<String> ids, Map<String, dynamic> data) async {
    final response = await _dioClient.patch('${ApiEndpoints.ownershipVerifications}/bulk', data: {
      'ids': ids,
      ...data,
    });
    final responseData = response.data['data'] as List;
    return responseData.map((json) => PropertyOwnershipVerification.fromJson(json)).toList();
  }

  Future<List<PropertyOwnershipVerification>> bulkVerifyOwnership(List<String> ids, {
    required String verificationMethod,
    String? verifiedBy,
    Map<String, dynamic>? verificationMetadata,
  }) async {
    final data = {
      'ids': ids,
      'verificationMethod': verificationMethod,
      if (verifiedBy != null) 'verifiedBy': verifiedBy,
      if (verificationMetadata != null) 'verificationMetadata': verificationMetadata,
    };
    final response = await _dioClient.post('${ApiEndpoints.ownershipVerifications}/bulk-verify', data: data);
    final responseData = response.data['data'] as List;
    return responseData.map((json) => PropertyOwnershipVerification.fromJson(json)).toList();
  }

  // Export
  Future<void> exportVerifications({
    String? format,
    String? orgId,
    String? propertyId,
    String? verificationStatus,
    String? dateFrom,
    String? dateTo,
  }) async {
    final queryParams = {
      if (format != null) 'format': format,
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (verificationStatus != null) 'verificationStatus': verificationStatus,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
    };
    await _dioClient.get('${ApiEndpoints.ownershipVerifications}/export', queryParameters: queryParams);
  }

  // Search
  Future<List<PropertyOwnershipVerification>> searchVerifications(String query, {
    String? orgId,
    String? propertyId,
    String? verificationStatus,
    String? verificationMethod,
    String? dateFrom,
    String? dateTo,
  }) async {
    final queryParams = {
      'query': query,
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (verificationStatus != null) 'verificationStatus': verificationStatus,
      if (verificationMethod != null) 'verificationMethod': verificationMethod,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
    };
    final response = await _dioClient.get('${ApiEndpoints.ownershipVerifications}/search', queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyOwnershipVerification.fromJson(json)).toList();
  }

  // Statistics
  Future<Map<String, dynamic>> getVerificationStats({
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
    final response = await _dioClient.get('${ApiEndpoints.ownershipVerifications}/stats', queryParameters: queryParams);
    return response.data as Map<String, dynamic>;
  }

  // Verification Methods
  Future<Map<String, dynamic>> getAvailableVerificationMethods() async {
    final response = await _dioClient.get('${ApiEndpoints.ownershipVerifications}/methods');
    return response.data as Map<String, dynamic>;
  }

  // Document Types
  Future<Map<String, dynamic>> getDocumentTypes() async {
    final response = await _dioClient.get('${ApiEndpoints.ownershipVerifications}/document-types');
    return response.data as Map<String, dynamic>;
  }

  // Jurisdictions
  Future<Map<String, dynamic>> getSupportedJurisdictions() async {
    final response = await _dioClient.get('${ApiEndpoints.ownershipVerifications}/jurisdictions');
    return response.data as Map<String, dynamic>;
  }
}
