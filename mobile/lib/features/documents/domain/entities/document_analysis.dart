// ── Document Analysis Entity
// Document analiz sonuçları için entity

class DocumentAnalysis {
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

  const DocumentAnalysis({
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

  DocumentAnalysis copyWith({
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
    return DocumentAnalysis(
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
    return other is DocumentAnalysis && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'DocumentAnalysis(id: $id, documentId: $documentId, confidence: $confidence)';
  }
}
