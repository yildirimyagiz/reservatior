enum AiTaskType {
  REELS_VIDEO_GEN,
  PDF_BROCHURE_GEN,
  DOCUMENT_OCR,
  FINANCIAL_EXTRACTION,
  TRANSLATION_LOCALIZATION,
  PHOTO_ENHANCEMENT,
  COMPLIANCE_CHECK
}

enum AiTaskStatus {
  QUEUED,
  PROCESSING,
  COMPLETED,
  FAILED,
  CANCELED
}

class AiServiceTask {
  final String id;
  final String orgId;
  final String propertyId;
  final String? listingId;
  final AiTaskType taskType;
  final AiTaskStatus status;
  final Map<String, dynamic>? inputData;
  final Map<String, dynamic>? outputData;
  final String? externalJobId;
  final String? errorMessage;
  final int progress;
  final int priority;
  final DateTime createdAt;
  final DateTime updatedAt;

  AiServiceTask({
    required this.id,
    required this.orgId,
    required this.propertyId,
    this.listingId,
    required this.taskType,
    required this.status,
    this.inputData,
    this.outputData,
    this.externalJobId,
    this.errorMessage,
    this.progress = 0,
    this.priority = 1,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AiServiceTask.fromJson(Map<String, dynamic> json) {
    return AiServiceTask(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      listingId: json['listingId'] as String?,
      taskType: AiTaskType.values.firstWhere((e) => e.name == json['taskType']),
      status: AiTaskStatus.values.firstWhere((e) => e.name == json['status']),
      inputData: json['inputData'] as Map<String, dynamic>?,
      outputData: json['outputData'] as Map<String, dynamic>?,
      externalJobId: json['externalJobId'] as String?,
      errorMessage: json['errorMessage'] as String?,
      progress: json['progress'] as int? ?? 0,
      priority: json['priority'] as int? ?? 1,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
