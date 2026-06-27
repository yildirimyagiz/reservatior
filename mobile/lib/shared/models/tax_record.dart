import 'analytics.dart';
import 'currency.dart';
import 'organization.dart';

class TaxRecord {
  final String id;
  final String orgId;
  final String? profileId;
  final String? transactionId;
  final String? propertyId;
  final String? contactId;
  final String recordType;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final TaxRecord? profile;
  final List<TaxRecord> profiles;
  final List<Currency> currencies;
  final List<Analytics> analytics;

  const TaxRecord({
    required this.id,
    required this.orgId,
    this.profileId,
    this.transactionId,
    this.propertyId,
    this.contactId,
    required this.recordType,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    this.profile,
    this.profiles = const [],
    this.currencies = const [],
    this.analytics = const [],
  });

  factory TaxRecord.fromJson(Map<String, dynamic> json) {
    return TaxRecord(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      profileId: json['profileId'] as String?,
      transactionId: json['transactionId'] as String?,
      propertyId: json['propertyId'] as String?,
      contactId: json['contactId'] as String?,
      recordType: json['recordType'] as String,
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      profile: json['Profile'] != null ? TaxRecord.fromJson(json['Profile'] as Map<String, dynamic>) : null,
      profiles: (json['profile'] as List<dynamic>?)?.map((e) => TaxRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      currencies: (json['currencies'] as List<dynamic>?)?.map((e) => Currency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      analytics: (json['analytics'] as List<dynamic>?)?.map((e) => Analytics.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'profileId': profileId,
      'transactionId': transactionId,
      'propertyId': propertyId,
      'contactId': contactId,
      'recordType': recordType,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'Profile': profile?.toJson(),
      'profile': profiles.map((e) => e.toJson()).toList(),
      'currencies': currencies.map((e) => e.toJson()).toList(),
      'analytics': analytics.map((e) => e.toJson()).toList(),
    };
  }

  TaxRecord copyWith({
    String? id,
    String? orgId,
    String? profileId,
    String? transactionId,
    String? propertyId,
    String? contactId,
    String? recordType,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    TaxRecord? profile,
    List<TaxRecord>? profiles,
    List<Currency>? currencies,
    List<Analytics>? analytics,
  }) {
    return TaxRecord(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      profileId: profileId ?? this.profileId,
      transactionId: transactionId ?? this.transactionId,
      propertyId: propertyId ?? this.propertyId,
      contactId: contactId ?? this.contactId,
      recordType: recordType ?? this.recordType,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      profile: profile ?? this.profile,
      profiles: profiles ?? this.profiles,
      currencies: currencies ?? this.currencies,
      analytics: analytics ?? this.analytics,
    );
  }
}
