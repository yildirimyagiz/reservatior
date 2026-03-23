
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'channel_type.dart';
import 'channel_category.dart';
import 'communication_log.dart';


class Channel implements PrismaModel<String, Channel> , Id<String> {
    @override
String? id;
	String? cuid;
	String? name;
	ChannelType? type;
	ChannelCategory? category;
	String? description;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<CommunicationLog>? CommunicationLogs;
	int? $CommunicationLogsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Channel({ this.id,
	 this.cuid,
	 this.name,
	 this.type = ChannelType.PUBLIC,
	 this.category = ChannelCategory.AGENCY,
	 this.description,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.CommunicationLogs,
	this.$CommunicationLogsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Channel, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"cuid": (m) => m.cuid,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"category": (m) => m.category,

	"description": (m) => m.description,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"CommunicationLogs": (m) => m.CommunicationLogs,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Channel) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Channel');
    }
    return propFunction as V? Function(Channel);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Channel.fromJson(JsonMap json) =>
      Channel(
        id: json['id'] as String?,
	cuid: json['cuid'] as String?,
	name: json['name'] as String?,
	type: json['type'] != null ? ChannelType.fromJson(json['type']) : null,
	category: json['category'] != null ? ChannelCategory.fromJson(json['category']) : null,
	description: json['description'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	CommunicationLogs: json['CommunicationLogs'] != null ? createModels<CommunicationLog>((json['CommunicationLogs'] as List).cast<JsonMap>(), CommunicationLog.fromJson) : null,
	$CommunicationLogsCount: json['_count']?['CommunicationLogs'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Channel copyWith({
        Value<String?>? id,
		Value<String?>? cuid,
		Value<String?>? name,
		Value<ChannelType?>? type,
		Value<ChannelCategory?>? category,
		Value<String?>? description,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<CommunicationLog>?>? CommunicationLogs,
		int? $CommunicationLogsCount,
        }) {
        return Channel(
            id: id != null ? id.value : this.id,
		cuid: cuid != null ? cuid.value : this.cuid,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		category: category != null ? category.value : this.category,
		description: description != null ? description.value : this.description,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		CommunicationLogs: CommunicationLogs != null ? CommunicationLogs.value : this.CommunicationLogs,
		$CommunicationLogsCount: $CommunicationLogsCount ?? this.$CommunicationLogsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Channel copyWithInstanceValues(Channel channel) {
        return Channel(
            id: channel.id ?? id,
		cuid: channel.cuid ?? cuid,
		name: channel.name ?? name,
		type: channel.type ?? type,
		category: channel.category ?? category,
		description: channel.description ?? description,
		createdAt: channel.createdAt ?? createdAt,
		updatedAt: channel.updatedAt ?? updatedAt,
		deletedAt: channel.deletedAt ?? deletedAt,
		CommunicationLogs: channel.CommunicationLogs ?? CommunicationLogs,
		$CommunicationLogsCount: channel.$CommunicationLogsCount ?? $CommunicationLogsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Channel mergeWithInstanceValues(Channel channel) {
        return Channel(
            id: channel.$assignedFields.contains('id') ? channel.id : id,
		cuid: channel.$assignedFields.contains('cuid') ? channel.cuid : cuid,
		name: channel.$assignedFields.contains('name') ? channel.name : name,
		type: channel.$assignedFields.contains('type') ? channel.type : type,
		category: channel.$assignedFields.contains('category') ? channel.category : category,
		description: channel.$assignedFields.contains('description') ? channel.description : description,
		createdAt: channel.$assignedFields.contains('createdAt') ? channel.createdAt : createdAt,
		updatedAt: channel.$assignedFields.contains('updatedAt') ? channel.updatedAt : updatedAt,
		deletedAt: channel.$assignedFields.contains('deletedAt') ? channel.deletedAt : deletedAt,
		CommunicationLogs: (channel.$assignedFields.contains('CommunicationLogs') && channel.CommunicationLogs != null) ? mergeModelLists(CommunicationLogs, channel.CommunicationLogs) : CommunicationLogs,
		$CommunicationLogsCount: channel.$CommunicationLogsCount ?? $CommunicationLogsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Channel updateWithInstanceValues(Channel channel) {
        if (channel.$assignedFields.contains('id')) { id = channel.id; }
		if (channel.$assignedFields.contains('cuid')) { cuid = channel.cuid; }
		if (channel.$assignedFields.contains('name')) { name = channel.name; }
		if (channel.$assignedFields.contains('type')) { type = channel.type; }
		if (channel.$assignedFields.contains('category')) { category = channel.category; }
		if (channel.$assignedFields.contains('description')) { description = channel.description; }
		if (channel.$assignedFields.contains('createdAt')) { createdAt = channel.createdAt; }
		if (channel.$assignedFields.contains('updatedAt')) { updatedAt = channel.updatedAt; }
		if (channel.$assignedFields.contains('deletedAt')) { deletedAt = channel.deletedAt; }
		if (channel.$assignedFields.contains('CommunicationLogs') && channel.CommunicationLogs != null) { CommunicationLogs = mergeModelLists(CommunicationLogs, channel.CommunicationLogs); }
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
          ? {...?serializedTypes, 'Channel'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(cuid != null) 'cuid': cuid,
	if(name != null) 'name': name,
	if(type != null) 'type': type?.toJson(),
	if(category != null) 'category': category?.toJson(),
	if(description != null) 'description': description,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(CommunicationLogs != null && (!preventCircularSerialization || !serializedModels.contains('CommunicationLog'))) 'CommunicationLogs': CommunicationLogs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($CommunicationLogsCount != null) '_count': { 
		if ($CommunicationLogsCount != null) 'CommunicationLogs': $CommunicationLogsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Channel &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    