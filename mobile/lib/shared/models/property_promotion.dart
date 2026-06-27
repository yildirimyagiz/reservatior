import 'package:reservatior/shared/enums/property_promotion_status.dart';
import 'package:reservatior/shared/enums/property_promotion_type.dart';
import 'agency.dart';
import 'agent.dart';
import 'property.dart';
import 'user.dart';

class PropertyPromotion {
  final String id;
  final String propertyId;
  final String? agencyId;
  final String? agentId;
  final PropertyPromotionType promotionType;
  final PropertyPromotionStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final String currency;
  final bool isAutoRenew;
  final List<String> features;
  final String? paymentHistoryId;
  final String? userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Property property;
  final Agency? agency;
  final Agent? agent;
  final User? user;

  const PropertyPromotion({
    required this.id,
    required this.propertyId,
    this.agencyId,
    this.agentId,
    required this.promotionType,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.currency,
    required this.isAutoRenew,
    this.features = const [],
    this.paymentHistoryId,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.property,
    this.agency,
    this.agent,
    this.user,
  });

  factory PropertyPromotion.fromJson(Map<String, dynamic> json) {
    return PropertyPromotion(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      agencyId: json['agencyId'] as String?,
      agentId: json['agentId'] as String?,
      promotionType: (() {
        final valUpper = json['promotionType']?.toString().toUpperCase() ?? '';
        return PropertyPromotionType.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => PropertyPromotionType.FEATURED,
        );
      })(),
      status: (() {
        final valUpper = json['status']?.toString().toUpperCase() ?? '';
        return PropertyPromotionStatus.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => PropertyPromotionStatus.ACTIVE,
        );
      })(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      isAutoRenew: json['isAutoRenew'] as bool,
      features: (json['features'] as List<dynamic>?)?.cast<String>() ?? [],
      paymentHistoryId: json['paymentHistoryId'] as String?,
      userId: json['userId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      property: Property.fromJson(json['Property'] as Map<String, dynamic>),
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as Map<String, dynamic>) : null,
      user: json['User'] != null ? User.fromJson(json['User'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'agencyId': agencyId,
      'agentId': agentId,
      'promotionType': promotionType.name,
      'status': status.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'price': price,
      'currency': currency,
      'isAutoRenew': isAutoRenew,
      'features': features,
      'paymentHistoryId': paymentHistoryId,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'Property': property.toJson(),
      'Agency': agency?.toJson(),
      'Agent': agent?.toJson(),
      'User': user?.toJson(),
    };
  }

  PropertyPromotion copyWith({
    String? id,
    String? propertyId,
    String? agencyId,
    String? agentId,
    PropertyPromotionType? promotionType,
    PropertyPromotionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    double? price,
    String? currency,
    bool? isAutoRenew,
    List<String>? features,
    String? paymentHistoryId,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Property? property,
    Agency? agency,
    Agent? agent,
    User? user,
  }) {
    return PropertyPromotion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      agencyId: agencyId ?? this.agencyId,
      agentId: agentId ?? this.agentId,
      promotionType: promotionType ?? this.promotionType,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      isAutoRenew: isAutoRenew ?? this.isAutoRenew,
      features: features ?? this.features,
      paymentHistoryId: paymentHistoryId ?? this.paymentHistoryId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      property: property ?? this.property,
      agency: agency ?? this.agency,
      agent: agent ?? this.agent,
      user: user ?? this.user,
    );
  }
}
