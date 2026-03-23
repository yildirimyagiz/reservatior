
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'facility_amenities.dart';
import 'location_amenities.dart';
import 'agency.dart';
import 'expense.dart';
import 'facility.dart';
import 'included_service.dart';
import 'payment.dart';
import 'property.dart';
import 'report.dart';
import 'task.dart';
import 'user.dart';
import 'reservation.dart';


class ExtraCharge implements PrismaModel<String, ExtraCharge> , Id<String> {
    @override
String? id;
	String? reservationId;
	String? name;
	String? description;
	double? amount;
	String? chargeType;
	bool? isPaid;
	String? icon;
	String? logo;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<FacilityAmenities>? facilityAmenities;
	List<LocationAmenities>? locationAmenities;
	String? facilityId;
	String? includedServiceId;
	List<Agency>? agencies;
	List<Expense>? expenses;
	Facility? Facility;
	IncludedService? IncludedService;
	List<Payment>? Payment;
	List<Property>? properties;
	List<Report>? reports;
	List<Task>? tasks;
	List<User>? users;
	Reservation? Reservation;
	int? $facilityAmenitiesCount;
	int? $locationAmenitiesCount;
	int? $agenciesCount;
	int? $expensesCount;
	int? $PaymentCount;
	int? $propertiesCount;
	int? $reportsCount;
	int? $tasksCount;
	int? $usersCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ExtraCharge({ this.id,
	 this.reservationId,
	 this.name,
	 this.description,
	 this.amount,
	 this.chargeType = "other",
	 this.isPaid = false,
	 this.icon,
	 this.logo,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.facilityAmenities,
	 this.locationAmenities,
	 this.facilityId,
	 this.includedServiceId,
	 this.agencies,
	 this.expenses,
	 this.Facility,
	 this.IncludedService,
	 this.Payment,
	 this.properties,
	 this.reports,
	 this.tasks,
	 this.users,
	 this.Reservation,
	this.$facilityAmenitiesCount,
	this.$locationAmenitiesCount,
	this.$agenciesCount,
	this.$expensesCount,
	this.$PaymentCount,
	this.$propertiesCount,
	this.$reportsCount,
	this.$tasksCount,
	this.$usersCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ExtraCharge, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"reservationId": (m) => m.reservationId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"amount": (m) => m.amount,

	"chargeType": (m) => m.chargeType,

	"isPaid": (m) => m.isPaid,

	"icon": (m) => m.icon,

	"logo": (m) => m.logo,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"facilityAmenities": (m) => m.facilityAmenities,

	"locationAmenities": (m) => m.locationAmenities,

	"facilityId": (m) => m.facilityId,

	"includedServiceId": (m) => m.includedServiceId,

	"agencies": (m) => m.agencies,

	"expenses": (m) => m.expenses,

	"Facility": (m) => m.Facility,

	"IncludedService": (m) => m.IncludedService,

	"Payment": (m) => m.Payment,

	"properties": (m) => m.properties,

	"reports": (m) => m.reports,

	"tasks": (m) => m.tasks,

	"users": (m) => m.users,

	"Reservation": (m) => m.Reservation,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ExtraCharge) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ExtraCharge');
    }
    return propFunction as V? Function(ExtraCharge);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ExtraCharge.fromJson(JsonMap json) =>
      ExtraCharge(
        id: json['id'] as String?,
	reservationId: json['reservationId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	amount: json['amount']?.toDouble(),
	chargeType: json['chargeType'] as String?,
	isPaid: json['isPaid'] as bool?,
	icon: json['icon'] as String?,
	logo: json['logo'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	facilityAmenities: json['facilityAmenities'] != null ? (json['facilityAmenities']).map((item) => FacilityAmenities.fromJson(item)).toList()) : null,
	locationAmenities: json['locationAmenities'] != null ? (json['locationAmenities']).map((item) => LocationAmenities.fromJson(item)).toList()) : null,
	facilityId: json['facilityId'] as String?,
	includedServiceId: json['includedServiceId'] as String?,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	expenses: json['expenses'] != null ? createModels<Expense>((json['expenses'] as List).cast<JsonMap>(), Expense.fromJson) : null,
	Facility: json['Facility'] != null ? Facility.fromJson(json['Facility'] as JsonMap) : null,
	IncludedService: json['IncludedService'] != null ? IncludedService.fromJson(json['IncludedService'] as JsonMap) : null,
	Payment: json['Payment'] != null ? createModels<Payment>((json['Payment'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	properties: json['properties'] != null ? createModels<Property>((json['properties'] as List).cast<JsonMap>(), Property.fromJson) : null,
	reports: json['reports'] != null ? createModels<Report>((json['reports'] as List).cast<JsonMap>(), Report.fromJson) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	users: json['users'] != null ? createModels<User>((json['users'] as List).cast<JsonMap>(), User.fromJson) : null,
	Reservation: json['Reservation'] != null ? Reservation.fromJson(json['Reservation'] as JsonMap) : null,
	$facilityAmenitiesCount: json['_count']?['facilityAmenities'] as int?,
	$locationAmenitiesCount: json['_count']?['locationAmenities'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$expensesCount: json['_count']?['expenses'] as int?,
	$PaymentCount: json['_count']?['Payment'] as int?,
	$propertiesCount: json['_count']?['properties'] as int?,
	$reportsCount: json['_count']?['reports'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
	$usersCount: json['_count']?['users'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ExtraCharge copyWith({
        Value<String?>? id,
		Value<String?>? reservationId,
		Value<String?>? name,
		Value<String?>? description,
		Value<double?>? amount,
		Value<String?>? chargeType,
		Value<bool?>? isPaid,
		Value<String?>? icon,
		Value<String?>? logo,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<FacilityAmenities>?>? facilityAmenities,
		Value<List<LocationAmenities>?>? locationAmenities,
		Value<String?>? facilityId,
		Value<String?>? includedServiceId,
		Value<List<Agency>?>? agencies,
		Value<List<Expense>?>? expenses,
		Value<Facility?>? Facility,
		Value<IncludedService?>? IncludedService,
		Value<List<Payment>?>? Payment,
		Value<List<Property>?>? properties,
		Value<List<Report>?>? reports,
		Value<List<Task>?>? tasks,
		Value<List<User>?>? users,
		Value<Reservation?>? Reservation,
		int? $facilityAmenitiesCount,
		int? $locationAmenitiesCount,
		int? $agenciesCount,
		int? $expensesCount,
		int? $PaymentCount,
		int? $propertiesCount,
		int? $reportsCount,
		int? $tasksCount,
		int? $usersCount,
        }) {
        return ExtraCharge(
            id: id != null ? id.value : this.id,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		amount: amount != null ? amount.value : this.amount,
		chargeType: chargeType != null ? chargeType.value : this.chargeType,
		isPaid: isPaid != null ? isPaid.value : this.isPaid,
		icon: icon != null ? icon.value : this.icon,
		logo: logo != null ? logo.value : this.logo,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		facilityAmenities: facilityAmenities != null ? facilityAmenities.value : this.facilityAmenities,
		locationAmenities: locationAmenities != null ? locationAmenities.value : this.locationAmenities,
		facilityId: facilityId != null ? facilityId.value : this.facilityId,
		includedServiceId: includedServiceId != null ? includedServiceId.value : this.includedServiceId,
		agencies: agencies != null ? agencies.value : this.agencies,
		expenses: expenses != null ? expenses.value : this.expenses,
		Facility: Facility != null ? Facility.value : this.Facility,
		IncludedService: IncludedService != null ? IncludedService.value : this.IncludedService,
		Payment: Payment != null ? Payment.value : this.Payment,
		properties: properties != null ? properties.value : this.properties,
		reports: reports != null ? reports.value : this.reports,
		tasks: tasks != null ? tasks.value : this.tasks,
		users: users != null ? users.value : this.users,
		Reservation: Reservation != null ? Reservation.value : this.Reservation,
		$facilityAmenitiesCount: $facilityAmenitiesCount ?? this.$facilityAmenitiesCount,
		$locationAmenitiesCount: $locationAmenitiesCount ?? this.$locationAmenitiesCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$expensesCount: $expensesCount ?? this.$expensesCount,
		$PaymentCount: $PaymentCount ?? this.$PaymentCount,
		$propertiesCount: $propertiesCount ?? this.$propertiesCount,
		$reportsCount: $reportsCount ?? this.$reportsCount,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$usersCount: $usersCount ?? this.$usersCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ExtraCharge copyWithInstanceValues(ExtraCharge extraCharge) {
        return ExtraCharge(
            id: extraCharge.id ?? id,
		reservationId: extraCharge.reservationId ?? reservationId,
		name: extraCharge.name ?? name,
		description: extraCharge.description ?? description,
		amount: extraCharge.amount ?? amount,
		chargeType: extraCharge.chargeType ?? chargeType,
		isPaid: extraCharge.isPaid ?? isPaid,
		icon: extraCharge.icon ?? icon,
		logo: extraCharge.logo ?? logo,
		createdAt: extraCharge.createdAt ?? createdAt,
		updatedAt: extraCharge.updatedAt ?? updatedAt,
		deletedAt: extraCharge.deletedAt ?? deletedAt,
		facilityAmenities: extraCharge.facilityAmenities ?? facilityAmenities,
		locationAmenities: extraCharge.locationAmenities ?? locationAmenities,
		facilityId: extraCharge.facilityId ?? facilityId,
		includedServiceId: extraCharge.includedServiceId ?? includedServiceId,
		agencies: extraCharge.agencies ?? agencies,
		expenses: extraCharge.expenses ?? expenses,
		Facility: extraCharge.Facility ?? Facility,
		IncludedService: extraCharge.IncludedService ?? IncludedService,
		Payment: extraCharge.Payment ?? Payment,
		properties: extraCharge.properties ?? properties,
		reports: extraCharge.reports ?? reports,
		tasks: extraCharge.tasks ?? tasks,
		users: extraCharge.users ?? users,
		Reservation: extraCharge.Reservation ?? Reservation,
		$facilityAmenitiesCount: extraCharge.$facilityAmenitiesCount ?? $facilityAmenitiesCount,
		$locationAmenitiesCount: extraCharge.$locationAmenitiesCount ?? $locationAmenitiesCount,
		$agenciesCount: extraCharge.$agenciesCount ?? $agenciesCount,
		$expensesCount: extraCharge.$expensesCount ?? $expensesCount,
		$PaymentCount: extraCharge.$PaymentCount ?? $PaymentCount,
		$propertiesCount: extraCharge.$propertiesCount ?? $propertiesCount,
		$reportsCount: extraCharge.$reportsCount ?? $reportsCount,
		$tasksCount: extraCharge.$tasksCount ?? $tasksCount,
		$usersCount: extraCharge.$usersCount ?? $usersCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ExtraCharge mergeWithInstanceValues(ExtraCharge extraCharge) {
        return ExtraCharge(
            id: extraCharge.$assignedFields.contains('id') ? extraCharge.id : id,
		reservationId: extraCharge.$assignedFields.contains('reservationId') ? extraCharge.reservationId : reservationId,
		name: extraCharge.$assignedFields.contains('name') ? extraCharge.name : name,
		description: extraCharge.$assignedFields.contains('description') ? extraCharge.description : description,
		amount: extraCharge.$assignedFields.contains('amount') ? extraCharge.amount : amount,
		chargeType: extraCharge.$assignedFields.contains('chargeType') ? extraCharge.chargeType : chargeType,
		isPaid: extraCharge.$assignedFields.contains('isPaid') ? extraCharge.isPaid : isPaid,
		icon: extraCharge.$assignedFields.contains('icon') ? extraCharge.icon : icon,
		logo: extraCharge.$assignedFields.contains('logo') ? extraCharge.logo : logo,
		createdAt: extraCharge.$assignedFields.contains('createdAt') ? extraCharge.createdAt : createdAt,
		updatedAt: extraCharge.$assignedFields.contains('updatedAt') ? extraCharge.updatedAt : updatedAt,
		deletedAt: extraCharge.$assignedFields.contains('deletedAt') ? extraCharge.deletedAt : deletedAt,
		facilityAmenities: extraCharge.$assignedFields.contains('facilityAmenities') ? extraCharge.facilityAmenities : facilityAmenities,
		locationAmenities: extraCharge.$assignedFields.contains('locationAmenities') ? extraCharge.locationAmenities : locationAmenities,
		facilityId: extraCharge.$assignedFields.contains('facilityId') ? extraCharge.facilityId : facilityId,
		includedServiceId: extraCharge.$assignedFields.contains('includedServiceId') ? extraCharge.includedServiceId : includedServiceId,
		agencies: (extraCharge.$assignedFields.contains('agencies') && extraCharge.agencies != null) ? mergeModelLists(agencies, extraCharge.agencies) : agencies,
		expenses: (extraCharge.$assignedFields.contains('expenses') && extraCharge.expenses != null) ? mergeModelLists(expenses, extraCharge.expenses) : expenses,
		Facility: extraCharge.$assignedFields.contains('Facility') ? extraCharge.Facility : Facility,
		IncludedService: extraCharge.$assignedFields.contains('IncludedService') ? extraCharge.IncludedService : IncludedService,
		Payment: (extraCharge.$assignedFields.contains('Payment') && extraCharge.Payment != null) ? mergeModelLists(Payment, extraCharge.Payment) : Payment,
		properties: (extraCharge.$assignedFields.contains('properties') && extraCharge.properties != null) ? mergeModelLists(properties, extraCharge.properties) : properties,
		reports: (extraCharge.$assignedFields.contains('reports') && extraCharge.reports != null) ? mergeModelLists(reports, extraCharge.reports) : reports,
		tasks: (extraCharge.$assignedFields.contains('tasks') && extraCharge.tasks != null) ? mergeModelLists(tasks, extraCharge.tasks) : tasks,
		users: (extraCharge.$assignedFields.contains('users') && extraCharge.users != null) ? mergeModelLists(users, extraCharge.users) : users,
		Reservation: extraCharge.$assignedFields.contains('Reservation') ? extraCharge.Reservation : Reservation,
		$facilityAmenitiesCount: extraCharge.$facilityAmenitiesCount ?? $facilityAmenitiesCount,
		$locationAmenitiesCount: extraCharge.$locationAmenitiesCount ?? $locationAmenitiesCount,
		$agenciesCount: extraCharge.$agenciesCount ?? $agenciesCount,
		$expensesCount: extraCharge.$expensesCount ?? $expensesCount,
		$PaymentCount: extraCharge.$PaymentCount ?? $PaymentCount,
		$propertiesCount: extraCharge.$propertiesCount ?? $propertiesCount,
		$reportsCount: extraCharge.$reportsCount ?? $reportsCount,
		$tasksCount: extraCharge.$tasksCount ?? $tasksCount,
		$usersCount: extraCharge.$usersCount ?? $usersCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ExtraCharge updateWithInstanceValues(ExtraCharge extraCharge) {
        if (extraCharge.$assignedFields.contains('id')) { id = extraCharge.id; }
		if (extraCharge.$assignedFields.contains('reservationId')) { reservationId = extraCharge.reservationId; }
		if (extraCharge.$assignedFields.contains('name')) { name = extraCharge.name; }
		if (extraCharge.$assignedFields.contains('description')) { description = extraCharge.description; }
		if (extraCharge.$assignedFields.contains('amount')) { amount = extraCharge.amount; }
		if (extraCharge.$assignedFields.contains('chargeType')) { chargeType = extraCharge.chargeType; }
		if (extraCharge.$assignedFields.contains('isPaid')) { isPaid = extraCharge.isPaid; }
		if (extraCharge.$assignedFields.contains('icon')) { icon = extraCharge.icon; }
		if (extraCharge.$assignedFields.contains('logo')) { logo = extraCharge.logo; }
		if (extraCharge.$assignedFields.contains('createdAt')) { createdAt = extraCharge.createdAt; }
		if (extraCharge.$assignedFields.contains('updatedAt')) { updatedAt = extraCharge.updatedAt; }
		if (extraCharge.$assignedFields.contains('deletedAt')) { deletedAt = extraCharge.deletedAt; }
		if (extraCharge.$assignedFields.contains('facilityAmenities')) { facilityAmenities = extraCharge.facilityAmenities; }
		if (extraCharge.$assignedFields.contains('locationAmenities')) { locationAmenities = extraCharge.locationAmenities; }
		if (extraCharge.$assignedFields.contains('facilityId')) { facilityId = extraCharge.facilityId; }
		if (extraCharge.$assignedFields.contains('includedServiceId')) { includedServiceId = extraCharge.includedServiceId; }
		if (extraCharge.$assignedFields.contains('agencies') && extraCharge.agencies != null) { agencies = mergeModelLists(agencies, extraCharge.agencies); }
		if (extraCharge.$assignedFields.contains('expenses') && extraCharge.expenses != null) { expenses = mergeModelLists(expenses, extraCharge.expenses); }
		if (extraCharge.$assignedFields.contains('Facility')) { Facility = extraCharge.Facility; }
		if (extraCharge.$assignedFields.contains('IncludedService')) { IncludedService = extraCharge.IncludedService; }
		if (extraCharge.$assignedFields.contains('Payment') && extraCharge.Payment != null) { Payment = mergeModelLists(Payment, extraCharge.Payment); }
		if (extraCharge.$assignedFields.contains('properties') && extraCharge.properties != null) { properties = mergeModelLists(properties, extraCharge.properties); }
		if (extraCharge.$assignedFields.contains('reports') && extraCharge.reports != null) { reports = mergeModelLists(reports, extraCharge.reports); }
		if (extraCharge.$assignedFields.contains('tasks') && extraCharge.tasks != null) { tasks = mergeModelLists(tasks, extraCharge.tasks); }
		if (extraCharge.$assignedFields.contains('users') && extraCharge.users != null) { users = mergeModelLists(users, extraCharge.users); }
		if (extraCharge.$assignedFields.contains('Reservation')) { Reservation = extraCharge.Reservation; }
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
          ? {...?serializedTypes, 'ExtraCharge'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(reservationId != null) 'reservationId': reservationId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(amount != null) 'amount': amount,
	if(chargeType != null) 'chargeType': chargeType,
	if(isPaid != null) 'isPaid': isPaid,
	if(icon != null) 'icon': icon,
	if(logo != null) 'logo': logo,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(facilityAmenities != null) 'facilityAmenities': facilityAmenities?.map((item) => item.toJson()).toList(),
	if(locationAmenities != null) 'locationAmenities': locationAmenities?.map((item) => item.toJson()).toList(),
	if(facilityId != null) 'facilityId': facilityId,
	if(includedServiceId != null) 'includedServiceId': includedServiceId,
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(expenses != null && (!preventCircularSerialization || !serializedModels.contains('Expense'))) 'expenses': expenses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Facility != null && (!preventCircularSerialization || !serializedModels.contains('Facility'))) 'Facility': Facility?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(IncludedService != null && (!preventCircularSerialization || !serializedModels.contains('IncludedService'))) 'IncludedService': IncludedService?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Payment != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'Payment': Payment?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(properties != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'properties': properties?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reports != null && (!preventCircularSerialization || !serializedModels.contains('Report'))) 'reports': reports?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(users != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'users': users?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($facilityAmenitiesCount != null || $locationAmenitiesCount != null || $agenciesCount != null || $expensesCount != null || $PaymentCount != null || $propertiesCount != null || $reportsCount != null || $tasksCount != null || $usersCount != null) '_count': { 
		if ($facilityAmenitiesCount != null) 'facilityAmenities': $facilityAmenitiesCount, 
		if ($locationAmenitiesCount != null) 'locationAmenities': $locationAmenitiesCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($expensesCount != null) 'expenses': $expensesCount, 
		if ($PaymentCount != null) 'Payment': $PaymentCount, 
		if ($propertiesCount != null) 'properties': $propertiesCount, 
		if ($reportsCount != null) 'reports': $reportsCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($usersCount != null) 'users': $usersCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ExtraCharge &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    