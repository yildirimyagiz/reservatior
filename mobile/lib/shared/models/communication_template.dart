import 'organization.dart';

class CommunicationTemplate {
  final String id;
  final String orgId;
  final String name;
  final String type;
  final String templateType;
  final String? subject;
  final String? htmlContent;
  final String? textContent;
  final String? title;
  final String? message;
  final List<String> channels;
  final String? category;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;

  const CommunicationTemplate({
    required this.id,
    required this.orgId,
    required this.name,
    required this.type,
    required this.templateType,
    this.subject,
    this.htmlContent,
    this.textContent,
    this.title,
    this.message,
    this.channels = const [],
    this.category,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
  });

  factory CommunicationTemplate.fromJson(Map<String, dynamic> json) {
    return CommunicationTemplate(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      templateType: json['templateType'] as String,
      subject: json['subject'] as String?,
      htmlContent: json['htmlContent'] as String?,
      textContent: json['textContent'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      channels: (json['channels'] as List<dynamic>?)?.cast<String>() ?? [],
      category: json['category'] as String?,
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'type': type,
      'templateType': templateType,
      'subject': subject,
      'htmlContent': htmlContent,
      'textContent': textContent,
      'title': title,
      'message': message,
      'channels': channels,
      'category': category,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
    };
  }

  CommunicationTemplate copyWith({
    String? id,
    String? orgId,
    String? name,
    String? type,
    String? templateType,
    String? subject,
    String? htmlContent,
    String? textContent,
    String? title,
    String? message,
    List<String>? channels,
    String? category,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
  }) {
    return CommunicationTemplate(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      type: type ?? this.type,
      templateType: templateType ?? this.templateType,
      subject: subject ?? this.subject,
      htmlContent: htmlContent ?? this.htmlContent,
      textContent: textContent ?? this.textContent,
      title: title ?? this.title,
      message: message ?? this.message,
      channels: channels ?? this.channels,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
    );
  }
}
