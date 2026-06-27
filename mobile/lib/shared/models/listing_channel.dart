import 'package:reservatior/shared/enums/listing_channel_type.dart';
import 'listing.dart';
import 'organization.dart';

class ListingChannel {
  final String id;
  final String orgId;
  final String listingId;
  final ListingChannelType channel;
  final String? channelId;
  final String status;
  final DateTime? lastSync;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Listing listing;
  final Organization org;

  const ListingChannel({
    required this.id,
    required this.orgId,
    required this.listingId,
    required this.channel,
    this.channelId,
    required this.status,
    this.lastSync,
    required this.createdAt,
    required this.updatedAt,
    required this.listing,
    required this.org,
  });

  factory ListingChannel.fromJson(Map<String, dynamic> json) {
    return ListingChannel(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String,
      channel: ListingChannelType.values.firstWhere((v) => v.name == json['channel']),
      channelId: json['channelId'] as String?,
      status: json['status'] as String,
      lastSync: json['lastSync'] != null ? DateTime.parse(json['lastSync'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'channel': channel.name,
      'channelId': channelId,
      'status': status,
      'lastSync': lastSync?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'listing': listing.toJson(),
      'org': org.toJson(),
    };
  }

  ListingChannel copyWith({
    String? id,
    String? orgId,
    String? listingId,
    ListingChannelType? channel,
    String? channelId,
    String? status,
    DateTime? lastSync,
    DateTime? createdAt,
    DateTime? updatedAt,
    Listing? listing,
    Organization? org,
  }) {
    return ListingChannel(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      channel: channel ?? this.channel,
      channelId: channelId ?? this.channelId,
      status: status ?? this.status,
      lastSync: lastSync ?? this.lastSync,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      listing: listing ?? this.listing,
      org: org ?? this.org,
    );
  }
}
