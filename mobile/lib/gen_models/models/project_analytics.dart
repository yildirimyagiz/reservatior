
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'project.dart';


class ProjectAnalytics implements PrismaModel<String, ProjectAnalytics> , Id<String> {
    @override
String? id;
	String? projectId;
	Project? project;
	String? analysisType;
	dynamic analysisData;
	List<String>? insights;
	List<String>? recommendations;
	double? score;
	DateTime? createdAt;
	DateTime? updatedAt;
	int? $insightsCount;
	int? $recommendationsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ProjectAnalytics({ this.id,
	 this.projectId,
	 this.project,
	 this.analysisType,
	required this.analysisData,
	 this.insights,
	 this.recommendations,
	 this.score,
	 this.createdAt,
	 this.updatedAt,
	this.$insightsCount,
	this.$recommendationsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ProjectAnalytics, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"projectId": (m) => m.projectId,

	"project": (m) => m.project,

	"analysisType": (m) => m.analysisType,

	"analysisData": (m) => m.analysisData,

	"insights": (m) => m.insights,

	"recommendations": (m) => m.recommendations,

	"score": (m) => m.score,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ProjectAnalytics) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ProjectAnalytics');
    }
    return propFunction as V? Function(ProjectAnalytics);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ProjectAnalytics.fromJson(JsonMap json) =>
      ProjectAnalytics(
        id: json['id'] as String?,
	projectId: json['projectId'] as String?,
	project: json['project'] != null ? Project.fromJson(json['project'] as JsonMap) : null,
	analysisType: json['analysisType'] as String?,
	analysisData: json['analysisData'] as dynamic,
	insights: json['insights'] != null ? (json['insights'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	recommendations: json['recommendations'] != null ? (json['recommendations'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	score: json['score']?.toDouble(),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	$insightsCount: json['_count']?['insights'] as int?,
	$recommendationsCount: json['_count']?['recommendations'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ProjectAnalytics copyWith({
        Value<String?>? id,
		Value<String?>? projectId,
		Value<Project?>? project,
		Value<String?>? analysisType,
		Value<dynamic>? analysisData,
		Value<List<String>?>? insights,
		Value<List<String>?>? recommendations,
		Value<double?>? score,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		int? $insightsCount,
		int? $recommendationsCount,
        }) {
        return ProjectAnalytics(
            id: id != null ? id.value : this.id,
		projectId: projectId != null ? projectId.value : this.projectId,
		project: project != null ? project.value : this.project,
		analysisType: analysisType != null ? analysisType.value : this.analysisType,
		analysisData: analysisData != null ? analysisData.value : this.analysisData,
		insights: insights != null ? insights.value : this.insights,
		recommendations: recommendations != null ? recommendations.value : this.recommendations,
		score: score != null ? score.value : this.score,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		$insightsCount: $insightsCount ?? this.$insightsCount,
		$recommendationsCount: $recommendationsCount ?? this.$recommendationsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ProjectAnalytics copyWithInstanceValues(ProjectAnalytics projectAnalytics) {
        return ProjectAnalytics(
            id: projectAnalytics.id ?? id,
		projectId: projectAnalytics.projectId ?? projectId,
		project: projectAnalytics.project ?? project,
		analysisType: projectAnalytics.analysisType ?? analysisType,
		analysisData: projectAnalytics.analysisData ?? analysisData,
		insights: projectAnalytics.insights ?? insights,
		recommendations: projectAnalytics.recommendations ?? recommendations,
		score: projectAnalytics.score ?? score,
		createdAt: projectAnalytics.createdAt ?? createdAt,
		updatedAt: projectAnalytics.updatedAt ?? updatedAt,
		$insightsCount: projectAnalytics.$insightsCount ?? $insightsCount,
		$recommendationsCount: projectAnalytics.$recommendationsCount ?? $recommendationsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ProjectAnalytics mergeWithInstanceValues(ProjectAnalytics projectAnalytics) {
        return ProjectAnalytics(
            id: projectAnalytics.$assignedFields.contains('id') ? projectAnalytics.id : id,
		projectId: projectAnalytics.$assignedFields.contains('projectId') ? projectAnalytics.projectId : projectId,
		project: projectAnalytics.$assignedFields.contains('project') ? projectAnalytics.project : project,
		analysisType: projectAnalytics.$assignedFields.contains('analysisType') ? projectAnalytics.analysisType : analysisType,
		analysisData: projectAnalytics.$assignedFields.contains('analysisData') ? projectAnalytics.analysisData : analysisData,
		insights: projectAnalytics.$assignedFields.contains('insights') ? projectAnalytics.insights : insights,
		recommendations: projectAnalytics.$assignedFields.contains('recommendations') ? projectAnalytics.recommendations : recommendations,
		score: projectAnalytics.$assignedFields.contains('score') ? projectAnalytics.score : score,
		createdAt: projectAnalytics.$assignedFields.contains('createdAt') ? projectAnalytics.createdAt : createdAt,
		updatedAt: projectAnalytics.$assignedFields.contains('updatedAt') ? projectAnalytics.updatedAt : updatedAt,
		$insightsCount: projectAnalytics.$insightsCount ?? $insightsCount,
		$recommendationsCount: projectAnalytics.$recommendationsCount ?? $recommendationsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ProjectAnalytics updateWithInstanceValues(ProjectAnalytics projectAnalytics) {
        if (projectAnalytics.$assignedFields.contains('id')) { id = projectAnalytics.id; }
		if (projectAnalytics.$assignedFields.contains('projectId')) { projectId = projectAnalytics.projectId; }
		if (projectAnalytics.$assignedFields.contains('project')) { project = projectAnalytics.project; }
		if (projectAnalytics.$assignedFields.contains('analysisType')) { analysisType = projectAnalytics.analysisType; }
		if (projectAnalytics.$assignedFields.contains('analysisData')) { analysisData = projectAnalytics.analysisData; }
		if (projectAnalytics.$assignedFields.contains('insights')) { insights = projectAnalytics.insights; }
		if (projectAnalytics.$assignedFields.contains('recommendations')) { recommendations = projectAnalytics.recommendations; }
		if (projectAnalytics.$assignedFields.contains('score')) { score = projectAnalytics.score; }
		if (projectAnalytics.$assignedFields.contains('createdAt')) { createdAt = projectAnalytics.createdAt; }
		if (projectAnalytics.$assignedFields.contains('updatedAt')) { updatedAt = projectAnalytics.updatedAt; }
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
          ? {...?serializedTypes, 'ProjectAnalytics'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(projectId != null) 'projectId': projectId,
	if(project != null && (!preventCircularSerialization || !serializedModels.contains('Project'))) 'project': project?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(analysisType != null) 'analysisType': analysisType,
	if(analysisData != null) 'analysisData': analysisData,
	if(insights != null) 'insights': insights,
	if(recommendations != null) 'recommendations': recommendations,
	if(score != null) 'score': score,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
		if ($insightsCount != null || $recommendationsCount != null) '_count': { 
		if ($insightsCount != null) 'insights': $insightsCount, 
		if ($recommendationsCount != null) 'recommendations': $recommendationsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ProjectAnalytics &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    