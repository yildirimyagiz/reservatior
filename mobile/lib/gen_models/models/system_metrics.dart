
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class SystemMetrics implements PrismaModel<String, SystemMetrics> , Id<String> {
    @override
String? id;
	String? orgId;
	String? metricType;
	String? metricName;
	double? value;
	String? unit;
	DateTime? timestamp;
	dynamic dimensions;
	dynamic tags;
	DateTime? collectedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    SystemMetrics({ this.id,
	 this.orgId,
	 this.metricType,
	 this.metricName,
	 this.value,
	 this.unit,
	 this.timestamp,
	required this.dimensions,
	required this.tags,
	 this.collectedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<SystemMetrics, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"metricType": (m) => m.metricType,

	"metricName": (m) => m.metricName,

	"value": (m) => m.value,

	"unit": (m) => m.unit,

	"timestamp": (m) => m.timestamp,

	"dimensions": (m) => m.dimensions,

	"tags": (m) => m.tags,

	"collectedAt": (m) => m.collectedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(SystemMetrics) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in SystemMetrics');
    }
    return propFunction as V? Function(SystemMetrics);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory SystemMetrics.fromJson(JsonMap json) =>
      SystemMetrics(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	metricType: json['metricType'] as String?,
	metricName: json['metricName'] as String?,
	value: json['value']?.toDouble(),
	unit: json['unit'] as String?,
	timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
	dimensions: json['dimensions'] as dynamic,
	tags: json['tags'] as dynamic,
	collectedAt: json['collectedAt'] != null ? DateTime.parse(json['collectedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    SystemMetrics copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? metricType,
		Value<String?>? metricName,
		Value<double?>? value,
		Value<String?>? unit,
		Value<DateTime?>? timestamp,
		Value<dynamic>? dimensions,
		Value<dynamic>? tags,
		Value<DateTime?>? collectedAt,
		Value<Organization?>? org,
        }) {
        return SystemMetrics(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		metricType: metricType != null ? metricType.value : this.metricType,
		metricName: metricName != null ? metricName.value : this.metricName,
		value: value != null ? value.value : this.value,
		unit: unit != null ? unit.value : this.unit,
		timestamp: timestamp != null ? timestamp.value : this.timestamp,
		dimensions: dimensions != null ? dimensions.value : this.dimensions,
		tags: tags != null ? tags.value : this.tags,
		collectedAt: collectedAt != null ? collectedAt.value : this.collectedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    SystemMetrics copyWithInstanceValues(SystemMetrics systemMetrics) {
        return SystemMetrics(
            id: systemMetrics.id ?? id,
		orgId: systemMetrics.orgId ?? orgId,
		metricType: systemMetrics.metricType ?? metricType,
		metricName: systemMetrics.metricName ?? metricName,
		value: systemMetrics.value ?? value,
		unit: systemMetrics.unit ?? unit,
		timestamp: systemMetrics.timestamp ?? timestamp,
		dimensions: systemMetrics.dimensions ?? dimensions,
		tags: systemMetrics.tags ?? tags,
		collectedAt: systemMetrics.collectedAt ?? collectedAt,
		org: systemMetrics.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    SystemMetrics mergeWithInstanceValues(SystemMetrics systemMetrics) {
        return SystemMetrics(
            id: systemMetrics.$assignedFields.contains('id') ? systemMetrics.id : id,
		orgId: systemMetrics.$assignedFields.contains('orgId') ? systemMetrics.orgId : orgId,
		metricType: systemMetrics.$assignedFields.contains('metricType') ? systemMetrics.metricType : metricType,
		metricName: systemMetrics.$assignedFields.contains('metricName') ? systemMetrics.metricName : metricName,
		value: systemMetrics.$assignedFields.contains('value') ? systemMetrics.value : value,
		unit: systemMetrics.$assignedFields.contains('unit') ? systemMetrics.unit : unit,
		timestamp: systemMetrics.$assignedFields.contains('timestamp') ? systemMetrics.timestamp : timestamp,
		dimensions: systemMetrics.$assignedFields.contains('dimensions') ? systemMetrics.dimensions : dimensions,
		tags: systemMetrics.$assignedFields.contains('tags') ? systemMetrics.tags : tags,
		collectedAt: systemMetrics.$assignedFields.contains('collectedAt') ? systemMetrics.collectedAt : collectedAt,
		org: systemMetrics.$assignedFields.contains('org') ? systemMetrics.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    SystemMetrics updateWithInstanceValues(SystemMetrics systemMetrics) {
        if (systemMetrics.$assignedFields.contains('id')) { id = systemMetrics.id; }
		if (systemMetrics.$assignedFields.contains('orgId')) { orgId = systemMetrics.orgId; }
		if (systemMetrics.$assignedFields.contains('metricType')) { metricType = systemMetrics.metricType; }
		if (systemMetrics.$assignedFields.contains('metricName')) { metricName = systemMetrics.metricName; }
		if (systemMetrics.$assignedFields.contains('value')) { value = systemMetrics.value; }
		if (systemMetrics.$assignedFields.contains('unit')) { unit = systemMetrics.unit; }
		if (systemMetrics.$assignedFields.contains('timestamp')) { timestamp = systemMetrics.timestamp; }
		if (systemMetrics.$assignedFields.contains('dimensions')) { dimensions = systemMetrics.dimensions; }
		if (systemMetrics.$assignedFields.contains('tags')) { tags = systemMetrics.tags; }
		if (systemMetrics.$assignedFields.contains('collectedAt')) { collectedAt = systemMetrics.collectedAt; }
		if (systemMetrics.$assignedFields.contains('org')) { org = systemMetrics.org; }
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
          ? {...?serializedTypes, 'SystemMetrics'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(metricType != null) 'metricType': metricType,
	if(metricName != null) 'metricName': metricName,
	if(value != null) 'value': value,
	if(unit != null) 'unit': unit,
	if(timestamp != null) 'timestamp': timestamp?.toIso8601String(),
	if(dimensions != null) 'dimensions': dimensions,
	if(tags != null) 'tags': tags,
	if(collectedAt != null) 'collectedAt': collectedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is SystemMetrics &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    