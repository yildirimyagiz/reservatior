import 'package:reservatior/shared/enums/photo_type.dart';
import 'agency.dart';
import 'agent.dart';
import 'post.dart';
import 'property.dart';
import 'user.dart';

class Photo {
  final String id;
  final String url;
  final String? originalName;
  final String? filename;
  final PhotoType type;
  final String? caption;
  final String? alt;
  final String? src;
  final bool featured;
  final int? width;
  final int? height;
  final int? fileSize;
  final String? mimeType;
  final String? dominantColor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? userId;
  final String? agencyId;
  final String? propertyId;
  final String? agentId;
  final String? postId;
  final Agency? agency;
  final Agent? agent;
  final Post? post;
  final Property? property;
  final User? user;

  const Photo({
    required this.id,
    required this.url,
    this.originalName,
    this.filename,
    required this.type,
    this.caption,
    this.alt,
    this.src,
    required this.featured,
    this.width,
    this.height,
    this.fileSize,
    this.mimeType,
    this.dominantColor,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.userId,
    this.agencyId,
    this.propertyId,
    this.agentId,
    this.postId,
    this.agency,
    this.agent,
    this.post,
    this.property,
    this.user,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      url: json['url'] as String,
      originalName: json['originalName'] as String?,
      filename: json['filename'] as String?,
      type: (() {
        final valUpper = json['type']?.toString().toUpperCase() ?? '';
        return PhotoType.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => PhotoType.GALLERY,
        );
      })(),
      caption: json['caption'] as String?,
      alt: json['alt'] as String?,
      src: json['src'] as String?,
      featured: json['featured'] as bool,
      width: json['width'] as int?,
      height: json['height'] as int?,
      fileSize: json['fileSize'] as int?,
      mimeType: json['mimeType'] as String?,
      dominantColor: json['dominantColor'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      userId: json['userId'] as String?,
      agencyId: json['agencyId'] as String?,
      propertyId: json['propertyId'] as String?,
      agentId: json['agentId'] as String?,
      postId: json['postId'] as String?,
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as Map<String, dynamic>) : null,
      post: json['Post'] != null ? Post.fromJson(json['Post'] as Map<String, dynamic>) : null,
      property: json['Property'] != null ? Property.fromJson(json['Property'] as Map<String, dynamic>) : null,
      user: json['User'] != null ? User.fromJson(json['User'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'originalName': originalName,
      'filename': filename,
      'type': type.name,
      'caption': caption,
      'alt': alt,
      'src': src,
      'featured': featured,
      'width': width,
      'height': height,
      'fileSize': fileSize,
      'mimeType': mimeType,
      'dominantColor': dominantColor,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'userId': userId,
      'agencyId': agencyId,
      'propertyId': propertyId,
      'agentId': agentId,
      'postId': postId,
      'Agency': agency?.toJson(),
      'Agent': agent?.toJson(),
      'Post': post?.toJson(),
      'Property': property?.toJson(),
      'User': user?.toJson(),
    };
  }

  Photo copyWith({
    String? id,
    String? url,
    String? originalName,
    String? filename,
    PhotoType? type,
    String? caption,
    String? alt,
    String? src,
    bool? featured,
    int? width,
    int? height,
    int? fileSize,
    String? mimeType,
    String? dominantColor,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? userId,
    String? agencyId,
    String? propertyId,
    String? agentId,
    String? postId,
    Agency? agency,
    Agent? agent,
    Post? post,
    Property? property,
    User? user,
  }) {
    return Photo(
      id: id ?? this.id,
      url: url ?? this.url,
      originalName: originalName ?? this.originalName,
      filename: filename ?? this.filename,
      type: type ?? this.type,
      caption: caption ?? this.caption,
      alt: alt ?? this.alt,
      src: src ?? this.src,
      featured: featured ?? this.featured,
      width: width ?? this.width,
      height: height ?? this.height,
      fileSize: fileSize ?? this.fileSize,
      mimeType: mimeType ?? this.mimeType,
      dominantColor: dominantColor ?? this.dominantColor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      userId: userId ?? this.userId,
      agencyId: agencyId ?? this.agencyId,
      propertyId: propertyId ?? this.propertyId,
      agentId: agentId ?? this.agentId,
      postId: postId ?? this.postId,
      agency: agency ?? this.agency,
      agent: agent ?? this.agent,
      post: post ?? this.post,
      property: property ?? this.property,
      user: user ?? this.user,
    );
  }
}
