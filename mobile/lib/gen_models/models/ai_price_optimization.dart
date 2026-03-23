//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'listing.dart';
import 'organization.dart';

class AIPriceOptimization
    implements PrismaModel<String, AIPriceOptimization>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? listingId;
  double? currentPrice;
  double? recommendedPrice;
  dynamic priceRange;
  dynamic factors;
  dynamic comparableData;
  dynamic marketTrends;
  double? confidence;
  DateTime? generatedAt;
  bool? isApplied;
  DateTime? appliedAt;
  DateTime? createdAt;
  Listing? listing;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  AIPriceOptimization({
    this.id,
    this.orgId,
    this.listingId,
    this.currentPrice,
    this.recommendedPrice,
    required this.priceRange,
    required this.factors,
    required this.comparableData,
    required this.marketTrends,
    this.confidence,
    this.generatedAt,
    this.isApplied = false,
    this.appliedAt,
    this.createdAt,
    this.listing,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<AIPriceOptimization, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "listingId": (m) => m.listingId,
    "currentPrice": (m) => m.currentPrice,
    "recommendedPrice": (m) => m.recommendedPrice,
    "priceRange": (m) => m.priceRange,
    "factors": (m) => m.factors,
    "comparableData": (m) => m.comparableData,
    "marketTrends": (m) => m.marketTrends,
    "confidence": (m) => m.confidence,
    "generatedAt": (m) => m.generatedAt,
    "isApplied": (m) => m.isApplied,
    "appliedAt": (m) => m.appliedAt,
    "createdAt": (m) => m.createdAt,
    "listing": (m) => m.listing,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(AIPriceOptimization) getPropToValueFunction<V>(
      String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception(
          'Property "$propertyName" not found in AIPriceOptimization');
    }
    return propFunction as V? Function(AIPriceOptimization);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory AIPriceOptimization.fromJson(JsonMap json) => AIPriceOptimization(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        listingId: json['listingId'] as String?,
        currentPrice: json['currentPrice'] as double?,
        recommendedPrice: json['recommendedPrice'] as double?,
        priceRange: json['priceRange'] as dynamic,
        factors: json['factors'] as dynamic,
        comparableData: json['comparableData'] as dynamic,
        marketTrends: json['marketTrends'] as dynamic,
        confidence: json['confidence']?.toDouble(),
        generatedAt: json['generatedAt'] != null
            ? DateTime.parse(json['generatedAt'])
            : null,
        isApplied: json['isApplied'] as bool?,
        appliedAt: json['appliedAt'] != null
            ? DateTime.parse(json['appliedAt'])
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        listing: json['listing'] != null
            ? Listing.fromJson(json['listing'] as JsonMap)
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  AIPriceOptimization copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? listingId,
    Value<double?>? currentPrice,
    Value<double?>? recommendedPrice,
    Value<dynamic>? priceRange,
    Value<dynamic>? factors,
    Value<dynamic>? comparableData,
    Value<dynamic>? marketTrends,
    Value<double?>? confidence,
    Value<DateTime?>? generatedAt,
    Value<bool?>? isApplied,
    Value<DateTime?>? appliedAt,
    Value<DateTime?>? createdAt,
    Value<Listing?>? listing,
    Value<Organization?>? org,
  }) {
    return AIPriceOptimization(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        listingId: listingId != null ? listingId.value : this.listingId,
        currentPrice:
            currentPrice != null ? currentPrice.value : this.currentPrice,
        recommendedPrice: recommendedPrice != null
            ? recommendedPrice.value
            : this.recommendedPrice,
        priceRange: priceRange != null ? priceRange.value : this.priceRange,
        factors: factors != null ? factors.value : this.factors,
        comparableData:
            comparableData != null ? comparableData.value : this.comparableData,
        marketTrends:
            marketTrends != null ? marketTrends.value : this.marketTrends,
        confidence: confidence != null ? confidence.value : this.confidence,
        generatedAt: generatedAt != null ? generatedAt.value : this.generatedAt,
        isApplied: isApplied != null ? isApplied.value : this.isApplied,
        appliedAt: appliedAt != null ? appliedAt.value : this.appliedAt,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        listing: listing != null ? listing.value : this.listing,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  AIPriceOptimization copyWithInstanceValues(
      AIPriceOptimization aIPriceOptimization) {
    return AIPriceOptimization(
        id: aIPriceOptimization.id ?? id,
        orgId: aIPriceOptimization.orgId ?? orgId,
        listingId: aIPriceOptimization.listingId ?? listingId,
        currentPrice: aIPriceOptimization.currentPrice ?? currentPrice,
        recommendedPrice:
            aIPriceOptimization.recommendedPrice ?? recommendedPrice,
        priceRange: aIPriceOptimization.priceRange ?? priceRange,
        factors: aIPriceOptimization.factors ?? factors,
        comparableData: aIPriceOptimization.comparableData ?? comparableData,
        marketTrends: aIPriceOptimization.marketTrends ?? marketTrends,
        confidence: aIPriceOptimization.confidence ?? confidence,
        generatedAt: aIPriceOptimization.generatedAt ?? generatedAt,
        isApplied: aIPriceOptimization.isApplied ?? isApplied,
        appliedAt: aIPriceOptimization.appliedAt ?? appliedAt,
        createdAt: aIPriceOptimization.createdAt ?? createdAt,
        listing: aIPriceOptimization.listing ?? listing,
        org: aIPriceOptimization.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  AIPriceOptimization mergeWithInstanceValues(
      AIPriceOptimization aIPriceOptimization) {
    return AIPriceOptimization(
        id: aIPriceOptimization.$assignedFields.contains('id')
            ? aIPriceOptimization.id
            : id,
        orgId: aIPriceOptimization.$assignedFields.contains('orgId')
            ? aIPriceOptimization.orgId
            : orgId,
        listingId: aIPriceOptimization.$assignedFields.contains('listingId')
            ? aIPriceOptimization.listingId
            : listingId,
        currentPrice:
            aIPriceOptimization.$assignedFields.contains('currentPrice')
                ? aIPriceOptimization.currentPrice
                : currentPrice,
        recommendedPrice:
            aIPriceOptimization.$assignedFields.contains('recommendedPrice')
                ? aIPriceOptimization.recommendedPrice
                : recommendedPrice,
        priceRange: aIPriceOptimization.$assignedFields.contains('priceRange')
            ? aIPriceOptimization.priceRange
            : priceRange,
        factors: aIPriceOptimization.$assignedFields.contains('factors')
            ? aIPriceOptimization.factors
            : factors,
        comparableData:
            aIPriceOptimization.$assignedFields.contains('comparableData')
                ? aIPriceOptimization.comparableData
                : comparableData,
        marketTrends:
            aIPriceOptimization.$assignedFields.contains('marketTrends')
                ? aIPriceOptimization.marketTrends
                : marketTrends,
        confidence: aIPriceOptimization.$assignedFields.contains('confidence')
            ? aIPriceOptimization.confidence
            : confidence,
        generatedAt: aIPriceOptimization.$assignedFields.contains('generatedAt')
            ? aIPriceOptimization.generatedAt
            : generatedAt,
        isApplied: aIPriceOptimization.$assignedFields.contains('isApplied')
            ? aIPriceOptimization.isApplied
            : isApplied,
        appliedAt: aIPriceOptimization.$assignedFields.contains('appliedAt')
            ? aIPriceOptimization.appliedAt
            : appliedAt,
        createdAt: aIPriceOptimization.$assignedFields.contains('createdAt')
            ? aIPriceOptimization.createdAt
            : createdAt,
        listing: aIPriceOptimization.$assignedFields.contains('listing')
            ? aIPriceOptimization.listing
            : listing,
        org: aIPriceOptimization.$assignedFields.contains('org')
            ? aIPriceOptimization.org
            : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  AIPriceOptimization updateWithInstanceValues(
      AIPriceOptimization aIPriceOptimization) {
    if (aIPriceOptimization.$assignedFields.contains('id')) {
      id = aIPriceOptimization.id;
    }
    if (aIPriceOptimization.$assignedFields.contains('orgId')) {
      orgId = aIPriceOptimization.orgId;
    }
    if (aIPriceOptimization.$assignedFields.contains('listingId')) {
      listingId = aIPriceOptimization.listingId;
    }
    if (aIPriceOptimization.$assignedFields.contains('currentPrice')) {
      currentPrice = aIPriceOptimization.currentPrice;
    }
    if (aIPriceOptimization.$assignedFields.contains('recommendedPrice')) {
      recommendedPrice = aIPriceOptimization.recommendedPrice;
    }
    if (aIPriceOptimization.$assignedFields.contains('priceRange')) {
      priceRange = aIPriceOptimization.priceRange;
    }
    if (aIPriceOptimization.$assignedFields.contains('factors')) {
      factors = aIPriceOptimization.factors;
    }
    if (aIPriceOptimization.$assignedFields.contains('comparableData')) {
      comparableData = aIPriceOptimization.comparableData;
    }
    if (aIPriceOptimization.$assignedFields.contains('marketTrends')) {
      marketTrends = aIPriceOptimization.marketTrends;
    }
    if (aIPriceOptimization.$assignedFields.contains('confidence')) {
      confidence = aIPriceOptimization.confidence;
    }
    if (aIPriceOptimization.$assignedFields.contains('generatedAt')) {
      generatedAt = aIPriceOptimization.generatedAt;
    }
    if (aIPriceOptimization.$assignedFields.contains('isApplied')) {
      isApplied = aIPriceOptimization.isApplied;
    }
    if (aIPriceOptimization.$assignedFields.contains('appliedAt')) {
      appliedAt = aIPriceOptimization.appliedAt;
    }
    if (aIPriceOptimization.$assignedFields.contains('createdAt')) {
      createdAt = aIPriceOptimization.createdAt;
    }
    if (aIPriceOptimization.$assignedFields.contains('listing')) {
      listing = aIPriceOptimization.listing;
    }
    if (aIPriceOptimization.$assignedFields.contains('org')) {
      org = aIPriceOptimization.org;
    }
    return this;
  }

  /// Converts this instance to a JSON object.
  ///
  /// [serializedTypes] - Internal parameter tracking which model types have been serialized
  /// in the current chain to prevent circular references.
  /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
  /// skipping relations whose types have already been serialized in the current chain.
  /// Set to false to serialize all relations (use with caution - may cause infinite loops).
  @override
  JsonMap toJson({
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
  }) {
    final Set<String> serializedModels = preventCircularSerialization
        ? {...?serializedTypes, 'AIPriceOptimization'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (listingId != null) 'listingId': listingId,
      if (currentPrice != null) 'currentPrice': currentPrice,
      if (recommendedPrice != null) 'recommendedPrice': recommendedPrice,
      if (priceRange != null) 'priceRange': priceRange,
      if (factors != null) 'factors': factors,
      if (comparableData != null) 'comparableData': comparableData,
      if (marketTrends != null) 'marketTrends': marketTrends,
      if (confidence != null) 'confidence': confidence,
      if (generatedAt != null) 'generatedAt': generatedAt?.toIso8601String(),
      if (isApplied != null) 'isApplied': isApplied,
      if (appliedAt != null) 'appliedAt': appliedAt?.toIso8601String(),
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (listing != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Listing')))
        'listing': listing?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
      if (org != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'org': org?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization)
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIPriceOptimization &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
