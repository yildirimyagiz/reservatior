
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'message.dart';
import 'organization.dart';
import 'property_compliance.dart';
import 'property.dart';
import 'review.dart';
import 'task.dart';
import 'financial_record.dart';


class Attachment implements PrismaModel<String, Attachment> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? entityType;
	String? entityId;
	String? fileName;
	String? mimeType;
	int? sizeBytes;
	String? storageKey;
	String? url;
	String? checksum;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? transactionId;
	String? taskId;
	String? messageId;
	String? propertyComplianceId;
	String? reviewId;
	Message? message;
	Organization? org;
	PropertyCompliance? propertyCompliance;
	Property? property;
	Review? review;
	Task? task;
	FinancialRecord? financialRecord;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Attachment({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.entityType,
	 this.entityId,
	 this.fileName,
	 this.mimeType,
	 this.sizeBytes,
	 this.storageKey,
	 this.url,
	 this.checksum,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.transactionId,
	 this.taskId,
	 this.messageId,
	 this.propertyComplianceId,
	 this.reviewId,
	 this.message,
	 this.org,
	 this.propertyCompliance,
	 this.property,
	 this.review,
	 this.task,
	 this.financialRecord,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Attachment, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"entityType": (m) => m.entityType,

	"entityId": (m) => m.entityId,

	"fileName": (m) => m.fileName,

	"mimeType": (m) => m.mimeType,

	"sizeBytes": (m) => m.sizeBytes,

	"storageKey": (m) => m.storageKey,

	"url": (m) => m.url,

	"checksum": (m) => m.checksum,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"transactionId": (m) => m.transactionId,

	"taskId": (m) => m.taskId,

	"messageId": (m) => m.messageId,

	"propertyComplianceId": (m) => m.propertyComplianceId,

	"reviewId": (m) => m.reviewId,

	"message": (m) => m.message,

	"org": (m) => m.org,

	"propertyCompliance": (m) => m.propertyCompliance,

	"property": (m) => m.property,

	"review": (m) => m.review,

	"task": (m) => m.task,

	"financialRecord": (m) => m.financialRecord,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Attachment) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Attachment');
    }
    return propFunction as V? Function(Attachment);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Attachment.fromJson(JsonMap json) =>
      Attachment(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	entityType: json['entityType'] as String?,
	entityId: json['entityId'] as String?,
	fileName: json['fileName'] as String?,
	mimeType: json['mimeType'] as String?,
	sizeBytes: int.tryParse(json['sizeBytes'].toString()),
	storageKey: json['storageKey'] as String?,
	url: json['url'] as String?,
	checksum: json['checksum'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	transactionId: json['transactionId'] as String?,
	taskId: json['taskId'] as String?,
	messageId: json['messageId'] as String?,
	propertyComplianceId: json['propertyComplianceId'] as String?,
	reviewId: json['reviewId'] as String?,
	message: json['message'] != null ? Message.fromJson(json['message'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	propertyCompliance: json['propertyCompliance'] != null ? PropertyCompliance.fromJson(json['propertyCompliance'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	review: json['review'] != null ? Review.fromJson(json['review'] as JsonMap) : null,
	task: json['task'] != null ? Task.fromJson(json['task'] as JsonMap) : null,
	financialRecord: json['financialRecord'] != null ? FinancialRecord.fromJson(json['financialRecord'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Attachment copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? entityType,
		Value<String?>? entityId,
		Value<String?>? fileName,
		Value<String?>? mimeType,
		Value<int?>? sizeBytes,
		Value<String?>? storageKey,
		Value<String?>? url,
		Value<String?>? checksum,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? transactionId,
		Value<String?>? taskId,
		Value<String?>? messageId,
		Value<String?>? propertyComplianceId,
		Value<String?>? reviewId,
		Value<Message?>? message,
		Value<Organization?>? org,
		Value<PropertyCompliance?>? propertyCompliance,
		Value<Property?>? property,
		Value<Review?>? review,
		Value<Task?>? task,
		Value<FinancialRecord?>? financialRecord,
        }) {
        return Attachment(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		entityType: entityType != null ? entityType.value : this.entityType,
		entityId: entityId != null ? entityId.value : this.entityId,
		fileName: fileName != null ? fileName.value : this.fileName,
		mimeType: mimeType != null ? mimeType.value : this.mimeType,
		sizeBytes: sizeBytes != null ? sizeBytes.value : this.sizeBytes,
		storageKey: storageKey != null ? storageKey.value : this.storageKey,
		url: url != null ? url.value : this.url,
		checksum: checksum != null ? checksum.value : this.checksum,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		transactionId: transactionId != null ? transactionId.value : this.transactionId,
		taskId: taskId != null ? taskId.value : this.taskId,
		messageId: messageId != null ? messageId.value : this.messageId,
		propertyComplianceId: propertyComplianceId != null ? propertyComplianceId.value : this.propertyComplianceId,
		reviewId: reviewId != null ? reviewId.value : this.reviewId,
		message: message != null ? message.value : this.message,
		org: org != null ? org.value : this.org,
		propertyCompliance: propertyCompliance != null ? propertyCompliance.value : this.propertyCompliance,
		property: property != null ? property.value : this.property,
		review: review != null ? review.value : this.review,
		task: task != null ? task.value : this.task,
		financialRecord: financialRecord != null ? financialRecord.value : this.financialRecord
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Attachment copyWithInstanceValues(Attachment attachment) {
        return Attachment(
            id: attachment.id ?? id,
		orgId: attachment.orgId ?? orgId,
		propertyId: attachment.propertyId ?? propertyId,
		entityType: attachment.entityType ?? entityType,
		entityId: attachment.entityId ?? entityId,
		fileName: attachment.fileName ?? fileName,
		mimeType: attachment.mimeType ?? mimeType,
		sizeBytes: attachment.sizeBytes ?? sizeBytes,
		storageKey: attachment.storageKey ?? storageKey,
		url: attachment.url ?? url,
		checksum: attachment.checksum ?? checksum,
		createdBy: attachment.createdBy ?? createdBy,
		createdAt: attachment.createdAt ?? createdAt,
		updatedAt: attachment.updatedAt ?? updatedAt,
		deletedAt: attachment.deletedAt ?? deletedAt,
		transactionId: attachment.transactionId ?? transactionId,
		taskId: attachment.taskId ?? taskId,
		messageId: attachment.messageId ?? messageId,
		propertyComplianceId: attachment.propertyComplianceId ?? propertyComplianceId,
		reviewId: attachment.reviewId ?? reviewId,
		message: attachment.message ?? message,
		org: attachment.org ?? org,
		propertyCompliance: attachment.propertyCompliance ?? propertyCompliance,
		property: attachment.property ?? property,
		review: attachment.review ?? review,
		task: attachment.task ?? task,
		financialRecord: attachment.financialRecord ?? financialRecord
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Attachment mergeWithInstanceValues(Attachment attachment) {
        return Attachment(
            id: attachment.$assignedFields.contains('id') ? attachment.id : id,
		orgId: attachment.$assignedFields.contains('orgId') ? attachment.orgId : orgId,
		propertyId: attachment.$assignedFields.contains('propertyId') ? attachment.propertyId : propertyId,
		entityType: attachment.$assignedFields.contains('entityType') ? attachment.entityType : entityType,
		entityId: attachment.$assignedFields.contains('entityId') ? attachment.entityId : entityId,
		fileName: attachment.$assignedFields.contains('fileName') ? attachment.fileName : fileName,
		mimeType: attachment.$assignedFields.contains('mimeType') ? attachment.mimeType : mimeType,
		sizeBytes: attachment.$assignedFields.contains('sizeBytes') ? attachment.sizeBytes : sizeBytes,
		storageKey: attachment.$assignedFields.contains('storageKey') ? attachment.storageKey : storageKey,
		url: attachment.$assignedFields.contains('url') ? attachment.url : url,
		checksum: attachment.$assignedFields.contains('checksum') ? attachment.checksum : checksum,
		createdBy: attachment.$assignedFields.contains('createdBy') ? attachment.createdBy : createdBy,
		createdAt: attachment.$assignedFields.contains('createdAt') ? attachment.createdAt : createdAt,
		updatedAt: attachment.$assignedFields.contains('updatedAt') ? attachment.updatedAt : updatedAt,
		deletedAt: attachment.$assignedFields.contains('deletedAt') ? attachment.deletedAt : deletedAt,
		transactionId: attachment.$assignedFields.contains('transactionId') ? attachment.transactionId : transactionId,
		taskId: attachment.$assignedFields.contains('taskId') ? attachment.taskId : taskId,
		messageId: attachment.$assignedFields.contains('messageId') ? attachment.messageId : messageId,
		propertyComplianceId: attachment.$assignedFields.contains('propertyComplianceId') ? attachment.propertyComplianceId : propertyComplianceId,
		reviewId: attachment.$assignedFields.contains('reviewId') ? attachment.reviewId : reviewId,
		message: attachment.$assignedFields.contains('message') ? attachment.message : message,
		org: attachment.$assignedFields.contains('org') ? attachment.org : org,
		propertyCompliance: attachment.$assignedFields.contains('propertyCompliance') ? attachment.propertyCompliance : propertyCompliance,
		property: attachment.$assignedFields.contains('property') ? attachment.property : property,
		review: attachment.$assignedFields.contains('review') ? attachment.review : review,
		task: attachment.$assignedFields.contains('task') ? attachment.task : task,
		financialRecord: attachment.$assignedFields.contains('financialRecord') ? attachment.financialRecord : financialRecord
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Attachment updateWithInstanceValues(Attachment attachment) {
        if (attachment.$assignedFields.contains('id')) { id = attachment.id; }
		if (attachment.$assignedFields.contains('orgId')) { orgId = attachment.orgId; }
		if (attachment.$assignedFields.contains('propertyId')) { propertyId = attachment.propertyId; }
		if (attachment.$assignedFields.contains('entityType')) { entityType = attachment.entityType; }
		if (attachment.$assignedFields.contains('entityId')) { entityId = attachment.entityId; }
		if (attachment.$assignedFields.contains('fileName')) { fileName = attachment.fileName; }
		if (attachment.$assignedFields.contains('mimeType')) { mimeType = attachment.mimeType; }
		if (attachment.$assignedFields.contains('sizeBytes')) { sizeBytes = attachment.sizeBytes; }
		if (attachment.$assignedFields.contains('storageKey')) { storageKey = attachment.storageKey; }
		if (attachment.$assignedFields.contains('url')) { url = attachment.url; }
		if (attachment.$assignedFields.contains('checksum')) { checksum = attachment.checksum; }
		if (attachment.$assignedFields.contains('createdBy')) { createdBy = attachment.createdBy; }
		if (attachment.$assignedFields.contains('createdAt')) { createdAt = attachment.createdAt; }
		if (attachment.$assignedFields.contains('updatedAt')) { updatedAt = attachment.updatedAt; }
		if (attachment.$assignedFields.contains('deletedAt')) { deletedAt = attachment.deletedAt; }
		if (attachment.$assignedFields.contains('transactionId')) { transactionId = attachment.transactionId; }
		if (attachment.$assignedFields.contains('taskId')) { taskId = attachment.taskId; }
		if (attachment.$assignedFields.contains('messageId')) { messageId = attachment.messageId; }
		if (attachment.$assignedFields.contains('propertyComplianceId')) { propertyComplianceId = attachment.propertyComplianceId; }
		if (attachment.$assignedFields.contains('reviewId')) { reviewId = attachment.reviewId; }
		if (attachment.$assignedFields.contains('message')) { message = attachment.message; }
		if (attachment.$assignedFields.contains('org')) { org = attachment.org; }
		if (attachment.$assignedFields.contains('propertyCompliance')) { propertyCompliance = attachment.propertyCompliance; }
		if (attachment.$assignedFields.contains('property')) { property = attachment.property; }
		if (attachment.$assignedFields.contains('review')) { review = attachment.review; }
		if (attachment.$assignedFields.contains('task')) { task = attachment.task; }
		if (attachment.$assignedFields.contains('financialRecord')) { financialRecord = attachment.financialRecord; }
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
          ? {...?serializedTypes, 'Attachment'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(entityType != null) 'entityType': entityType,
	if(entityId != null) 'entityId': entityId,
	if(fileName != null) 'fileName': fileName,
	if(mimeType != null) 'mimeType': mimeType,
	if(sizeBytes != null) 'sizeBytes': sizeBytes,
	if(storageKey != null) 'storageKey': storageKey,
	if(url != null) 'url': url,
	if(checksum != null) 'checksum': checksum,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(transactionId != null) 'transactionId': transactionId,
	if(taskId != null) 'taskId': taskId,
	if(messageId != null) 'messageId': messageId,
	if(propertyComplianceId != null) 'propertyComplianceId': propertyComplianceId,
	if(reviewId != null) 'reviewId': reviewId,
	if(message != null && (!preventCircularSerialization || !serializedModels.contains('Message'))) 'message': message?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(propertyCompliance != null && (!preventCircularSerialization || !serializedModels.contains('PropertyCompliance'))) 'propertyCompliance': propertyCompliance?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(review != null && (!preventCircularSerialization || !serializedModels.contains('Review'))) 'review': review?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(task != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'task': task?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(financialRecord != null && (!preventCircularSerialization || !serializedModels.contains('FinancialRecord'))) 'financialRecord': financialRecord?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Attachment &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    