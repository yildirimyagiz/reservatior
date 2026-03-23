
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'analytics_type.dart';
import 'agency.dart';
import 'agent.dart';
import 'property.dart';
import 'reservation.dart';
import 'task.dart';
import 'tax_record.dart';
import 'user.dart';


class Analytics implements PrismaModel<String, Analytics> , Id<String> {
    @override
String? id;
	String? entityId;
	String? entityType;
	AnalyticsType? type;
	dynamic data;
	DateTime? timestamp;
	DateTime? deletedAt;
	String? propertyId;
	String? userId;
	String? agentId;
	String? agencyId;
	String? reservationId;
	String? taskId;
	String? taxRecordId;
	Agency? Agency;
	Agent? Agent;
	Property? Property;
	Reservation? Reservation;
	Task? Task;
	TaxRecord? TaxRecord;
	User? User;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Analytics({ this.id,
	 this.entityId,
	 this.entityType,
	 this.type,
	required this.data,
	 this.timestamp,
	 this.deletedAt,
	 this.propertyId,
	 this.userId,
	 this.agentId,
	 this.agencyId,
	 this.reservationId,
	 this.taskId,
	 this.taxRecordId,
	 this.Agency,
	 this.Agent,
	 this.Property,
	 this.Reservation,
	 this.Task,
	 this.TaxRecord,
	 this.User,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Analytics, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"entityId": (m) => m.entityId,

	"entityType": (m) => m.entityType,

	"type": (m) => m.type,

	"data": (m) => m.data,

	"timestamp": (m) => m.timestamp,

	"deletedAt": (m) => m.deletedAt,

	"propertyId": (m) => m.propertyId,

	"userId": (m) => m.userId,

	"agentId": (m) => m.agentId,

	"agencyId": (m) => m.agencyId,

	"reservationId": (m) => m.reservationId,

	"taskId": (m) => m.taskId,

	"taxRecordId": (m) => m.taxRecordId,

	"Agency": (m) => m.Agency,

	"Agent": (m) => m.Agent,

	"Property": (m) => m.Property,

	"Reservation": (m) => m.Reservation,

	"Task": (m) => m.Task,

	"TaxRecord": (m) => m.TaxRecord,

	"User": (m) => m.User,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Analytics) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Analytics');
    }
    return propFunction as V? Function(Analytics);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Analytics.fromJson(JsonMap json) =>
      Analytics(
        id: json['id'] as String?,
	entityId: json['entityId'] as String?,
	entityType: json['entityType'] as String?,
	type: json['type'] != null ? AnalyticsType.fromJson(json['type']) : null,
	data: json['data'] as dynamic,
	timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	propertyId: json['propertyId'] as String?,
	userId: json['userId'] as String?,
	agentId: json['agentId'] as String?,
	agencyId: json['agencyId'] as String?,
	reservationId: json['reservationId'] as String?,
	taskId: json['taskId'] as String?,
	taxRecordId: json['taxRecordId'] as String?,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Reservation: json['Reservation'] != null ? Reservation.fromJson(json['Reservation'] as JsonMap) : null,
	Task: json['Task'] != null ? Task.fromJson(json['Task'] as JsonMap) : null,
	TaxRecord: json['TaxRecord'] != null ? TaxRecord.fromJson(json['TaxRecord'] as JsonMap) : null,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Analytics copyWith({
        Value<String?>? id,
		Value<String?>? entityId,
		Value<String?>? entityType,
		Value<AnalyticsType?>? type,
		Value<dynamic>? data,
		Value<DateTime?>? timestamp,
		Value<DateTime?>? deletedAt,
		Value<String?>? propertyId,
		Value<String?>? userId,
		Value<String?>? agentId,
		Value<String?>? agencyId,
		Value<String?>? reservationId,
		Value<String?>? taskId,
		Value<String?>? taxRecordId,
		Value<Agency?>? Agency,
		Value<Agent?>? Agent,
		Value<Property?>? Property,
		Value<Reservation?>? Reservation,
		Value<Task?>? Task,
		Value<TaxRecord?>? TaxRecord,
		Value<User?>? User,
        }) {
        return Analytics(
            id: id != null ? id.value : this.id,
		entityId: entityId != null ? entityId.value : this.entityId,
		entityType: entityType != null ? entityType.value : this.entityType,
		type: type != null ? type.value : this.type,
		data: data != null ? data.value : this.data,
		timestamp: timestamp != null ? timestamp.value : this.timestamp,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		userId: userId != null ? userId.value : this.userId,
		agentId: agentId != null ? agentId.value : this.agentId,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		taskId: taskId != null ? taskId.value : this.taskId,
		taxRecordId: taxRecordId != null ? taxRecordId.value : this.taxRecordId,
		Agency: Agency != null ? Agency.value : this.Agency,
		Agent: Agent != null ? Agent.value : this.Agent,
		Property: Property != null ? Property.value : this.Property,
		Reservation: Reservation != null ? Reservation.value : this.Reservation,
		Task: Task != null ? Task.value : this.Task,
		TaxRecord: TaxRecord != null ? TaxRecord.value : this.TaxRecord,
		User: User != null ? User.value : this.User
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Analytics copyWithInstanceValues(Analytics analytics) {
        return Analytics(
            id: analytics.id ?? id,
		entityId: analytics.entityId ?? entityId,
		entityType: analytics.entityType ?? entityType,
		type: analytics.type ?? type,
		data: analytics.data ?? data,
		timestamp: analytics.timestamp ?? timestamp,
		deletedAt: analytics.deletedAt ?? deletedAt,
		propertyId: analytics.propertyId ?? propertyId,
		userId: analytics.userId ?? userId,
		agentId: analytics.agentId ?? agentId,
		agencyId: analytics.agencyId ?? agencyId,
		reservationId: analytics.reservationId ?? reservationId,
		taskId: analytics.taskId ?? taskId,
		taxRecordId: analytics.taxRecordId ?? taxRecordId,
		Agency: analytics.Agency ?? Agency,
		Agent: analytics.Agent ?? Agent,
		Property: analytics.Property ?? Property,
		Reservation: analytics.Reservation ?? Reservation,
		Task: analytics.Task ?? Task,
		TaxRecord: analytics.TaxRecord ?? TaxRecord,
		User: analytics.User ?? User
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Analytics mergeWithInstanceValues(Analytics analytics) {
        return Analytics(
            id: analytics.$assignedFields.contains('id') ? analytics.id : id,
		entityId: analytics.$assignedFields.contains('entityId') ? analytics.entityId : entityId,
		entityType: analytics.$assignedFields.contains('entityType') ? analytics.entityType : entityType,
		type: analytics.$assignedFields.contains('type') ? analytics.type : type,
		data: analytics.$assignedFields.contains('data') ? analytics.data : data,
		timestamp: analytics.$assignedFields.contains('timestamp') ? analytics.timestamp : timestamp,
		deletedAt: analytics.$assignedFields.contains('deletedAt') ? analytics.deletedAt : deletedAt,
		propertyId: analytics.$assignedFields.contains('propertyId') ? analytics.propertyId : propertyId,
		userId: analytics.$assignedFields.contains('userId') ? analytics.userId : userId,
		agentId: analytics.$assignedFields.contains('agentId') ? analytics.agentId : agentId,
		agencyId: analytics.$assignedFields.contains('agencyId') ? analytics.agencyId : agencyId,
		reservationId: analytics.$assignedFields.contains('reservationId') ? analytics.reservationId : reservationId,
		taskId: analytics.$assignedFields.contains('taskId') ? analytics.taskId : taskId,
		taxRecordId: analytics.$assignedFields.contains('taxRecordId') ? analytics.taxRecordId : taxRecordId,
		Agency: analytics.$assignedFields.contains('Agency') ? analytics.Agency : Agency,
		Agent: analytics.$assignedFields.contains('Agent') ? analytics.Agent : Agent,
		Property: analytics.$assignedFields.contains('Property') ? analytics.Property : Property,
		Reservation: analytics.$assignedFields.contains('Reservation') ? analytics.Reservation : Reservation,
		Task: analytics.$assignedFields.contains('Task') ? analytics.Task : Task,
		TaxRecord: analytics.$assignedFields.contains('TaxRecord') ? analytics.TaxRecord : TaxRecord,
		User: analytics.$assignedFields.contains('User') ? analytics.User : User
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Analytics updateWithInstanceValues(Analytics analytics) {
        if (analytics.$assignedFields.contains('id')) { id = analytics.id; }
		if (analytics.$assignedFields.contains('entityId')) { entityId = analytics.entityId; }
		if (analytics.$assignedFields.contains('entityType')) { entityType = analytics.entityType; }
		if (analytics.$assignedFields.contains('type')) { type = analytics.type; }
		if (analytics.$assignedFields.contains('data')) { data = analytics.data; }
		if (analytics.$assignedFields.contains('timestamp')) { timestamp = analytics.timestamp; }
		if (analytics.$assignedFields.contains('deletedAt')) { deletedAt = analytics.deletedAt; }
		if (analytics.$assignedFields.contains('propertyId')) { propertyId = analytics.propertyId; }
		if (analytics.$assignedFields.contains('userId')) { userId = analytics.userId; }
		if (analytics.$assignedFields.contains('agentId')) { agentId = analytics.agentId; }
		if (analytics.$assignedFields.contains('agencyId')) { agencyId = analytics.agencyId; }
		if (analytics.$assignedFields.contains('reservationId')) { reservationId = analytics.reservationId; }
		if (analytics.$assignedFields.contains('taskId')) { taskId = analytics.taskId; }
		if (analytics.$assignedFields.contains('taxRecordId')) { taxRecordId = analytics.taxRecordId; }
		if (analytics.$assignedFields.contains('Agency')) { Agency = analytics.Agency; }
		if (analytics.$assignedFields.contains('Agent')) { Agent = analytics.Agent; }
		if (analytics.$assignedFields.contains('Property')) { Property = analytics.Property; }
		if (analytics.$assignedFields.contains('Reservation')) { Reservation = analytics.Reservation; }
		if (analytics.$assignedFields.contains('Task')) { Task = analytics.Task; }
		if (analytics.$assignedFields.contains('TaxRecord')) { TaxRecord = analytics.TaxRecord; }
		if (analytics.$assignedFields.contains('User')) { User = analytics.User; }
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
          ? {...?serializedTypes, 'Analytics'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(entityId != null) 'entityId': entityId,
	if(entityType != null) 'entityType': entityType,
	if(type != null) 'type': type?.toJson(),
	if(data != null) 'data': data,
	if(timestamp != null) 'timestamp': timestamp?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(propertyId != null) 'propertyId': propertyId,
	if(userId != null) 'userId': userId,
	if(agentId != null) 'agentId': agentId,
	if(agencyId != null) 'agencyId': agencyId,
	if(reservationId != null) 'reservationId': reservationId,
	if(taskId != null) 'taskId': taskId,
	if(taxRecordId != null) 'taxRecordId': taxRecordId,
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Agent != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'Agent': Agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Task != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'Task': Task?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(TaxRecord != null && (!preventCircularSerialization || !serializedModels.contains('TaxRecord'))) 'TaxRecord': TaxRecord?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Analytics &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    