import 'agency.dart';
import 'agent.dart';
import 'user.dart';

class Language {
  final String id;
  final String code;
  final String name;
  final String nativeName;
  final bool isRTL;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? agencyId;
  final String? agentId;
  final String? userId;
  final Agency? agency;
  final Agent? agent;
  final User? user;

  const Language({
    required this.id,
    required this.code,
    required this.name,
    required this.nativeName,
    required this.isRTL,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.agencyId,
    this.agentId,
    this.userId,
    this.agency,
    this.agent,
    this.user,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      nativeName: json['nativeName'] as String,
      isRTL: json['isRTL'] as bool,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      agencyId: json['agencyId'] as String?,
      agentId: json['agentId'] as String?,
      userId: json['userId'] as String?,
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as Map<String, dynamic>) : null,
      user: json['User'] != null ? User.fromJson(json['User'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'nativeName': nativeName,
      'isRTL': isRTL,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'agencyId': agencyId,
      'agentId': agentId,
      'userId': userId,
      'Agency': agency?.toJson(),
      'Agent': agent?.toJson(),
      'User': user?.toJson(),
    };
  }

  Language copyWith({
    String? id,
    String? code,
    String? name,
    String? nativeName,
    bool? isRTL,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? agencyId,
    String? agentId,
    String? userId,
    Agency? agency,
    Agent? agent,
    User? user,
  }) {
    return Language(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      nativeName: nativeName ?? this.nativeName,
      isRTL: isRTL ?? this.isRTL,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      agencyId: agencyId ?? this.agencyId,
      agentId: agentId ?? this.agentId,
      userId: userId ?? this.userId,
      agency: agency ?? this.agency,
      agent: agent ?? this.agent,
      user: user ?? this.user,
    );
  }
}
