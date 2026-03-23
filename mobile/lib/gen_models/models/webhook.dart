
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'webhook_delivery.dart';


class Webhook implements PrismaModel<String, Webhook> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	String? description;
	String? url;
	String? secret;
	List<String>? events;
	dynamic headers;
	bool? isActive;
	DateTime? lastTriggeredAt;
	int? failureCount;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	List<WebhookDelivery>? deliveries;
	int? $eventsCount;
	int? $deliveriesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Webhook({ this.id,
	 this.orgId,
	 this.name,
	 this.description,
	 this.url,
	 this.secret,
	 this.events,
	required this.headers,
	 this.isActive = true,
	 this.lastTriggeredAt,
	 this.failureCount = 0,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.deliveries,
	this.$eventsCount,
	this.$deliveriesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Webhook, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"url": (m) => m.url,

	"secret": (m) => m.secret,

	"events": (m) => m.events,

	"headers": (m) => m.headers,

	"isActive": (m) => m.isActive,

	"lastTriggeredAt": (m) => m.lastTriggeredAt,

	"failureCount": (m) => m.failureCount,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"deliveries": (m) => m.deliveries,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Webhook) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Webhook');
    }
    return propFunction as V? Function(Webhook);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Webhook.fromJson(JsonMap json) =>
      Webhook(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	url: json['url'] as String?,
	secret: json['secret'] as String?,
	events: json['events'] != null ? (json['events'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	headers: json['headers'] as dynamic,
	isActive: json['isActive'] as bool?,
	lastTriggeredAt: json['lastTriggeredAt'] != null ? DateTime.parse(json['lastTriggeredAt']) : null,
	failureCount: int.tryParse(json['failureCount'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	deliveries: json['deliveries'] != null ? createModels<WebhookDelivery>((json['deliveries'] as List).cast<JsonMap>(), WebhookDelivery.fromJson) : null,
	$eventsCount: json['_count']?['events'] as int?,
	$deliveriesCount: json['_count']?['deliveries'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Webhook copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? description,
		Value<String?>? url,
		Value<String?>? secret,
		Value<List<String>?>? events,
		Value<dynamic>? headers,
		Value<bool?>? isActive,
		Value<DateTime?>? lastTriggeredAt,
		Value<int?>? failureCount,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<List<WebhookDelivery>?>? deliveries,
		int? $eventsCount,
		int? $deliveriesCount,
        }) {
        return Webhook(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		url: url != null ? url.value : this.url,
		secret: secret != null ? secret.value : this.secret,
		events: events != null ? events.value : this.events,
		headers: headers != null ? headers.value : this.headers,
		isActive: isActive != null ? isActive.value : this.isActive,
		lastTriggeredAt: lastTriggeredAt != null ? lastTriggeredAt.value : this.lastTriggeredAt,
		failureCount: failureCount != null ? failureCount.value : this.failureCount,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		deliveries: deliveries != null ? deliveries.value : this.deliveries,
		$eventsCount: $eventsCount ?? this.$eventsCount,
		$deliveriesCount: $deliveriesCount ?? this.$deliveriesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Webhook copyWithInstanceValues(Webhook webhook) {
        return Webhook(
            id: webhook.id ?? id,
		orgId: webhook.orgId ?? orgId,
		name: webhook.name ?? name,
		description: webhook.description ?? description,
		url: webhook.url ?? url,
		secret: webhook.secret ?? secret,
		events: webhook.events ?? events,
		headers: webhook.headers ?? headers,
		isActive: webhook.isActive ?? isActive,
		lastTriggeredAt: webhook.lastTriggeredAt ?? lastTriggeredAt,
		failureCount: webhook.failureCount ?? failureCount,
		createdAt: webhook.createdAt ?? createdAt,
		updatedAt: webhook.updatedAt ?? updatedAt,
		deletedAt: webhook.deletedAt ?? deletedAt,
		org: webhook.org ?? org,
		deliveries: webhook.deliveries ?? deliveries,
		$eventsCount: webhook.$eventsCount ?? $eventsCount,
		$deliveriesCount: webhook.$deliveriesCount ?? $deliveriesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Webhook mergeWithInstanceValues(Webhook webhook) {
        return Webhook(
            id: webhook.$assignedFields.contains('id') ? webhook.id : id,
		orgId: webhook.$assignedFields.contains('orgId') ? webhook.orgId : orgId,
		name: webhook.$assignedFields.contains('name') ? webhook.name : name,
		description: webhook.$assignedFields.contains('description') ? webhook.description : description,
		url: webhook.$assignedFields.contains('url') ? webhook.url : url,
		secret: webhook.$assignedFields.contains('secret') ? webhook.secret : secret,
		events: webhook.$assignedFields.contains('events') ? webhook.events : events,
		headers: webhook.$assignedFields.contains('headers') ? webhook.headers : headers,
		isActive: webhook.$assignedFields.contains('isActive') ? webhook.isActive : isActive,
		lastTriggeredAt: webhook.$assignedFields.contains('lastTriggeredAt') ? webhook.lastTriggeredAt : lastTriggeredAt,
		failureCount: webhook.$assignedFields.contains('failureCount') ? webhook.failureCount : failureCount,
		createdAt: webhook.$assignedFields.contains('createdAt') ? webhook.createdAt : createdAt,
		updatedAt: webhook.$assignedFields.contains('updatedAt') ? webhook.updatedAt : updatedAt,
		deletedAt: webhook.$assignedFields.contains('deletedAt') ? webhook.deletedAt : deletedAt,
		org: webhook.$assignedFields.contains('org') ? webhook.org : org,
		deliveries: (webhook.$assignedFields.contains('deliveries') && webhook.deliveries != null) ? mergeModelLists(deliveries, webhook.deliveries) : deliveries,
		$eventsCount: webhook.$eventsCount ?? $eventsCount,
		$deliveriesCount: webhook.$deliveriesCount ?? $deliveriesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Webhook updateWithInstanceValues(Webhook webhook) {
        if (webhook.$assignedFields.contains('id')) { id = webhook.id; }
		if (webhook.$assignedFields.contains('orgId')) { orgId = webhook.orgId; }
		if (webhook.$assignedFields.contains('name')) { name = webhook.name; }
		if (webhook.$assignedFields.contains('description')) { description = webhook.description; }
		if (webhook.$assignedFields.contains('url')) { url = webhook.url; }
		if (webhook.$assignedFields.contains('secret')) { secret = webhook.secret; }
		if (webhook.$assignedFields.contains('events')) { events = webhook.events; }
		if (webhook.$assignedFields.contains('headers')) { headers = webhook.headers; }
		if (webhook.$assignedFields.contains('isActive')) { isActive = webhook.isActive; }
		if (webhook.$assignedFields.contains('lastTriggeredAt')) { lastTriggeredAt = webhook.lastTriggeredAt; }
		if (webhook.$assignedFields.contains('failureCount')) { failureCount = webhook.failureCount; }
		if (webhook.$assignedFields.contains('createdAt')) { createdAt = webhook.createdAt; }
		if (webhook.$assignedFields.contains('updatedAt')) { updatedAt = webhook.updatedAt; }
		if (webhook.$assignedFields.contains('deletedAt')) { deletedAt = webhook.deletedAt; }
		if (webhook.$assignedFields.contains('org')) { org = webhook.org; }
		if (webhook.$assignedFields.contains('deliveries') && webhook.deliveries != null) { deliveries = mergeModelLists(deliveries, webhook.deliveries); }
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
          ? {...?serializedTypes, 'Webhook'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(url != null) 'url': url,
	if(secret != null) 'secret': secret,
	if(events != null) 'events': events,
	if(headers != null) 'headers': headers,
	if(isActive != null) 'isActive': isActive,
	if(lastTriggeredAt != null) 'lastTriggeredAt': lastTriggeredAt?.toIso8601String(),
	if(failureCount != null) 'failureCount': failureCount,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(deliveries != null && (!preventCircularSerialization || !serializedModels.contains('WebhookDelivery'))) 'deliveries': deliveries?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($eventsCount != null || $deliveriesCount != null) '_count': { 
		if ($eventsCount != null) 'events': $eventsCount, 
		if ($deliveriesCount != null) 'deliveries': $deliveriesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Webhook &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    