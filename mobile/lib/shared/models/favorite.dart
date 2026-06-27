import 'property.dart';
import 'user.dart';

class Favorite {
  final String id;
  final String userId;
  final String propertyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Property property;
  final User user;

  const Favorite({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.property,
    required this.user,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'] as String,
      userId: json['userId'] as String,
      propertyId: json['propertyId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'propertyId': propertyId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'property': property.toJson(),
      'user': user.toJson(),
    };
  }

  Favorite copyWith({
    String? id,
    String? userId,
    String? propertyId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Property? property,
    User? user,
  }) {
    return Favorite(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      propertyId: propertyId ?? this.propertyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      property: property ?? this.property,
      user: user ?? this.user,
    );
  }
}
