
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'message_participant_type.dart';
import 'signature_status.dart';
import 'contact.dart';
import 'organization.dart';
import 'signature_request.dart';
import 'user.dart';


class SignatureSigner implements PrismaModel<String, SignatureSigner> , Id<String> {
    @override
String? id;
	String? orgId;
	String? signatureRequestId;
	MessageParticipantType? participantType;
	String? userId;
	String? contactId;
	String? fullName;
	String? email;
	SignatureStatus? status;
	DateTime? signedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? contact;
	Organization? org;
	SignatureRequest? request;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    SignatureSigner({ this.id,
	 this.orgId,
	 this.signatureRequestId,
	 this.participantType,
	 this.userId,
	 this.contactId,
	 this.fullName,
	 this.email,
	 this.status = SignatureStatus.PENDING,
	 this.signedAt,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contact,
	 this.org,
	 this.request,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<SignatureSigner, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"signatureRequestId": (m) => m.signatureRequestId,

	"participantType": (m) => m.participantType,

	"userId": (m) => m.userId,

	"contactId": (m) => m.contactId,

	"fullName": (m) => m.fullName,

	"email": (m) => m.email,

	"status": (m) => m.status,

	"signedAt": (m) => m.signedAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contact": (m) => m.contact,

	"org": (m) => m.org,

	"request": (m) => m.request,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(SignatureSigner) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in SignatureSigner');
    }
    return propFunction as V? Function(SignatureSigner);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory SignatureSigner.fromJson(JsonMap json) =>
      SignatureSigner(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	signatureRequestId: json['signatureRequestId'] as String?,
	participantType: json['participantType'] != null ? MessageParticipantType.fromJson(json['participantType']) : null,
	userId: json['userId'] as String?,
	contactId: json['contactId'] as String?,
	fullName: json['fullName'] as String?,
	email: json['email'] as String?,
	status: json['status'] != null ? SignatureStatus.fromJson(json['status']) : null,
	signedAt: json['signedAt'] != null ? DateTime.parse(json['signedAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	request: json['request'] != null ? SignatureRequest.fromJson(json['request'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    SignatureSigner copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? signatureRequestId,
		Value<MessageParticipantType?>? participantType,
		Value<String?>? userId,
		Value<String?>? contactId,
		Value<String?>? fullName,
		Value<String?>? email,
		Value<SignatureStatus?>? status,
		Value<DateTime?>? signedAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? contact,
		Value<Organization?>? org,
		Value<SignatureRequest?>? request,
		Value<User?>? user,
        }) {
        return SignatureSigner(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		signatureRequestId: signatureRequestId != null ? signatureRequestId.value : this.signatureRequestId,
		participantType: participantType != null ? participantType.value : this.participantType,
		userId: userId != null ? userId.value : this.userId,
		contactId: contactId != null ? contactId.value : this.contactId,
		fullName: fullName != null ? fullName.value : this.fullName,
		email: email != null ? email.value : this.email,
		status: status != null ? status.value : this.status,
		signedAt: signedAt != null ? signedAt.value : this.signedAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contact: contact != null ? contact.value : this.contact,
		org: org != null ? org.value : this.org,
		request: request != null ? request.value : this.request,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    SignatureSigner copyWithInstanceValues(SignatureSigner signatureSigner) {
        return SignatureSigner(
            id: signatureSigner.id ?? id,
		orgId: signatureSigner.orgId ?? orgId,
		signatureRequestId: signatureSigner.signatureRequestId ?? signatureRequestId,
		participantType: signatureSigner.participantType ?? participantType,
		userId: signatureSigner.userId ?? userId,
		contactId: signatureSigner.contactId ?? contactId,
		fullName: signatureSigner.fullName ?? fullName,
		email: signatureSigner.email ?? email,
		status: signatureSigner.status ?? status,
		signedAt: signatureSigner.signedAt ?? signedAt,
		createdAt: signatureSigner.createdAt ?? createdAt,
		updatedAt: signatureSigner.updatedAt ?? updatedAt,
		deletedAt: signatureSigner.deletedAt ?? deletedAt,
		contact: signatureSigner.contact ?? contact,
		org: signatureSigner.org ?? org,
		request: signatureSigner.request ?? request,
		user: signatureSigner.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    SignatureSigner mergeWithInstanceValues(SignatureSigner signatureSigner) {
        return SignatureSigner(
            id: signatureSigner.$assignedFields.contains('id') ? signatureSigner.id : id,
		orgId: signatureSigner.$assignedFields.contains('orgId') ? signatureSigner.orgId : orgId,
		signatureRequestId: signatureSigner.$assignedFields.contains('signatureRequestId') ? signatureSigner.signatureRequestId : signatureRequestId,
		participantType: signatureSigner.$assignedFields.contains('participantType') ? signatureSigner.participantType : participantType,
		userId: signatureSigner.$assignedFields.contains('userId') ? signatureSigner.userId : userId,
		contactId: signatureSigner.$assignedFields.contains('contactId') ? signatureSigner.contactId : contactId,
		fullName: signatureSigner.$assignedFields.contains('fullName') ? signatureSigner.fullName : fullName,
		email: signatureSigner.$assignedFields.contains('email') ? signatureSigner.email : email,
		status: signatureSigner.$assignedFields.contains('status') ? signatureSigner.status : status,
		signedAt: signatureSigner.$assignedFields.contains('signedAt') ? signatureSigner.signedAt : signedAt,
		createdAt: signatureSigner.$assignedFields.contains('createdAt') ? signatureSigner.createdAt : createdAt,
		updatedAt: signatureSigner.$assignedFields.contains('updatedAt') ? signatureSigner.updatedAt : updatedAt,
		deletedAt: signatureSigner.$assignedFields.contains('deletedAt') ? signatureSigner.deletedAt : deletedAt,
		contact: signatureSigner.$assignedFields.contains('contact') ? signatureSigner.contact : contact,
		org: signatureSigner.$assignedFields.contains('org') ? signatureSigner.org : org,
		request: signatureSigner.$assignedFields.contains('request') ? signatureSigner.request : request,
		user: signatureSigner.$assignedFields.contains('user') ? signatureSigner.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    SignatureSigner updateWithInstanceValues(SignatureSigner signatureSigner) {
        if (signatureSigner.$assignedFields.contains('id')) { id = signatureSigner.id; }
		if (signatureSigner.$assignedFields.contains('orgId')) { orgId = signatureSigner.orgId; }
		if (signatureSigner.$assignedFields.contains('signatureRequestId')) { signatureRequestId = signatureSigner.signatureRequestId; }
		if (signatureSigner.$assignedFields.contains('participantType')) { participantType = signatureSigner.participantType; }
		if (signatureSigner.$assignedFields.contains('userId')) { userId = signatureSigner.userId; }
		if (signatureSigner.$assignedFields.contains('contactId')) { contactId = signatureSigner.contactId; }
		if (signatureSigner.$assignedFields.contains('fullName')) { fullName = signatureSigner.fullName; }
		if (signatureSigner.$assignedFields.contains('email')) { email = signatureSigner.email; }
		if (signatureSigner.$assignedFields.contains('status')) { status = signatureSigner.status; }
		if (signatureSigner.$assignedFields.contains('signedAt')) { signedAt = signatureSigner.signedAt; }
		if (signatureSigner.$assignedFields.contains('createdAt')) { createdAt = signatureSigner.createdAt; }
		if (signatureSigner.$assignedFields.contains('updatedAt')) { updatedAt = signatureSigner.updatedAt; }
		if (signatureSigner.$assignedFields.contains('deletedAt')) { deletedAt = signatureSigner.deletedAt; }
		if (signatureSigner.$assignedFields.contains('contact')) { contact = signatureSigner.contact; }
		if (signatureSigner.$assignedFields.contains('org')) { org = signatureSigner.org; }
		if (signatureSigner.$assignedFields.contains('request')) { request = signatureSigner.request; }
		if (signatureSigner.$assignedFields.contains('user')) { user = signatureSigner.user; }
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
          ? {...?serializedTypes, 'SignatureSigner'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(signatureRequestId != null) 'signatureRequestId': signatureRequestId,
	if(participantType != null) 'participantType': participantType?.toJson(),
	if(userId != null) 'userId': userId,
	if(contactId != null) 'contactId': contactId,
	if(fullName != null) 'fullName': fullName,
	if(email != null) 'email': email,
	if(status != null) 'status': status?.toJson(),
	if(signedAt != null) 'signedAt': signedAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(request != null && (!preventCircularSerialization || !serializedModels.contains('SignatureRequest'))) 'request': request?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is SignatureSigner &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    