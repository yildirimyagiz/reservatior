
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'project.dart';


class ProjectReport implements PrismaModel<String, ProjectReport> , Id<String> {
    @override
String? id;
	String? projectId;
	Project? project;
	String? reportType;
	String? title;
	String? content;
	dynamic data;
	String? generatedBy;
	DateTime? createdAt;
	DateTime? updatedAt;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ProjectReport({ this.id,
	 this.projectId,
	 this.project,
	 this.reportType,
	 this.title,
	 this.content,
	required this.data,
	 this.generatedBy,
	 this.createdAt,
	 this.updatedAt,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ProjectReport, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"projectId": (m) => m.projectId,

	"project": (m) => m.project,

	"reportType": (m) => m.reportType,

	"title": (m) => m.title,

	"content": (m) => m.content,

	"data": (m) => m.data,

	"generatedBy": (m) => m.generatedBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ProjectReport) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ProjectReport');
    }
    return propFunction as V? Function(ProjectReport);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ProjectReport.fromJson(JsonMap json) =>
      ProjectReport(
        id: json['id'] as String?,
	projectId: json['projectId'] as String?,
	project: json['project'] != null ? Project.fromJson(json['project'] as JsonMap) : null,
	reportType: json['reportType'] as String?,
	title: json['title'] as String?,
	content: json['content'] as String?,
	data: json['data'] as dynamic,
	generatedBy: json['generatedBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ProjectReport copyWith({
        Value<String?>? id,
		Value<String?>? projectId,
		Value<Project?>? project,
		Value<String?>? reportType,
		Value<String?>? title,
		Value<String?>? content,
		Value<dynamic>? data,
		Value<String?>? generatedBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
        }) {
        return ProjectReport(
            id: id != null ? id.value : this.id,
		projectId: projectId != null ? projectId.value : this.projectId,
		project: project != null ? project.value : this.project,
		reportType: reportType != null ? reportType.value : this.reportType,
		title: title != null ? title.value : this.title,
		content: content != null ? content.value : this.content,
		data: data != null ? data.value : this.data,
		generatedBy: generatedBy != null ? generatedBy.value : this.generatedBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ProjectReport copyWithInstanceValues(ProjectReport projectReport) {
        return ProjectReport(
            id: projectReport.id ?? id,
		projectId: projectReport.projectId ?? projectId,
		project: projectReport.project ?? project,
		reportType: projectReport.reportType ?? reportType,
		title: projectReport.title ?? title,
		content: projectReport.content ?? content,
		data: projectReport.data ?? data,
		generatedBy: projectReport.generatedBy ?? generatedBy,
		createdAt: projectReport.createdAt ?? createdAt,
		updatedAt: projectReport.updatedAt ?? updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ProjectReport mergeWithInstanceValues(ProjectReport projectReport) {
        return ProjectReport(
            id: projectReport.$assignedFields.contains('id') ? projectReport.id : id,
		projectId: projectReport.$assignedFields.contains('projectId') ? projectReport.projectId : projectId,
		project: projectReport.$assignedFields.contains('project') ? projectReport.project : project,
		reportType: projectReport.$assignedFields.contains('reportType') ? projectReport.reportType : reportType,
		title: projectReport.$assignedFields.contains('title') ? projectReport.title : title,
		content: projectReport.$assignedFields.contains('content') ? projectReport.content : content,
		data: projectReport.$assignedFields.contains('data') ? projectReport.data : data,
		generatedBy: projectReport.$assignedFields.contains('generatedBy') ? projectReport.generatedBy : generatedBy,
		createdAt: projectReport.$assignedFields.contains('createdAt') ? projectReport.createdAt : createdAt,
		updatedAt: projectReport.$assignedFields.contains('updatedAt') ? projectReport.updatedAt : updatedAt
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ProjectReport updateWithInstanceValues(ProjectReport projectReport) {
        if (projectReport.$assignedFields.contains('id')) { id = projectReport.id; }
		if (projectReport.$assignedFields.contains('projectId')) { projectId = projectReport.projectId; }
		if (projectReport.$assignedFields.contains('project')) { project = projectReport.project; }
		if (projectReport.$assignedFields.contains('reportType')) { reportType = projectReport.reportType; }
		if (projectReport.$assignedFields.contains('title')) { title = projectReport.title; }
		if (projectReport.$assignedFields.contains('content')) { content = projectReport.content; }
		if (projectReport.$assignedFields.contains('data')) { data = projectReport.data; }
		if (projectReport.$assignedFields.contains('generatedBy')) { generatedBy = projectReport.generatedBy; }
		if (projectReport.$assignedFields.contains('createdAt')) { createdAt = projectReport.createdAt; }
		if (projectReport.$assignedFields.contains('updatedAt')) { updatedAt = projectReport.updatedAt; }
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
          ? {...?serializedTypes, 'ProjectReport'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(projectId != null) 'projectId': projectId,
	if(project != null && (!preventCircularSerialization || !serializedModels.contains('Project'))) 'project': project?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(reportType != null) 'reportType': reportType,
	if(title != null) 'title': title,
	if(content != null) 'content': content,
	if(data != null) 'data': data,
	if(generatedBy != null) 'generatedBy': generatedBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String()
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ProjectReport &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    