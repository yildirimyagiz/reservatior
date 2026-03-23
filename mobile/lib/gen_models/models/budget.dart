
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';


class Budget implements PrismaModel<String, Budget> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? name;
	String? description;
	String? budgetType;
	String? period;
	DateTime? startDate;
	DateTime? endDate;
	double? totalAmount;
	String? currency;
	dynamic lineItems;
	dynamic categories;
	dynamic alerts;
	double? actualSpent;
	bool? isActive;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Budget({ this.id,
	 this.orgId,
	 this.userId,
	 this.name,
	 this.description,
	 this.budgetType,
	 this.period,
	 this.startDate,
	 this.endDate,
	 this.totalAmount,
	 this.currency = "USD",
	required this.lineItems,
	required this.categories,
	required this.alerts,
	 this.actualSpent = 0,
	 this.isActive = true,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Budget, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"budgetType": (m) => m.budgetType,

	"period": (m) => m.period,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"totalAmount": (m) => m.totalAmount,

	"currency": (m) => m.currency,

	"lineItems": (m) => m.lineItems,

	"categories": (m) => m.categories,

	"alerts": (m) => m.alerts,

	"actualSpent": (m) => m.actualSpent,

	"isActive": (m) => m.isActive,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Budget) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Budget');
    }
    return propFunction as V? Function(Budget);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Budget.fromJson(JsonMap json) =>
      Budget(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	budgetType: json['budgetType'] as String?,
	period: json['period'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	totalAmount: json['totalAmount'] as double?,
	currency: json['currency'] as String?,
	lineItems: json['lineItems'] as dynamic,
	categories: json['categories'] as dynamic,
	alerts: json['alerts'] as dynamic,
	actualSpent: json['actualSpent'] as double?,
	isActive: json['isActive'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Budget copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? name,
		Value<String?>? description,
		Value<String?>? budgetType,
		Value<String?>? period,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<double?>? totalAmount,
		Value<String?>? currency,
		Value<dynamic>? lineItems,
		Value<dynamic>? categories,
		Value<dynamic>? alerts,
		Value<double?>? actualSpent,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return Budget(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		budgetType: budgetType != null ? budgetType.value : this.budgetType,
		period: period != null ? period.value : this.period,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		totalAmount: totalAmount != null ? totalAmount.value : this.totalAmount,
		currency: currency != null ? currency.value : this.currency,
		lineItems: lineItems != null ? lineItems.value : this.lineItems,
		categories: categories != null ? categories.value : this.categories,
		alerts: alerts != null ? alerts.value : this.alerts,
		actualSpent: actualSpent != null ? actualSpent.value : this.actualSpent,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Budget copyWithInstanceValues(Budget budget) {
        return Budget(
            id: budget.id ?? id,
		orgId: budget.orgId ?? orgId,
		userId: budget.userId ?? userId,
		name: budget.name ?? name,
		description: budget.description ?? description,
		budgetType: budget.budgetType ?? budgetType,
		period: budget.period ?? period,
		startDate: budget.startDate ?? startDate,
		endDate: budget.endDate ?? endDate,
		totalAmount: budget.totalAmount ?? totalAmount,
		currency: budget.currency ?? currency,
		lineItems: budget.lineItems ?? lineItems,
		categories: budget.categories ?? categories,
		alerts: budget.alerts ?? alerts,
		actualSpent: budget.actualSpent ?? actualSpent,
		isActive: budget.isActive ?? isActive,
		createdBy: budget.createdBy ?? createdBy,
		createdAt: budget.createdAt ?? createdAt,
		updatedAt: budget.updatedAt ?? updatedAt,
		deletedAt: budget.deletedAt ?? deletedAt,
		org: budget.org ?? org,
		user: budget.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Budget mergeWithInstanceValues(Budget budget) {
        return Budget(
            id: budget.$assignedFields.contains('id') ? budget.id : id,
		orgId: budget.$assignedFields.contains('orgId') ? budget.orgId : orgId,
		userId: budget.$assignedFields.contains('userId') ? budget.userId : userId,
		name: budget.$assignedFields.contains('name') ? budget.name : name,
		description: budget.$assignedFields.contains('description') ? budget.description : description,
		budgetType: budget.$assignedFields.contains('budgetType') ? budget.budgetType : budgetType,
		period: budget.$assignedFields.contains('period') ? budget.period : period,
		startDate: budget.$assignedFields.contains('startDate') ? budget.startDate : startDate,
		endDate: budget.$assignedFields.contains('endDate') ? budget.endDate : endDate,
		totalAmount: budget.$assignedFields.contains('totalAmount') ? budget.totalAmount : totalAmount,
		currency: budget.$assignedFields.contains('currency') ? budget.currency : currency,
		lineItems: budget.$assignedFields.contains('lineItems') ? budget.lineItems : lineItems,
		categories: budget.$assignedFields.contains('categories') ? budget.categories : categories,
		alerts: budget.$assignedFields.contains('alerts') ? budget.alerts : alerts,
		actualSpent: budget.$assignedFields.contains('actualSpent') ? budget.actualSpent : actualSpent,
		isActive: budget.$assignedFields.contains('isActive') ? budget.isActive : isActive,
		createdBy: budget.$assignedFields.contains('createdBy') ? budget.createdBy : createdBy,
		createdAt: budget.$assignedFields.contains('createdAt') ? budget.createdAt : createdAt,
		updatedAt: budget.$assignedFields.contains('updatedAt') ? budget.updatedAt : updatedAt,
		deletedAt: budget.$assignedFields.contains('deletedAt') ? budget.deletedAt : deletedAt,
		org: budget.$assignedFields.contains('org') ? budget.org : org,
		user: budget.$assignedFields.contains('user') ? budget.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Budget updateWithInstanceValues(Budget budget) {
        if (budget.$assignedFields.contains('id')) { id = budget.id; }
		if (budget.$assignedFields.contains('orgId')) { orgId = budget.orgId; }
		if (budget.$assignedFields.contains('userId')) { userId = budget.userId; }
		if (budget.$assignedFields.contains('name')) { name = budget.name; }
		if (budget.$assignedFields.contains('description')) { description = budget.description; }
		if (budget.$assignedFields.contains('budgetType')) { budgetType = budget.budgetType; }
		if (budget.$assignedFields.contains('period')) { period = budget.period; }
		if (budget.$assignedFields.contains('startDate')) { startDate = budget.startDate; }
		if (budget.$assignedFields.contains('endDate')) { endDate = budget.endDate; }
		if (budget.$assignedFields.contains('totalAmount')) { totalAmount = budget.totalAmount; }
		if (budget.$assignedFields.contains('currency')) { currency = budget.currency; }
		if (budget.$assignedFields.contains('lineItems')) { lineItems = budget.lineItems; }
		if (budget.$assignedFields.contains('categories')) { categories = budget.categories; }
		if (budget.$assignedFields.contains('alerts')) { alerts = budget.alerts; }
		if (budget.$assignedFields.contains('actualSpent')) { actualSpent = budget.actualSpent; }
		if (budget.$assignedFields.contains('isActive')) { isActive = budget.isActive; }
		if (budget.$assignedFields.contains('createdBy')) { createdBy = budget.createdBy; }
		if (budget.$assignedFields.contains('createdAt')) { createdAt = budget.createdAt; }
		if (budget.$assignedFields.contains('updatedAt')) { updatedAt = budget.updatedAt; }
		if (budget.$assignedFields.contains('deletedAt')) { deletedAt = budget.deletedAt; }
		if (budget.$assignedFields.contains('org')) { org = budget.org; }
		if (budget.$assignedFields.contains('user')) { user = budget.user; }
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
          ? {...?serializedTypes, 'Budget'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(budgetType != null) 'budgetType': budgetType,
	if(period != null) 'period': period,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(totalAmount != null) 'totalAmount': totalAmount,
	if(currency != null) 'currency': currency,
	if(lineItems != null) 'lineItems': lineItems,
	if(categories != null) 'categories': categories,
	if(alerts != null) 'alerts': alerts,
	if(actualSpent != null) 'actualSpent': actualSpent,
	if(isActive != null) 'isActive': isActive,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Budget &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    