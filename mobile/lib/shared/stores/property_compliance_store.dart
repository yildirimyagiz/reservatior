
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyComplianceStore extends ModelStreamStore<String, PropertyCompliance> {

  static PropertyComplianceStore? _instance;

  static PropertyComplianceStore get instance {
    _instance ??= PropertyComplianceStore();
    return _instance!;
  }

  PropertyComplianceStore() : super(PropertyCompliance.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyComplianceStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyComplianceStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyComplianceStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyComplianceId(PropertyCompliance propertyCompliance) => propertyCompliance.id;

	String? getPropertyComplianceOrgId(PropertyCompliance propertyCompliance) => propertyCompliance.orgId;

	String? getPropertyCompliancePropertyId(PropertyCompliance propertyCompliance) => propertyCompliance.propertyId;

	String? getPropertyComplianceType(PropertyCompliance propertyCompliance) => propertyCompliance.type;

	String? getPropertyComplianceStatus(PropertyCompliance propertyCompliance) => propertyCompliance.status;

	dynamic? getPropertyComplianceData(PropertyCompliance propertyCompliance) => propertyCompliance.data;

	String? getPropertyComplianceInspectorId(PropertyCompliance propertyCompliance) => propertyCompliance.inspectorId;

	String? getPropertyComplianceInspectorContactId(PropertyCompliance propertyCompliance) => propertyCompliance.inspectorContactId;

	DateTime? getPropertyComplianceCreatedAt(PropertyCompliance propertyCompliance) => propertyCompliance.createdAt;

	DateTime? getPropertyComplianceUpdatedAt(PropertyCompliance propertyCompliance) => propertyCompliance.updatedAt;

	DateTime? getPropertyComplianceDeletedAt(PropertyCompliance propertyCompliance) => propertyCompliance.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PropertyCompliance> getByOrgId(
    String orgId,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyComplianceOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PropertyCompliance> getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyCompliancePropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyCompliance> getByType(
    String type,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyComplianceType, type, modelFilter: modelFilter, includes: includes);

	
List<PropertyCompliance> getByStatus(
    String status,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyComplianceStatus, status, modelFilter: modelFilter, includes: includes);

	
List<PropertyCompliance> getByData(
    dynamic data,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyComplianceData, data, modelFilter: modelFilter, includes: includes);

	
List<PropertyCompliance> getByInspectorId(
    String inspectorId,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyComplianceInspectorId, inspectorId, modelFilter: modelFilter, includes: includes);

	
List<PropertyCompliance> getByInspectorContactId(
    String inspectorContactId,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyComplianceInspectorContactId, inspectorContactId, modelFilter: modelFilter, includes: includes);

	
List<PropertyCompliance> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyComplianceCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyCompliance> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyComplianceUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyCompliance> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}
    ) =>
    getManyIncluding(getPropertyComplianceDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getInspectorContact(
    PropertyCompliance propertyCompliance, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (propertyCompliance.inspectorContactId == null) {
        return null;
    } else {
        final inspectorContact = ContactStore.instance.getById(propertyCompliance.inspectorContactId!, includes: includes);
        propertyCompliance.inspectorContact = inspectorContact;
        // setIncludedReferences(inspectorContact, includes: includes);
        return inspectorContact;
    }
}

	User? getInspector(
    PropertyCompliance propertyCompliance, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (propertyCompliance.inspectorId == null) {
        return null;
    } else {
        final inspector = UserStore.instance.getById(propertyCompliance.inspectorId!, includes: includes);
        propertyCompliance.inspector = inspector;
        // setIncludedReferences(inspector, includes: includes);
        return inspector;
    }
}

	Organization? getOrg(
    PropertyCompliance propertyCompliance, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyCompliance.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(propertyCompliance.orgId!, includes: includes);
        propertyCompliance.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    PropertyCompliance propertyCompliance, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyCompliance.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(propertyCompliance.propertyId!, includes: includes);
        propertyCompliance.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  List<Attachment> getAttachments(
    PropertyCompliance propertyCompliance, {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    final attachments = AttachmentStore.instance.getByPropertyComplianceId(propertyCompliance.$uid!, modelFilter: modelFilter, includes: includes);
    propertyCompliance.attachments = attachments;
    // setIncludedReferencesForList(attachments, includes: includes);
    return attachments;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyCompliance>> getAll$({bool useCache = true, ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyComplianceEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyCompliance?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyComplianceId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyCompliance>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyComplianceOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyCompliance>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyCompliancePropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyCompliance>> getByType$(
        String type,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyComplianceType,
        value: type,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyCompliance>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyComplianceStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyCompliance>> getByData$(
        dynamic data,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPropertyComplianceData,
        value: data,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyCompliance>> getByInspectorId$(
        String inspectorId,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyComplianceInspectorId,
        value: inspectorId,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByInspectorId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyCompliance>> getByInspectorContactId$(
        String inspectorContactId,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyComplianceInspectorContactId,
        value: inspectorContactId,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByInspectorContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyCompliance>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyComplianceCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyCompliance>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyComplianceUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyCompliance>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<PropertyCompliance>? modelFilter,
        List<PropertyComplianceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyComplianceDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PropertyComplianceEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getInspectorContact$(
    PropertyCompliance propertyCompliance, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (propertyCompliance.inspectorContactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            propertyCompliance.inspectorContactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((inspectorContact) {
            propertyCompliance.inspectorContact = inspectorContact;
        });
    }
}

	Stream<User?> getInspector$(
    PropertyCompliance propertyCompliance, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (propertyCompliance.inspectorId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            propertyCompliance.inspectorId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((inspector) {
            propertyCompliance.inspector = inspector;
        });
    }
}

	Stream<Organization?> getOrg$(
    PropertyCompliance propertyCompliance, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyCompliance.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            propertyCompliance.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            propertyCompliance.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    PropertyCompliance propertyCompliance, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyCompliance.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyCompliance.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            propertyCompliance.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Attachment>> getAttachments$(
    PropertyCompliance propertyCompliance, {bool useCache = true, ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    return AttachmentStore.instance.getByPropertyComplianceId$(
        propertyCompliance.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attachments) {
        propertyCompliance.attachments = attachments;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
PropertyCompliance recursiveUpsert(PropertyCompliance propertyCompliance, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyCompliance'} 
        : const {};
    if (propertyCompliance.attachments != null && (!preventCircularSerialization || !upsertedTypes.contains('Attachment'))) {
        propertyCompliance.attachments = AttachmentStore.instance.recursiveListUpsert(propertyCompliance.attachments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyCompliance.inspectorContact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        propertyCompliance.inspectorContact = ContactStore.instance.recursiveUpsert(propertyCompliance.inspectorContact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyCompliance.inspector != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        propertyCompliance.inspector = UserStore.instance.recursiveUpsert(propertyCompliance.inspector!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyCompliance.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        propertyCompliance.org = OrganizationStore.instance.recursiveUpsert(propertyCompliance.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyCompliance.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyCompliance.property = PropertyStore.instance.recursiveUpsert(propertyCompliance.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyCompliance);
}

  List<PropertyCompliance> recursiveListUpsert(List<PropertyCompliance> propertyCompliances, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyCompliances = <PropertyCompliance>[];
    for (var propertyCompliance in propertyCompliances) {
        updatedPropertyCompliances.add(recursiveUpsert(propertyCompliance, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyCompliances;
}

//   @override
//   PropertyCompliance upsert(PropertyCompliance item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyComplianceInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyComplianceInclude.attachments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Attachment>? modelFilter,
    List<AttachmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getAttachments$(propertyCompliance, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getAttachments(propertyCompliance, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyComplianceInclude.inspectorContact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getInspectorContact$(propertyCompliance, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getInspectorContact(propertyCompliance, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyComplianceInclude.inspector({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getInspector$(propertyCompliance, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getInspector(propertyCompliance, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyComplianceInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getOrg$(propertyCompliance, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getOrg(propertyCompliance, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyComplianceInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getProperty$(propertyCompliance, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyCompliance) => PropertyComplianceStore.instance
            .getProperty(propertyCompliance, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyComplianceEndpoints implements Endpoint {

    getAll('/propertyCompliance', HttpMethod.post, List<PropertyCompliance>),
	getById('/propertyCompliance/byId/:id', HttpMethod.post, PropertyCompliance),
	getManyByOrgId('/propertyCompliance/byOrgId/:orgId', HttpMethod.post, List<PropertyCompliance>),
	getManyByPropertyId('/propertyCompliance/byPropertyId/:propertyId', HttpMethod.post, List<PropertyCompliance>),
	getManyByType('/propertyCompliance/byType/:type', HttpMethod.post, List<PropertyCompliance>),
	getManyByStatus('/propertyCompliance/byStatus/:status', HttpMethod.post, List<PropertyCompliance>),
	getManyByData('/propertyCompliance/byData/:data', HttpMethod.post, List<PropertyCompliance>),
	getManyByInspectorId('/propertyCompliance/byInspectorId/:inspectorId', HttpMethod.post, List<PropertyCompliance>),
	getManyByInspectorContactId('/propertyCompliance/byInspectorContactId/:inspectorContactId', HttpMethod.post, List<PropertyCompliance>),
	getManyByCreatedAt('/propertyCompliance/byCreatedAt/:createdAt', HttpMethod.post, List<PropertyCompliance>),
	getManyByUpdatedAt('/propertyCompliance/byUpdatedAt/:updatedAt', HttpMethod.post, List<PropertyCompliance>),
	getManyByDeletedAt('/propertyCompliance/byDeletedAt/:deletedAt', HttpMethod.post, List<PropertyCompliance>);

    const PropertyComplianceEndpoints(this.path, this.method, this.responseType);

    @override
  final String path;

  @override
  final HttpMethod method;

  final Type responseType;

  static String withPathParameter(String path, dynamic param) {
    final regex = RegExp(r':([a-zA-Z]+)');
    return path.replaceFirst(regex, param.toString());
  }
}
