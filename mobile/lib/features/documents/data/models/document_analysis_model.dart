
// ── Document Analysis Model
// Document Analysis entity'si için data model

class DocumentAnalysisModel {
  final String? id;
  final String? documentId;
  final String? jobId;
  final String? orgId;
  final String? extractedText;
  final dynamic metadata;
  final dynamic classification;
  final double? confidence;
  final int? processingTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DocumentAnalysisModel({
    this.id,
    this.documentId,
    this.jobId,
    this.orgId,
    this.extractedText,
    this.metadata,
    this.classification,
    this.confidence,
    this.processingTime,
    this.createdAt,
    this.updatedAt,
  });

  factory DocumentAnalysisModel.fromJson(Map<String, dynamic> json) {
    return DocumentAnalysisModel(
      id: json['id'] as String?,
      documentId: json['documentId'] as String?,
      jobId: json['jobId'] as String?,
      orgId: json['orgId'] as String?,
      extractedText: json['extractedText'] as String?,
      metadata: json['metadata'],
      classification: json['classification'],
      confidence: (json['confidence'] as num?)?.toDouble(),
      processingTime: json['processingTime'] as int?,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentId': documentId,
      'jobId': jobId,
      'orgId': orgId,
      'extractedText': extractedText,
      'metadata': metadata,
      'classification': classification,
      'confidence': confidence,
      'processingTime': processingTime,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  DocumentAnalysisModel copyWith({
    String? id,
    String? documentId,
    String? jobId,
    String? orgId,
    String? extractedText,
    dynamic metadata,
    dynamic classification,
    double? confidence,
    int? processingTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DocumentAnalysisModel(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      jobId: jobId ?? this.jobId,
      orgId: orgId ?? this.orgId,
      extractedText: extractedText ?? this.extractedText,
      metadata: metadata ?? this.metadata,
      classification: classification ?? this.classification,
      confidence: confidence ?? this.confidence,
      processingTime: processingTime ?? this.processingTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DocumentAnalysisModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'DocumentAnalysisModel(id: $id, documentId: $documentId, confidence: $confidence)';
  }
}
