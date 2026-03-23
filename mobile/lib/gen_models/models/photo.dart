
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'photo_type.dart';
import 'agency.dart';
import 'agent.dart';
import 'post.dart';
import 'property.dart';
import 'user.dart';


class Photo implements PrismaModel<String, Photo> , Id<String> {
    @override
String? id;
	String? url;
	String? originalName;
	String? filename;
	PhotoType? type;
	String? caption;
	String? alt;
	String? src;
	bool? featured;
	int? width;
	int? height;
	int? fileSize;
	String? mimeType;
	String? dominantColor;
	dynamic mlMetadata;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? userId;
	String? agencyId;
	String? propertyId;
	String? agentId;
	String? postId;
	Agency? Agency;
	Agent? Agent;
	Post? Post;
	Property? Property;
	User? User;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Photo({ this.id,
	 this.url,
	 this.originalName,
	 this.filename,
	 this.type = PhotoType.GALLERY,
	 this.caption,
	 this.alt,
	 this.src,
	 this.featured = false,
	 this.width,
	 this.height,
	 this.fileSize,
	 this.mimeType,
	 this.dominantColor,
	required this.mlMetadata,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.userId,
	 this.agencyId,
	 this.propertyId,
	 this.agentId,
	 this.postId,
	 this.Agency,
	 this.Agent,
	 this.Post,
	 this.Property,
	 this.User,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Photo, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"url": (m) => m.url,

	"originalName": (m) => m.originalName,

	"filename": (m) => m.filename,

	"type": (m) => m.type,

	"caption": (m) => m.caption,

	"alt": (m) => m.alt,

	"src": (m) => m.src,

	"featured": (m) => m.featured,

	"width": (m) => m.width,

	"height": (m) => m.height,

	"fileSize": (m) => m.fileSize,

	"mimeType": (m) => m.mimeType,

	"dominantColor": (m) => m.dominantColor,

	"mlMetadata": (m) => m.mlMetadata,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"userId": (m) => m.userId,

	"agencyId": (m) => m.agencyId,

	"propertyId": (m) => m.propertyId,

	"agentId": (m) => m.agentId,

	"postId": (m) => m.postId,

	"Agency": (m) => m.Agency,

	"Agent": (m) => m.Agent,

	"Post": (m) => m.Post,

	"Property": (m) => m.Property,

	"User": (m) => m.User,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Photo) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Photo');
    }
    return propFunction as V? Function(Photo);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Photo.fromJson(JsonMap json) =>
      Photo(
        id: json['id'] as String?,
	url: json['url'] as String?,
	originalName: json['originalName'] as String?,
	filename: json['filename'] as String?,
	type: json['type'] != null ? PhotoType.fromJson(json['type']) : null,
	caption: json['caption'] as String?,
	alt: json['alt'] as String?,
	src: json['src'] as String?,
	featured: json['featured'] as bool?,
	width: int.tryParse(json['width'].toString()),
	height: int.tryParse(json['height'].toString()),
	fileSize: int.tryParse(json['fileSize'].toString()),
	mimeType: json['mimeType'] as String?,
	dominantColor: json['dominantColor'] as String?,
	mlMetadata: json['mlMetadata'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	userId: json['userId'] as String?,
	agencyId: json['agencyId'] as String?,
	propertyId: json['propertyId'] as String?,
	agentId: json['agentId'] as String?,
	postId: json['postId'] as String?,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as JsonMap) : null,
	Post: json['Post'] != null ? Post.fromJson(json['Post'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Photo copyWith({
        Value<String?>? id,
		Value<String?>? url,
		Value<String?>? originalName,
		Value<String?>? filename,
		Value<PhotoType?>? type,
		Value<String?>? caption,
		Value<String?>? alt,
		Value<String?>? src,
		Value<bool?>? featured,
		Value<int?>? width,
		Value<int?>? height,
		Value<int?>? fileSize,
		Value<String?>? mimeType,
		Value<String?>? dominantColor,
		Value<dynamic>? mlMetadata,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? userId,
		Value<String?>? agencyId,
		Value<String?>? propertyId,
		Value<String?>? agentId,
		Value<String?>? postId,
		Value<Agency?>? Agency,
		Value<Agent?>? Agent,
		Value<Post?>? Post,
		Value<Property?>? Property,
		Value<User?>? User,
        }) {
        return Photo(
            id: id != null ? id.value : this.id,
		url: url != null ? url.value : this.url,
		originalName: originalName != null ? originalName.value : this.originalName,
		filename: filename != null ? filename.value : this.filename,
		type: type != null ? type.value : this.type,
		caption: caption != null ? caption.value : this.caption,
		alt: alt != null ? alt.value : this.alt,
		src: src != null ? src.value : this.src,
		featured: featured != null ? featured.value : this.featured,
		width: width != null ? width.value : this.width,
		height: height != null ? height.value : this.height,
		fileSize: fileSize != null ? fileSize.value : this.fileSize,
		mimeType: mimeType != null ? mimeType.value : this.mimeType,
		dominantColor: dominantColor != null ? dominantColor.value : this.dominantColor,
		mlMetadata: mlMetadata != null ? mlMetadata.value : this.mlMetadata,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		userId: userId != null ? userId.value : this.userId,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		agentId: agentId != null ? agentId.value : this.agentId,
		postId: postId != null ? postId.value : this.postId,
		Agency: Agency != null ? Agency.value : this.Agency,
		Agent: Agent != null ? Agent.value : this.Agent,
		Post: Post != null ? Post.value : this.Post,
		Property: Property != null ? Property.value : this.Property,
		User: User != null ? User.value : this.User
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Photo copyWithInstanceValues(Photo photo) {
        return Photo(
            id: photo.id ?? id,
		url: photo.url ?? url,
		originalName: photo.originalName ?? originalName,
		filename: photo.filename ?? filename,
		type: photo.type ?? type,
		caption: photo.caption ?? caption,
		alt: photo.alt ?? alt,
		src: photo.src ?? src,
		featured: photo.featured ?? featured,
		width: photo.width ?? width,
		height: photo.height ?? height,
		fileSize: photo.fileSize ?? fileSize,
		mimeType: photo.mimeType ?? mimeType,
		dominantColor: photo.dominantColor ?? dominantColor,
		mlMetadata: photo.mlMetadata ?? mlMetadata,
		createdAt: photo.createdAt ?? createdAt,
		updatedAt: photo.updatedAt ?? updatedAt,
		deletedAt: photo.deletedAt ?? deletedAt,
		userId: photo.userId ?? userId,
		agencyId: photo.agencyId ?? agencyId,
		propertyId: photo.propertyId ?? propertyId,
		agentId: photo.agentId ?? agentId,
		postId: photo.postId ?? postId,
		Agency: photo.Agency ?? Agency,
		Agent: photo.Agent ?? Agent,
		Post: photo.Post ?? Post,
		Property: photo.Property ?? Property,
		User: photo.User ?? User
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Photo mergeWithInstanceValues(Photo photo) {
        return Photo(
            id: photo.$assignedFields.contains('id') ? photo.id : id,
		url: photo.$assignedFields.contains('url') ? photo.url : url,
		originalName: photo.$assignedFields.contains('originalName') ? photo.originalName : originalName,
		filename: photo.$assignedFields.contains('filename') ? photo.filename : filename,
		type: photo.$assignedFields.contains('type') ? photo.type : type,
		caption: photo.$assignedFields.contains('caption') ? photo.caption : caption,
		alt: photo.$assignedFields.contains('alt') ? photo.alt : alt,
		src: photo.$assignedFields.contains('src') ? photo.src : src,
		featured: photo.$assignedFields.contains('featured') ? photo.featured : featured,
		width: photo.$assignedFields.contains('width') ? photo.width : width,
		height: photo.$assignedFields.contains('height') ? photo.height : height,
		fileSize: photo.$assignedFields.contains('fileSize') ? photo.fileSize : fileSize,
		mimeType: photo.$assignedFields.contains('mimeType') ? photo.mimeType : mimeType,
		dominantColor: photo.$assignedFields.contains('dominantColor') ? photo.dominantColor : dominantColor,
		mlMetadata: photo.$assignedFields.contains('mlMetadata') ? photo.mlMetadata : mlMetadata,
		createdAt: photo.$assignedFields.contains('createdAt') ? photo.createdAt : createdAt,
		updatedAt: photo.$assignedFields.contains('updatedAt') ? photo.updatedAt : updatedAt,
		deletedAt: photo.$assignedFields.contains('deletedAt') ? photo.deletedAt : deletedAt,
		userId: photo.$assignedFields.contains('userId') ? photo.userId : userId,
		agencyId: photo.$assignedFields.contains('agencyId') ? photo.agencyId : agencyId,
		propertyId: photo.$assignedFields.contains('propertyId') ? photo.propertyId : propertyId,
		agentId: photo.$assignedFields.contains('agentId') ? photo.agentId : agentId,
		postId: photo.$assignedFields.contains('postId') ? photo.postId : postId,
		Agency: photo.$assignedFields.contains('Agency') ? photo.Agency : Agency,
		Agent: photo.$assignedFields.contains('Agent') ? photo.Agent : Agent,
		Post: photo.$assignedFields.contains('Post') ? photo.Post : Post,
		Property: photo.$assignedFields.contains('Property') ? photo.Property : Property,
		User: photo.$assignedFields.contains('User') ? photo.User : User
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Photo updateWithInstanceValues(Photo photo) {
        if (photo.$assignedFields.contains('id')) { id = photo.id; }
		if (photo.$assignedFields.contains('url')) { url = photo.url; }
		if (photo.$assignedFields.contains('originalName')) { originalName = photo.originalName; }
		if (photo.$assignedFields.contains('filename')) { filename = photo.filename; }
		if (photo.$assignedFields.contains('type')) { type = photo.type; }
		if (photo.$assignedFields.contains('caption')) { caption = photo.caption; }
		if (photo.$assignedFields.contains('alt')) { alt = photo.alt; }
		if (photo.$assignedFields.contains('src')) { src = photo.src; }
		if (photo.$assignedFields.contains('featured')) { featured = photo.featured; }
		if (photo.$assignedFields.contains('width')) { width = photo.width; }
		if (photo.$assignedFields.contains('height')) { height = photo.height; }
		if (photo.$assignedFields.contains('fileSize')) { fileSize = photo.fileSize; }
		if (photo.$assignedFields.contains('mimeType')) { mimeType = photo.mimeType; }
		if (photo.$assignedFields.contains('dominantColor')) { dominantColor = photo.dominantColor; }
		if (photo.$assignedFields.contains('mlMetadata')) { mlMetadata = photo.mlMetadata; }
		if (photo.$assignedFields.contains('createdAt')) { createdAt = photo.createdAt; }
		if (photo.$assignedFields.contains('updatedAt')) { updatedAt = photo.updatedAt; }
		if (photo.$assignedFields.contains('deletedAt')) { deletedAt = photo.deletedAt; }
		if (photo.$assignedFields.contains('userId')) { userId = photo.userId; }
		if (photo.$assignedFields.contains('agencyId')) { agencyId = photo.agencyId; }
		if (photo.$assignedFields.contains('propertyId')) { propertyId = photo.propertyId; }
		if (photo.$assignedFields.contains('agentId')) { agentId = photo.agentId; }
		if (photo.$assignedFields.contains('postId')) { postId = photo.postId; }
		if (photo.$assignedFields.contains('Agency')) { Agency = photo.Agency; }
		if (photo.$assignedFields.contains('Agent')) { Agent = photo.Agent; }
		if (photo.$assignedFields.contains('Post')) { Post = photo.Post; }
		if (photo.$assignedFields.contains('Property')) { Property = photo.Property; }
		if (photo.$assignedFields.contains('User')) { User = photo.User; }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'Photo'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(url != null) 'url': url,
	if(originalName != null) 'originalName': originalName,
	if(filename != null) 'filename': filename,
	if(type != null) 'type': type?.toJson(),
	if(caption != null) 'caption': caption,
	if(alt != null) 'alt': alt,
	if(src != null) 'src': src,
	if(featured != null) 'featured': featured,
	if(width != null) 'width': width,
	if(height != null) 'height': height,
	if(fileSize != null) 'fileSize': fileSize,
	if(mimeType != null) 'mimeType': mimeType,
	if(dominantColor != null) 'dominantColor': dominantColor,
	if(mlMetadata != null) 'mlMetadata': mlMetadata,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(userId != null) 'userId': userId,
	if(agencyId != null) 'agencyId': agencyId,
	if(propertyId != null) 'propertyId': propertyId,
	if(agentId != null) 'agentId': agentId,
	if(postId != null) 'postId': postId,
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Agent != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'Agent': Agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Post != null && (!preventCircularSerialization || !serializedModels.contains('Post'))) 'Post': Post?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Photo &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    