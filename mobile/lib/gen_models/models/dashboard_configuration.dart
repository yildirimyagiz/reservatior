
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';


class DashboardConfiguration implements PrismaModel<String, DashboardConfiguration> , Id<String> {
    @override
String? id;
	String? userId;
	String? orgId;
	String? dashboardName;
	bool? isDefault;
	dynamic layout;
	dynamic widgets;
	dynamic filters;
	String? timeRange;
	bool? isPublic;
	List<String>? sharedWith;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;
	User? user;
	int? $sharedWithCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    DashboardConfiguration({ this.id,
	 this.userId,
	 this.orgId,
	 this.dashboardName,
	 this.isDefault = false,
	required this.layout,
	required this.widgets,
	required this.filters,
	 this.timeRange = "LAST_30_DAYS",
	 this.isPublic = false,
	 this.sharedWith,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
	 this.user,
	this.$sharedWithCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<DashboardConfiguration, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"orgId": (m) => m.orgId,

	"dashboardName": (m) => m.dashboardName,

	"isDefault": (m) => m.isDefault,

	"layout": (m) => m.layout,

	"widgets": (m) => m.widgets,

	"filters": (m) => m.filters,

	"timeRange": (m) => m.timeRange,

	"isPublic": (m) => m.isPublic,

	"sharedWith": (m) => m.sharedWith,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(DashboardConfiguration) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in DashboardConfiguration');
    }
    return propFunction as V? Function(DashboardConfiguration);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory DashboardConfiguration.fromJson(JsonMap json) =>
      DashboardConfiguration(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	orgId: json['orgId'] as String?,
	dashboardName: json['dashboardName'] as String?,
	isDefault: json['isDefault'] as bool?,
	layout: json['layout'] as dynamic,
	widgets: json['widgets'] as dynamic,
	filters: json['filters'] as dynamic,
	timeRange: json['timeRange'] as String?,
	isPublic: json['isPublic'] as bool?,
	sharedWith: json['sharedWith'] != null ? (json['sharedWith'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	$sharedWithCount: json['_count']?['sharedWith'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    DashboardConfiguration copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? orgId,
		Value<String?>? dashboardName,
		Value<bool?>? isDefault,
		Value<dynamic>? layout,
		Value<dynamic>? widgets,
		Value<dynamic>? filters,
		Value<String?>? timeRange,
		Value<bool?>? isPublic,
		Value<List<String>?>? sharedWith,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
		Value<User?>? user,
		int? $sharedWithCount,
        }) {
        return DashboardConfiguration(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		orgId: orgId != null ? orgId.value : this.orgId,
		dashboardName: dashboardName != null ? dashboardName.value : this.dashboardName,
		isDefault: isDefault != null ? isDefault.value : this.isDefault,
		layout: layout != null ? layout.value : this.layout,
		widgets: widgets != null ? widgets.value : this.widgets,
		filters: filters != null ? filters.value : this.filters,
		timeRange: timeRange != null ? timeRange.value : this.timeRange,
		isPublic: isPublic != null ? isPublic.value : this.isPublic,
		sharedWith: sharedWith != null ? sharedWith.value : this.sharedWith,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user,
		$sharedWithCount: $sharedWithCount ?? this.$sharedWithCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    DashboardConfiguration copyWithInstanceValues(DashboardConfiguration dashboardConfiguration) {
        return DashboardConfiguration(
            id: dashboardConfiguration.id ?? id,
		userId: dashboardConfiguration.userId ?? userId,
		orgId: dashboardConfiguration.orgId ?? orgId,
		dashboardName: dashboardConfiguration.dashboardName ?? dashboardName,
		isDefault: dashboardConfiguration.isDefault ?? isDefault,
		layout: dashboardConfiguration.layout ?? layout,
		widgets: dashboardConfiguration.widgets ?? widgets,
		filters: dashboardConfiguration.filters ?? filters,
		timeRange: dashboardConfiguration.timeRange ?? timeRange,
		isPublic: dashboardConfiguration.isPublic ?? isPublic,
		sharedWith: dashboardConfiguration.sharedWith ?? sharedWith,
		createdAt: dashboardConfiguration.createdAt ?? createdAt,
		updatedAt: dashboardConfiguration.updatedAt ?? updatedAt,
		org: dashboardConfiguration.org ?? org,
		user: dashboardConfiguration.user ?? user,
		$sharedWithCount: dashboardConfiguration.$sharedWithCount ?? $sharedWithCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    DashboardConfiguration mergeWithInstanceValues(DashboardConfiguration dashboardConfiguration) {
        return DashboardConfiguration(
            id: dashboardConfiguration.$assignedFields.contains('id') ? dashboardConfiguration.id : id,
		userId: dashboardConfiguration.$assignedFields.contains('userId') ? dashboardConfiguration.userId : userId,
		orgId: dashboardConfiguration.$assignedFields.contains('orgId') ? dashboardConfiguration.orgId : orgId,
		dashboardName: dashboardConfiguration.$assignedFields.contains('dashboardName') ? dashboardConfiguration.dashboardName : dashboardName,
		isDefault: dashboardConfiguration.$assignedFields.contains('isDefault') ? dashboardConfiguration.isDefault : isDefault,
		layout: dashboardConfiguration.$assignedFields.contains('layout') ? dashboardConfiguration.layout : layout,
		widgets: dashboardConfiguration.$assignedFields.contains('widgets') ? dashboardConfiguration.widgets : widgets,
		filters: dashboardConfiguration.$assignedFields.contains('filters') ? dashboardConfiguration.filters : filters,
		timeRange: dashboardConfiguration.$assignedFields.contains('timeRange') ? dashboardConfiguration.timeRange : timeRange,
		isPublic: dashboardConfiguration.$assignedFields.contains('isPublic') ? dashboardConfiguration.isPublic : isPublic,
		sharedWith: dashboardConfiguration.$assignedFields.contains('sharedWith') ? dashboardConfiguration.sharedWith : sharedWith,
		createdAt: dashboardConfiguration.$assignedFields.contains('createdAt') ? dashboardConfiguration.createdAt : createdAt,
		updatedAt: dashboardConfiguration.$assignedFields.contains('updatedAt') ? dashboardConfiguration.updatedAt : updatedAt,
		org: dashboardConfiguration.$assignedFields.contains('org') ? dashboardConfiguration.org : org,
		user: dashboardConfiguration.$assignedFields.contains('user') ? dashboardConfiguration.user : user,
		$sharedWithCount: dashboardConfiguration.$sharedWithCount ?? $sharedWithCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    DashboardConfiguration updateWithInstanceValues(DashboardConfiguration dashboardConfiguration) {
        if (dashboardConfiguration.$assignedFields.contains('id')) { id = dashboardConfiguration.id; }
		if (dashboardConfiguration.$assignedFields.contains('userId')) { userId = dashboardConfiguration.userId; }
		if (dashboardConfiguration.$assignedFields.contains('orgId')) { orgId = dashboardConfiguration.orgId; }
		if (dashboardConfiguration.$assignedFields.contains('dashboardName')) { dashboardName = dashboardConfiguration.dashboardName; }
		if (dashboardConfiguration.$assignedFields.contains('isDefault')) { isDefault = dashboardConfiguration.isDefault; }
		if (dashboardConfiguration.$assignedFields.contains('layout')) { layout = dashboardConfiguration.layout; }
		if (dashboardConfiguration.$assignedFields.contains('widgets')) { widgets = dashboardConfiguration.widgets; }
		if (dashboardConfiguration.$assignedFields.contains('filters')) { filters = dashboardConfiguration.filters; }
		if (dashboardConfiguration.$assignedFields.contains('timeRange')) { timeRange = dashboardConfiguration.timeRange; }
		if (dashboardConfiguration.$assignedFields.contains('isPublic')) { isPublic = dashboardConfiguration.isPublic; }
		if (dashboardConfiguration.$assignedFields.contains('sharedWith')) { sharedWith = dashboardConfiguration.sharedWith; }
		if (dashboardConfiguration.$assignedFields.contains('createdAt')) { createdAt = dashboardConfiguration.createdAt; }
		if (dashboardConfiguration.$assignedFields.contains('updatedAt')) { updatedAt = dashboardConfiguration.updatedAt; }
		if (dashboardConfiguration.$assignedFields.contains('org')) { org = dashboardConfiguration.org; }
		if (dashboardConfiguration.$assignedFields.contains('user')) { user = dashboardConfiguration.user; }
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
          ? {...?serializedTypes, 'DashboardConfiguration'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(orgId != null) 'orgId': orgId,
	if(dashboardName != null) 'dashboardName': dashboardName,
	if(isDefault != null) 'isDefault': isDefault,
	if(layout != null) 'layout': layout,
	if(widgets != null) 'widgets': widgets,
	if(filters != null) 'filters': filters,
	if(timeRange != null) 'timeRange': timeRange,
	if(isPublic != null) 'isPublic': isPublic,
	if(sharedWith != null) 'sharedWith': sharedWith,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($sharedWithCount != null) '_count': { 
		if ($sharedWithCount != null) 'sharedWith': $sharedWithCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is DashboardConfiguration &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    