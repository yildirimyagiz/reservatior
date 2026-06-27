import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'user.dart';

class PropertyViewing {
  final String id;
  final String orgId;
  final String propertyId;
  final String? listingId;
  final String viewingType;
  final DateTime scheduledDate;
  final int duration;
  final String attendeeName;
  final String attendeeEmail;
  final String? attendeePhone;
  final String attendeeType;
  final String status;
  final String? assignedAgentId;
  final String? feedback;
  final String? interestedLevel;
  final bool followUpRequired;
  final String? followUpNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? assignedAgent;
  final Listing? listing;
  final Organization org;
  final Property property;

  const PropertyViewing({
    required this.id,
    required this.orgId,
    required this.propertyId,
    this.listingId,
    required this.viewingType,
    required this.scheduledDate,
    required this.duration,
    required this.attendeeName,
    required this.attendeeEmail,
    this.attendeePhone,
    required this.attendeeType,
    required this.status,
    this.assignedAgentId,
    this.feedback,
    this.interestedLevel,
    required this.followUpRequired,
    this.followUpNotes,
    required this.createdAt,
    required this.updatedAt,
    this.assignedAgent,
    this.listing,
    required this.org,
    required this.property,
  });

  factory PropertyViewing.fromJson(Map<String, dynamic> json) {
    return PropertyViewing(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      listingId: json['listingId'] as String?,
      viewingType: json['viewingType'] as String,
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      duration: json['duration'] as int,
      attendeeName: json['attendeeName'] as String,
      attendeeEmail: json['attendeeEmail'] as String,
      attendeePhone: json['attendeePhone'] as String?,
      attendeeType: json['attendeeType'] as String,
      status: json['status'] as String,
      assignedAgentId: json['assignedAgentId'] as String?,
      feedback: json['feedback'] as String?,
      interestedLevel: json['interestedLevel'] as String?,
      followUpRequired: json['followUpRequired'] as bool,
      followUpNotes: json['followUpNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      assignedAgent: json['assignedAgent'] != null ? User.fromJson(json['assignedAgent'] as Map<String, dynamic>) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'listingId': listingId,
      'viewingType': viewingType,
      'scheduledDate': scheduledDate.toIso8601String(),
      'duration': duration,
      'attendeeName': attendeeName,
      'attendeeEmail': attendeeEmail,
      'attendeePhone': attendeePhone,
      'attendeeType': attendeeType,
      'status': status,
      'assignedAgentId': assignedAgentId,
      'feedback': feedback,
      'interestedLevel': interestedLevel,
      'followUpRequired': followUpRequired,
      'followUpNotes': followUpNotes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'assignedAgent': assignedAgent?.toJson(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'property': property.toJson(),
    };
  }

  PropertyViewing copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    String? viewingType,
    DateTime? scheduledDate,
    int? duration,
    String? attendeeName,
    String? attendeeEmail,
    String? attendeePhone,
    String? attendeeType,
    String? status,
    String? assignedAgentId,
    String? feedback,
    String? interestedLevel,
    bool? followUpRequired,
    String? followUpNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? assignedAgent,
    Listing? listing,
    Organization? org,
    Property? property,
  }) {
    return PropertyViewing(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      viewingType: viewingType ?? this.viewingType,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      duration: duration ?? this.duration,
      attendeeName: attendeeName ?? this.attendeeName,
      attendeeEmail: attendeeEmail ?? this.attendeeEmail,
      attendeePhone: attendeePhone ?? this.attendeePhone,
      attendeeType: attendeeType ?? this.attendeeType,
      status: status ?? this.status,
      assignedAgentId: assignedAgentId ?? this.assignedAgentId,
      feedback: feedback ?? this.feedback,
      interestedLevel: interestedLevel ?? this.interestedLevel,
      followUpRequired: followUpRequired ?? this.followUpRequired,
      followUpNotes: followUpNotes ?? this.followUpNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      assignedAgent: assignedAgent ?? this.assignedAgent,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
