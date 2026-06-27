import 'package:reservatior/shared/enums/notification_channel.dart';
import 'package:reservatior/shared/enums/relationship_status.dart';
import 'contact.dart';
import 'user.dart';

class ClientRelationship {
  final String id;
  final String agentId;
  final String clientId;
  final RelationshipStatus status;
  final DateTime firstContact;
  final DateTime? lastContact;
  final String? contactFrequency;
  final NotificationChannel? preferredChannel;
  final User agent;
  final Contact client;

  const ClientRelationship({
    required this.id,
    required this.agentId,
    required this.clientId,
    required this.status,
    required this.firstContact,
    this.lastContact,
    this.contactFrequency,
    this.preferredChannel,
    required this.agent,
    required this.client,
  });

  factory ClientRelationship.fromJson(Map<String, dynamic> json) {
    return ClientRelationship(
      id: json['id'] as String,
      agentId: json['agentId'] as String,
      clientId: json['clientId'] as String,
      status: RelationshipStatus.values.firstWhere((v) => v.name == json['status']),
      firstContact: DateTime.parse(json['firstContact'] as String),
      lastContact: json['lastContact'] != null ? DateTime.parse(json['lastContact'] as String) : null,
      contactFrequency: json['contactFrequency'] as String?,
      preferredChannel: json['preferredChannel'] != null ? NotificationChannel.values.firstWhere((v) => v.name == json['preferredChannel']) : null,
      agent: User.fromJson(json['agent'] as Map<String, dynamic>),
      client: Contact.fromJson(json['client'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'agentId': agentId,
      'clientId': clientId,
      'status': status.name,
      'firstContact': firstContact.toIso8601String(),
      'lastContact': lastContact?.toIso8601String(),
      'contactFrequency': contactFrequency,
      'preferredChannel': preferredChannel?.name,
      'agent': agent.toJson(),
      'client': client.toJson(),
    };
  }

  ClientRelationship copyWith({
    String? id,
    String? agentId,
    String? clientId,
    RelationshipStatus? status,
    DateTime? firstContact,
    DateTime? lastContact,
    String? contactFrequency,
    NotificationChannel? preferredChannel,
    User? agent,
    Contact? client,
  }) {
    return ClientRelationship(
      id: id ?? this.id,
      agentId: agentId ?? this.agentId,
      clientId: clientId ?? this.clientId,
      status: status ?? this.status,
      firstContact: firstContact ?? this.firstContact,
      lastContact: lastContact ?? this.lastContact,
      contactFrequency: contactFrequency ?? this.contactFrequency,
      preferredChannel: preferredChannel ?? this.preferredChannel,
      agent: agent ?? this.agent,
      client: client ?? this.client,
    );
  }
}
