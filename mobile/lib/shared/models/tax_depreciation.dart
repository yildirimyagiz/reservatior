import 'package:reservatior/shared/enums/asset_type.dart';
import 'package:reservatior/shared/enums/depreciation_method.dart';
import 'organization.dart';
import 'property.dart';

class TaxDepreciation {
  final String id;
  final String propertyId;
  final AssetType assetType;
  final double costBasis;
  final DepreciationMethod depreciationMethod;
  final int usefulLife;
  final double salvageValue;
  final DateTime startDate;
  final double accumulatedDepreciation;
  final String? organizationId;
  final Organization? organization;
  final Property property;

  const TaxDepreciation({
    required this.id,
    required this.propertyId,
    required this.assetType,
    required this.costBasis,
    required this.depreciationMethod,
    required this.usefulLife,
    required this.salvageValue,
    required this.startDate,
    required this.accumulatedDepreciation,
    this.organizationId,
    this.organization,
    required this.property,
  });

  factory TaxDepreciation.fromJson(Map<String, dynamic> json) {
    return TaxDepreciation(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      assetType: AssetType.values.firstWhere((v) => v.name == json['assetType']),
      costBasis: (json['costBasis'] as num).toDouble(),
      depreciationMethod: DepreciationMethod.values.firstWhere((v) => v.name == json['depreciationMethod']),
      usefulLife: json['usefulLife'] as int,
      salvageValue: (json['salvageValue'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      accumulatedDepreciation: (json['accumulatedDepreciation'] as num).toDouble(),
      organizationId: json['organizationId'] as String?,
      organization: json['organization'] != null ? Organization.fromJson(json['organization'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'assetType': assetType.name,
      'costBasis': costBasis,
      'depreciationMethod': depreciationMethod.name,
      'usefulLife': usefulLife,
      'salvageValue': salvageValue,
      'startDate': startDate.toIso8601String(),
      'accumulatedDepreciation': accumulatedDepreciation,
      'organizationId': organizationId,
      'organization': organization?.toJson(),
      'property': property.toJson(),
    };
  }

  TaxDepreciation copyWith({
    String? id,
    String? propertyId,
    AssetType? assetType,
    double? costBasis,
    DepreciationMethod? depreciationMethod,
    int? usefulLife,
    double? salvageValue,
    DateTime? startDate,
    double? accumulatedDepreciation,
    String? organizationId,
    Organization? organization,
    Property? property,
  }) {
    return TaxDepreciation(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      assetType: assetType ?? this.assetType,
      costBasis: costBasis ?? this.costBasis,
      depreciationMethod: depreciationMethod ?? this.depreciationMethod,
      usefulLife: usefulLife ?? this.usefulLife,
      salvageValue: salvageValue ?? this.salvageValue,
      startDate: startDate ?? this.startDate,
      accumulatedDepreciation: accumulatedDepreciation ?? this.accumulatedDepreciation,
      organizationId: organizationId ?? this.organizationId,
      organization: organization ?? this.organization,
      property: property ?? this.property,
    );
  }
}
