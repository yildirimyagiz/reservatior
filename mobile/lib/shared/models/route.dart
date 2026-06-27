import 'package:reservatior/shared/enums/map_provider.dart';
import 'location.dart';
import 'organization.dart';

class Route {
  final String id;
  final String orgId;
  final String name;
  final String type;
  final String startLocationId;
  final String endLocationId;
  final double? distance;
  final int? duration;
  final String? polyline;
  final MapProvider provider;
  final double? tolls;
  final bool isVisible;
  final String? color;
  final int strokeWidth;
  final double opacity;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Location endLocation;
  final Organization org;
  final Location startLocation;

  const Route({
    required this.id,
    required this.orgId,
    required this.name,
    required this.type,
    required this.startLocationId,
    required this.endLocationId,
    this.distance,
    this.duration,
    this.polyline,
    required this.provider,
    this.tolls,
    required this.isVisible,
    this.color,
    required this.strokeWidth,
    required this.opacity,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.endLocation,
    required this.org,
    required this.startLocation,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      startLocationId: json['startLocationId'] as String,
      endLocationId: json['endLocationId'] as String,
      distance: (json['distance'] as num?)?.toDouble(),
      duration: json['duration'] as int?,
      polyline: json['polyline'] as String?,
      provider: MapProvider.values.firstWhere((v) => v.name == json['provider']),
      tolls: (json['tolls'] as num?)?.toDouble(),
      isVisible: json['isVisible'] as bool,
      color: json['color'] as String?,
      strokeWidth: json['strokeWidth'] as int,
      opacity: (json['opacity'] as num).toDouble(),
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      endLocation: Location.fromJson(json['endLocation'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      startLocation: Location.fromJson(json['startLocation'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'type': type,
      'startLocationId': startLocationId,
      'endLocationId': endLocationId,
      'distance': distance,
      'duration': duration,
      'polyline': polyline,
      'provider': provider.name,
      'tolls': tolls,
      'isVisible': isVisible,
      'color': color,
      'strokeWidth': strokeWidth,
      'opacity': opacity,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'endLocation': endLocation.toJson(),
      'org': org.toJson(),
      'startLocation': startLocation.toJson(),
    };
  }

  Route copyWith({
    String? id,
    String? orgId,
    String? name,
    String? type,
    String? startLocationId,
    String? endLocationId,
    double? distance,
    int? duration,
    String? polyline,
    MapProvider? provider,
    double? tolls,
    bool? isVisible,
    String? color,
    int? strokeWidth,
    double? opacity,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Location? endLocation,
    Organization? org,
    Location? startLocation,
  }) {
    return Route(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      type: type ?? this.type,
      startLocationId: startLocationId ?? this.startLocationId,
      endLocationId: endLocationId ?? this.endLocationId,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      polyline: polyline ?? this.polyline,
      provider: provider ?? this.provider,
      tolls: tolls ?? this.tolls,
      isVisible: isVisible ?? this.isVisible,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      opacity: opacity ?? this.opacity,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      endLocation: endLocation ?? this.endLocation,
      org: org ?? this.org,
      startLocation: startLocation ?? this.startLocation,
    );
  }
}
