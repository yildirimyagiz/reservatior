
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class QueueMessage implements PrismaModel<String, QueueMessage> , Id<String> {
    @override
String? id;
	String? orgId;
	String? messageId;
	String? queueName;
	String? exchangeName;
	String? routingKey;
	String? messageType;
	dynamic payload;
	String? status;
	int? priority;
	int? retryCount;
	int? maxRetries;
	DateTime? nextRetryAt;
	DateTime? processedAt;
	DateTime? completedAt;
	DateTime? failedAt;
	String? errorMessage;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    QueueMessage({ this.id,
	 this.orgId,
	 this.messageId,
	 this.queueName,
	 this.exchangeName,
	 this.routingKey,
	 this.messageType,
	required this.payload,
	 this.status = "QUEUED",
	 this.priority = 0,
	 this.retryCount = 0,
	 this.maxRetries = 3,
	 this.nextRetryAt,
	 this.processedAt,
	 this.completedAt,
	 this.failedAt,
	 this.errorMessage,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<QueueMessage, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"messageId": (m) => m.messageId,

	"queueName": (m) => m.queueName,

	"exchangeName": (m) => m.exchangeName,

	"routingKey": (m) => m.routingKey,

	"messageType": (m) => m.messageType,

	"payload": (m) => m.payload,

	"status": (m) => m.status,

	"priority": (m) => m.priority,

	"retryCount": (m) => m.retryCount,

	"maxRetries": (m) => m.maxRetries,

	"nextRetryAt": (m) => m.nextRetryAt,

	"processedAt": (m) => m.processedAt,

	"completedAt": (m) => m.completedAt,

	"failedAt": (m) => m.failedAt,

	"errorMessage": (m) => m.errorMessage,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(QueueMessage) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in QueueMessage');
    }
    return propFunction as V? Function(QueueMessage);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory QueueMessage.fromJson(JsonMap json) =>
      QueueMessage(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	messageId: json['messageId'] as String?,
	queueName: json['queueName'] as String?,
	exchangeName: json['exchangeName'] as String?,
	routingKey: json['routingKey'] as String?,
	messageType: json['messageType'] as String?,
	payload: json['payload'] as dynamic,
	status: json['status'] as String?,
	priority: int.tryParse(json['priority'].toString()),
	retryCount: int.tryParse(json['retryCount'].toString()),
	maxRetries: int.tryParse(json['maxRetries'].toString()),
	nextRetryAt: json['nextRetryAt'] != null ? DateTime.parse(json['nextRetryAt']) : null,
	processedAt: json['processedAt'] != null ? DateTime.parse(json['processedAt']) : null,
	completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
	failedAt: json['failedAt'] != null ? DateTime.parse(json['failedAt']) : null,
	errorMessage: json['errorMessage'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    QueueMessage copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? messageId,
		Value<String?>? queueName,
		Value<String?>? exchangeName,
		Value<String?>? routingKey,
		Value<String?>? messageType,
		Value<dynamic>? payload,
		Value<String?>? status,
		Value<int?>? priority,
		Value<int?>? retryCount,
		Value<int?>? maxRetries,
		Value<DateTime?>? nextRetryAt,
		Value<DateTime?>? processedAt,
		Value<DateTime?>? completedAt,
		Value<DateTime?>? failedAt,
		Value<String?>? errorMessage,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
        }) {
        return QueueMessage(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		messageId: messageId != null ? messageId.value : this.messageId,
		queueName: queueName != null ? queueName.value : this.queueName,
		exchangeName: exchangeName != null ? exchangeName.value : this.exchangeName,
		routingKey: routingKey != null ? routingKey.value : this.routingKey,
		messageType: messageType != null ? messageType.value : this.messageType,
		payload: payload != null ? payload.value : this.payload,
		status: status != null ? status.value : this.status,
		priority: priority != null ? priority.value : this.priority,
		retryCount: retryCount != null ? retryCount.value : this.retryCount,
		maxRetries: maxRetries != null ? maxRetries.value : this.maxRetries,
		nextRetryAt: nextRetryAt != null ? nextRetryAt.value : this.nextRetryAt,
		processedAt: processedAt != null ? processedAt.value : this.processedAt,
		completedAt: completedAt != null ? completedAt.value : this.completedAt,
		failedAt: failedAt != null ? failedAt.value : this.failedAt,
		errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    QueueMessage copyWithInstanceValues(QueueMessage queueMessage) {
        return QueueMessage(
            id: queueMessage.id ?? id,
		orgId: queueMessage.orgId ?? orgId,
		messageId: queueMessage.messageId ?? messageId,
		queueName: queueMessage.queueName ?? queueName,
		exchangeName: queueMessage.exchangeName ?? exchangeName,
		routingKey: queueMessage.routingKey ?? routingKey,
		messageType: queueMessage.messageType ?? messageType,
		payload: queueMessage.payload ?? payload,
		status: queueMessage.status ?? status,
		priority: queueMessage.priority ?? priority,
		retryCount: queueMessage.retryCount ?? retryCount,
		maxRetries: queueMessage.maxRetries ?? maxRetries,
		nextRetryAt: queueMessage.nextRetryAt ?? nextRetryAt,
		processedAt: queueMessage.processedAt ?? processedAt,
		completedAt: queueMessage.completedAt ?? completedAt,
		failedAt: queueMessage.failedAt ?? failedAt,
		errorMessage: queueMessage.errorMessage ?? errorMessage,
		createdAt: queueMessage.createdAt ?? createdAt,
		updatedAt: queueMessage.updatedAt ?? updatedAt,
		org: queueMessage.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    QueueMessage mergeWithInstanceValues(QueueMessage queueMessage) {
        return QueueMessage(
            id: queueMessage.$assignedFields.contains('id') ? queueMessage.id : id,
		orgId: queueMessage.$assignedFields.contains('orgId') ? queueMessage.orgId : orgId,
		messageId: queueMessage.$assignedFields.contains('messageId') ? queueMessage.messageId : messageId,
		queueName: queueMessage.$assignedFields.contains('queueName') ? queueMessage.queueName : queueName,
		exchangeName: queueMessage.$assignedFields.contains('exchangeName') ? queueMessage.exchangeName : exchangeName,
		routingKey: queueMessage.$assignedFields.contains('routingKey') ? queueMessage.routingKey : routingKey,
		messageType: queueMessage.$assignedFields.contains('messageType') ? queueMessage.messageType : messageType,
		payload: queueMessage.$assignedFields.contains('payload') ? queueMessage.payload : payload,
		status: queueMessage.$assignedFields.contains('status') ? queueMessage.status : status,
		priority: queueMessage.$assignedFields.contains('priority') ? queueMessage.priority : priority,
		retryCount: queueMessage.$assignedFields.contains('retryCount') ? queueMessage.retryCount : retryCount,
		maxRetries: queueMessage.$assignedFields.contains('maxRetries') ? queueMessage.maxRetries : maxRetries,
		nextRetryAt: queueMessage.$assignedFields.contains('nextRetryAt') ? queueMessage.nextRetryAt : nextRetryAt,
		processedAt: queueMessage.$assignedFields.contains('processedAt') ? queueMessage.processedAt : processedAt,
		completedAt: queueMessage.$assignedFields.contains('completedAt') ? queueMessage.completedAt : completedAt,
		failedAt: queueMessage.$assignedFields.contains('failedAt') ? queueMessage.failedAt : failedAt,
		errorMessage: queueMessage.$assignedFields.contains('errorMessage') ? queueMessage.errorMessage : errorMessage,
		createdAt: queueMessage.$assignedFields.contains('createdAt') ? queueMessage.createdAt : createdAt,
		updatedAt: queueMessage.$assignedFields.contains('updatedAt') ? queueMessage.updatedAt : updatedAt,
		org: queueMessage.$assignedFields.contains('org') ? queueMessage.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    QueueMessage updateWithInstanceValues(QueueMessage queueMessage) {
        if (queueMessage.$assignedFields.contains('id')) { id = queueMessage.id; }
		if (queueMessage.$assignedFields.contains('orgId')) { orgId = queueMessage.orgId; }
		if (queueMessage.$assignedFields.contains('messageId')) { messageId = queueMessage.messageId; }
		if (queueMessage.$assignedFields.contains('queueName')) { queueName = queueMessage.queueName; }
		if (queueMessage.$assignedFields.contains('exchangeName')) { exchangeName = queueMessage.exchangeName; }
		if (queueMessage.$assignedFields.contains('routingKey')) { routingKey = queueMessage.routingKey; }
		if (queueMessage.$assignedFields.contains('messageType')) { messageType = queueMessage.messageType; }
		if (queueMessage.$assignedFields.contains('payload')) { payload = queueMessage.payload; }
		if (queueMessage.$assignedFields.contains('status')) { status = queueMessage.status; }
		if (queueMessage.$assignedFields.contains('priority')) { priority = queueMessage.priority; }
		if (queueMessage.$assignedFields.contains('retryCount')) { retryCount = queueMessage.retryCount; }
		if (queueMessage.$assignedFields.contains('maxRetries')) { maxRetries = queueMessage.maxRetries; }
		if (queueMessage.$assignedFields.contains('nextRetryAt')) { nextRetryAt = queueMessage.nextRetryAt; }
		if (queueMessage.$assignedFields.contains('processedAt')) { processedAt = queueMessage.processedAt; }
		if (queueMessage.$assignedFields.contains('completedAt')) { completedAt = queueMessage.completedAt; }
		if (queueMessage.$assignedFields.contains('failedAt')) { failedAt = queueMessage.failedAt; }
		if (queueMessage.$assignedFields.contains('errorMessage')) { errorMessage = queueMessage.errorMessage; }
		if (queueMessage.$assignedFields.contains('createdAt')) { createdAt = queueMessage.createdAt; }
		if (queueMessage.$assignedFields.contains('updatedAt')) { updatedAt = queueMessage.updatedAt; }
		if (queueMessage.$assignedFields.contains('org')) { org = queueMessage.org; }
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
          ? {...?serializedTypes, 'QueueMessage'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(messageId != null) 'messageId': messageId,
	if(queueName != null) 'queueName': queueName,
	if(exchangeName != null) 'exchangeName': exchangeName,
	if(routingKey != null) 'routingKey': routingKey,
	if(messageType != null) 'messageType': messageType,
	if(payload != null) 'payload': payload,
	if(status != null) 'status': status,
	if(priority != null) 'priority': priority,
	if(retryCount != null) 'retryCount': retryCount,
	if(maxRetries != null) 'maxRetries': maxRetries,
	if(nextRetryAt != null) 'nextRetryAt': nextRetryAt?.toIso8601String(),
	if(processedAt != null) 'processedAt': processedAt?.toIso8601String(),
	if(completedAt != null) 'completedAt': completedAt?.toIso8601String(),
	if(failedAt != null) 'failedAt': failedAt?.toIso8601String(),
	if(errorMessage != null) 'errorMessage': errorMessage,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is QueueMessage &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    