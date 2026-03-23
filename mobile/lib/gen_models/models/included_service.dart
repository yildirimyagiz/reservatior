
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'facility_amenities.dart';
import 'location_amenities.dart';
import 'agency.dart';
import 'expense.dart';
import 'extra_charge.dart';
import 'facility.dart';
import 'payment.dart';
import 'property.dart';
import 'report.dart';
import 'task.dart';
import 'user.dart';


class IncludedService implements PrismaModel<String, IncludedService> , Id<String> {
    @override
String? id;
	String? propertyId;
	String? name;
	String? description;
	double? value;
	bool? isRecurring;
	String? frequency;
	String? icon;
	String? logo;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<FacilityAmenities>? facilityAmenities;
	List<LocationAmenities>? locationAmenities;
	String? facilityId;
	List<Agency>? agencies;
	List<Expense>? expenses;
	List<ExtraCharge>? extraCharges;
	Facility? Facility;
	List<Payment>? Payment;
	List<Property>? properties;
	List<Report>? reports;
	List<Task>? tasks;
	List<User>? users;
	Property? Property;
	int? $facilityAmenitiesCount;
	int? $locationAmenitiesCount;
	int? $agenciesCount;
	int? $expensesCount;
	int? $extraChargesCount;
	int? $PaymentCount;
	int? $propertiesCount;
	int? $reportsCount;
	int? $tasksCount;
	int? $usersCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    IncludedService({ this.id,
	 this.propertyId,
	 this.name,
	 this.description,
	 this.value,
	 this.isRecurring = false,
	 this.frequency = "monthly",
	 this.icon,
	 this.logo,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.facilityAmenities,
	 this.locationAmenities,
	 this.facilityId,
	 this.agencies,
	 this.expenses,
	 this.extraCharges,
	 this.Facility,
	 this.Payment,
	 this.properties,
	 this.reports,
	 this.tasks,
	 this.users,
	 this.Property,
	this.$facilityAmenitiesCount,
	this.$locationAmenitiesCount,
	this.$agenciesCount,
	this.$expensesCount,
	this.$extraChargesCount,
	this.$PaymentCount,
	this.$propertiesCount,
	this.$reportsCount,
	this.$tasksCount,
	this.$usersCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<IncludedService, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"value": (m) => m.value,

	"isRecurring": (m) => m.isRecurring,

	"frequency": (m) => m.frequency,

	"icon": (m) => m.icon,

	"logo": (m) => m.logo,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"facilityAmenities": (m) => m.facilityAmenities,

	"locationAmenities": (m) => m.locationAmenities,

	"facilityId": (m) => m.facilityId,

	"agencies": (m) => m.agencies,

	"expenses": (m) => m.expenses,

	"extraCharges": (m) => m.extraCharges,

	"Facility": (m) => m.Facility,

	"Payment": (m) => m.Payment,

	"properties": (m) => m.properties,

	"reports": (m) => m.reports,

	"tasks": (m) => m.tasks,

	"users": (m) => m.users,

	"Property": (m) => m.Property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(IncludedService) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in IncludedService');
    }
    return propFunction as V? Function(IncludedService);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory IncludedService.fromJson(JsonMap json) =>
      IncludedService(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	value: json['value']?.toDouble(),
	isRecurring: json['isRecurring'] as bool?,
	frequency: json['frequency'] as String?,
	icon: json['icon'] as String?,
	logo: json['logo'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	facilityAmenities: json['facilityAmenities'] != null ? (json['facilityAmenities']).map((item) => FacilityAmenities.fromJson(item)).toList() : null,
	locationAmenities: json['locationAmenities'] != null ? (json['locationAmenities']).map((item) => LocationAmenities.fromJson(item)).toList() : null,
	facilityId: json['facilityId'] as String?,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	expenses: json['expenses'] != null ? createModels<Expense>((json['expenses'] as List).cast<JsonMap>(), Expense.fromJson) : null,
	extraCharges: json['extraCharges'] != null ? createModels<ExtraCharge>((json['extraCharges'] as List).cast<JsonMap>(), ExtraCharge.fromJson) : null,
	Facility: json['Facility'] != null ? Facility.fromJson(json['Facility'] as JsonMap) : null,
	Payment: json['Payment'] != null ? createModels<Payment>((json['Payment'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	properties: json['properties'] != null ? createModels<Property>((json['properties'] as List).cast<JsonMap>(), Property.fromJson) : null,
	reports: json['reports'] != null ? createModels<Report>((json['reports'] as List).cast<JsonMap>(), Report.fromJson) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	users: json['users'] != null ? createModels<User>((json['users'] as List).cast<JsonMap>(), User.fromJson) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	$facilityAmenitiesCount: json['_count']?['facilityAmenities'] as int?,
	$locationAmenitiesCount: json['_count']?['locationAmenities'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$expensesCount: json['_count']?['expenses'] as int?,
	$extraChargesCount: json['_count']?['extraCharges'] as int?,
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
    IncludedService copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<String?>? name,
		Value<String?>? description,
		Value<double?>? value,
		Value<bool?>? isRecurring,
		Value<String?>? frequency,
		Value<String?>? icon,
		Value<String?>? logo,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<FacilityAmenities>?>? facilityAmenities,
		Value<List<LocationAmenities>?>? locationAmenities,
		Value<String?>? facilityId,
		Value<List<Agency>?>? agencies,
		Value<List<Expense>?>? expenses,
		Value<List<ExtraCharge>?>? extraCharges,
		Value<Facility?>? Facility,
		Value<List<Payment>?>? Payment,
		Value<List<Property>?>? properties,
		Value<List<Report>?>? reports,
		Value<List<Task>?>? tasks,
		Value<List<User>?>? users,
		Value<Property?>? Property,
		int? $facilityAmenitiesCount,
		int? $locationAmenitiesCount,
		int? $agenciesCount,
		int? $expensesCount,
		int? $extraChargesCount,
		int? $PaymentCount,
		int? $propertiesCount,
		int? $reportsCount,
		int? $tasksCount,
		int? $usersCount,
        }) {
        return IncludedService(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		value: value != null ? value.value : this.value,
		isRecurring: isRecurring != null ? isRecurring.value : this.isRecurring,
		frequency: frequency != null ? frequency.value : this.frequency,
		icon: icon != null ? icon.value : this.icon,
		logo: logo != null ? logo.value : this.logo,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		facilityAmenities: facilityAmenities != null ? facilityAmenities.value : this.facilityAmenities,
		locationAmenities: locationAmenities != null ? locationAmenities.value : this.locationAmenities,
		facilityId: facilityId != null ? facilityId.value : this.facilityId,
		agencies: agencies != null ? agencies.value : this.agencies,
		expenses: expenses != null ? expenses.value : this.expenses,
		extraCharges: extraCharges != null ? extraCharges.value : this.extraCharges,
		Facility: Facility != null ? Facility.value : this.Facility,
		Payment: Payment != null ? Payment.value : this.Payment,
		properties: properties != null ? properties.value : this.properties,
		reports: reports != null ? reports.value : this.reports,
		tasks: tasks != null ? tasks.value : this.tasks,
		users: users != null ? users.value : this.users,
		Property: Property != null ? Property.value : this.Property,
		$facilityAmenitiesCount: $facilityAmenitiesCount ?? this.$facilityAmenitiesCount,
		$locationAmenitiesCount: $locationAmenitiesCount ?? this.$locationAmenitiesCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$expensesCount: $expensesCount ?? this.$expensesCount,
		$extraChargesCount: $extraChargesCount ?? this.$extraChargesCount,
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
    IncludedService copyWithInstanceValues(IncludedService includedService) {
        return IncludedService(
            id: includedService.id ?? id,
		propertyId: includedService.propertyId ?? propertyId,
		name: includedService.name ?? name,
		description: includedService.description ?? description,
		value: includedService.value ?? value,
		isRecurring: includedService.isRecurring ?? isRecurring,
		frequency: includedService.frequency ?? frequency,
		icon: includedService.icon ?? icon,
		logo: includedService.logo ?? logo,
		createdAt: includedService.createdAt ?? createdAt,
		updatedAt: includedService.updatedAt ?? updatedAt,
		deletedAt: includedService.deletedAt ?? deletedAt,
		facilityAmenities: includedService.facilityAmenities ?? facilityAmenities,
		locationAmenities: includedService.locationAmenities ?? locationAmenities,
		facilityId: includedService.facilityId ?? facilityId,
		agencies: includedService.agencies ?? agencies,
		expenses: includedService.expenses ?? expenses,
		extraCharges: includedService.extraCharges ?? extraCharges,
		Facility: includedService.Facility ?? Facility,
		Payment: includedService.Payment ?? Payment,
		properties: includedService.properties ?? properties,
		reports: includedService.reports ?? reports,
		tasks: includedService.tasks ?? tasks,
		users: includedService.users ?? users,
		Property: includedService.Property ?? Property,
		$facilityAmenitiesCount: includedService.$facilityAmenitiesCount ?? $facilityAmenitiesCount,
		$locationAmenitiesCount: includedService.$locationAmenitiesCount ?? $locationAmenitiesCount,
		$agenciesCount: includedService.$agenciesCount ?? $agenciesCount,
		$expensesCount: includedService.$expensesCount ?? $expensesCount,
		$extraChargesCount: includedService.$extraChargesCount ?? $extraChargesCount,
		$PaymentCount: includedService.$PaymentCount ?? $PaymentCount,
		$propertiesCount: includedService.$propertiesCount ?? $propertiesCount,
		$reportsCount: includedService.$reportsCount ?? $reportsCount,
		$tasksCount: includedService.$tasksCount ?? $tasksCount,
		$usersCount: includedService.$usersCount ?? $usersCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    IncludedService mergeWithInstanceValues(IncludedService includedService) {
        return IncludedService(
            id: includedService.$assignedFields.contains('id') ? includedService.id : id,
		propertyId: includedService.$assignedFields.contains('propertyId') ? includedService.propertyId : propertyId,
		name: includedService.$assignedFields.contains('name') ? includedService.name : name,
		description: includedService.$assignedFields.contains('description') ? includedService.description : description,
		value: includedService.$assignedFields.contains('value') ? includedService.value : value,
		isRecurring: includedService.$assignedFields.contains('isRecurring') ? includedService.isRecurring : isRecurring,
		frequency: includedService.$assignedFields.contains('frequency') ? includedService.frequency : frequency,
		icon: includedService.$assignedFields.contains('icon') ? includedService.icon : icon,
		logo: includedService.$assignedFields.contains('logo') ? includedService.logo : logo,
		createdAt: includedService.$assignedFields.contains('createdAt') ? includedService.createdAt : createdAt,
		updatedAt: includedService.$assignedFields.contains('updatedAt') ? includedService.updatedAt : updatedAt,
		deletedAt: includedService.$assignedFields.contains('deletedAt') ? includedService.deletedAt : deletedAt,
		facilityAmenities: includedService.$assignedFields.contains('facilityAmenities') ? includedService.facilityAmenities : facilityAmenities,
		locationAmenities: includedService.$assignedFields.contains('locationAmenities') ? includedService.locationAmenities : locationAmenities,
		facilityId: includedService.$assignedFields.contains('facilityId') ? includedService.facilityId : facilityId,
		agencies: (includedService.$assignedFields.contains('agencies') && includedService.agencies != null) ? mergeModelLists(agencies, includedService.agencies) : agencies,
		expenses: (includedService.$assignedFields.contains('expenses') && includedService.expenses != null) ? mergeModelLists(expenses, includedService.expenses) : expenses,
		extraCharges: (includedService.$assignedFields.contains('extraCharges') && includedService.extraCharges != null) ? mergeModelLists(extraCharges, includedService.extraCharges) : extraCharges,
		Facility: includedService.$assignedFields.contains('Facility') ? includedService.Facility : Facility,
		Payment: (includedService.$assignedFields.contains('Payment') && includedService.Payment != null) ? mergeModelLists(Payment, includedService.Payment) : Payment,
		properties: (includedService.$assignedFields.contains('properties') && includedService.properties != null) ? mergeModelLists(properties, includedService.properties) : properties,
		reports: (includedService.$assignedFields.contains('reports') && includedService.reports != null) ? mergeModelLists(reports, includedService.reports) : reports,
		tasks: (includedService.$assignedFields.contains('tasks') && includedService.tasks != null) ? mergeModelLists(tasks, includedService.tasks) : tasks,
		users: (includedService.$assignedFields.contains('users') && includedService.users != null) ? mergeModelLists(users, includedService.users) : users,
		Property: includedService.$assignedFields.contains('Property') ? includedService.Property : Property,
		$facilityAmenitiesCount: includedService.$facilityAmenitiesCount ?? $facilityAmenitiesCount,
		$locationAmenitiesCount: includedService.$locationAmenitiesCount ?? $locationAmenitiesCount,
		$agenciesCount: includedService.$agenciesCount ?? $agenciesCount,
		$expensesCount: includedService.$expensesCount ?? $expensesCount,
		$extraChargesCount: includedService.$extraChargesCount ?? $extraChargesCount,
		$PaymentCount: includedService.$PaymentCount ?? $PaymentCount,
		$propertiesCount: includedService.$propertiesCount ?? $propertiesCount,
		$reportsCount: includedService.$reportsCount ?? $reportsCount,
		$tasksCount: includedService.$tasksCount ?? $tasksCount,
		$usersCount: includedService.$usersCount ?? $usersCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    IncludedService updateWithInstanceValues(IncludedService includedService) {
        if (includedService.$assignedFields.contains('id')) { id = includedService.id; }
		if (includedService.$assignedFields.contains('propertyId')) { propertyId = includedService.propertyId; }
		if (includedService.$assignedFields.contains('name')) { name = includedService.name; }
		if (includedService.$assignedFields.contains('description')) { description = includedService.description; }
		if (includedService.$assignedFields.contains('value')) { value = includedService.value; }
		if (includedService.$assignedFields.contains('isRecurring')) { isRecurring = includedService.isRecurring; }
		if (includedService.$assignedFields.contains('frequency')) { frequency = includedService.frequency; }
		if (includedService.$assignedFields.contains('icon')) { icon = includedService.icon; }
		if (includedService.$assignedFields.contains('logo')) { logo = includedService.logo; }
		if (includedService.$assignedFields.contains('createdAt')) { createdAt = includedService.createdAt; }
		if (includedService.$assignedFields.contains('updatedAt')) { updatedAt = includedService.updatedAt; }
		if (includedService.$assignedFields.contains('deletedAt')) { deletedAt = includedService.deletedAt; }
		if (includedService.$assignedFields.contains('facilityAmenities')) { facilityAmenities = includedService.facilityAmenities; }
		if (includedService.$assignedFields.contains('locationAmenities')) { locationAmenities = includedService.locationAmenities; }
		if (includedService.$assignedFields.contains('facilityId')) { facilityId = includedService.facilityId; }
		if (includedService.$assignedFields.contains('agencies') && includedService.agencies != null) { agencies = mergeModelLists(agencies, includedService.agencies); }
		if (includedService.$assignedFields.contains('expenses') && includedService.expenses != null) { expenses = mergeModelLists(expenses, includedService.expenses); }
		if (includedService.$assignedFields.contains('extraCharges') && includedService.extraCharges != null) { extraCharges = mergeModelLists(extraCharges, includedService.extraCharges); }
		if (includedService.$assignedFields.contains('Facility')) { Facility = includedService.Facility; }
		if (includedService.$assignedFields.contains('Payment') && includedService.Payment != null) { Payment = mergeModelLists(Payment, includedService.Payment); }
		if (includedService.$assignedFields.contains('properties') && includedService.properties != null) { properties = mergeModelLists(properties, includedService.properties); }
		if (includedService.$assignedFields.contains('reports') && includedService.reports != null) { reports = mergeModelLists(reports, includedService.reports); }
		if (includedService.$assignedFields.contains('tasks') && includedService.tasks != null) { tasks = mergeModelLists(tasks, includedService.tasks); }
		if (includedService.$assignedFields.contains('users') && includedService.users != null) { users = mergeModelLists(users, includedService.users); }
		if (includedService.$assignedFields.contains('Property')) { Property = includedService.Property; }
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
          ? {...?serializedTypes, 'IncludedService'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(value != null) 'value': value,
	if(isRecurring != null) 'isRecurring': isRecurring,
	if(frequency != null) 'frequency': frequency,
	if(icon != null) 'icon': icon,
	if(logo != null) 'logo': logo,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(facilityAmenities != null) 'facilityAmenities': facilityAmenities?.map((item) => item.toJson()).toList(),
	if(locationAmenities != null) 'locationAmenities': locationAmenities?.map((item) => item.toJson()).toList(),
	if(facilityId != null) 'facilityId': facilityId,
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(expenses != null && (!preventCircularSerialization || !serializedModels.contains('Expense'))) 'expenses': expenses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(extraCharges != null && (!preventCircularSerialization || !serializedModels.contains('ExtraCharge'))) 'extraCharges': extraCharges?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Facility != null && (!preventCircularSerialization || !serializedModels.contains('Facility'))) 'Facility': Facility?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Payment != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'Payment': Payment?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(properties != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'properties': properties?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reports != null && (!preventCircularSerialization || !serializedModels.contains('Report'))) 'reports': reports?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(users != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'users': users?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($facilityAmenitiesCount != null || $locationAmenitiesCount != null || $agenciesCount != null || $expensesCount != null || $extraChargesCount != null || $PaymentCount != null || $propertiesCount != null || $reportsCount != null || $tasksCount != null || $usersCount != null) '_count': { 
		if ($facilityAmenitiesCount != null) 'facilityAmenities': $facilityAmenitiesCount, 
		if ($locationAmenitiesCount != null) 'locationAmenities': $locationAmenitiesCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($expensesCount != null) 'expenses': $expensesCount, 
		if ($extraChargesCount != null) 'extraCharges': $extraChargesCount, 
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
            identical(this, other) || other is IncludedService &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    