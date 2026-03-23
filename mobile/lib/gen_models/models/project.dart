
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'user.dart';
import 'organization.dart';
import 'property.dart';
import 'task.dart';
import 'project_alert.dart';
import 'project_analytics.dart';
import 'project_report.dart';


class Project implements PrismaModel<String, Project> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	String? description;
	String? projectType;
	String? propertyId;
	String? address;
	String? status;
	DateTime? startDate;
	DateTime? estimatedEndDate;
	DateTime? actualEndDate;
	double? budget;
	String? currency;
	double? actualCost;
	String? managerId;
	String? contractorId;
	dynamic milestones;
	dynamic phases;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? contractor;
	User? manager;
	Organization? org;
	Property? property;
	List<Task>? tasks;
	List<ProjectAlert>? projectAlerts;
	List<ProjectAnalytics>? projectAnalytics;
	List<ProjectReport>? projectReports;
	int? $tasksCount;
	int? $projectAlertsCount;
	int? $projectAnalyticsCount;
	int? $projectReportsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Project({ this.id,
	 this.orgId,
	 this.name,
	 this.description,
	 this.projectType,
	 this.propertyId,
	 this.address,
	 this.status = "PLANNING",
	 this.startDate,
	 this.estimatedEndDate,
	 this.actualEndDate,
	 this.budget,
	 this.currency = "USD",
	 this.actualCost,
	 this.managerId,
	 this.contractorId,
	required this.milestones,
	required this.phases,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contractor,
	 this.manager,
	 this.org,
	 this.property,
	 this.tasks,
	 this.projectAlerts,
	 this.projectAnalytics,
	 this.projectReports,
	this.$tasksCount,
	this.$projectAlertsCount,
	this.$projectAnalyticsCount,
	this.$projectReportsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Project, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"projectType": (m) => m.projectType,

	"propertyId": (m) => m.propertyId,

	"address": (m) => m.address,

	"status": (m) => m.status,

	"startDate": (m) => m.startDate,

	"estimatedEndDate": (m) => m.estimatedEndDate,

	"actualEndDate": (m) => m.actualEndDate,

	"budget": (m) => m.budget,

	"currency": (m) => m.currency,

	"actualCost": (m) => m.actualCost,

	"managerId": (m) => m.managerId,

	"contractorId": (m) => m.contractorId,

	"milestones": (m) => m.milestones,

	"phases": (m) => m.phases,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contractor": (m) => m.contractor,

	"manager": (m) => m.manager,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"tasks": (m) => m.tasks,

	"projectAlerts": (m) => m.projectAlerts,

	"projectAnalytics": (m) => m.projectAnalytics,

	"projectReports": (m) => m.projectReports,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Project) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Project');
    }
    return propFunction as V? Function(Project);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Project.fromJson(JsonMap json) =>
      Project(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	projectType: json['projectType'] as String?,
	propertyId: json['propertyId'] as String?,
	address: json['address'] as String?,
	status: json['status'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	estimatedEndDate: json['estimatedEndDate'] != null ? DateTime.parse(json['estimatedEndDate']) : null,
	actualEndDate: json['actualEndDate'] != null ? DateTime.parse(json['actualEndDate']) : null,
	budget: json['budget'] as double?,
	currency: json['currency'] as String?,
	actualCost: json['actualCost'] as double?,
	managerId: json['managerId'] as String?,
	contractorId: json['contractorId'] as String?,
	milestones: json['milestones'] as dynamic,
	phases: json['phases'] as dynamic,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contractor: json['contractor'] != null ? Contact.fromJson(json['contractor'] as JsonMap) : null,
	manager: json['manager'] != null ? User.fromJson(json['manager'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	projectAlerts: json['projectAlerts'] != null ? createModels<ProjectAlert>((json['projectAlerts'] as List).cast<JsonMap>(), ProjectAlert.fromJson) : null,
	projectAnalytics: json['projectAnalytics'] != null ? createModels<ProjectAnalytics>((json['projectAnalytics'] as List).cast<JsonMap>(), ProjectAnalytics.fromJson) : null,
	projectReports: json['projectReports'] != null ? createModels<ProjectReport>((json['projectReports'] as List).cast<JsonMap>(), ProjectReport.fromJson) : null,
	$tasksCount: json['_count']?['tasks'] as int?,
	$projectAlertsCount: json['_count']?['projectAlerts'] as int?,
	$projectAnalyticsCount: json['_count']?['projectAnalytics'] as int?,
	$projectReportsCount: json['_count']?['projectReports'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Project copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? description,
		Value<String?>? projectType,
		Value<String?>? propertyId,
		Value<String?>? address,
		Value<String?>? status,
		Value<DateTime?>? startDate,
		Value<DateTime?>? estimatedEndDate,
		Value<DateTime?>? actualEndDate,
		Value<double?>? budget,
		Value<String?>? currency,
		Value<double?>? actualCost,
		Value<String?>? managerId,
		Value<String?>? contractorId,
		Value<dynamic>? milestones,
		Value<dynamic>? phases,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? contractor,
		Value<User?>? manager,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<List<Task>?>? tasks,
		Value<List<ProjectAlert>?>? projectAlerts,
		Value<List<ProjectAnalytics>?>? projectAnalytics,
		Value<List<ProjectReport>?>? projectReports,
		int? $tasksCount,
		int? $projectAlertsCount,
		int? $projectAnalyticsCount,
		int? $projectReportsCount,
        }) {
        return Project(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		projectType: projectType != null ? projectType.value : this.projectType,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		address: address != null ? address.value : this.address,
		status: status != null ? status.value : this.status,
		startDate: startDate != null ? startDate.value : this.startDate,
		estimatedEndDate: estimatedEndDate != null ? estimatedEndDate.value : this.estimatedEndDate,
		actualEndDate: actualEndDate != null ? actualEndDate.value : this.actualEndDate,
		budget: budget != null ? budget.value : this.budget,
		currency: currency != null ? currency.value : this.currency,
		actualCost: actualCost != null ? actualCost.value : this.actualCost,
		managerId: managerId != null ? managerId.value : this.managerId,
		contractorId: contractorId != null ? contractorId.value : this.contractorId,
		milestones: milestones != null ? milestones.value : this.milestones,
		phases: phases != null ? phases.value : this.phases,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contractor: contractor != null ? contractor.value : this.contractor,
		manager: manager != null ? manager.value : this.manager,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		tasks: tasks != null ? tasks.value : this.tasks,
		projectAlerts: projectAlerts != null ? projectAlerts.value : this.projectAlerts,
		projectAnalytics: projectAnalytics != null ? projectAnalytics.value : this.projectAnalytics,
		projectReports: projectReports != null ? projectReports.value : this.projectReports,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$projectAlertsCount: $projectAlertsCount ?? this.$projectAlertsCount,
		$projectAnalyticsCount: $projectAnalyticsCount ?? this.$projectAnalyticsCount,
		$projectReportsCount: $projectReportsCount ?? this.$projectReportsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Project copyWithInstanceValues(Project project) {
        return Project(
            id: project.id ?? id,
		orgId: project.orgId ?? orgId,
		name: project.name ?? name,
		description: project.description ?? description,
		projectType: project.projectType ?? projectType,
		propertyId: project.propertyId ?? propertyId,
		address: project.address ?? address,
		status: project.status ?? status,
		startDate: project.startDate ?? startDate,
		estimatedEndDate: project.estimatedEndDate ?? estimatedEndDate,
		actualEndDate: project.actualEndDate ?? actualEndDate,
		budget: project.budget ?? budget,
		currency: project.currency ?? currency,
		actualCost: project.actualCost ?? actualCost,
		managerId: project.managerId ?? managerId,
		contractorId: project.contractorId ?? contractorId,
		milestones: project.milestones ?? milestones,
		phases: project.phases ?? phases,
		createdBy: project.createdBy ?? createdBy,
		createdAt: project.createdAt ?? createdAt,
		updatedAt: project.updatedAt ?? updatedAt,
		deletedAt: project.deletedAt ?? deletedAt,
		contractor: project.contractor ?? contractor,
		manager: project.manager ?? manager,
		org: project.org ?? org,
		property: project.property ?? property,
		tasks: project.tasks ?? tasks,
		projectAlerts: project.projectAlerts ?? projectAlerts,
		projectAnalytics: project.projectAnalytics ?? projectAnalytics,
		projectReports: project.projectReports ?? projectReports,
		$tasksCount: project.$tasksCount ?? $tasksCount,
		$projectAlertsCount: project.$projectAlertsCount ?? $projectAlertsCount,
		$projectAnalyticsCount: project.$projectAnalyticsCount ?? $projectAnalyticsCount,
		$projectReportsCount: project.$projectReportsCount ?? $projectReportsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Project mergeWithInstanceValues(Project project) {
        return Project(
            id: project.$assignedFields.contains('id') ? project.id : id,
		orgId: project.$assignedFields.contains('orgId') ? project.orgId : orgId,
		name: project.$assignedFields.contains('name') ? project.name : name,
		description: project.$assignedFields.contains('description') ? project.description : description,
		projectType: project.$assignedFields.contains('projectType') ? project.projectType : projectType,
		propertyId: project.$assignedFields.contains('propertyId') ? project.propertyId : propertyId,
		address: project.$assignedFields.contains('address') ? project.address : address,
		status: project.$assignedFields.contains('status') ? project.status : status,
		startDate: project.$assignedFields.contains('startDate') ? project.startDate : startDate,
		estimatedEndDate: project.$assignedFields.contains('estimatedEndDate') ? project.estimatedEndDate : estimatedEndDate,
		actualEndDate: project.$assignedFields.contains('actualEndDate') ? project.actualEndDate : actualEndDate,
		budget: project.$assignedFields.contains('budget') ? project.budget : budget,
		currency: project.$assignedFields.contains('currency') ? project.currency : currency,
		actualCost: project.$assignedFields.contains('actualCost') ? project.actualCost : actualCost,
		managerId: project.$assignedFields.contains('managerId') ? project.managerId : managerId,
		contractorId: project.$assignedFields.contains('contractorId') ? project.contractorId : contractorId,
		milestones: project.$assignedFields.contains('milestones') ? project.milestones : milestones,
		phases: project.$assignedFields.contains('phases') ? project.phases : phases,
		createdBy: project.$assignedFields.contains('createdBy') ? project.createdBy : createdBy,
		createdAt: project.$assignedFields.contains('createdAt') ? project.createdAt : createdAt,
		updatedAt: project.$assignedFields.contains('updatedAt') ? project.updatedAt : updatedAt,
		deletedAt: project.$assignedFields.contains('deletedAt') ? project.deletedAt : deletedAt,
		contractor: project.$assignedFields.contains('contractor') ? project.contractor : contractor,
		manager: project.$assignedFields.contains('manager') ? project.manager : manager,
		org: project.$assignedFields.contains('org') ? project.org : org,
		property: project.$assignedFields.contains('property') ? project.property : property,
		tasks: (project.$assignedFields.contains('tasks') && project.tasks != null) ? mergeModelLists(tasks, project.tasks) : tasks,
		projectAlerts: (project.$assignedFields.contains('projectAlerts') && project.projectAlerts != null) ? mergeModelLists(projectAlerts, project.projectAlerts) : projectAlerts,
		projectAnalytics: (project.$assignedFields.contains('projectAnalytics') && project.projectAnalytics != null) ? mergeModelLists(projectAnalytics, project.projectAnalytics) : projectAnalytics,
		projectReports: (project.$assignedFields.contains('projectReports') && project.projectReports != null) ? mergeModelLists(projectReports, project.projectReports) : projectReports,
		$tasksCount: project.$tasksCount ?? $tasksCount,
		$projectAlertsCount: project.$projectAlertsCount ?? $projectAlertsCount,
		$projectAnalyticsCount: project.$projectAnalyticsCount ?? $projectAnalyticsCount,
		$projectReportsCount: project.$projectReportsCount ?? $projectReportsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Project updateWithInstanceValues(Project project) {
        if (project.$assignedFields.contains('id')) { id = project.id; }
		if (project.$assignedFields.contains('orgId')) { orgId = project.orgId; }
		if (project.$assignedFields.contains('name')) { name = project.name; }
		if (project.$assignedFields.contains('description')) { description = project.description; }
		if (project.$assignedFields.contains('projectType')) { projectType = project.projectType; }
		if (project.$assignedFields.contains('propertyId')) { propertyId = project.propertyId; }
		if (project.$assignedFields.contains('address')) { address = project.address; }
		if (project.$assignedFields.contains('status')) { status = project.status; }
		if (project.$assignedFields.contains('startDate')) { startDate = project.startDate; }
		if (project.$assignedFields.contains('estimatedEndDate')) { estimatedEndDate = project.estimatedEndDate; }
		if (project.$assignedFields.contains('actualEndDate')) { actualEndDate = project.actualEndDate; }
		if (project.$assignedFields.contains('budget')) { budget = project.budget; }
		if (project.$assignedFields.contains('currency')) { currency = project.currency; }
		if (project.$assignedFields.contains('actualCost')) { actualCost = project.actualCost; }
		if (project.$assignedFields.contains('managerId')) { managerId = project.managerId; }
		if (project.$assignedFields.contains('contractorId')) { contractorId = project.contractorId; }
		if (project.$assignedFields.contains('milestones')) { milestones = project.milestones; }
		if (project.$assignedFields.contains('phases')) { phases = project.phases; }
		if (project.$assignedFields.contains('createdBy')) { createdBy = project.createdBy; }
		if (project.$assignedFields.contains('createdAt')) { createdAt = project.createdAt; }
		if (project.$assignedFields.contains('updatedAt')) { updatedAt = project.updatedAt; }
		if (project.$assignedFields.contains('deletedAt')) { deletedAt = project.deletedAt; }
		if (project.$assignedFields.contains('contractor')) { contractor = project.contractor; }
		if (project.$assignedFields.contains('manager')) { manager = project.manager; }
		if (project.$assignedFields.contains('org')) { org = project.org; }
		if (project.$assignedFields.contains('property')) { property = project.property; }
		if (project.$assignedFields.contains('tasks') && project.tasks != null) { tasks = mergeModelLists(tasks, project.tasks); }
		if (project.$assignedFields.contains('projectAlerts') && project.projectAlerts != null) { projectAlerts = mergeModelLists(projectAlerts, project.projectAlerts); }
		if (project.$assignedFields.contains('projectAnalytics') && project.projectAnalytics != null) { projectAnalytics = mergeModelLists(projectAnalytics, project.projectAnalytics); }
		if (project.$assignedFields.contains('projectReports') && project.projectReports != null) { projectReports = mergeModelLists(projectReports, project.projectReports); }
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
          ? {...?serializedTypes, 'Project'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(projectType != null) 'projectType': projectType,
	if(propertyId != null) 'propertyId': propertyId,
	if(address != null) 'address': address,
	if(status != null) 'status': status,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(estimatedEndDate != null) 'estimatedEndDate': estimatedEndDate?.toIso8601String(),
	if(actualEndDate != null) 'actualEndDate': actualEndDate?.toIso8601String(),
	if(budget != null) 'budget': budget,
	if(currency != null) 'currency': currency,
	if(actualCost != null) 'actualCost': actualCost,
	if(managerId != null) 'managerId': managerId,
	if(contractorId != null) 'contractorId': contractorId,
	if(milestones != null) 'milestones': milestones,
	if(phases != null) 'phases': phases,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contractor != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contractor': contractor?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(manager != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'manager': manager?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(projectAlerts != null && (!preventCircularSerialization || !serializedModels.contains('ProjectAlert'))) 'projectAlerts': projectAlerts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(projectAnalytics != null && (!preventCircularSerialization || !serializedModels.contains('ProjectAnalytics'))) 'projectAnalytics': projectAnalytics?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(projectReports != null && (!preventCircularSerialization || !serializedModels.contains('ProjectReport'))) 'projectReports': projectReports?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($tasksCount != null || $projectAlertsCount != null || $projectAnalyticsCount != null || $projectReportsCount != null) '_count': { 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($projectAlertsCount != null) 'projectAlerts': $projectAlertsCount, 
		if ($projectAnalyticsCount != null) 'projectAnalytics': $projectAnalyticsCount, 
		if ($projectReportsCount != null) 'projectReports': $projectReportsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Project &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    