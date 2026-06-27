import 'financial_record.dart';
import 'message.dart';
import 'organization.dart';
import 'property.dart';
import 'property_compliance.dart';
import 'review.dart';
import 'task.dart';

class Attachment {
  final String id;
  final String orgId;
  final String? propertyId;
  final String entityType;
  final String entityId;
  final String fileName;
  final String mimeType;
  final int sizeBytes;
  final String storageKey;
  final String? url;
  final String? checksum;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? transactionId;
  final String? taskId;
  final String? messageId;
  final String? propertyComplianceId;
  final String? reviewId;
  final Message? message;
  final Organization org;
  final PropertyCompliance? propertyCompliance;
  final Property? property;
  final Review? review;
  final Task? task;
  final FinancialRecord? financialRecord;

  const Attachment({
    required this.id,
    required this.orgId,
    this.propertyId,
    required this.entityType,
    required this.entityId,
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
    required this.storageKey,
    this.url,
    this.checksum,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.transactionId,
    this.taskId,
    this.messageId,
    this.propertyComplianceId,
    this.reviewId,
    this.message,
    required this.org,
    this.propertyCompliance,
    this.property,
    this.review,
    this.task,
    this.financialRecord,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String?,
      entityType: json['entityType'] as String,
      entityId: json['entityId'] as String,
      fileName: json['fileName'] as String,
      mimeType: json['mimeType'] as String,
      sizeBytes: json['sizeBytes'] as int,
      storageKey: json['storageKey'] as String,
      url: json['url'] as String?,
      checksum: json['checksum'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      transactionId: json['transactionId'] as String?,
      taskId: json['taskId'] as String?,
      messageId: json['messageId'] as String?,
      propertyComplianceId: json['propertyComplianceId'] as String?,
      reviewId: json['reviewId'] as String?,
      message: json['message'] != null ? Message.fromJson(json['message'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      propertyCompliance: json['propertyCompliance'] != null ? PropertyCompliance.fromJson(json['propertyCompliance'] as Map<String, dynamic>) : null,
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
      review: json['review'] != null ? Review.fromJson(json['review'] as Map<String, dynamic>) : null,
      task: json['task'] != null ? Task.fromJson(json['task'] as Map<String, dynamic>) : null,
      financialRecord: json['financialRecord'] != null ? FinancialRecord.fromJson(json['financialRecord'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'entityType': entityType,
      'entityId': entityId,
      'fileName': fileName,
      'mimeType': mimeType,
      'sizeBytes': sizeBytes,
      'storageKey': storageKey,
      'url': url,
      'checksum': checksum,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'transactionId': transactionId,
      'taskId': taskId,
      'messageId': messageId,
      'propertyComplianceId': propertyComplianceId,
      'reviewId': reviewId,
      'message': message?.toJson(),
      'org': org.toJson(),
      'propertyCompliance': propertyCompliance?.toJson(),
      'property': property?.toJson(),
      'review': review?.toJson(),
      'task': task?.toJson(),
      'financialRecord': financialRecord?.toJson(),
    };
  }

  Attachment copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? entityType,
    String? entityId,
    String? fileName,
    String? mimeType,
    int? sizeBytes,
    String? storageKey,
    String? url,
    String? checksum,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? transactionId,
    String? taskId,
    String? messageId,
    String? propertyComplianceId,
    String? reviewId,
    Message? message,
    Organization? org,
    PropertyCompliance? propertyCompliance,
    Property? property,
    Review? review,
    Task? task,
    FinancialRecord? financialRecord,
  }) {
    return Attachment(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      storageKey: storageKey ?? this.storageKey,
      url: url ?? this.url,
      checksum: checksum ?? this.checksum,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      transactionId: transactionId ?? this.transactionId,
      taskId: taskId ?? this.taskId,
      messageId: messageId ?? this.messageId,
      propertyComplianceId: propertyComplianceId ?? this.propertyComplianceId,
      reviewId: reviewId ?? this.reviewId,
      message: message ?? this.message,
      org: org ?? this.org,
      propertyCompliance: propertyCompliance ?? this.propertyCompliance,
      property: property ?? this.property,
      review: review ?? this.review,
      task: task ?? this.task,
      financialRecord: financialRecord ?? this.financialRecord,
    );
  }
}
