
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'widget_type.dart';
import 'organization.dart';
import 'user.dart';


class DashboardWidget implements PrismaModel<String, DashboardWidget> , Id<String> {
    @override
String? id;
	String? userId;
	String? orgId;
	WidgetType? widgetType;
	String? title;
	dynamic config;
	dynamic position;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    DashboardWidget({ this.id,
	 this.userId,
	 this.orgId,
	 this.widgetType,
	 this.title,
	required this.config,
	required this.position,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<DashboardWidget, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"orgId": (m) => m.orgId,

	"widgetType": (m) => m.widgetType,

	"title": (m) => m.title,

	"config": (m) => m.config,

	"position": (m) => m.position,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(DashboardWidget) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in DashboardWidget');
    }
    return propFunction as V? Function(DashboardWidget);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory DashboardWidget.fromJson(JsonMap json) =>
      DashboardWidget(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	orgId: json['orgId'] as String?,
	widgetType: json['widgetType'] != null ? WidgetType.fromJson(json['widgetType']) : null,
	title: json['title'] as String?,
	config: json['config'] as dynamic,
	position: json['position'] as dynamic,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    DashboardWidget copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? orgId,
		Value<WidgetType?>? widgetType,
		Value<String?>? title,
		Value<dynamic>? config,
		Value<dynamic>? position,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return DashboardWidget(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		orgId: orgId != null ? orgId.value : this.orgId,
		widgetType: widgetType != null ? widgetType.value : this.widgetType,
		title: title != null ? title.value : this.title,
		config: config != null ? config.value : this.config,
		position: position != null ? position.value : this.position,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    DashboardWidget copyWithInstanceValues(DashboardWidget dashboardWidget) {
        return DashboardWidget(
            id: dashboardWidget.id ?? id,
		userId: dashboardWidget.userId ?? userId,
		orgId: dashboardWidget.orgId ?? orgId,
		widgetType: dashboardWidget.widgetType ?? widgetType,
		title: dashboardWidget.title ?? title,
		config: dashboardWidget.config ?? config,
		position: dashboardWidget.position ?? position,
		org: dashboardWidget.org ?? org,
		user: dashboardWidget.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    DashboardWidget mergeWithInstanceValues(DashboardWidget dashboardWidget) {
        return DashboardWidget(
            id: dashboardWidget.$assignedFields.contains('id') ? dashboardWidget.id : id,
		userId: dashboardWidget.$assignedFields.contains('userId') ? dashboardWidget.userId : userId,
		orgId: dashboardWidget.$assignedFields.contains('orgId') ? dashboardWidget.orgId : orgId,
		widgetType: dashboardWidget.$assignedFields.contains('widgetType') ? dashboardWidget.widgetType : widgetType,
		title: dashboardWidget.$assignedFields.contains('title') ? dashboardWidget.title : title,
		config: dashboardWidget.$assignedFields.contains('config') ? dashboardWidget.config : config,
		position: dashboardWidget.$assignedFields.contains('position') ? dashboardWidget.position : position,
		org: dashboardWidget.$assignedFields.contains('org') ? dashboardWidget.org : org,
		user: dashboardWidget.$assignedFields.contains('user') ? dashboardWidget.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    DashboardWidget updateWithInstanceValues(DashboardWidget dashboardWidget) {
        if (dashboardWidget.$assignedFields.contains('id')) { id = dashboardWidget.id; }
		if (dashboardWidget.$assignedFields.contains('userId')) { userId = dashboardWidget.userId; }
		if (dashboardWidget.$assignedFields.contains('orgId')) { orgId = dashboardWidget.orgId; }
		if (dashboardWidget.$assignedFields.contains('widgetType')) { widgetType = dashboardWidget.widgetType; }
		if (dashboardWidget.$assignedFields.contains('title')) { title = dashboardWidget.title; }
		if (dashboardWidget.$assignedFields.contains('config')) { config = dashboardWidget.config; }
		if (dashboardWidget.$assignedFields.contains('position')) { position = dashboardWidget.position; }
		if (dashboardWidget.$assignedFields.contains('org')) { org = dashboardWidget.org; }
		if (dashboardWidget.$assignedFields.contains('user')) { user = dashboardWidget.user; }
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
          ? {...?serializedTypes, 'DashboardWidget'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(orgId != null) 'orgId': orgId,
	if(widgetType != null) 'widgetType': widgetType?.toJson(),
	if(title != null) 'title': title,
	if(config != null) 'config': config,
	if(position != null) 'position': position,
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is DashboardWidget &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    