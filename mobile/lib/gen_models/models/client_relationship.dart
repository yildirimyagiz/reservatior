
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'relationship_status.dart';
import 'notification_channel.dart';
import 'user.dart';
import 'contact.dart';


class ClientRelationship implements PrismaModel<String, ClientRelationship> , Id<String> {
    @override
String? id;
	String? agentId;
	String? clientId;
	RelationshipStatus? status;
	DateTime? firstContact;
	DateTime? lastContact;
	String? contactFrequency;
	NotificationChannel? preferredChannel;
	User? agent;
	Contact? client;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ClientRelationship({ this.id,
	 this.agentId,
	 this.clientId,
	 this.status = RelationshipStatus.PROSPECT,
	 this.firstContact,
	 this.lastContact,
	 this.contactFrequency,
	 this.preferredChannel,
	 this.agent,
	 this.client,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ClientRelationship, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"agentId": (m) => m.agentId,

	"clientId": (m) => m.clientId,

	"status": (m) => m.status,

	"firstContact": (m) => m.firstContact,

	"lastContact": (m) => m.lastContact,

	"contactFrequency": (m) => m.contactFrequency,

	"preferredChannel": (m) => m.preferredChannel,

	"agent": (m) => m.agent,

	"client": (m) => m.client,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ClientRelationship) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ClientRelationship');
    }
    return propFunction as V? Function(ClientRelationship);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ClientRelationship.fromJson(JsonMap json) =>
      ClientRelationship(
        id: json['id'] as String?,
	agentId: json['agentId'] as String?,
	clientId: json['clientId'] as String?,
	status: json['status'] != null ? RelationshipStatus.fromJson(json['status']) : null,
	firstContact: json['firstContact'] != null ? DateTime.parse(json['firstContact']) : null,
	lastContact: json['lastContact'] != null ? DateTime.parse(json['lastContact']) : null,
	contactFrequency: json['contactFrequency'] as String?,
	preferredChannel: json['preferredChannel'] != null ? NotificationChannel.fromJson(json['preferredChannel']) : null,
	agent: json['agent'] != null ? User.fromJson(json['agent'] as JsonMap) : null,
	client: json['client'] != null ? Contact.fromJson(json['client'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ClientRelationship copyWith({
        Value<String?>? id,
		Value<String?>? agentId,
		Value<String?>? clientId,
		Value<RelationshipStatus?>? status,
		Value<DateTime?>? firstContact,
		Value<DateTime?>? lastContact,
		Value<String?>? contactFrequency,
		Value<NotificationChannel?>? preferredChannel,
		Value<User?>? agent,
		Value<Contact?>? client,
        }) {
        return ClientRelationship(
            id: id != null ? id.value : this.id,
		agentId: agentId != null ? agentId.value : this.agentId,
		clientId: clientId != null ? clientId.value : this.clientId,
		status: status != null ? status.value : this.status,
		firstContact: firstContact != null ? firstContact.value : this.firstContact,
		lastContact: lastContact != null ? lastContact.value : this.lastContact,
		contactFrequency: contactFrequency != null ? contactFrequency.value : this.contactFrequency,
		preferredChannel: preferredChannel != null ? preferredChannel.value : this.preferredChannel,
		agent: agent != null ? agent.value : this.agent,
		client: client != null ? client.value : this.client
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ClientRelationship copyWithInstanceValues(ClientRelationship clientRelationship) {
        return ClientRelationship(
            id: clientRelationship.id ?? id,
		agentId: clientRelationship.agentId ?? agentId,
		clientId: clientRelationship.clientId ?? clientId,
		status: clientRelationship.status ?? status,
		firstContact: clientRelationship.firstContact ?? firstContact,
		lastContact: clientRelationship.lastContact ?? lastContact,
		contactFrequency: clientRelationship.contactFrequency ?? contactFrequency,
		preferredChannel: clientRelationship.preferredChannel ?? preferredChannel,
		agent: clientRelationship.agent ?? agent,
		client: clientRelationship.client ?? client
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ClientRelationship mergeWithInstanceValues(ClientRelationship clientRelationship) {
        return ClientRelationship(
            id: clientRelationship.$assignedFields.contains('id') ? clientRelationship.id : id,
		agentId: clientRelationship.$assignedFields.contains('agentId') ? clientRelationship.agentId : agentId,
		clientId: clientRelationship.$assignedFields.contains('clientId') ? clientRelationship.clientId : clientId,
		status: clientRelationship.$assignedFields.contains('status') ? clientRelationship.status : status,
		firstContact: clientRelationship.$assignedFields.contains('firstContact') ? clientRelationship.firstContact : firstContact,
		lastContact: clientRelationship.$assignedFields.contains('lastContact') ? clientRelationship.lastContact : lastContact,
		contactFrequency: clientRelationship.$assignedFields.contains('contactFrequency') ? clientRelationship.contactFrequency : contactFrequency,
		preferredChannel: clientRelationship.$assignedFields.contains('preferredChannel') ? clientRelationship.preferredChannel : preferredChannel,
		agent: clientRelationship.$assignedFields.contains('agent') ? clientRelationship.agent : agent,
		client: clientRelationship.$assignedFields.contains('client') ? clientRelationship.client : client
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ClientRelationship updateWithInstanceValues(ClientRelationship clientRelationship) {
        if (clientRelationship.$assignedFields.contains('id')) { id = clientRelationship.id; }
		if (clientRelationship.$assignedFields.contains('agentId')) { agentId = clientRelationship.agentId; }
		if (clientRelationship.$assignedFields.contains('clientId')) { clientId = clientRelationship.clientId; }
		if (clientRelationship.$assignedFields.contains('status')) { status = clientRelationship.status; }
		if (clientRelationship.$assignedFields.contains('firstContact')) { firstContact = clientRelationship.firstContact; }
		if (clientRelationship.$assignedFields.contains('lastContact')) { lastContact = clientRelationship.lastContact; }
		if (clientRelationship.$assignedFields.contains('contactFrequency')) { contactFrequency = clientRelationship.contactFrequency; }
		if (clientRelationship.$assignedFields.contains('preferredChannel')) { preferredChannel = clientRelationship.preferredChannel; }
		if (clientRelationship.$assignedFields.contains('agent')) { agent = clientRelationship.agent; }
		if (clientRelationship.$assignedFields.contains('client')) { client = clientRelationship.client; }
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
          ? {...?serializedTypes, 'ClientRelationship'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(agentId != null) 'agentId': agentId,
	if(clientId != null) 'clientId': clientId,
	if(status != null) 'status': status?.toJson(),
	if(firstContact != null) 'firstContact': firstContact?.toIso8601String(),
	if(lastContact != null) 'lastContact': lastContact?.toIso8601String(),
	if(contactFrequency != null) 'contactFrequency': contactFrequency,
	if(preferredChannel != null) 'preferredChannel': preferredChannel?.toJson(),
	if(agent != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'agent': agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(client != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'client': client?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ClientRelationship &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    