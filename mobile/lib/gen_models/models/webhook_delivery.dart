
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'webhook.dart';


class WebhookDelivery implements PrismaModel<String, WebhookDelivery> , Id<String> {
    @override
String? id;
	String? orgId;
	String? webhookId;
	String? eventType;
	dynamic payload;
	dynamic response;
	int? statusCode;
	DateTime? deliveredAt;
	String? error;
	DateTime? createdAt;
	Organization? org;
	Webhook? webhook;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    WebhookDelivery({ this.id,
	 this.orgId,
	 this.webhookId,
	 this.eventType,
	required this.payload,
	required this.response,
	 this.statusCode,
	 this.deliveredAt,
	 this.error,
	 this.createdAt,
	 this.org,
	 this.webhook,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<WebhookDelivery, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"webhookId": (m) => m.webhookId,

	"eventType": (m) => m.eventType,

	"payload": (m) => m.payload,

	"response": (m) => m.response,

	"statusCode": (m) => m.statusCode,

	"deliveredAt": (m) => m.deliveredAt,

	"error": (m) => m.error,

	"createdAt": (m) => m.createdAt,

	"org": (m) => m.org,

	"webhook": (m) => m.webhook,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(WebhookDelivery) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in WebhookDelivery');
    }
    return propFunction as V? Function(WebhookDelivery);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory WebhookDelivery.fromJson(JsonMap json) =>
      WebhookDelivery(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	webhookId: json['webhookId'] as String?,
	eventType: json['eventType'] as String?,
	payload: json['payload'] as dynamic,
	response: json['response'] as dynamic,
	statusCode: int.tryParse(json['statusCode'].toString()),
	deliveredAt: json['deliveredAt'] != null ? DateTime.parse(json['deliveredAt']) : null,
	error: json['error'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	webhook: json['webhook'] != null ? Webhook.fromJson(json['webhook'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    WebhookDelivery copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? webhookId,
		Value<String?>? eventType,
		Value<dynamic>? payload,
		Value<dynamic>? response,
		Value<int?>? statusCode,
		Value<DateTime?>? deliveredAt,
		Value<String?>? error,
		Value<DateTime?>? createdAt,
		Value<Organization?>? org,
		Value<Webhook?>? webhook,
        }) {
        return WebhookDelivery(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		webhookId: webhookId != null ? webhookId.value : this.webhookId,
		eventType: eventType != null ? eventType.value : this.eventType,
		payload: payload != null ? payload.value : this.payload,
		response: response != null ? response.value : this.response,
		statusCode: statusCode != null ? statusCode.value : this.statusCode,
		deliveredAt: deliveredAt != null ? deliveredAt.value : this.deliveredAt,
		error: error != null ? error.value : this.error,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		org: org != null ? org.value : this.org,
		webhook: webhook != null ? webhook.value : this.webhook
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    WebhookDelivery copyWithInstanceValues(WebhookDelivery webhookDelivery) {
        return WebhookDelivery(
            id: webhookDelivery.id ?? id,
		orgId: webhookDelivery.orgId ?? orgId,
		webhookId: webhookDelivery.webhookId ?? webhookId,
		eventType: webhookDelivery.eventType ?? eventType,
		payload: webhookDelivery.payload ?? payload,
		response: webhookDelivery.response ?? response,
		statusCode: webhookDelivery.statusCode ?? statusCode,
		deliveredAt: webhookDelivery.deliveredAt ?? deliveredAt,
		error: webhookDelivery.error ?? error,
		createdAt: webhookDelivery.createdAt ?? createdAt,
		org: webhookDelivery.org ?? org,
		webhook: webhookDelivery.webhook ?? webhook
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    WebhookDelivery mergeWithInstanceValues(WebhookDelivery webhookDelivery) {
        return WebhookDelivery(
            id: webhookDelivery.$assignedFields.contains('id') ? webhookDelivery.id : id,
		orgId: webhookDelivery.$assignedFields.contains('orgId') ? webhookDelivery.orgId : orgId,
		webhookId: webhookDelivery.$assignedFields.contains('webhookId') ? webhookDelivery.webhookId : webhookId,
		eventType: webhookDelivery.$assignedFields.contains('eventType') ? webhookDelivery.eventType : eventType,
		payload: webhookDelivery.$assignedFields.contains('payload') ? webhookDelivery.payload : payload,
		response: webhookDelivery.$assignedFields.contains('response') ? webhookDelivery.response : response,
		statusCode: webhookDelivery.$assignedFields.contains('statusCode') ? webhookDelivery.statusCode : statusCode,
		deliveredAt: webhookDelivery.$assignedFields.contains('deliveredAt') ? webhookDelivery.deliveredAt : deliveredAt,
		error: webhookDelivery.$assignedFields.contains('error') ? webhookDelivery.error : error,
		createdAt: webhookDelivery.$assignedFields.contains('createdAt') ? webhookDelivery.createdAt : createdAt,
		org: webhookDelivery.$assignedFields.contains('org') ? webhookDelivery.org : org,
		webhook: webhookDelivery.$assignedFields.contains('webhook') ? webhookDelivery.webhook : webhook
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    WebhookDelivery updateWithInstanceValues(WebhookDelivery webhookDelivery) {
        if (webhookDelivery.$assignedFields.contains('id')) { id = webhookDelivery.id; }
		if (webhookDelivery.$assignedFields.contains('orgId')) { orgId = webhookDelivery.orgId; }
		if (webhookDelivery.$assignedFields.contains('webhookId')) { webhookId = webhookDelivery.webhookId; }
		if (webhookDelivery.$assignedFields.contains('eventType')) { eventType = webhookDelivery.eventType; }
		if (webhookDelivery.$assignedFields.contains('payload')) { payload = webhookDelivery.payload; }
		if (webhookDelivery.$assignedFields.contains('response')) { response = webhookDelivery.response; }
		if (webhookDelivery.$assignedFields.contains('statusCode')) { statusCode = webhookDelivery.statusCode; }
		if (webhookDelivery.$assignedFields.contains('deliveredAt')) { deliveredAt = webhookDelivery.deliveredAt; }
		if (webhookDelivery.$assignedFields.contains('error')) { error = webhookDelivery.error; }
		if (webhookDelivery.$assignedFields.contains('createdAt')) { createdAt = webhookDelivery.createdAt; }
		if (webhookDelivery.$assignedFields.contains('org')) { org = webhookDelivery.org; }
		if (webhookDelivery.$assignedFields.contains('webhook')) { webhook = webhookDelivery.webhook; }
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
          ? {...?serializedTypes, 'WebhookDelivery'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(webhookId != null) 'webhookId': webhookId,
	if(eventType != null) 'eventType': eventType,
	if(payload != null) 'payload': payload,
	if(response != null) 'response': response,
	if(statusCode != null) 'statusCode': statusCode,
	if(deliveredAt != null) 'deliveredAt': deliveredAt?.toIso8601String(),
	if(error != null) 'error': error,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(webhook != null && (!preventCircularSerialization || !serializedModels.contains('Webhook'))) 'webhook': webhook?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is WebhookDelivery &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    