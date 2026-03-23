
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'source_type.dart';
import 'lead.dart';
import 'organization.dart';


class LeadSource implements PrismaModel<String, LeadSource> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	SourceType? type;
	dynamic config;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Lead>? leads;
	Organization? org;
	int? $leadsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    LeadSource({ this.id,
	 this.orgId,
	 this.name,
	 this.type,
	required this.config,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.leads,
	 this.org,
	this.$leadsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<LeadSource, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"config": (m) => m.config,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"leads": (m) => m.leads,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(LeadSource) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in LeadSource');
    }
    return propFunction as V? Function(LeadSource);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory LeadSource.fromJson(JsonMap json) =>
      LeadSource(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	type: json['type'] != null ? SourceType.fromJson(json['type']) : null,
	config: json['config'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	leads: json['leads'] != null ? createModels<Lead>((json['leads'] as List).cast<JsonMap>(), Lead.fromJson) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	$leadsCount: json['_count']?['leads'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    LeadSource copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<SourceType?>? type,
		Value<dynamic>? config,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Lead>?>? leads,
		Value<Organization?>? org,
		int? $leadsCount,
        }) {
        return LeadSource(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		config: config != null ? config.value : this.config,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		leads: leads != null ? leads.value : this.leads,
		org: org != null ? org.value : this.org,
		$leadsCount: $leadsCount ?? this.$leadsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    LeadSource copyWithInstanceValues(LeadSource leadSource) {
        return LeadSource(
            id: leadSource.id ?? id,
		orgId: leadSource.orgId ?? orgId,
		name: leadSource.name ?? name,
		type: leadSource.type ?? type,
		config: leadSource.config ?? config,
		createdAt: leadSource.createdAt ?? createdAt,
		updatedAt: leadSource.updatedAt ?? updatedAt,
		deletedAt: leadSource.deletedAt ?? deletedAt,
		leads: leadSource.leads ?? leads,
		org: leadSource.org ?? org,
		$leadsCount: leadSource.$leadsCount ?? $leadsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    LeadSource mergeWithInstanceValues(LeadSource leadSource) {
        return LeadSource(
            id: leadSource.$assignedFields.contains('id') ? leadSource.id : id,
		orgId: leadSource.$assignedFields.contains('orgId') ? leadSource.orgId : orgId,
		name: leadSource.$assignedFields.contains('name') ? leadSource.name : name,
		type: leadSource.$assignedFields.contains('type') ? leadSource.type : type,
		config: leadSource.$assignedFields.contains('config') ? leadSource.config : config,
		createdAt: leadSource.$assignedFields.contains('createdAt') ? leadSource.createdAt : createdAt,
		updatedAt: leadSource.$assignedFields.contains('updatedAt') ? leadSource.updatedAt : updatedAt,
		deletedAt: leadSource.$assignedFields.contains('deletedAt') ? leadSource.deletedAt : deletedAt,
		leads: (leadSource.$assignedFields.contains('leads') && leadSource.leads != null) ? mergeModelLists(leads, leadSource.leads) : leads,
		org: leadSource.$assignedFields.contains('org') ? leadSource.org : org,
		$leadsCount: leadSource.$leadsCount ?? $leadsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    LeadSource updateWithInstanceValues(LeadSource leadSource) {
        if (leadSource.$assignedFields.contains('id')) { id = leadSource.id; }
		if (leadSource.$assignedFields.contains('orgId')) { orgId = leadSource.orgId; }
		if (leadSource.$assignedFields.contains('name')) { name = leadSource.name; }
		if (leadSource.$assignedFields.contains('type')) { type = leadSource.type; }
		if (leadSource.$assignedFields.contains('config')) { config = leadSource.config; }
		if (leadSource.$assignedFields.contains('createdAt')) { createdAt = leadSource.createdAt; }
		if (leadSource.$assignedFields.contains('updatedAt')) { updatedAt = leadSource.updatedAt; }
		if (leadSource.$assignedFields.contains('deletedAt')) { deletedAt = leadSource.deletedAt; }
		if (leadSource.$assignedFields.contains('leads') && leadSource.leads != null) { leads = mergeModelLists(leads, leadSource.leads); }
		if (leadSource.$assignedFields.contains('org')) { org = leadSource.org; }
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
          ? {...?serializedTypes, 'LeadSource'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(type != null) 'type': type?.toJson(),
	if(config != null) 'config': config,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(leads != null && (!preventCircularSerialization || !serializedModels.contains('Lead'))) 'leads': leads?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($leadsCount != null) '_count': { 
		if ($leadsCount != null) 'leads': $leadsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is LeadSource &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    