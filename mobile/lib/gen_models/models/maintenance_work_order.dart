
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'priority.dart';
import 'work_order_status.dart';
import 'organization.dart';
import 'property.dart';
import 'tenant.dart';
import 'user.dart';
import 'contact.dart';


class MaintenanceWorkOrder implements PrismaModel<String, MaintenanceWorkOrder> , Id<String> {
    @override
String? id;
	String? propertyId;
	String? tenantId;
	String? reportedBy;
	String? title;
	String? description;
	Priority? priority;
	String? category;
	WorkOrderStatus? status;
	DateTime? reportedAt;
	DateTime? dueDate;
	String? assignedTo;
	String? assignedVendor;
	double? estimatedCost;
	double? actualCost;
	String? userId;
	String? organizationId;
	bool? isActive;
	Organization? organization;
	Property? property;
	Tenant? tenant;
	User? user;
	User? assignedToUser;
	List<Contact>? Contact;
	int? $ContactCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MaintenanceWorkOrder({ this.id,
	 this.propertyId,
	 this.tenantId,
	 this.reportedBy,
	 this.title,
	 this.description,
	 this.priority,
	 this.category,
	 this.status = WorkOrderStatus.OPEN,
	 this.reportedAt,
	 this.dueDate,
	 this.assignedTo,
	 this.assignedVendor,
	 this.estimatedCost,
	 this.actualCost,
	 this.userId,
	 this.organizationId,
	 this.isActive = true,
	 this.organization,
	 this.property,
	 this.tenant,
	 this.user,
	 this.assignedToUser,
	 this.Contact,
	this.$ContactCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MaintenanceWorkOrder, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"tenantId": (m) => m.tenantId,

	"reportedBy": (m) => m.reportedBy,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"priority": (m) => m.priority,

	"category": (m) => m.category,

	"status": (m) => m.status,

	"reportedAt": (m) => m.reportedAt,

	"dueDate": (m) => m.dueDate,

	"assignedTo": (m) => m.assignedTo,

	"assignedVendor": (m) => m.assignedVendor,

	"estimatedCost": (m) => m.estimatedCost,

	"actualCost": (m) => m.actualCost,

	"userId": (m) => m.userId,

	"organizationId": (m) => m.organizationId,

	"isActive": (m) => m.isActive,

	"organization": (m) => m.organization,

	"property": (m) => m.property,

	"tenant": (m) => m.tenant,

	"user": (m) => m.user,

	"assignedToUser": (m) => m.assignedToUser,

	"Contact": (m) => m.Contact,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MaintenanceWorkOrder) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MaintenanceWorkOrder');
    }
    return propFunction as V? Function(MaintenanceWorkOrder);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MaintenanceWorkOrder.fromJson(JsonMap json) =>
      MaintenanceWorkOrder(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	tenantId: json['tenantId'] as String?,
	reportedBy: json['reportedBy'] as String?,
	title: json['title'] as String?,
	description: json['description'] as String?,
	priority: json['priority'] != null ? Priority.fromJson(json['priority']) : null,
	category: json['category'] as String?,
	status: json['status'] != null ? WorkOrderStatus.fromJson(json['status']) : null,
	reportedAt: json['reportedAt'] != null ? DateTime.parse(json['reportedAt']) : null,
	dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
	assignedTo: json['assignedTo'] as String?,
	assignedVendor: json['assignedVendor'] as String?,
	estimatedCost: json['estimatedCost'] as double?,
	actualCost: json['actualCost'] as double?,
	userId: json['userId'] as String?,
	organizationId: json['organizationId'] as String?,
	isActive: json['isActive'] as bool?,
	organization: json['organization'] != null ? Organization.fromJson(json['organization'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	tenant: json['tenant'] != null ? Tenant.fromJson(json['tenant'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	assignedToUser: json['assignedToUser'] != null ? User.fromJson(json['assignedToUser'] as JsonMap) : null,
	Contact: json['Contact'] != null ? createModels<Contact>((json['Contact'] as List).cast<JsonMap>(), Contact.fromJson) : null,
	$ContactCount: json['_count']?['Contact'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MaintenanceWorkOrder copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<String?>? tenantId,
		Value<String?>? reportedBy,
		Value<String?>? title,
		Value<String?>? description,
		Value<Priority?>? priority,
		Value<String?>? category,
		Value<WorkOrderStatus?>? status,
		Value<DateTime?>? reportedAt,
		Value<DateTime?>? dueDate,
		Value<String?>? assignedTo,
		Value<String?>? assignedVendor,
		Value<double?>? estimatedCost,
		Value<double?>? actualCost,
		Value<String?>? userId,
		Value<String?>? organizationId,
		Value<bool?>? isActive,
		Value<Organization?>? organization,
		Value<Property?>? property,
		Value<Tenant?>? tenant,
		Value<User?>? user,
		Value<User?>? assignedToUser,
		Value<List<Contact>?>? Contact,
		int? $ContactCount,
        }) {
        return MaintenanceWorkOrder(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		tenantId: tenantId != null ? tenantId.value : this.tenantId,
		reportedBy: reportedBy != null ? reportedBy.value : this.reportedBy,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		priority: priority != null ? priority.value : this.priority,
		category: category != null ? category.value : this.category,
		status: status != null ? status.value : this.status,
		reportedAt: reportedAt != null ? reportedAt.value : this.reportedAt,
		dueDate: dueDate != null ? dueDate.value : this.dueDate,
		assignedTo: assignedTo != null ? assignedTo.value : this.assignedTo,
		assignedVendor: assignedVendor != null ? assignedVendor.value : this.assignedVendor,
		estimatedCost: estimatedCost != null ? estimatedCost.value : this.estimatedCost,
		actualCost: actualCost != null ? actualCost.value : this.actualCost,
		userId: userId != null ? userId.value : this.userId,
		organizationId: organizationId != null ? organizationId.value : this.organizationId,
		isActive: isActive != null ? isActive.value : this.isActive,
		organization: organization != null ? organization.value : this.organization,
		property: property != null ? property.value : this.property,
		tenant: tenant != null ? tenant.value : this.tenant,
		user: user != null ? user.value : this.user,
		assignedToUser: assignedToUser != null ? assignedToUser.value : this.assignedToUser,
		Contact: Contact != null ? Contact.value : this.Contact,
		$ContactCount: $ContactCount ?? this.$ContactCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MaintenanceWorkOrder copyWithInstanceValues(MaintenanceWorkOrder maintenanceWorkOrder) {
        return MaintenanceWorkOrder(
            id: maintenanceWorkOrder.id ?? id,
		propertyId: maintenanceWorkOrder.propertyId ?? propertyId,
		tenantId: maintenanceWorkOrder.tenantId ?? tenantId,
		reportedBy: maintenanceWorkOrder.reportedBy ?? reportedBy,
		title: maintenanceWorkOrder.title ?? title,
		description: maintenanceWorkOrder.description ?? description,
		priority: maintenanceWorkOrder.priority ?? priority,
		category: maintenanceWorkOrder.category ?? category,
		status: maintenanceWorkOrder.status ?? status,
		reportedAt: maintenanceWorkOrder.reportedAt ?? reportedAt,
		dueDate: maintenanceWorkOrder.dueDate ?? dueDate,
		assignedTo: maintenanceWorkOrder.assignedTo ?? assignedTo,
		assignedVendor: maintenanceWorkOrder.assignedVendor ?? assignedVendor,
		estimatedCost: maintenanceWorkOrder.estimatedCost ?? estimatedCost,
		actualCost: maintenanceWorkOrder.actualCost ?? actualCost,
		userId: maintenanceWorkOrder.userId ?? userId,
		organizationId: maintenanceWorkOrder.organizationId ?? organizationId,
		isActive: maintenanceWorkOrder.isActive ?? isActive,
		organization: maintenanceWorkOrder.organization ?? organization,
		property: maintenanceWorkOrder.property ?? property,
		tenant: maintenanceWorkOrder.tenant ?? tenant,
		user: maintenanceWorkOrder.user ?? user,
		assignedToUser: maintenanceWorkOrder.assignedToUser ?? assignedToUser,
		Contact: maintenanceWorkOrder.Contact ?? Contact,
		$ContactCount: maintenanceWorkOrder.$ContactCount ?? $ContactCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MaintenanceWorkOrder mergeWithInstanceValues(MaintenanceWorkOrder maintenanceWorkOrder) {
        return MaintenanceWorkOrder(
            id: maintenanceWorkOrder.$assignedFields.contains('id') ? maintenanceWorkOrder.id : id,
		propertyId: maintenanceWorkOrder.$assignedFields.contains('propertyId') ? maintenanceWorkOrder.propertyId : propertyId,
		tenantId: maintenanceWorkOrder.$assignedFields.contains('tenantId') ? maintenanceWorkOrder.tenantId : tenantId,
		reportedBy: maintenanceWorkOrder.$assignedFields.contains('reportedBy') ? maintenanceWorkOrder.reportedBy : reportedBy,
		title: maintenanceWorkOrder.$assignedFields.contains('title') ? maintenanceWorkOrder.title : title,
		description: maintenanceWorkOrder.$assignedFields.contains('description') ? maintenanceWorkOrder.description : description,
		priority: maintenanceWorkOrder.$assignedFields.contains('priority') ? maintenanceWorkOrder.priority : priority,
		category: maintenanceWorkOrder.$assignedFields.contains('category') ? maintenanceWorkOrder.category : category,
		status: maintenanceWorkOrder.$assignedFields.contains('status') ? maintenanceWorkOrder.status : status,
		reportedAt: maintenanceWorkOrder.$assignedFields.contains('reportedAt') ? maintenanceWorkOrder.reportedAt : reportedAt,
		dueDate: maintenanceWorkOrder.$assignedFields.contains('dueDate') ? maintenanceWorkOrder.dueDate : dueDate,
		assignedTo: maintenanceWorkOrder.$assignedFields.contains('assignedTo') ? maintenanceWorkOrder.assignedTo : assignedTo,
		assignedVendor: maintenanceWorkOrder.$assignedFields.contains('assignedVendor') ? maintenanceWorkOrder.assignedVendor : assignedVendor,
		estimatedCost: maintenanceWorkOrder.$assignedFields.contains('estimatedCost') ? maintenanceWorkOrder.estimatedCost : estimatedCost,
		actualCost: maintenanceWorkOrder.$assignedFields.contains('actualCost') ? maintenanceWorkOrder.actualCost : actualCost,
		userId: maintenanceWorkOrder.$assignedFields.contains('userId') ? maintenanceWorkOrder.userId : userId,
		organizationId: maintenanceWorkOrder.$assignedFields.contains('organizationId') ? maintenanceWorkOrder.organizationId : organizationId,
		isActive: maintenanceWorkOrder.$assignedFields.contains('isActive') ? maintenanceWorkOrder.isActive : isActive,
		organization: maintenanceWorkOrder.$assignedFields.contains('organization') ? maintenanceWorkOrder.organization : organization,
		property: maintenanceWorkOrder.$assignedFields.contains('property') ? maintenanceWorkOrder.property : property,
		tenant: maintenanceWorkOrder.$assignedFields.contains('tenant') ? maintenanceWorkOrder.tenant : tenant,
		user: maintenanceWorkOrder.$assignedFields.contains('user') ? maintenanceWorkOrder.user : user,
		assignedToUser: maintenanceWorkOrder.$assignedFields.contains('assignedToUser') ? maintenanceWorkOrder.assignedToUser : assignedToUser,
		Contact: (maintenanceWorkOrder.$assignedFields.contains('Contact') && maintenanceWorkOrder.Contact != null) ? mergeModelLists(Contact, maintenanceWorkOrder.Contact) : Contact,
		$ContactCount: maintenanceWorkOrder.$ContactCount ?? $ContactCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MaintenanceWorkOrder updateWithInstanceValues(MaintenanceWorkOrder maintenanceWorkOrder) {
        if (maintenanceWorkOrder.$assignedFields.contains('id')) { id = maintenanceWorkOrder.id; }
		if (maintenanceWorkOrder.$assignedFields.contains('propertyId')) { propertyId = maintenanceWorkOrder.propertyId; }
		if (maintenanceWorkOrder.$assignedFields.contains('tenantId')) { tenantId = maintenanceWorkOrder.tenantId; }
		if (maintenanceWorkOrder.$assignedFields.contains('reportedBy')) { reportedBy = maintenanceWorkOrder.reportedBy; }
		if (maintenanceWorkOrder.$assignedFields.contains('title')) { title = maintenanceWorkOrder.title; }
		if (maintenanceWorkOrder.$assignedFields.contains('description')) { description = maintenanceWorkOrder.description; }
		if (maintenanceWorkOrder.$assignedFields.contains('priority')) { priority = maintenanceWorkOrder.priority; }
		if (maintenanceWorkOrder.$assignedFields.contains('category')) { category = maintenanceWorkOrder.category; }
		if (maintenanceWorkOrder.$assignedFields.contains('status')) { status = maintenanceWorkOrder.status; }
		if (maintenanceWorkOrder.$assignedFields.contains('reportedAt')) { reportedAt = maintenanceWorkOrder.reportedAt; }
		if (maintenanceWorkOrder.$assignedFields.contains('dueDate')) { dueDate = maintenanceWorkOrder.dueDate; }
		if (maintenanceWorkOrder.$assignedFields.contains('assignedTo')) { assignedTo = maintenanceWorkOrder.assignedTo; }
		if (maintenanceWorkOrder.$assignedFields.contains('assignedVendor')) { assignedVendor = maintenanceWorkOrder.assignedVendor; }
		if (maintenanceWorkOrder.$assignedFields.contains('estimatedCost')) { estimatedCost = maintenanceWorkOrder.estimatedCost; }
		if (maintenanceWorkOrder.$assignedFields.contains('actualCost')) { actualCost = maintenanceWorkOrder.actualCost; }
		if (maintenanceWorkOrder.$assignedFields.contains('userId')) { userId = maintenanceWorkOrder.userId; }
		if (maintenanceWorkOrder.$assignedFields.contains('organizationId')) { organizationId = maintenanceWorkOrder.organizationId; }
		if (maintenanceWorkOrder.$assignedFields.contains('isActive')) { isActive = maintenanceWorkOrder.isActive; }
		if (maintenanceWorkOrder.$assignedFields.contains('organization')) { organization = maintenanceWorkOrder.organization; }
		if (maintenanceWorkOrder.$assignedFields.contains('property')) { property = maintenanceWorkOrder.property; }
		if (maintenanceWorkOrder.$assignedFields.contains('tenant')) { tenant = maintenanceWorkOrder.tenant; }
		if (maintenanceWorkOrder.$assignedFields.contains('user')) { user = maintenanceWorkOrder.user; }
		if (maintenanceWorkOrder.$assignedFields.contains('assignedToUser')) { assignedToUser = maintenanceWorkOrder.assignedToUser; }
		if (maintenanceWorkOrder.$assignedFields.contains('Contact') && maintenanceWorkOrder.Contact != null) { Contact = mergeModelLists(Contact, maintenanceWorkOrder.Contact); }
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
          ? {...?serializedTypes, 'MaintenanceWorkOrder'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(tenantId != null) 'tenantId': tenantId,
	if(reportedBy != null) 'reportedBy': reportedBy,
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(priority != null) 'priority': priority?.toJson(),
	if(category != null) 'category': category,
	if(status != null) 'status': status?.toJson(),
	if(reportedAt != null) 'reportedAt': reportedAt?.toIso8601String(),
	if(dueDate != null) 'dueDate': dueDate?.toIso8601String(),
	if(assignedTo != null) 'assignedTo': assignedTo,
	if(assignedVendor != null) 'assignedVendor': assignedVendor,
	if(estimatedCost != null) 'estimatedCost': estimatedCost,
	if(actualCost != null) 'actualCost': actualCost,
	if(userId != null) 'userId': userId,
	if(organizationId != null) 'organizationId': organizationId,
	if(isActive != null) 'isActive': isActive,
	if(organization != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'organization': organization?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(tenant != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'tenant': tenant?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(assignedToUser != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'assignedToUser': assignedToUser?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'Contact': Contact?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($ContactCount != null) '_count': { 
		if ($ContactCount != null) 'Contact': $ContactCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MaintenanceWorkOrder &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    