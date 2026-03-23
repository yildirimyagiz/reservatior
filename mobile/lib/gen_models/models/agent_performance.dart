
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'user.dart';


class AgentPerformance implements PrismaModel<String, AgentPerformance> , Id<String> {
    @override
String? id;
	String? userId;
	String? period;
	DateTime? startDate;
	DateTime? endDate;
	int? leadsGenerated;
	int? showingsCompleted;
	int? offersSubmitted;
	int? dealsClosed;
	double? commissionEarned;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AgentPerformance({ this.id,
	 this.userId,
	 this.period,
	 this.startDate,
	 this.endDate,
	 this.leadsGenerated = 0,
	 this.showingsCompleted = 0,
	 this.offersSubmitted = 0,
	 this.dealsClosed = 0,
	 this.commissionEarned = 0,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AgentPerformance, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"period": (m) => m.period,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"leadsGenerated": (m) => m.leadsGenerated,

	"showingsCompleted": (m) => m.showingsCompleted,

	"offersSubmitted": (m) => m.offersSubmitted,

	"dealsClosed": (m) => m.dealsClosed,

	"commissionEarned": (m) => m.commissionEarned,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AgentPerformance) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AgentPerformance');
    }
    return propFunction as V? Function(AgentPerformance);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AgentPerformance.fromJson(JsonMap json) =>
      AgentPerformance(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	period: json['period'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	leadsGenerated: int.tryParse(json['leadsGenerated'].toString()),
	showingsCompleted: int.tryParse(json['showingsCompleted'].toString()),
	offersSubmitted: int.tryParse(json['offersSubmitted'].toString()),
	dealsClosed: int.tryParse(json['dealsClosed'].toString()),
	commissionEarned: json['commissionEarned'] as double?,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AgentPerformance copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? period,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<int?>? leadsGenerated,
		Value<int?>? showingsCompleted,
		Value<int?>? offersSubmitted,
		Value<int?>? dealsClosed,
		Value<double?>? commissionEarned,
		Value<User?>? user,
        }) {
        return AgentPerformance(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		period: period != null ? period.value : this.period,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		leadsGenerated: leadsGenerated != null ? leadsGenerated.value : this.leadsGenerated,
		showingsCompleted: showingsCompleted != null ? showingsCompleted.value : this.showingsCompleted,
		offersSubmitted: offersSubmitted != null ? offersSubmitted.value : this.offersSubmitted,
		dealsClosed: dealsClosed != null ? dealsClosed.value : this.dealsClosed,
		commissionEarned: commissionEarned != null ? commissionEarned.value : this.commissionEarned,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AgentPerformance copyWithInstanceValues(AgentPerformance agentPerformance) {
        return AgentPerformance(
            id: agentPerformance.id ?? id,
		userId: agentPerformance.userId ?? userId,
		period: agentPerformance.period ?? period,
		startDate: agentPerformance.startDate ?? startDate,
		endDate: agentPerformance.endDate ?? endDate,
		leadsGenerated: agentPerformance.leadsGenerated ?? leadsGenerated,
		showingsCompleted: agentPerformance.showingsCompleted ?? showingsCompleted,
		offersSubmitted: agentPerformance.offersSubmitted ?? offersSubmitted,
		dealsClosed: agentPerformance.dealsClosed ?? dealsClosed,
		commissionEarned: agentPerformance.commissionEarned ?? commissionEarned,
		user: agentPerformance.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AgentPerformance mergeWithInstanceValues(AgentPerformance agentPerformance) {
        return AgentPerformance(
            id: agentPerformance.$assignedFields.contains('id') ? agentPerformance.id : id,
		userId: agentPerformance.$assignedFields.contains('userId') ? agentPerformance.userId : userId,
		period: agentPerformance.$assignedFields.contains('period') ? agentPerformance.period : period,
		startDate: agentPerformance.$assignedFields.contains('startDate') ? agentPerformance.startDate : startDate,
		endDate: agentPerformance.$assignedFields.contains('endDate') ? agentPerformance.endDate : endDate,
		leadsGenerated: agentPerformance.$assignedFields.contains('leadsGenerated') ? agentPerformance.leadsGenerated : leadsGenerated,
		showingsCompleted: agentPerformance.$assignedFields.contains('showingsCompleted') ? agentPerformance.showingsCompleted : showingsCompleted,
		offersSubmitted: agentPerformance.$assignedFields.contains('offersSubmitted') ? agentPerformance.offersSubmitted : offersSubmitted,
		dealsClosed: agentPerformance.$assignedFields.contains('dealsClosed') ? agentPerformance.dealsClosed : dealsClosed,
		commissionEarned: agentPerformance.$assignedFields.contains('commissionEarned') ? agentPerformance.commissionEarned : commissionEarned,
		user: agentPerformance.$assignedFields.contains('user') ? agentPerformance.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AgentPerformance updateWithInstanceValues(AgentPerformance agentPerformance) {
        if (agentPerformance.$assignedFields.contains('id')) { id = agentPerformance.id; }
		if (agentPerformance.$assignedFields.contains('userId')) { userId = agentPerformance.userId; }
		if (agentPerformance.$assignedFields.contains('period')) { period = agentPerformance.period; }
		if (agentPerformance.$assignedFields.contains('startDate')) { startDate = agentPerformance.startDate; }
		if (agentPerformance.$assignedFields.contains('endDate')) { endDate = agentPerformance.endDate; }
		if (agentPerformance.$assignedFields.contains('leadsGenerated')) { leadsGenerated = agentPerformance.leadsGenerated; }
		if (agentPerformance.$assignedFields.contains('showingsCompleted')) { showingsCompleted = agentPerformance.showingsCompleted; }
		if (agentPerformance.$assignedFields.contains('offersSubmitted')) { offersSubmitted = agentPerformance.offersSubmitted; }
		if (agentPerformance.$assignedFields.contains('dealsClosed')) { dealsClosed = agentPerformance.dealsClosed; }
		if (agentPerformance.$assignedFields.contains('commissionEarned')) { commissionEarned = agentPerformance.commissionEarned; }
		if (agentPerformance.$assignedFields.contains('user')) { user = agentPerformance.user; }
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
          ? {...?serializedTypes, 'AgentPerformance'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(period != null) 'period': period,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(leadsGenerated != null) 'leadsGenerated': leadsGenerated,
	if(showingsCompleted != null) 'showingsCompleted': showingsCompleted,
	if(offersSubmitted != null) 'offersSubmitted': offersSubmitted,
	if(dealsClosed != null) 'dealsClosed': dealsClosed,
	if(commissionEarned != null) 'commissionEarned': commissionEarned,
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AgentPerformance &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    