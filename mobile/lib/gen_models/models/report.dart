
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';
import 'report_execution.dart';
import 'agent.dart';
import 'extra_charge.dart';
import 'agency.dart';
import 'reference_source.dart';
import 'tenant.dart';
import 'included_service.dart';


class Report implements PrismaModel<String, Report> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? name;
	String? description;
	String? reportType;
	dynamic config;
	dynamic schedule;
	dynamic recipients;
	DateTime? lastRunAt;
	bool? isActive;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	User? user;
	List<ReportExecution>? executions;
	List<Agent>? agents;
	List<ExtraCharge>? extraCharges;
	List<Agency>? agencies;
	List<ReferenceSource>? referenceSources;
	List<Tenant>? tenants;
	List<IncludedService>? includedServices;
	int? $executionsCount;
	int? $agentsCount;
	int? $extraChargesCount;
	int? $agenciesCount;
	int? $referenceSourcesCount;
	int? $tenantsCount;
	int? $includedServicesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Report({ this.id,
	 this.orgId,
	 this.userId,
	 this.name,
	 this.description,
	 this.reportType,
	required this.config,
	required this.schedule,
	required this.recipients,
	 this.lastRunAt,
	 this.isActive = true,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.user,
	 this.executions,
	 this.agents,
	 this.extraCharges,
	 this.agencies,
	 this.referenceSources,
	 this.tenants,
	 this.includedServices,
	this.$executionsCount,
	this.$agentsCount,
	this.$extraChargesCount,
	this.$agenciesCount,
	this.$referenceSourcesCount,
	this.$tenantsCount,
	this.$includedServicesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Report, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"reportType": (m) => m.reportType,

	"config": (m) => m.config,

	"schedule": (m) => m.schedule,

	"recipients": (m) => m.recipients,

	"lastRunAt": (m) => m.lastRunAt,

	"isActive": (m) => m.isActive,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,

	"executions": (m) => m.executions,

	"agents": (m) => m.agents,

	"extraCharges": (m) => m.extraCharges,

	"agencies": (m) => m.agencies,

	"referenceSources": (m) => m.referenceSources,

	"tenants": (m) => m.tenants,

	"includedServices": (m) => m.includedServices,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Report) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Report');
    }
    return propFunction as V? Function(Report);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Report.fromJson(JsonMap json) =>
      Report(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	reportType: json['reportType'] as String?,
	config: json['config'] as dynamic,
	schedule: json['schedule'] as dynamic,
	recipients: json['recipients'] as dynamic,
	lastRunAt: json['lastRunAt'] != null ? DateTime.parse(json['lastRunAt']) : null,
	isActive: json['isActive'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	executions: json['executions'] != null ? createModels<ReportExecution>((json['executions'] as List).cast<JsonMap>(), ReportExecution.fromJson) : null,
	agents: json['agents'] != null ? createModels<Agent>((json['agents'] as List).cast<JsonMap>(), Agent.fromJson) : null,
	extraCharges: json['extraCharges'] != null ? createModels<ExtraCharge>((json['extraCharges'] as List).cast<JsonMap>(), ExtraCharge.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	referenceSources: json['referenceSources'] != null ? createModels<ReferenceSource>((json['referenceSources'] as List).cast<JsonMap>(), ReferenceSource.fromJson) : null,
	tenants: json['tenants'] != null ? createModels<Tenant>((json['tenants'] as List).cast<JsonMap>(), Tenant.fromJson) : null,
	includedServices: json['includedServices'] != null ? createModels<IncludedService>((json['includedServices'] as List).cast<JsonMap>(), IncludedService.fromJson) : null,
	$executionsCount: json['_count']?['executions'] as int?,
	$agentsCount: json['_count']?['agents'] as int?,
	$extraChargesCount: json['_count']?['extraCharges'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$referenceSourcesCount: json['_count']?['referenceSources'] as int?,
	$tenantsCount: json['_count']?['tenants'] as int?,
	$includedServicesCount: json['_count']?['includedServices'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Report copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? name,
		Value<String?>? description,
		Value<String?>? reportType,
		Value<dynamic>? config,
		Value<dynamic>? schedule,
		Value<dynamic>? recipients,
		Value<DateTime?>? lastRunAt,
		Value<bool?>? isActive,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<User?>? user,
		Value<List<ReportExecution>?>? executions,
		Value<List<Agent>?>? agents,
		Value<List<ExtraCharge>?>? extraCharges,
		Value<List<Agency>?>? agencies,
		Value<List<ReferenceSource>?>? referenceSources,
		Value<List<Tenant>?>? tenants,
		Value<List<IncludedService>?>? includedServices,
		int? $executionsCount,
		int? $agentsCount,
		int? $extraChargesCount,
		int? $agenciesCount,
		int? $referenceSourcesCount,
		int? $tenantsCount,
		int? $includedServicesCount,
        }) {
        return Report(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		reportType: reportType != null ? reportType.value : this.reportType,
		config: config != null ? config.value : this.config,
		schedule: schedule != null ? schedule.value : this.schedule,
		recipients: recipients != null ? recipients.value : this.recipients,
		lastRunAt: lastRunAt != null ? lastRunAt.value : this.lastRunAt,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user,
		executions: executions != null ? executions.value : this.executions,
		agents: agents != null ? agents.value : this.agents,
		extraCharges: extraCharges != null ? extraCharges.value : this.extraCharges,
		agencies: agencies != null ? agencies.value : this.agencies,
		referenceSources: referenceSources != null ? referenceSources.value : this.referenceSources,
		tenants: tenants != null ? tenants.value : this.tenants,
		includedServices: includedServices != null ? includedServices.value : this.includedServices,
		$executionsCount: $executionsCount ?? this.$executionsCount,
		$agentsCount: $agentsCount ?? this.$agentsCount,
		$extraChargesCount: $extraChargesCount ?? this.$extraChargesCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$referenceSourcesCount: $referenceSourcesCount ?? this.$referenceSourcesCount,
		$tenantsCount: $tenantsCount ?? this.$tenantsCount,
		$includedServicesCount: $includedServicesCount ?? this.$includedServicesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Report copyWithInstanceValues(Report report) {
        return Report(
            id: report.id ?? id,
		orgId: report.orgId ?? orgId,
		userId: report.userId ?? userId,
		name: report.name ?? name,
		description: report.description ?? description,
		reportType: report.reportType ?? reportType,
		config: report.config ?? config,
		schedule: report.schedule ?? schedule,
		recipients: report.recipients ?? recipients,
		lastRunAt: report.lastRunAt ?? lastRunAt,
		isActive: report.isActive ?? isActive,
		createdAt: report.createdAt ?? createdAt,
		updatedAt: report.updatedAt ?? updatedAt,
		deletedAt: report.deletedAt ?? deletedAt,
		org: report.org ?? org,
		user: report.user ?? user,
		executions: report.executions ?? executions,
		agents: report.agents ?? agents,
		extraCharges: report.extraCharges ?? extraCharges,
		agencies: report.agencies ?? agencies,
		referenceSources: report.referenceSources ?? referenceSources,
		tenants: report.tenants ?? tenants,
		includedServices: report.includedServices ?? includedServices,
		$executionsCount: report.$executionsCount ?? $executionsCount,
		$agentsCount: report.$agentsCount ?? $agentsCount,
		$extraChargesCount: report.$extraChargesCount ?? $extraChargesCount,
		$agenciesCount: report.$agenciesCount ?? $agenciesCount,
		$referenceSourcesCount: report.$referenceSourcesCount ?? $referenceSourcesCount,
		$tenantsCount: report.$tenantsCount ?? $tenantsCount,
		$includedServicesCount: report.$includedServicesCount ?? $includedServicesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Report mergeWithInstanceValues(Report report) {
        return Report(
            id: report.$assignedFields.contains('id') ? report.id : id,
		orgId: report.$assignedFields.contains('orgId') ? report.orgId : orgId,
		userId: report.$assignedFields.contains('userId') ? report.userId : userId,
		name: report.$assignedFields.contains('name') ? report.name : name,
		description: report.$assignedFields.contains('description') ? report.description : description,
		reportType: report.$assignedFields.contains('reportType') ? report.reportType : reportType,
		config: report.$assignedFields.contains('config') ? report.config : config,
		schedule: report.$assignedFields.contains('schedule') ? report.schedule : schedule,
		recipients: report.$assignedFields.contains('recipients') ? report.recipients : recipients,
		lastRunAt: report.$assignedFields.contains('lastRunAt') ? report.lastRunAt : lastRunAt,
		isActive: report.$assignedFields.contains('isActive') ? report.isActive : isActive,
		createdAt: report.$assignedFields.contains('createdAt') ? report.createdAt : createdAt,
		updatedAt: report.$assignedFields.contains('updatedAt') ? report.updatedAt : updatedAt,
		deletedAt: report.$assignedFields.contains('deletedAt') ? report.deletedAt : deletedAt,
		org: report.$assignedFields.contains('org') ? report.org : org,
		user: report.$assignedFields.contains('user') ? report.user : user,
		executions: (report.$assignedFields.contains('executions') && report.executions != null) ? mergeModelLists(executions, report.executions) : executions,
		agents: (report.$assignedFields.contains('agents') && report.agents != null) ? mergeModelLists(agents, report.agents) : agents,
		extraCharges: (report.$assignedFields.contains('extraCharges') && report.extraCharges != null) ? mergeModelLists(extraCharges, report.extraCharges) : extraCharges,
		agencies: (report.$assignedFields.contains('agencies') && report.agencies != null) ? mergeModelLists(agencies, report.agencies) : agencies,
		referenceSources: (report.$assignedFields.contains('referenceSources') && report.referenceSources != null) ? mergeModelLists(referenceSources, report.referenceSources) : referenceSources,
		tenants: (report.$assignedFields.contains('tenants') && report.tenants != null) ? mergeModelLists(tenants, report.tenants) : tenants,
		includedServices: (report.$assignedFields.contains('includedServices') && report.includedServices != null) ? mergeModelLists(includedServices, report.includedServices) : includedServices,
		$executionsCount: report.$executionsCount ?? $executionsCount,
		$agentsCount: report.$agentsCount ?? $agentsCount,
		$extraChargesCount: report.$extraChargesCount ?? $extraChargesCount,
		$agenciesCount: report.$agenciesCount ?? $agenciesCount,
		$referenceSourcesCount: report.$referenceSourcesCount ?? $referenceSourcesCount,
		$tenantsCount: report.$tenantsCount ?? $tenantsCount,
		$includedServicesCount: report.$includedServicesCount ?? $includedServicesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Report updateWithInstanceValues(Report report) {
        if (report.$assignedFields.contains('id')) { id = report.id; }
		if (report.$assignedFields.contains('orgId')) { orgId = report.orgId; }
		if (report.$assignedFields.contains('userId')) { userId = report.userId; }
		if (report.$assignedFields.contains('name')) { name = report.name; }
		if (report.$assignedFields.contains('description')) { description = report.description; }
		if (report.$assignedFields.contains('reportType')) { reportType = report.reportType; }
		if (report.$assignedFields.contains('config')) { config = report.config; }
		if (report.$assignedFields.contains('schedule')) { schedule = report.schedule; }
		if (report.$assignedFields.contains('recipients')) { recipients = report.recipients; }
		if (report.$assignedFields.contains('lastRunAt')) { lastRunAt = report.lastRunAt; }
		if (report.$assignedFields.contains('isActive')) { isActive = report.isActive; }
		if (report.$assignedFields.contains('createdAt')) { createdAt = report.createdAt; }
		if (report.$assignedFields.contains('updatedAt')) { updatedAt = report.updatedAt; }
		if (report.$assignedFields.contains('deletedAt')) { deletedAt = report.deletedAt; }
		if (report.$assignedFields.contains('org')) { org = report.org; }
		if (report.$assignedFields.contains('user')) { user = report.user; }
		if (report.$assignedFields.contains('executions') && report.executions != null) { executions = mergeModelLists(executions, report.executions); }
		if (report.$assignedFields.contains('agents') && report.agents != null) { agents = mergeModelLists(agents, report.agents); }
		if (report.$assignedFields.contains('extraCharges') && report.extraCharges != null) { extraCharges = mergeModelLists(extraCharges, report.extraCharges); }
		if (report.$assignedFields.contains('agencies') && report.agencies != null) { agencies = mergeModelLists(agencies, report.agencies); }
		if (report.$assignedFields.contains('referenceSources') && report.referenceSources != null) { referenceSources = mergeModelLists(referenceSources, report.referenceSources); }
		if (report.$assignedFields.contains('tenants') && report.tenants != null) { tenants = mergeModelLists(tenants, report.tenants); }
		if (report.$assignedFields.contains('includedServices') && report.includedServices != null) { includedServices = mergeModelLists(includedServices, report.includedServices); }
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
          ? {...?serializedTypes, 'Report'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(reportType != null) 'reportType': reportType,
	if(config != null) 'config': config,
	if(schedule != null) 'schedule': schedule,
	if(recipients != null) 'recipients': recipients,
	if(lastRunAt != null) 'lastRunAt': lastRunAt?.toIso8601String(),
	if(isActive != null) 'isActive': isActive,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(executions != null && (!preventCircularSerialization || !serializedModels.contains('ReportExecution'))) 'executions': executions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agents != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'agents': agents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(extraCharges != null && (!preventCircularSerialization || !serializedModels.contains('ExtraCharge'))) 'extraCharges': extraCharges?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(referenceSources != null && (!preventCircularSerialization || !serializedModels.contains('ReferenceSource'))) 'referenceSources': referenceSources?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tenants != null && (!preventCircularSerialization || !serializedModels.contains('Tenant'))) 'tenants': tenants?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(includedServices != null && (!preventCircularSerialization || !serializedModels.contains('IncludedService'))) 'includedServices': includedServices?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($executionsCount != null || $agentsCount != null || $extraChargesCount != null || $agenciesCount != null || $referenceSourcesCount != null || $tenantsCount != null || $includedServicesCount != null) '_count': { 
		if ($executionsCount != null) 'executions': $executionsCount, 
		if ($agentsCount != null) 'agents': $agentsCount, 
		if ($extraChargesCount != null) 'extraCharges': $extraChargesCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($referenceSourcesCount != null) 'referenceSources': $referenceSourcesCount, 
		if ($tenantsCount != null) 'tenants': $tenantsCount, 
		if ($includedServicesCount != null) 'includedServices': $includedServicesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Report &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    