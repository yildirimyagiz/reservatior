import 'property.dart';
import 'user.dart';
import 'organization.dart';
import 'contact.dart';

enum ValuationType {
  BASIC,
  PROFESSIONAL,
  ENTERPRISE,
  INSTANT,
  DETAILED,
}

enum ValuationStatus {
  PENDING,
  PROCESSING,
  COMPLETED,
  FAILED,
  EXPIRED,
}

class PropertyValuation {
  final String id;
  final String propertyId;
  final String? agentId;
  final String orgId;
  final String? userId;
  final ValuationType valuationType;
  final ValuationStatus status;
  final double value;
  final double? confidence;
  final DateTime valuationDate;
  final String source;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Additional fields for UI
  final Map<String, dynamic>? priceRange;
  final Map<String, dynamic>? marketTrends;
  final List<dynamic>? comparableProperties;
  final Map<String, dynamic>? factors;
  final Map<String, dynamic>? aiAnalysis;
  final Map<String, dynamic>? videoAnalysis;
  final Map<String, dynamic>? userBehavior;
  final List<String>? recommendations;
  final List<String>? requirements;
  final Map<String, dynamic>? contactInfo;
  final Map<String, dynamic>? propertyData;
  final String? videoUrl;
  final List<String>? images;
  final String? priority;
  
  // Relations
  final Property? property;
  final User? agent;
  final Organization? organization;
  final User? user;
  final List<ValuationRequest>? valuationRequests;
  final List<ValuationReport>? valuationReports;
  final List<LeadConversion>? leadConversions;

  const PropertyValuation({
    required this.id,
    required this.propertyId,
    this.agentId,
    required this.orgId,
    this.userId,
    required this.valuationType,
    required this.status,
    required this.value,
    this.confidence,
    required this.valuationDate,
    required this.source,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.priceRange,
    this.marketTrends,
    this.comparableProperties,
    this.factors,
    this.aiAnalysis,
    this.videoAnalysis,
    this.userBehavior,
    this.recommendations,
    this.requirements,
    this.contactInfo,
    this.propertyData,
    this.videoUrl,
    this.images,
    this.priority,
    this.property,
    this.agent,
    this.organization,
    this.user,
    this.valuationRequests,
    this.valuationReports,
    this.leadConversions,
  });

  factory PropertyValuation.fromJson(Map<String, dynamic> json) {
    return PropertyValuation(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      agentId: json['agentId'] as String?,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String?,
      valuationType: ValuationType.values.firstWhere(
        (e) => e.name == json['valuationType'],
        orElse: () => ValuationType.BASIC,
      ),
      status: ValuationStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ValuationStatus.PENDING,
      ),
      value: (json['value'] as num).toDouble(),
      confidence: (json['confidence'] as num?)?.toDouble(),
      valuationDate: DateTime.parse(json['valuationDate'] as String),
      source: json['source'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      priceRange: json['priceRange'] as Map<String, dynamic>?,
      marketTrends: json['marketTrends'] as Map<String, dynamic>?,
      comparableProperties: json['comparableProperties'] as List<dynamic>?,
      factors: json['factors'] as Map<String, dynamic>?,
      aiAnalysis: json['aiAnalysis'] as Map<String, dynamic>?,
      videoAnalysis: json['videoAnalysis'] as Map<String, dynamic>?,
      userBehavior: json['userBehavior'] as Map<String, dynamic>?,
      recommendations: (json['recommendations'] as List<dynamic>?)?.cast<String>(),
      requirements: (json['requirements'] as List<dynamic>?)?.cast<String>(),
      contactInfo: json['contactInfo'] as Map<String, dynamic>?,
      propertyData: json['propertyData'] as Map<String, dynamic>?,
      videoUrl: json['videoUrl'] as String?,
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
      priority: json['priority'] as String?,
      property: json['property'] != null 
          ? Property.fromJson(json['property'] as Map<String, dynamic>) 
          : null,
      agent: json['agent'] != null 
          ? User.fromJson(json['agent'] as Map<String, dynamic>) 
          : null,
      organization: json['organization'] != null 
          ? Organization.fromJson(json['organization'] as Map<String, dynamic>) 
          : null,
      user: json['user'] != null 
          ? User.fromJson(json['user'] as Map<String, dynamic>) 
          : null,
      valuationRequests: json['valuationRequests'] != null
          ? (json['valuationRequests'] as List<dynamic>)
              .map((e) => ValuationRequest.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      valuationReports: json['valuationReports'] != null
          ? (json['valuationReports'] as List<dynamic>)
              .map((e) => ValuationReport.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      leadConversions: json['leadConversions'] != null
          ? (json['leadConversions'] as List<dynamic>)
              .map((e) => LeadConversion.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'agentId': agentId,
      'orgId': orgId,
      'userId': userId,
      'valuationType': valuationType.name,
      'status': status.name,
      'value': value,
      'confidence': confidence,
      'valuationDate': valuationDate.toIso8601String(),
      'source': source,
      'metadata': metadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'priceRange': priceRange,
      'marketTrends': marketTrends,
      'comparableProperties': comparableProperties,
      'factors': factors,
      'aiAnalysis': aiAnalysis,
      'videoAnalysis': videoAnalysis,
      'userBehavior': userBehavior,
      'recommendations': recommendations,
      'requirements': requirements,
      'contactInfo': contactInfo,
      'propertyData': propertyData,
      'videoUrl': videoUrl,
      'images': images,
      'priority': priority,
      'property': property?.toJson(),
      'agent': agent?.toJson(),
      'organization': organization?.toJson(),
      'user': user?.toJson(),
      'valuationRequests': valuationRequests?.map((e) => e.toJson()).toList(),
      'valuationReports': valuationReports?.map((e) => e.toJson()).toList(),
      'leadConversions': leadConversions?.map((e) => e.toJson()).toList(),
    };
  }

  PropertyValuation copyWith({
    String? id,
    String? propertyId,
    String? agentId,
    String? orgId,
    String? userId,
    ValuationType? valuationType,
    ValuationStatus? status,
    double? value,
    double? confidence,
    DateTime? valuationDate,
    String? source,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? priceRange,
    Map<String, dynamic>? marketTrends,
    List<dynamic>? comparableProperties,
    Map<String, dynamic>? factors,
    Map<String, dynamic>? aiAnalysis,
    Map<String, dynamic>? videoAnalysis,
    Map<String, dynamic>? userBehavior,
    List<String>? recommendations,
    List<String>? requirements,
    Map<String, dynamic>? contactInfo,
    Map<String, dynamic>? propertyData,
    String? videoUrl,
    List<String>? images,
    String? priority,
    Property? property,
    User? agent,
    Organization? organization,
    User? user,
    List<ValuationRequest>? valuationRequests,
    List<ValuationReport>? valuationReports,
    List<LeadConversion>? leadConversions,
  }) {
    return PropertyValuation(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      agentId: agentId ?? this.agentId,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      valuationType: valuationType ?? this.valuationType,
      status: status ?? this.status,
      value: value ?? this.value,
      confidence: confidence ?? this.confidence,
      valuationDate: valuationDate ?? this.valuationDate,
      source: source ?? this.source,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      priceRange: priceRange ?? this.priceRange,
      marketTrends: marketTrends ?? this.marketTrends,
      comparableProperties: comparableProperties ?? this.comparableProperties,
      factors: factors ?? this.factors,
      aiAnalysis: aiAnalysis ?? this.aiAnalysis,
      videoAnalysis: videoAnalysis ?? this.videoAnalysis,
      userBehavior: userBehavior ?? this.userBehavior,
      recommendations: recommendations ?? this.recommendations,
      requirements: requirements ?? this.requirements,
      contactInfo: contactInfo ?? this.contactInfo,
      propertyData: propertyData ?? this.propertyData,
      videoUrl: videoUrl ?? this.videoUrl,
      images: images ?? this.images,
      priority: priority ?? this.priority,
      property: property ?? this.property,
      agent: agent ?? this.agent,
      organization: organization ?? this.organization,
      user: user ?? this.user,
      valuationRequests: valuationRequests ?? this.valuationRequests,
      valuationReports: valuationReports ?? this.valuationReports,
      leadConversions: leadConversions ?? this.leadConversions,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertyValuation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'PropertyValuation{id: $id, propertyId: $propertyId, value: $value, status: $status}';
  }
}

class ValuationRequest {
  final String id;
  final String valuationId;
  final String userId;
  final String? propertyId;
  final String orgId;
  final String requestType;
  final String priority;
  final Map<String, dynamic>? contactInfo;
  final Map<String, dynamic>? propertyData;
  final String? videoUrl;
  final List<String> images;
  final List<String> requirements;
  final String status;
  final DateTime? processingStartedAt;
  final DateTime? completedAt;
  final double? estimatedPrice;
  final double? confidenceScore;
  final String? errorMessage;
  final Map<String, dynamic>? processingMetadata;
  final Map<String, dynamic>? userFeedback;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Relations
  final PropertyValuation? valuation;
  final User? user;
  final Property? property;
  final Organization? organization;

  const ValuationRequest({
    required this.id,
    required this.valuationId,
    required this.userId,
    this.propertyId,
    required this.orgId,
    required this.requestType,
    required this.priority,
    this.contactInfo,
    this.propertyData,
    this.videoUrl,
    required this.images,
    required this.requirements,
    required this.status,
    this.processingStartedAt,
    this.completedAt,
    this.estimatedPrice,
    this.confidenceScore,
    this.errorMessage,
    this.processingMetadata,
    this.userFeedback,
    required this.createdAt,
    required this.updatedAt,
    this.valuation,
    this.user,
    this.property,
    this.organization,
  });

  factory ValuationRequest.fromJson(Map<String, dynamic> json) {
    return ValuationRequest(
      id: json['id'] as String,
      valuationId: json['valuationId'] as String,
      userId: json['userId'] as String,
      propertyId: json['propertyId'] as String?,
      orgId: json['orgId'] as String,
      requestType: json['requestType'] as String,
      priority: json['priority'] as String,
      contactInfo: json['contactInfo'] as Map<String, dynamic>?,
      propertyData: json['propertyData'] as Map<String, dynamic>?,
      videoUrl: json['videoUrl'] as String?,
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      requirements: (json['requirements'] as List<dynamic>?)?.cast<String>() ?? [],
      status: json['status'] as String,
      processingStartedAt: json['processingStartedAt'] != null 
          ? DateTime.parse(json['processingStartedAt'] as String) 
          : null,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'] as String) 
          : null,
      estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble(),
      confidenceScore: (json['confidenceScore'] as num?)?.toDouble(),
      errorMessage: json['errorMessage'] as String?,
      processingMetadata: json['processingMetadata'] as Map<String, dynamic>?,
      userFeedback: json['userFeedback'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      valuation: json['valuation'] != null 
          ? PropertyValuation.fromJson(json['valuation'] as Map<String, dynamic>) 
          : null,
      user: json['user'] != null 
          ? User.fromJson(json['user'] as Map<String, dynamic>) 
          : null,
      property: json['property'] != null 
          ? Property.fromJson(json['property'] as Map<String, dynamic>) 
          : null,
      organization: json['organization'] != null 
          ? Organization.fromJson(json['organization'] as Map<String, dynamic>) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'valuationId': valuationId,
      'userId': userId,
      'propertyId': propertyId,
      'orgId': orgId,
      'requestType': requestType,
      'priority': priority,
      'contactInfo': contactInfo,
      'propertyData': propertyData,
      'videoUrl': videoUrl,
      'images': images,
      'requirements': requirements,
      'status': status,
      'processingStartedAt': processingStartedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'estimatedPrice': estimatedPrice,
      'confidenceScore': confidenceScore,
      'errorMessage': errorMessage,
      'processingMetadata': processingMetadata,
      'userFeedback': userFeedback,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'valuation': valuation?.toJson(),
      'user': user?.toJson(),
      'property': property?.toJson(),
      'organization': organization?.toJson(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValuationRequest &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class ValuationReport {
  final String id;
  final String valuationId;
  final String userId;
  final String orgId;
  final String reportType;
  final String format;
  final Map<String, dynamic>? content;
  final String? summary;
  final List<String> insights;
  final List<String> recommendations;
  final Map<String, dynamic>? charts;
  final bool isPublic;
  final String? shareToken;
  final int downloadCount;
  final int viewCount;
  final DateTime generatedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Relations
  final PropertyValuation? valuation;
  final User? user;
  final Organization? organization;

  const ValuationReport({
    required this.id,
    required this.valuationId,
    required this.userId,
    required this.orgId,
    required this.reportType,
    required this.format,
    this.content,
    this.summary,
    required this.insights,
    required this.recommendations,
    this.charts,
    required this.isPublic,
    this.shareToken,
    required this.downloadCount,
    required this.viewCount,
    required this.generatedAt,
    required this.createdAt,
    required this.updatedAt,
    this.valuation,
    this.user,
    this.organization,
  });

  factory ValuationReport.fromJson(Map<String, dynamic> json) {
    return ValuationReport(
      id: json['id'] as String,
      valuationId: json['valuationId'] as String,
      userId: json['userId'] as String,
      orgId: json['orgId'] as String,
      reportType: json['reportType'] as String,
      format: json['format'] as String,
      content: json['content'] as Map<String, dynamic>?,
      summary: json['summary'] as String?,
      insights: (json['insights'] as List<dynamic>?)?.cast<String>() ?? [],
      recommendations: (json['recommendations'] as List<dynamic>?)?.cast<String>() ?? [],
      charts: json['charts'] as Map<String, dynamic>?,
      isPublic: json['isPublic'] as bool,
      shareToken: json['shareToken'] as String?,
      downloadCount: json['downloadCount'] as int,
      viewCount: json['viewCount'] as int,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      valuation: json['valuation'] != null 
          ? PropertyValuation.fromJson(json['valuation'] as Map<String, dynamic>) 
          : null,
      user: json['user'] != null 
          ? User.fromJson(json['user'] as Map<String, dynamic>) 
          : null,
      organization: json['organization'] != null 
          ? Organization.fromJson(json['organization'] as Map<String, dynamic>) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'valuationId': valuationId,
      'userId': userId,
      'orgId': orgId,
      'reportType': reportType,
      'format': format,
      'content': content,
      'summary': summary,
      'insights': insights,
      'recommendations': recommendations,
      'charts': charts,
      'isPublic': isPublic,
      'shareToken': shareToken,
      'downloadCount': downloadCount,
      'viewCount': viewCount,
      'generatedAt': generatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'valuation': valuation?.toJson(),
      'user': user?.toJson(),
      'organization': organization?.toJson(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValuationReport &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class LeadConversion {
  final String id;
  final String valuationId;
  final String? contactId;
  final String orgId;
  final String conversionType;
  final double? conversionValue;
  final double? commissionAmount;
  final String status;
  final DateTime? convertedAt;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Relations
  final PropertyValuation? valuation;
  final Contact? contact;
  final Organization? organization;

  const LeadConversion({
    required this.id,
    required this.valuationId,
    this.contactId,
    required this.orgId,
    required this.conversionType,
    this.conversionValue,
    this.commissionAmount,
    required this.status,
    this.convertedAt,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.valuation,
    this.contact,
    this.organization,
  });

  factory LeadConversion.fromJson(Map<String, dynamic> json) {
    return LeadConversion(
      id: json['id'] as String,
      valuationId: json['valuationId'] as String,
      contactId: json['contactId'] as String?,
      orgId: json['orgId'] as String,
      conversionType: json['conversionType'] as String,
      conversionValue: (json['conversionValue'] as num?)?.toDouble(),
      commissionAmount: (json['commissionAmount'] as num?)?.toDouble(),
      status: json['status'] as String,
      convertedAt: json['convertedAt'] != null 
          ? DateTime.parse(json['convertedAt'] as String) 
          : null,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      valuation: json['valuation'] != null 
          ? PropertyValuation.fromJson(json['valuation'] as Map<String, dynamic>) 
          : null,
      contact: json['contact'] != null 
          ? Contact.fromJson(json['contact'] as Map<String, dynamic>) 
          : null,
      organization: json['organization'] != null 
          ? Organization.fromJson(json['organization'] as Map<String, dynamic>) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'valuationId': valuationId,
      'contactId': contactId,
      'orgId': orgId,
      'conversionType': conversionType,
      'conversionValue': conversionValue,
      'commissionAmount': commissionAmount,
      'status': status,
      'convertedAt': convertedAt?.toIso8601String(),
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'valuation': valuation?.toJson(),
      'contact': contact?.toJson(),
      'organization': organization?.toJson(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeadConversion &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
