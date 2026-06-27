import 'package:reservatior/shared/enums/channel_category.dart';
import 'package:reservatior/shared/enums/channel_type.dart';
import 'communication_log.dart';

class Channel {
  final String id;
  final String cuid;
  final String name;
  final ChannelType type;
  final ChannelCategory category;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<CommunicationLog> communicationLogs;

  const Channel({
    required this.id,
    required this.cuid,
    required this.name,
    required this.type,
    required this.category,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.communicationLogs = const [],
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'] as String,
      cuid: json['cuid'] as String,
      name: json['name'] as String,
      type: ChannelType.values.firstWhere((v) => v.name == json['type']),
      category: ChannelCategory.values.firstWhere((v) => v.name == json['category']),
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      communicationLogs: (json['CommunicationLogs'] as List<dynamic>?)?.map((e) => CommunicationLog.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cuid': cuid,
      'name': name,
      'type': type.name,
      'category': category.name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'CommunicationLogs': communicationLogs.map((e) => e.toJson()).toList(),
    };
  }

  Channel copyWith({
    String? id,
    String? cuid,
    String? name,
    ChannelType? type,
    ChannelCategory? category,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<CommunicationLog>? communicationLogs,
  }) {
    return Channel(
      id: id ?? this.id,
      cuid: cuid ?? this.cuid,
      name: name ?? this.name,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      communicationLogs: communicationLogs ?? this.communicationLogs,
    );
  }
}
