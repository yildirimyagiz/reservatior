
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'notification_status.dart';
import 'organization.dart';
import 'user.dart';
import 'agent.dart';
import 'agency.dart';
import 'tenant.dart';


class Notification implements PrismaModel<String, Notification> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? title;
	String? body;
	dynamic data;
	NotificationStatus? status;
	DateTime? sentAt;
	DateTime? readAt;
	dynamic userPreferences;
	dynamic deliveries;
	String? ruleKey;
	dynamic ruleConfig;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	User? user;
	List<Agent>? agents;
	List<Agency>? agencies;
	List<Tenant>? tenants;
	int? $agentsCount;
	int? $agenciesCount;
	int? $tenantsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Notification({ this.id,
	 this.orgId,
	 this.userId,
	 this.title,
	 this.body,
	required this.data,
	 this.status = NotificationStatus.QUEUED,
	 this.sentAt,
	 this.readAt,
	required this.userPreferences,
	required this.deliveries,
	 this.ruleKey,
	required this.ruleConfig,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.user,
	 this.agents,
	 this.agencies,
	 this.tenants,
	this.$agentsCount,
	this.$agenciesCount,
	this.$tenantsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Notification, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"title": (m) => m.title,

	"body": (m) => m.body,

	"data": (m) => m.data,

	"status": (m) => m.status,

	"sentAt": (m) => m.sentAt,

	"readAt": (m) => m.readAt,

	"userPreferences": (m) => m.userPreferences,

	"deliveries": (m) => m.deliveries,

	"ruleKey": (m) => m.ruleKey,

	"ruleConfig": (m) => m.ruleConfig,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,

	"agents": (m) => m.agents,

	"agencies": (m) => m.agencies,

	"tenants": (m) => m.tenants,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Notification) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Notification');
    }
    return propFunction as V? Function(Notification);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Notification.fromJson(JsonMap json) =>
      Notification(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	title: json['title'] as String?,
	body: json['body'] as String?,
	data: json['data'] as dynamic,
	status: json['status'] != null ? NotificationStatus.fromJson(json['status']) : null,
	sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt']) : null,
	readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
	userPreferences: json['userPreferences'] as dynamic,
	deliveries: json['deliveries'] as dynamic,
	ruleKey: json['ruleKey'] as String?,
	ruleConfig: json['ruleConfig'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	agents: json['agents'] != null ? createModels<Agent>((json['agents'] as List).cast<JsonMap>(), Agent.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	tenants: json['tenants'] != null ? createModels<Tenant>((json['tenants'] as List).cast<JsonMap>(), Tenant.fromJson) : null,
	$agentsCount: json['_count']?['agents'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$tenantsCount: json['_count']?['tenants'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Notification copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? title,
		Value<String?>? body,
		Value<dynamic>? data,
		Value<NotificationStatus?>? status,
		Value<DateTime?>? sentAt,
		Value<DateTime?>? readAt,
		Value<dynamic>? userPreferences,
		Value<dynamic>? deliveries,
		Value<String?>? ruleKey,
		Value<dynamic>? ruleConfig,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<User?>? user,
		Value<List<Agent>?>? agents,
		Value<List<Agency>?>? agencies,
		Value<List<Tenant>?>? tenants,
		int? $agentsCount,
		int? $agenciesCount,
		int? $tenantsCount,
        }) {
        return Notification(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		title: title != null ? title.value : this.title,
		body: body != null ? body.value : this.body,
		data: data != null ? data.value : this.data,
		status: status != null ? status.value : this.status,
		sentAt: sentAt != null ? sentAt.value : this.sentAt,
		readAt: readAt != null ? readAt.value : this.readAt,
		userPreferences: userPreferences != null ? userPreferences.value : this.userPreferences,
		deliveries: deliveries != null ? deliveries.value : this.deliveries,
		ruleKey: ruleKey != null ? ruleKey.value : this.ruleKey,
		ruleConfig: ruleConfig != null ? ruleConfig.value : this.ruleConfig,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user,
		agents: agents != null ? agents.value : this.agents,
		agencies: agencies != null ? agencies.value : this.agencies,
		tenants: tenants != null ? tenants.value : this.tenants,
		$agentsCount: $agentsCount ?? this.$agentsCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$tenantsCount: $tenantsCount ?? this.$tenantsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Notification copyWithInstanceValues(Notification notification) {
        return Notification(
            id: notification.id ?? id,
		orgId: notification.orgId ?? orgId,
		userId: notification.userId ?? userId,
		title: notification.title ?? title,
		body: notification.body ?? body,
		data: notification.data ?? data,
		status: notification.status ?? status,
		sentAt: notification.sentAt ?? sentAt,
		readAt: notification.readAt ?? readAt,
		userPreferences: notification.userPreferences ?? userPreferences,
		deliveries: notification.deliveries ?? deliveries,
		ruleKey: notification.ruleKey ?? ruleKey,
		ruleConfig: notification.ruleConfig ?? ruleConfig,
		createdAt: notification.createdAt ?? createdAt,
		updatedAt: notification.updatedAt ?? updatedAt,
		deletedAt: notification.deletedAt ?? deletedAt,
		org: notification.org ?? org,
		user: notification.user ?? user,
		agents: notification.agents ?? agents,
		agencies: notification.agencies ?? agencies,
		tenants: notification.tenants ?? tenants,
		$agentsCount: notification.$agentsCount ?? $agentsCount,
		$agenciesCount: notification.$agenciesCount ?? $agenciesCount,
		$tenantsCount: notification.$tenantsCount ?? $tenantsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Notification mergeWithInstanceValues(Notification notification) {
        return Notification(
            id: notification.$assignedFields.contains('id') ? notification.id : id,
		orgId: notification.$assignedFields.contains('orgId') ? notification.orgId : orgId,
		userId: notification.$assignedFields.contains('userId') ? notification.userId : userId,
		title: notification.$assignedFields.contains('title') ? notification.title : title,
		body: notification.$assignedFields.contains('body') ? notification.body : body,
		data: notification.$assignedFields.contains('data') ? notification.data : data,
		status: notification.$assignedFields.contains('status') ? notification.status : status,
		sentAt: notification.$assignedFields.contains('sentAt') ? notification.sentAt : sentAt,
		readAt: notification.$assignedFields.contains('readAt') ? notification.readAt : readAt,
		userPreferences: notification.$assignedFields.contains('userPreferences') ? notification.userPreferences : userPreferences,
		deliveries: notification.$assignedFields.contains('deliveries') ? notification.deliveries : deliveries,
		ruleKey: notification.$assignedFields.contains('ruleKey') ? notification.ruleKey : ruleKey,
		ruleConfig: notification.$assignedFields.contains('ruleConfig') ? notification.ruleConfig : ruleConfig,
		createdAt: notification.$assignedFields.contains('createdAt') ? notification.createdAt : createdAt,
		updatedAt: notification.$assignedFields.contains('updatedAt') ? notification.updatedAt : updatedAt,
		deletedAt: notification.$assignedFields.contains('deletedAt') ? notification.deletedAt : deletedAt,
		org: notification.$assignedFields.contains('org') ? notification.org : org,
		user: notification.$assignedFields.contains('user') ? notification.user : user,
		agents: (notification.$assignedFields.contains('agents') && notification.agents != null) ? mergeModelLists(agents, notification.agents) : agents,
		agencies: (notification.$assignedFields.contains('agencies') && notification.agencies != null) ? mergeModelLists(agencies, notification.agencies) : agencies,
		tenants: (notification.$assignedFields.contains('tenants') && notification.tenants != null) ? mergeModelLists(tenants, notification.tenants) : tenants,
		$agentsCount: notification.$agentsCount ?? $agentsCount,
		$agenciesCount: notification.$agenciesCount ?? $agenciesCount,
		$tenantsCount: notification.$tenantsCount ?? $tenantsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Notification updateWithInstanceValues(Notification notification) {
        if (notification.$assignedFields.contains('id')) { id = notification.id; }
		if (notification.$assignedFields.contains('orgId')) { orgId = notification.orgId; }
		if (notification.$assignedFields.contains('userId')) { userId = notification.userId; }
		if (notification.$assignedFields.contains('title')) { title = notification.title; }
		if (notification.$assignedFields.contains('body')) { body = notification.body; }
		if (notification.$assignedFields.contains('data')) { data = notification.data; }
		if (notification.$assignedFields.contains('status')) { status = notification.status; }
		if (notification.$assignedFields.contains('sentAt')) { sentAt = notification.sentAt; }
		if (notification.$assignedFields.contains('readAt')) { readAt = notification.readAt; }
		if (notification.$assignedFields.contains('userPreferences')) { userPreferences = notification.userPreferences; }
		if (notification.$assignedFields.contains('deliveries')) { deliveries = notification.deliveries; }
		if (notification.$assignedFields.contains('ruleKey')) { ruleKey = notification.ruleKey; }
		if (notification.$assignedFields.contains('ruleConfig')) { ruleConfig = notification.ruleConfig; }
		if (notification.$assignedFields.contains('createdAt')) { createdAt = notification.createdAt; }
		if (notification.$assignedFields.contains('updatedAt')) { updatedAt = notification.updatedAt; }
		if (notification.$assignedFields.contains('deletedAt')) { deletedAt = notification.deletedAt; }
		if (notification.$assignedFields.contains('org')) { org = notification.org; }
		if (notification.$assignedFields.contains('user')) { user = notification.user; }
		if (notification.$assignedFields.contains('agents') && notification.agents != null) { agents = mergeModelLists(agents, notification.agents); }
		if (notification.$assignedFields.contains('agencies') && notification.agencies != null) { agencies = mergeModelLists(agencies, notification.agencies); }
		if (notification.$assignedFields.contains('tenants') && notification.tenants != null) { tenants = mergeModelLists(tenants, notification.tenants); }
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
          ? {...?serializedTypes, 'Notification'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(title != null) 'title': title,
	if(body != null) 'body': body,
	if(data != null) 'data': data,
	if(status != null) 'status': status?.toJson(),
	if(sentAt != null) 'sentAt': sentAt?.toIso8601String(),
	if(readAt != null) 'readAt': readAt?.toIso8601String(),
	if(userPreferences != null) 'userPreferences': userPreferences,
	if(deliveries != null) 'deliveries': deliveries,
	if(ruleKey != null) 'ruleKey': ruleKey,
	if(ruleConfig != null) 'ruleConfig': ruleConfig,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(agents != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'agents': agents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tenants != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'tenants': tenants?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($agentsCount != null || $agenciesCount != null || $tenantsCount != null) '_count': { 
		if ($agentsCount != null) 'agents': $agentsCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($tenantsCount != null) 'tenants': $tenantsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Notification &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    