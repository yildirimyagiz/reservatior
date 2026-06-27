import 'organization.dart';

enum MlsProviderKey {
  rightmove,
  zoopla,
  ontheMarket,
  savills,
  stratfordGraham,
  genericRets,
  other
}

class MlsDataMapping {
  final String id;
  final String orgId;
  final MlsProviderKey mlsProvider;
  final String fieldName;
  final String standardField;
  final String dataType;
  final bool isRequired;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;

  const MlsDataMapping({
    required this.id,
    required this.orgId,
    required this.mlsProvider,
    required this.fieldName,
    required this.standardField,
    required this.dataType,
    required this.isRequired,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
  });

  factory MlsDataMapping.fromJson(Map<String, dynamic> json) {
    return MlsDataMapping(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      mlsProvider: MlsProviderKey.values.firstWhere((v) => v.name.toUpperCase() == json['mlsProvider'].toString().toUpperCase(), orElse: () => MlsProviderKey.other),
      fieldName: json['fieldName'] as String,
      standardField: json['standardField'] as String,
      dataType: json['dataType'] as String,
      isRequired: json['isRequired'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'mlsProvider': mlsProvider.name,
      'fieldName': fieldName,
      'standardField': standardField,
      'dataType': dataType,
      'isRequired': isRequired,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
    };
  }

  MlsDataMapping copyWith({
    String? id,
    String? orgId,
    MlsProviderKey? mlsProvider,
    String? fieldName,
    String? standardField,
    String? dataType,
    bool? isRequired,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
  }) {
    return MlsDataMapping(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      mlsProvider: mlsProvider ?? this.mlsProvider,
      fieldName: fieldName ?? this.fieldName,
      standardField: standardField ?? this.standardField,
      dataType: dataType ?? this.dataType,
      isRequired: isRequired ?? this.isRequired,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
    );
  }
}
