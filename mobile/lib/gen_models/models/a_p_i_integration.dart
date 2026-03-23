//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'organization.dart';

class APIIntegration
    implements PrismaModel<String, APIIntegration>, Id<String> {
  @override
  String? id;
  String? orgId;
  String? providerName;
  String? integrationType;
  String? apiKeyCiphertext;
  String? apiSecretCiphertext;
  String? accessTokenCiphertext;
  String? refreshTokenCiphertext;
  String? baseUrl;
  int? rateLimit;
  int? timeout;
  dynamic config;
  dynamic webhooks;
  String? status;
  DateTime? lastUsedAt;
  int? errorCount;
  String? lastError;
  bool? isSandbox;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Organization? org;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  APIIntegration({
    this.id,
    this.orgId,
    this.providerName,
    this.integrationType,
    this.apiKeyCiphertext,
    this.apiSecretCiphertext,
    this.accessTokenCiphertext,
    this.refreshTokenCiphertext,
    this.baseUrl,
    this.rateLimit,
    this.timeout = 30,
    required this.config,
    required this.webhooks,
    this.status = "ACTIVE",
    this.lastUsedAt,
    this.errorCount = 0,
    this.lastError,
    this.isSandbox = false,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.org,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<APIIntegration, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "orgId": (m) => m.orgId,
    "providerName": (m) => m.providerName,
    "integrationType": (m) => m.integrationType,
    "apiKeyCiphertext": (m) => m.apiKeyCiphertext,
    "apiSecretCiphertext": (m) => m.apiSecretCiphertext,
    "accessTokenCiphertext": (m) => m.accessTokenCiphertext,
    "refreshTokenCiphertext": (m) => m.refreshTokenCiphertext,
    "baseUrl": (m) => m.baseUrl,
    "rateLimit": (m) => m.rateLimit,
    "timeout": (m) => m.timeout,
    "config": (m) => m.config,
    "webhooks": (m) => m.webhooks,
    "status": (m) => m.status,
    "lastUsedAt": (m) => m.lastUsedAt,
    "errorCount": (m) => m.errorCount,
    "lastError": (m) => m.lastError,
    "isSandbox": (m) => m.isSandbox,
    "deletedAt": (m) => m.deletedAt,
    "createdAt": (m) => m.createdAt,
    "updatedAt": (m) => m.updatedAt,
    "org": (m) => m.org,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(APIIntegration) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in APIIntegration');
    }
    return propFunction as V? Function(APIIntegration);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory APIIntegration.fromJson(JsonMap json) => APIIntegration(
        id: json['id'] as String?,
        orgId: json['orgId'] as String?,
        providerName: json['providerName'] as String?,
        integrationType: json['integrationType'] as String?,
        apiKeyCiphertext: json['apiKeyCiphertext'] as String?,
        apiSecretCiphertext: json['apiSecretCiphertext'] as String?,
        accessTokenCiphertext: json['accessTokenCiphertext'] as String?,
        refreshTokenCiphertext: json['refreshTokenCiphertext'] as String?,
        baseUrl: json['baseUrl'] as String?,
        rateLimit: int.tryParse(json['rateLimit'].toString()),
        timeout: int.tryParse(json['timeout'].toString()),
        config: json['config'] as dynamic,
        webhooks: json['webhooks'] as dynamic,
        status: json['status'] as String?,
        lastUsedAt: json['lastUsedAt'] != null
            ? DateTime.parse(json['lastUsedAt'])
            : null,
        errorCount: int.tryParse(json['errorCount'].toString()),
        lastError: json['lastError'] as String?,
        isSandbox: json['isSandbox'] as bool?,
        deletedAt: json['deletedAt'] != null
            ? DateTime.parse(json['deletedAt'])
            : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        org: json['org'] != null
            ? Organization.fromJson(json['org'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  APIIntegration copyWith({
    Value<String?>? id,
    Value<String?>? orgId,
    Value<String?>? providerName,
    Value<String?>? integrationType,
    Value<String?>? apiKeyCiphertext,
    Value<String?>? apiSecretCiphertext,
    Value<String?>? accessTokenCiphertext,
    Value<String?>? refreshTokenCiphertext,
    Value<String?>? baseUrl,
    Value<int?>? rateLimit,
    Value<int?>? timeout,
    Value<dynamic>? config,
    Value<dynamic>? webhooks,
    Value<String?>? status,
    Value<DateTime?>? lastUsedAt,
    Value<int?>? errorCount,
    Value<String?>? lastError,
    Value<bool?>? isSandbox,
    Value<DateTime?>? deletedAt,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<Organization?>? org,
  }) {
    return APIIntegration(
        id: id != null ? id.value : this.id,
        orgId: orgId != null ? orgId.value : this.orgId,
        providerName:
            providerName != null ? providerName.value : this.providerName,
        integrationType: integrationType != null
            ? integrationType.value
            : this.integrationType,
        apiKeyCiphertext: apiKeyCiphertext != null
            ? apiKeyCiphertext.value
            : this.apiKeyCiphertext,
        apiSecretCiphertext: apiSecretCiphertext != null
            ? apiSecretCiphertext.value
            : this.apiSecretCiphertext,
        accessTokenCiphertext: accessTokenCiphertext != null
            ? accessTokenCiphertext.value
            : this.accessTokenCiphertext,
        refreshTokenCiphertext: refreshTokenCiphertext != null
            ? refreshTokenCiphertext.value
            : this.refreshTokenCiphertext,
        baseUrl: baseUrl != null ? baseUrl.value : this.baseUrl,
        rateLimit: rateLimit != null ? rateLimit.value : this.rateLimit,
        timeout: timeout != null ? timeout.value : this.timeout,
        config: config != null ? config.value : this.config,
        webhooks: webhooks != null ? webhooks.value : this.webhooks,
        status: status != null ? status.value : this.status,
        lastUsedAt: lastUsedAt != null ? lastUsedAt.value : this.lastUsedAt,
        errorCount: errorCount != null ? errorCount.value : this.errorCount,
        lastError: lastError != null ? lastError.value : this.lastError,
        isSandbox: isSandbox != null ? isSandbox.value : this.isSandbox,
        deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        org: org != null ? org.value : this.org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  APIIntegration copyWithInstanceValues(APIIntegration aPIIntegration) {
    return APIIntegration(
        id: aPIIntegration.id ?? id,
        orgId: aPIIntegration.orgId ?? orgId,
        providerName: aPIIntegration.providerName ?? providerName,
        integrationType: aPIIntegration.integrationType ?? integrationType,
        apiKeyCiphertext: aPIIntegration.apiKeyCiphertext ?? apiKeyCiphertext,
        apiSecretCiphertext:
            aPIIntegration.apiSecretCiphertext ?? apiSecretCiphertext,
        accessTokenCiphertext:
            aPIIntegration.accessTokenCiphertext ?? accessTokenCiphertext,
        refreshTokenCiphertext:
            aPIIntegration.refreshTokenCiphertext ?? refreshTokenCiphertext,
        baseUrl: aPIIntegration.baseUrl ?? baseUrl,
        rateLimit: aPIIntegration.rateLimit ?? rateLimit,
        timeout: aPIIntegration.timeout ?? timeout,
        config: aPIIntegration.config ?? config,
        webhooks: aPIIntegration.webhooks ?? webhooks,
        status: aPIIntegration.status ?? status,
        lastUsedAt: aPIIntegration.lastUsedAt ?? lastUsedAt,
        errorCount: aPIIntegration.errorCount ?? errorCount,
        lastError: aPIIntegration.lastError ?? lastError,
        isSandbox: aPIIntegration.isSandbox ?? isSandbox,
        deletedAt: aPIIntegration.deletedAt ?? deletedAt,
        createdAt: aPIIntegration.createdAt ?? createdAt,
        updatedAt: aPIIntegration.updatedAt ?? updatedAt,
        org: aPIIntegration.org ?? org);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  APIIntegration mergeWithInstanceValues(APIIntegration aPIIntegration) {
    return APIIntegration(
        id: aPIIntegration.$assignedFields.contains('id')
            ? aPIIntegration.id
            : id,
        orgId: aPIIntegration.$assignedFields.contains('orgId')
            ? aPIIntegration.orgId
            : orgId,
        providerName: aPIIntegration.$assignedFields.contains('providerName')
            ? aPIIntegration.providerName
            : providerName,
        integrationType: aPIIntegration.$assignedFields.contains('integrationType')
            ? aPIIntegration.integrationType
            : integrationType,
        apiKeyCiphertext: aPIIntegration.$assignedFields.contains('apiKeyCiphertext')
            ? aPIIntegration.apiKeyCiphertext
            : apiKeyCiphertext,
        apiSecretCiphertext: aPIIntegration.$assignedFields.contains('apiSecretCiphertext')
            ? aPIIntegration.apiSecretCiphertext
            : apiSecretCiphertext,
        accessTokenCiphertext:
            aPIIntegration.$assignedFields.contains('accessTokenCiphertext')
                ? aPIIntegration.accessTokenCiphertext
                : accessTokenCiphertext,
        refreshTokenCiphertext:
            aPIIntegration.$assignedFields.contains('refreshTokenCiphertext')
                ? aPIIntegration.refreshTokenCiphertext
                : refreshTokenCiphertext,
        baseUrl: aPIIntegration.$assignedFields.contains('baseUrl')
            ? aPIIntegration.baseUrl
            : baseUrl,
        rateLimit: aPIIntegration.$assignedFields.contains('rateLimit')
            ? aPIIntegration.rateLimit
            : rateLimit,
        timeout: aPIIntegration.$assignedFields.contains('timeout')
            ? aPIIntegration.timeout
            : timeout,
        config: aPIIntegration.$assignedFields.contains('config')
            ? aPIIntegration.config
            : config,
        webhooks: aPIIntegration.$assignedFields.contains('webhooks')
            ? aPIIntegration.webhooks
            : webhooks,
        status: aPIIntegration.$assignedFields.contains('status') ? aPIIntegration.status : status,
        lastUsedAt: aPIIntegration.$assignedFields.contains('lastUsedAt') ? aPIIntegration.lastUsedAt : lastUsedAt,
        errorCount: aPIIntegration.$assignedFields.contains('errorCount') ? aPIIntegration.errorCount : errorCount,
        lastError: aPIIntegration.$assignedFields.contains('lastError') ? aPIIntegration.lastError : lastError,
        isSandbox: aPIIntegration.$assignedFields.contains('isSandbox') ? aPIIntegration.isSandbox : isSandbox,
        deletedAt: aPIIntegration.$assignedFields.contains('deletedAt') ? aPIIntegration.deletedAt : deletedAt,
        createdAt: aPIIntegration.$assignedFields.contains('createdAt') ? aPIIntegration.createdAt : createdAt,
        updatedAt: aPIIntegration.$assignedFields.contains('updatedAt') ? aPIIntegration.updatedAt : updatedAt,
        org: aPIIntegration.$assignedFields.contains('org') ? aPIIntegration.org : org);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  APIIntegration updateWithInstanceValues(APIIntegration aPIIntegration) {
    if (aPIIntegration.$assignedFields.contains('id')) {
      id = aPIIntegration.id;
    }
    if (aPIIntegration.$assignedFields.contains('orgId')) {
      orgId = aPIIntegration.orgId;
    }
    if (aPIIntegration.$assignedFields.contains('providerName')) {
      providerName = aPIIntegration.providerName;
    }
    if (aPIIntegration.$assignedFields.contains('integrationType')) {
      integrationType = aPIIntegration.integrationType;
    }
    if (aPIIntegration.$assignedFields.contains('apiKeyCiphertext')) {
      apiKeyCiphertext = aPIIntegration.apiKeyCiphertext;
    }
    if (aPIIntegration.$assignedFields.contains('apiSecretCiphertext')) {
      apiSecretCiphertext = aPIIntegration.apiSecretCiphertext;
    }
    if (aPIIntegration.$assignedFields.contains('accessTokenCiphertext')) {
      accessTokenCiphertext = aPIIntegration.accessTokenCiphertext;
    }
    if (aPIIntegration.$assignedFields.contains('refreshTokenCiphertext')) {
      refreshTokenCiphertext = aPIIntegration.refreshTokenCiphertext;
    }
    if (aPIIntegration.$assignedFields.contains('baseUrl')) {
      baseUrl = aPIIntegration.baseUrl;
    }
    if (aPIIntegration.$assignedFields.contains('rateLimit')) {
      rateLimit = aPIIntegration.rateLimit;
    }
    if (aPIIntegration.$assignedFields.contains('timeout')) {
      timeout = aPIIntegration.timeout;
    }
    if (aPIIntegration.$assignedFields.contains('config')) {
      config = aPIIntegration.config;
    }
    if (aPIIntegration.$assignedFields.contains('webhooks')) {
      webhooks = aPIIntegration.webhooks;
    }
    if (aPIIntegration.$assignedFields.contains('status')) {
      status = aPIIntegration.status;
    }
    if (aPIIntegration.$assignedFields.contains('lastUsedAt')) {
      lastUsedAt = aPIIntegration.lastUsedAt;
    }
    if (aPIIntegration.$assignedFields.contains('errorCount')) {
      errorCount = aPIIntegration.errorCount;
    }
    if (aPIIntegration.$assignedFields.contains('lastError')) {
      lastError = aPIIntegration.lastError;
    }
    if (aPIIntegration.$assignedFields.contains('isSandbox')) {
      isSandbox = aPIIntegration.isSandbox;
    }
    if (aPIIntegration.$assignedFields.contains('deletedAt')) {
      deletedAt = aPIIntegration.deletedAt;
    }
    if (aPIIntegration.$assignedFields.contains('createdAt')) {
      createdAt = aPIIntegration.createdAt;
    }
    if (aPIIntegration.$assignedFields.contains('updatedAt')) {
      updatedAt = aPIIntegration.updatedAt;
    }
    if (aPIIntegration.$assignedFields.contains('org')) {
      org = aPIIntegration.org;
    }
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
        ? {...?serializedTypes, 'APIIntegration'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (orgId != null) 'orgId': orgId,
      if (providerName != null) 'providerName': providerName,
      if (integrationType != null) 'integrationType': integrationType,
      if (apiKeyCiphertext != null) 'apiKeyCiphertext': apiKeyCiphertext,
      if (apiSecretCiphertext != null)
        'apiSecretCiphertext': apiSecretCiphertext,
      if (accessTokenCiphertext != null)
        'accessTokenCiphertext': accessTokenCiphertext,
      if (refreshTokenCiphertext != null)
        'refreshTokenCiphertext': refreshTokenCiphertext,
      if (baseUrl != null) 'baseUrl': baseUrl,
      if (rateLimit != null) 'rateLimit': rateLimit,
      if (timeout != null) 'timeout': timeout,
      if (config != null) 'config': config,
      if (webhooks != null) 'webhooks': webhooks,
      if (status != null) 'status': status,
      if (lastUsedAt != null) 'lastUsedAt': lastUsedAt?.toIso8601String(),
      if (errorCount != null) 'errorCount': errorCount,
      if (lastError != null) 'lastError': lastError,
      if (isSandbox != null) 'isSandbox': isSandbox,
      if (deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (org != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'org': org?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization)
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is APIIntegration &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
