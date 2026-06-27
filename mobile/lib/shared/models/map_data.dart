

class MapData {
  final String id;
  final String? projectId;

  const MapData({
    required this.id,
    this.projectId,
  });

  factory MapData.fromJson(Map<String, dynamic> json) {
    return MapData(
      id: json['id'] as String,
      projectId: json['projectId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
    };
  }

  MapData copyWith({
    String? id,
    String? projectId,
  }) {
    return MapData(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
    );
  }
}
