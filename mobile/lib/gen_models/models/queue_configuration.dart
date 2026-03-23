
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class QueueConfiguration implements PrismaModel<String, QueueConfiguration> , Id<String> {
    @override
String? id;
	String? orgId;
	String? queueName;
	String? exchangeName;
	String? routingKey;
	String? messageType;
	String? handlerClass;
	int? maxConcurrency;
	dynamic retryPolicy;
	String? deadLetterQueue;
	bool? isActive;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    QueueConfiguration({ this.id,
	 this.orgId,
	 this.queueName,
	 this.exchangeName,
	 this.routingKey,
	 this.messageType,
	 this.handlerClass,
	 this.maxConcurrency = 5,
	required this.retryPolicy,
	 this.deadLetterQueue,
	 this.isActive = true,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<QueueConfiguration, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"queueName": (m) => m.queueName,

	"exchangeName": (m) => m.exchangeName,

	"routingKey": (m) => m.routingKey,

	"messageType": (m) => m.messageType,

	"handlerClass": (m) => m.handlerClass,

	"maxConcurrency": (m) => m.maxConcurrency,

	"retryPolicy": (m) => m.retryPolicy,

	"deadLetterQueue": (m) => m.deadLetterQueue,

	"isActive": (m) => m.isActive,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(QueueConfiguration) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in QueueConfiguration');
    }
    return propFunction as V? Function(QueueConfiguration);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory QueueConfiguration.fromJson(JsonMap json) =>
      QueueConfiguration(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	queueName: json['queueName'] as String?,
	exchangeName: json['exchangeName'] as String?,
	routingKey: json['routingKey'] as String?,
	messageType: json['messageType'] as String?,
	handlerClass: json['handlerClass'] as String?,
	maxConcurrency: int.tryParse(json['maxConcurrency'].toString()),
	retryPolicy: json['retryPolicy'] as dynamic,
	deadLetterQueue: json['deadLetterQueue'] as String?,
	isActive: json['isActive'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    QueueConfiguration copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? queueName,
		Value<String?>? exchangeName,
		Value<String?>? routingKey,
		Value<String?>? messageType,
		Value<String?>? handlerClass,
		Value<int?>? maxConcurrency,
		Value<dynamic>? retryPolicy,
		Value<String?>? deadLetterQueue,
		Value<bool?>? isActive,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
        }) {
        return QueueConfiguration(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		queueName: queueName != null ? queueName.value : this.queueName,
		exchangeName: exchangeName != null ? exchangeName.value : this.exchangeName,
		routingKey: routingKey != null ? routingKey.value : this.routingKey,
		messageType: messageType != null ? messageType.value : this.messageType,
		handlerClass: handlerClass != null ? handlerClass.value : this.handlerClass,
		maxConcurrency: maxConcurrency != null ? maxConcurrency.value : this.maxConcurrency,
		retryPolicy: retryPolicy != null ? retryPolicy.value : this.retryPolicy,
		deadLetterQueue: deadLetterQueue != null ? deadLetterQueue.value : this.deadLetterQueue,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    QueueConfiguration copyWithInstanceValues(QueueConfiguration queueConfiguration) {
        return QueueConfiguration(
            id: queueConfiguration.id ?? id,
		orgId: queueConfiguration.orgId ?? orgId,
		queueName: queueConfiguration.queueName ?? queueName,
		exchangeName: queueConfiguration.exchangeName ?? exchangeName,
		routingKey: queueConfiguration.routingKey ?? routingKey,
		messageType: queueConfiguration.messageType ?? messageType,
		handlerClass: queueConfiguration.handlerClass ?? handlerClass,
		maxConcurrency: queueConfiguration.maxConcurrency ?? maxConcurrency,
		retryPolicy: queueConfiguration.retryPolicy ?? retryPolicy,
		deadLetterQueue: queueConfiguration.deadLetterQueue ?? deadLetterQueue,
		isActive: queueConfiguration.isActive ?? isActive,
		createdAt: queueConfiguration.createdAt ?? createdAt,
		updatedAt: queueConfiguration.updatedAt ?? updatedAt,
		org: queueConfiguration.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    QueueConfiguration mergeWithInstanceValues(QueueConfiguration queueConfiguration) {
        return QueueConfiguration(
            id: queueConfiguration.$assignedFields.contains('id') ? queueConfiguration.id : id,
		orgId: queueConfiguration.$assignedFields.contains('orgId') ? queueConfiguration.orgId : orgId,
		queueName: queueConfiguration.$assignedFields.contains('queueName') ? queueConfiguration.queueName : queueName,
		exchangeName: queueConfiguration.$assignedFields.contains('exchangeName') ? queueConfiguration.exchangeName : exchangeName,
		routingKey: queueConfiguration.$assignedFields.contains('routingKey') ? queueConfiguration.routingKey : routingKey,
		messageType: queueConfiguration.$assignedFields.contains('messageType') ? queueConfiguration.messageType : messageType,
		handlerClass: queueConfiguration.$assignedFields.contains('handlerClass') ? queueConfiguration.handlerClass : handlerClass,
		maxConcurrency: queueConfiguration.$assignedFields.contains('maxConcurrency') ? queueConfiguration.maxConcurrency : maxConcurrency,
		retryPolicy: queueConfiguration.$assignedFields.contains('retryPolicy') ? queueConfiguration.retryPolicy : retryPolicy,
		deadLetterQueue: queueConfiguration.$assignedFields.contains('deadLetterQueue') ? queueConfiguration.deadLetterQueue : deadLetterQueue,
		isActive: queueConfiguration.$assignedFields.contains('isActive') ? queueConfiguration.isActive : isActive,
		createdAt: queueConfiguration.$assignedFields.contains('createdAt') ? queueConfiguration.createdAt : createdAt,
		updatedAt: queueConfiguration.$assignedFields.contains('updatedAt') ? queueConfiguration.updatedAt : updatedAt,
		org: queueConfiguration.$assignedFields.contains('org') ? queueConfiguration.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    QueueConfiguration updateWithInstanceValues(QueueConfiguration queueConfiguration) {
        if (queueConfiguration.$assignedFields.contains('id')) { id = queueConfiguration.id; }
		if (queueConfiguration.$assignedFields.contains('orgId')) { orgId = queueConfiguration.orgId; }
		if (queueConfiguration.$assignedFields.contains('queueName')) { queueName = queueConfiguration.queueName; }
		if (queueConfiguration.$assignedFields.contains('exchangeName')) { exchangeName = queueConfiguration.exchangeName; }
		if (queueConfiguration.$assignedFields.contains('routingKey')) { routingKey = queueConfiguration.routingKey; }
		if (queueConfiguration.$assignedFields.contains('messageType')) { messageType = queueConfiguration.messageType; }
		if (queueConfiguration.$assignedFields.contains('handlerClass')) { handlerClass = queueConfiguration.handlerClass; }
		if (queueConfiguration.$assignedFields.contains('maxConcurrency')) { maxConcurrency = queueConfiguration.maxConcurrency; }
		if (queueConfiguration.$assignedFields.contains('retryPolicy')) { retryPolicy = queueConfiguration.retryPolicy; }
		if (queueConfiguration.$assignedFields.contains('deadLetterQueue')) { deadLetterQueue = queueConfiguration.deadLetterQueue; }
		if (queueConfiguration.$assignedFields.contains('isActive')) { isActive = queueConfiguration.isActive; }
		if (queueConfiguration.$assignedFields.contains('createdAt')) { createdAt = queueConfiguration.createdAt; }
		if (queueConfiguration.$assignedFields.contains('updatedAt')) { updatedAt = queueConfiguration.updatedAt; }
		if (queueConfiguration.$assignedFields.contains('org')) { org = queueConfiguration.org; }
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
          ? {...?serializedTypes, 'QueueConfiguration'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(queueName != null) 'queueName': queueName,
	if(exchangeName != null) 'exchangeName': exchangeName,
	if(routingKey != null) 'routingKey': routingKey,
	if(messageType != null) 'messageType': messageType,
	if(handlerClass != null) 'handlerClass': handlerClass,
	if(maxConcurrency != null) 'maxConcurrency': maxConcurrency,
	if(retryPolicy != null) 'retryPolicy': retryPolicy,
	if(deadLetterQueue != null) 'deadLetterQueue': deadLetterQueue,
	if(isActive != null) 'isActive': isActive,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is QueueConfiguration &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    