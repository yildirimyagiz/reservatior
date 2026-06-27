import 'package:reservatior/shared/enums/map_provider.dart';
import 'organization.dart';

class MapLayer {
  final String id;
  final String orgId;
  final String name;
  final String type;
  final MapProvider provider;
  final String? url;
  final bool isVisible;
  final double opacity;
  final int zIndex;
  final double? northEastLat;
  final double? northEastLng;
  final double? southWestLat;
  final double? southWestLng;
  final double? centerLat;
  final double? centerLng;
  final int? zoomLevel;
  final int? minZoom;
  final int? maxZoom;
  final String? fillColor;
  final String? strokeColor;
  final double? strokeWidth;
  final double? fillOpacity;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;

  const MapLayer({
    required this.id,
    required this.orgId,
    required this.name,
    required this.type,
    required this.provider,
    this.url,
    required this.isVisible,
    required this.opacity,
    required this.zIndex,
    this.northEastLat,
    this.northEastLng,
    this.southWestLat,
    this.southWestLng,
    this.centerLat,
    this.centerLng,
    this.zoomLevel,
    this.minZoom,
    this.maxZoom,
    this.fillColor,
    this.strokeColor,
    this.strokeWidth,
    this.fillOpacity,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
  });

  factory MapLayer.fromJson(Map<String, dynamic> json) {
    return MapLayer(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      provider: MapProvider.values.firstWhere((v) => v.name == json['provider']),
      url: json['url'] as String?,
      isVisible: json['isVisible'] as bool,
      opacity: (json['opacity'] as num).toDouble(),
      zIndex: json['zIndex'] as int,
      northEastLat: (json['northEastLat'] as num?)?.toDouble(),
      northEastLng: (json['northEastLng'] as num?)?.toDouble(),
      southWestLat: (json['southWestLat'] as num?)?.toDouble(),
      southWestLng: (json['southWestLng'] as num?)?.toDouble(),
      centerLat: (json['centerLat'] as num?)?.toDouble(),
      centerLng: (json['centerLng'] as num?)?.toDouble(),
      zoomLevel: json['zoomLevel'] as int?,
      minZoom: json['minZoom'] as int?,
      maxZoom: json['maxZoom'] as int?,
      fillColor: json['fillColor'] as String?,
      strokeColor: json['strokeColor'] as String?,
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble(),
      fillOpacity: (json['fillOpacity'] as num?)?.toDouble(),
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
      'provider': provider.name,
      'url': url,
      'isVisible': isVisible,
      'opacity': opacity,
      'zIndex': zIndex,
      'northEastLat': northEastLat,
      'northEastLng': northEastLng,
      'southWestLat': southWestLat,
      'southWestLng': southWestLng,
      'centerLat': centerLat,
      'centerLng': centerLng,
      'zoomLevel': zoomLevel,
      'minZoom': minZoom,
      'maxZoom': maxZoom,
      'fillColor': fillColor,
      'strokeColor': strokeColor,
      'strokeWidth': strokeWidth,
      'fillOpacity': fillOpacity,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
    };
  }

  MapLayer copyWith({
    String? id,
    String? orgId,
    String? name,
    String? type,
    MapProvider? provider,
    String? url,
    bool? isVisible,
    double? opacity,
    int? zIndex,
    double? northEastLat,
    double? northEastLng,
    double? southWestLat,
    double? southWestLng,
    double? centerLat,
    double? centerLng,
    int? zoomLevel,
    int? minZoom,
    int? maxZoom,
    String? fillColor,
    String? strokeColor,
    double? strokeWidth,
    double? fillOpacity,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
  }) {
    return MapLayer(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      type: type ?? this.type,
      provider: provider ?? this.provider,
      url: url ?? this.url,
      isVisible: isVisible ?? this.isVisible,
      opacity: opacity ?? this.opacity,
      zIndex: zIndex ?? this.zIndex,
      northEastLat: northEastLat ?? this.northEastLat,
      northEastLng: northEastLng ?? this.northEastLng,
      southWestLat: southWestLat ?? this.southWestLat,
      southWestLng: southWestLng ?? this.southWestLng,
      centerLat: centerLat ?? this.centerLat,
      centerLng: centerLng ?? this.centerLng,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      minZoom: minZoom ?? this.minZoom,
      maxZoom: maxZoom ?? this.maxZoom,
      fillColor: fillColor ?? this.fillColor,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      fillOpacity: fillOpacity ?? this.fillOpacity,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
    );
  }
}
