
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';


class ScrapingJob implements PrismaModel<String, ScrapingJob> , Id<String> {
    @override
String? id;
	String? jobType;
	String? status;
	DateTime? startTime;
	DateTime? endTime;
	int? projectsScraped;
	List<String>? errors;
	dynamic configuration;
	DateTime? createdAt;
	DateTime? updatedAt;
	int? $errorsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ScrapingJob({ this.id,
	 this.jobType,
	 this.status,
	 this.startTime,
	 this.endTime,
	 this.projectsScraped = 0,
	 this.errors,
	required this.configuration,
	 this.createdAt,
	 this.updatedAt,
	this.$errorsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ScrapingJob, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"jobType": (m) => m.jobType,

	"status": (m) => m.status,

	"startTime": (m) => m.startTime,

	"endTime": (m) => m.endTime,

	"projectsScraped": (m) => m.projectsScraped,

	"errors": (m) => m.errors,

	"configuration": (m) => m.configuration,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ScrapingJob) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ScrapingJob');
    }
    return propFunction as V? Function(ScrapingJob);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ScrapingJob.fromJson(JsonMap json) =>
      ScrapingJob(
        id: json['id'] as String?,
	jobType: json['jobType'] as String?,
	status: json['status'] as String?,
	startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
	endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
	projectsScraped: int.tryParse(json['projectsScraped'].toString()),
	errors: json['errors'] != null ? (json['errors'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	configuration: json['configuration'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	$errorsCount: json['_count']?['errors'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ScrapingJob copyWith({
        Value<String?>? id,
		Value<String?>? jobType,
		Value<String?>? status,
		Value<DateTime?>? startTime,
		Value<DateTime?>? endTime,
		Value<int?>? projectsScraped,
		Value<List<String>?>? errors,
		Value<dynamic>? configuration,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		int? $errorsCount,
        }) {
        return ScrapingJob(
            id: id != null ? id.value : this.id,
		jobType: jobType != null ? jobType.value : this.jobType,
		status: status != null ? status.value : this.status,
		startTime: startTime != null ? startTime.value : this.startTime,
		endTime: endTime != null ? endTime.value : this.endTime,
		projectsScraped: projectsScraped != null ? projectsScraped.value : this.projectsScraped,
		errors: errors != null ? errors.value : this.errors,
		configuration: configuration != null ? configuration.value : this.configuration,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		$errorsCount: $errorsCount ?? this.$errorsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ScrapingJob copyWithInstanceValues(ScrapingJob scrapingJob) {
        return ScrapingJob(
            id: scrapingJob.id ?? id,
		jobType: scrapingJob.jobType ?? jobType,
		status: scrapingJob.status ?? status,
		startTime: scrapingJob.startTime ?? startTime,
		endTime: scrapingJob.endTime ?? endTime,
		projectsScraped: scrapingJob.projectsScraped ?? projectsScraped,
		errors: scrapingJob.errors ?? errors,
		configuration: scrapingJob.configuration ?? configuration,
		createdAt: scrapingJob.createdAt ?? createdAt,
		updatedAt: scrapingJob.updatedAt ?? updatedAt,
		$errorsCount: scrapingJob.$errorsCount ?? $errorsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ScrapingJob mergeWithInstanceValues(ScrapingJob scrapingJob) {
        return ScrapingJob(
            id: scrapingJob.$assignedFields.contains('id') ? scrapingJob.id : id,
		jobType: scrapingJob.$assignedFields.contains('jobType') ? scrapingJob.jobType : jobType,
		status: scrapingJob.$assignedFields.contains('status') ? scrapingJob.status : status,
		startTime: scrapingJob.$assignedFields.contains('startTime') ? scrapingJob.startTime : startTime,
		endTime: scrapingJob.$assignedFields.contains('endTime') ? scrapingJob.endTime : endTime,
		projectsScraped: scrapingJob.$assignedFields.contains('projectsScraped') ? scrapingJob.projectsScraped : projectsScraped,
		errors: scrapingJob.$assignedFields.contains('errors') ? scrapingJob.errors : errors,
		configuration: scrapingJob.$assignedFields.contains('configuration') ? scrapingJob.configuration : configuration,
		createdAt: scrapingJob.$assignedFields.contains('createdAt') ? scrapingJob.createdAt : createdAt,
		updatedAt: scrapingJob.$assignedFields.contains('updatedAt') ? scrapingJob.updatedAt : updatedAt,
		$errorsCount: scrapingJob.$errorsCount ?? $errorsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ScrapingJob updateWithInstanceValues(ScrapingJob scrapingJob) {
        if (scrapingJob.$assignedFields.contains('id')) { id = scrapingJob.id; }
		if (scrapingJob.$assignedFields.contains('jobType')) { jobType = scrapingJob.jobType; }
		if (scrapingJob.$assignedFields.contains('status')) { status = scrapingJob.status; }
		if (scrapingJob.$assignedFields.contains('startTime')) { startTime = scrapingJob.startTime; }
		if (scrapingJob.$assignedFields.contains('endTime')) { endTime = scrapingJob.endTime; }
		if (scrapingJob.$assignedFields.contains('projectsScraped')) { projectsScraped = scrapingJob.projectsScraped; }
		if (scrapingJob.$assignedFields.contains('errors')) { errors = scrapingJob.errors; }
		if (scrapingJob.$assignedFields.contains('configuration')) { configuration = scrapingJob.configuration; }
		if (scrapingJob.$assignedFields.contains('createdAt')) { createdAt = scrapingJob.createdAt; }
		if (scrapingJob.$assignedFields.contains('updatedAt')) { updatedAt = scrapingJob.updatedAt; }
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
          ? {...?serializedTypes, 'ScrapingJob'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(jobType != null) 'jobType': jobType,
	if(status != null) 'status': status,
	if(startTime != null) 'startTime': startTime?.toIso8601String(),
	if(endTime != null) 'endTime': endTime?.toIso8601String(),
	if(projectsScraped != null) 'projectsScraped': projectsScraped,
	if(errors != null) 'errors': errors,
	if(configuration != null) 'configuration': configuration,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
		if ($errorsCount != null) '_count': { 
		if ($errorsCount != null) 'errors': $errorsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ScrapingJob &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    