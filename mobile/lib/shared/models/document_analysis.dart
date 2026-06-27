import 'analysis_job.dart';
import 'document.dart';
import 'organization.dart';

class DocumentAnalysis {
  final String id;
  final String documentName;
  final String type;
  final String status;
  final double confidence;
  final Map<String, dynamic> extractedFields;
  final DateTime createdAt;

  const DocumentAnalysis({
    required this.id,
    required this.documentName,
    required this.type,
    required this.status,
    required this.confidence,
    required this.extractedFields,
    required this.createdAt,
  });

  factory DocumentAnalysis.fromJson(Map<String, dynamic> json) {
    return DocumentAnalysis(
      id: json['id'].toString(),
      documentName: json['documentName'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      extractedFields: json['extractedFields'] as Map<String, dynamic>? ?? {},
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentName': documentName,
      'type': type,
      'status': status,
      'confidence': confidence,
      'extractedFields': extractedFields,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  DocumentAnalysis copyWith({
    String? id,
    String? documentName,
    String? type,
    String? status,
    double? confidence,
    Map<String, dynamic>? extractedFields,
    DateTime? createdAt,
  }) {
    return DocumentAnalysis(
      id: id ?? this.id,
      documentName: documentName ?? this.documentName,
      type: type ?? this.type,
      status: status ?? this.status,
      confidence: confidence ?? this.confidence,
      extractedFields: extractedFields ?? this.extractedFields,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
