
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'project.dart';


class ProjectAlert implements PrismaModel<String, ProjectAlert> , Id<String> {
    @override
String? id;
	String? projectId;
	Project? project;
	String? alertType;
	String? title;
	String? message;
	String? severity;
	bool? isRead;
	bool? isResolved;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? resolvedAt;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ProjectAlert({ this.id,
	 this.projectId,
	 this.project,
	 this.alertType,
	 this.title,
	 this.message,
	 this.severity,
	 this.isRead = false,
	 this.isResolved = false,
	 this.createdAt,
	 this.updatedAt,
	 this.resolvedAt,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ProjectAlert, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"projectId": (m) => m.projectId,

	"project": (m) => m.project,

	"alertType": (m) => m.alertType,

	"title": (m) => m.title,

	"message": (m) => m.message,

	"severity": (m) => m.severity,

	"isRead": (m) => m.isRead,

	"isResolved": (m) => m.isResolved,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"resolvedAt": (m) => m.resolvedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ProjectAlert) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ProjectAlert');
    }
    return propFunction as V? Function(ProjectAlert);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ProjectAlert.fromJson(JsonMap json) =>
      ProjectAlert(
        id: json['id'] as String?,
	projectId: json['projectId'] as String?,
	project: json['project'] != null ? Project.fromJson(json['project'] as JsonMap) : null,
	alertType: json['alertType'] as String?,
	title: json['title'] as String?,
	message: json['message'] as String?,
	severity: json['severity'] as String?,
	isRead: json['isRead'] as bool?,
	isResolved: json['isResolved'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt']) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ProjectAlert copyWith({
        Value<String?>? id,
		Value<String?>? projectId,
		Value<Project?>? project,
		Value<String?>? alertType,
		Value<String?>? title,
		Value<String?>? message,
		Value<String?>? severity,
		Value<bool?>? isRead,
		Value<bool?>? isResolved,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? resolvedAt,
        }) {
        return ProjectAlert(
            id: id != null ? id.value : this.id,
		projectId: projectId != null ? projectId.value : this.projectId,
		project: project != null ? project.value : this.project,
		alertType: alertType != null ? alertType.value : this.alertType,
		title: title != null ? title.value : this.title,
		message: message != null ? message.value : this.message,
		severity: severity != null ? severity.value : this.severity,
		isRead: isRead != null ? isRead.value : this.isRead,
		isResolved: isResolved != null ? isResolved.value : this.isResolved,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		resolvedAt: resolvedAt != null ? resolvedAt.value : this.resolvedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ProjectAlert copyWithInstanceValues(ProjectAlert projectAlert) {
        return ProjectAlert(
            id: projectAlert.id ?? id,
		projectId: projectAlert.projectId ?? projectId,
		project: projectAlert.project ?? project,
		alertType: projectAlert.alertType ?? alertType,
		title: projectAlert.title ?? title,
		message: projectAlert.message ?? message,
		severity: projectAlert.severity ?? severity,
		isRead: projectAlert.isRead ?? isRead,
		isResolved: projectAlert.isResolved ?? isResolved,
		createdAt: projectAlert.createdAt ?? createdAt,
		updatedAt: projectAlert.updatedAt ?? updatedAt,
		resolvedAt: projectAlert.resolvedAt ?? resolvedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ProjectAlert mergeWithInstanceValues(ProjectAlert projectAlert) {
        return ProjectAlert(
            id: projectAlert.$assignedFields.contains('id') ? projectAlert.id : id,
		projectId: projectAlert.$assignedFields.contains('projectId') ? projectAlert.projectId : projectId,
		project: projectAlert.$assignedFields.contains('project') ? projectAlert.project : project,
		alertType: projectAlert.$assignedFields.contains('alertType') ? projectAlert.alertType : alertType,
		title: projectAlert.$assignedFields.contains('title') ? projectAlert.title : title,
		message: projectAlert.$assignedFields.contains('message') ? projectAlert.message : message,
		severity: projectAlert.$assignedFields.contains('severity') ? projectAlert.severity : severity,
		isRead: projectAlert.$assignedFields.contains('isRead') ? projectAlert.isRead : isRead,
		isResolved: projectAlert.$assignedFields.contains('isResolved') ? projectAlert.isResolved : isResolved,
		createdAt: projectAlert.$assignedFields.contains('createdAt') ? projectAlert.createdAt : createdAt,
		updatedAt: projectAlert.$assignedFields.contains('updatedAt') ? projectAlert.updatedAt : updatedAt,
		resolvedAt: projectAlert.$assignedFields.contains('resolvedAt') ? projectAlert.resolvedAt : resolvedAt
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ProjectAlert updateWithInstanceValues(ProjectAlert projectAlert) {
        if (projectAlert.$assignedFields.contains('id')) { id = projectAlert.id; }
		if (projectAlert.$assignedFields.contains('projectId')) { projectId = projectAlert.projectId; }
		if (projectAlert.$assignedFields.contains('project')) { project = projectAlert.project; }
		if (projectAlert.$assignedFields.contains('alertType')) { alertType = projectAlert.alertType; }
		if (projectAlert.$assignedFields.contains('title')) { title = projectAlert.title; }
		if (projectAlert.$assignedFields.contains('message')) { message = projectAlert.message; }
		if (projectAlert.$assignedFields.contains('severity')) { severity = projectAlert.severity; }
		if (projectAlert.$assignedFields.contains('isRead')) { isRead = projectAlert.isRead; }
		if (projectAlert.$assignedFields.contains('isResolved')) { isResolved = projectAlert.isResolved; }
		if (projectAlert.$assignedFields.contains('createdAt')) { createdAt = projectAlert.createdAt; }
		if (projectAlert.$assignedFields.contains('updatedAt')) { updatedAt = projectAlert.updatedAt; }
		if (projectAlert.$assignedFields.contains('resolvedAt')) { resolvedAt = projectAlert.resolvedAt; }
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
          ? {...?serializedTypes, 'ProjectAlert'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(projectId != null) 'projectId': projectId,
	if(project != null && (!preventCircularSerialization || !serializedModels.contains('Project'))) 'project': project?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(alertType != null) 'alertType': alertType,
	if(title != null) 'title': title,
	if(message != null) 'message': message,
	if(severity != null) 'severity': severity,
	if(isRead != null) 'isRead': isRead,
	if(isResolved != null) 'isResolved': isResolved,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(resolvedAt != null) 'resolvedAt': resolvedAt?.toIso8601String()
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ProjectAlert &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    