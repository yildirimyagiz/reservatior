
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class CommunicationTemplateStore extends ModelStreamStore<String, CommunicationTemplate> {

  static CommunicationTemplateStore? _instance;

  static CommunicationTemplateStore get instance {
    _instance ??= CommunicationTemplateStore();
    return _instance!;
  }

  CommunicationTemplateStore() : super(CommunicationTemplate.fromJson) {
    if (_instance != null) {
        throw Exception(
            'CommunicationTemplateStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending CommunicationTemplateStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use CommunicationTemplateStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getCommunicationTemplateId(CommunicationTemplate communicationTemplate) => communicationTemplate.id;

	String? getCommunicationTemplateOrgId(CommunicationTemplate communicationTemplate) => communicationTemplate.orgId;

	String? getCommunicationTemplateName(CommunicationTemplate communicationTemplate) => communicationTemplate.name;

	String? getCommunicationTemplateType(CommunicationTemplate communicationTemplate) => communicationTemplate.type;

	String? getCommunicationTemplateTemplateType(CommunicationTemplate communicationTemplate) => communicationTemplate.templateType;

	String? getCommunicationTemplateSubject(CommunicationTemplate communicationTemplate) => communicationTemplate.subject;

	String? getCommunicationTemplateHtmlContent(CommunicationTemplate communicationTemplate) => communicationTemplate.htmlContent;

	String? getCommunicationTemplateTextContent(CommunicationTemplate communicationTemplate) => communicationTemplate.textContent;

	String? getCommunicationTemplateTitle(CommunicationTemplate communicationTemplate) => communicationTemplate.title;

	String? getCommunicationTemplateMessage(CommunicationTemplate communicationTemplate) => communicationTemplate.message;

	List<String>? getCommunicationTemplateChannels(CommunicationTemplate communicationTemplate) => communicationTemplate.channels;

	String? getCommunicationTemplateCategory(CommunicationTemplate communicationTemplate) => communicationTemplate.category;

	dynamic? getCommunicationTemplateVariables(CommunicationTemplate communicationTemplate) => communicationTemplate.variables;

	bool? getCommunicationTemplateIsActive(CommunicationTemplate communicationTemplate) => communicationTemplate.isActive;

	String? getCommunicationTemplateCreatedBy(CommunicationTemplate communicationTemplate) => communicationTemplate.createdBy;

	DateTime? getCommunicationTemplateCreatedAt(CommunicationTemplate communicationTemplate) => communicationTemplate.createdAt;

	DateTime? getCommunicationTemplateUpdatedAt(CommunicationTemplate communicationTemplate) => communicationTemplate.updatedAt;

	DateTime? getCommunicationTemplateDeletedAt(CommunicationTemplate communicationTemplate) => communicationTemplate.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<CommunicationTemplate> getByOrgId(
    String orgId,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByName(
    String name,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateName, name, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByType(
    String type,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateType, type, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByTemplateType(
    String templateType,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateTemplateType, templateType, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getBySubject(
    String subject,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateSubject, subject, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByHtmlContent(
    String htmlContent,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateHtmlContent, htmlContent, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByTextContent(
    String textContent,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateTextContent, textContent, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByTitle(
    String title,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateTitle, title, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByMessage(
    String message,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateMessage, message, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByChannels(
    String channels,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateChannels, channels, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByCategory(
    String category,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateCategory, category, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByVariables(
    dynamic variables,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateVariables, variables, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByIsActive(
    bool isActive,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByCreatedBy(
    String createdBy,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<CommunicationTemplate> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}
    ) =>
    getManyIncluding(getCommunicationTemplateDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    CommunicationTemplate communicationTemplate, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (communicationTemplate.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(communicationTemplate.orgId!, includes: includes);
        communicationTemplate.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<CommunicationTemplate>> getAll$({bool useCache = true, ModelFilter<CommunicationTemplate>? modelFilter, List<CommunicationTemplateInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: CommunicationTemplateEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<CommunicationTemplate?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getCommunicationTemplateId,
        value: id,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<CommunicationTemplate>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateName,
        value: name,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByType$(
        String type,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateType,
        value: type,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByTemplateType$(
        String templateType,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateTemplateType,
        value: templateType,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByTemplateType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getBySubject$(
        String subject,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateSubject,
        value: subject,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyBySubject,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByHtmlContent$(
        String htmlContent,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateHtmlContent,
        value: htmlContent,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByHtmlContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByTextContent$(
        String textContent,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateTextContent,
        value: textContent,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByTextContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByMessage$(
        String message,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateMessage,
        value: message,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByMessage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByChannels$(
        String channels,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateChannels,
        value: channels,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByChannels,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByCategory$(
        String category,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateCategory,
        value: category,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByVariables$(
        dynamic variables,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCommunicationTemplateVariables,
        value: variables,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByVariables,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getCommunicationTemplateIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommunicationTemplateCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationTemplateCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationTemplateUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommunicationTemplate>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<CommunicationTemplate>? modelFilter,
        List<CommunicationTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommunicationTemplateDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: CommunicationTemplateEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    CommunicationTemplate communicationTemplate, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (communicationTemplate.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            communicationTemplate.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            communicationTemplate.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
CommunicationTemplate recursiveUpsert(CommunicationTemplate communicationTemplate, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'CommunicationTemplate'} 
        : const {};
    if (communicationTemplate.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        communicationTemplate.org = OrganizationStore.instance.recursiveUpsert(communicationTemplate.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(communicationTemplate);
}

  List<CommunicationTemplate> recursiveListUpsert(List<CommunicationTemplate> communicationTemplates, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedCommunicationTemplates = <CommunicationTemplate>[];
    for (var communicationTemplate in communicationTemplates) {
        updatedCommunicationTemplates.add(recursiveUpsert(communicationTemplate, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedCommunicationTemplates;
}

//   @override
//   CommunicationTemplate upsert(CommunicationTemplate item) {
//     return recursiveUpsert(item);
//   }

}


class CommunicationTemplateInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      CommunicationTemplateInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (communicationTemplate) => CommunicationTemplateStore.instance
            .getOrg$(communicationTemplate, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (communicationTemplate) => CommunicationTemplateStore.instance
            .getOrg(communicationTemplate, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum CommunicationTemplateEndpoints implements Endpoint {

    getAll('/communicationTemplate', HttpMethod.post, List<CommunicationTemplate>),
	getById('/communicationTemplate/byId/:id', HttpMethod.post, CommunicationTemplate),
	getManyByOrgId('/communicationTemplate/byOrgId/:orgId', HttpMethod.post, List<CommunicationTemplate>),
	getManyByName('/communicationTemplate/byName/:name', HttpMethod.post, List<CommunicationTemplate>),
	getManyByType('/communicationTemplate/byType/:type', HttpMethod.post, List<CommunicationTemplate>),
	getManyByTemplateType('/communicationTemplate/byTemplateType/:templateType', HttpMethod.post, List<CommunicationTemplate>),
	getManyBySubject('/communicationTemplate/bySubject/:subject', HttpMethod.post, List<CommunicationTemplate>),
	getManyByHtmlContent('/communicationTemplate/byHtmlContent/:htmlContent', HttpMethod.post, List<CommunicationTemplate>),
	getManyByTextContent('/communicationTemplate/byTextContent/:textContent', HttpMethod.post, List<CommunicationTemplate>),
	getManyByTitle('/communicationTemplate/byTitle/:title', HttpMethod.post, List<CommunicationTemplate>),
	getManyByMessage('/communicationTemplate/byMessage/:message', HttpMethod.post, List<CommunicationTemplate>),
	getManyByChannels('/communicationTemplate/byChannels/:channels', HttpMethod.post, List<CommunicationTemplate>),
	getManyByCategory('/communicationTemplate/byCategory/:category', HttpMethod.post, List<CommunicationTemplate>),
	getManyByVariables('/communicationTemplate/byVariables/:variables', HttpMethod.post, List<CommunicationTemplate>),
	getManyByIsActive('/communicationTemplate/byIsActive/:isActive', HttpMethod.post, List<CommunicationTemplate>),
	getManyByCreatedBy('/communicationTemplate/byCreatedBy/:createdBy', HttpMethod.post, List<CommunicationTemplate>),
	getManyByCreatedAt('/communicationTemplate/byCreatedAt/:createdAt', HttpMethod.post, List<CommunicationTemplate>),
	getManyByUpdatedAt('/communicationTemplate/byUpdatedAt/:updatedAt', HttpMethod.post, List<CommunicationTemplate>),
	getManyByDeletedAt('/communicationTemplate/byDeletedAt/:deletedAt', HttpMethod.post, List<CommunicationTemplate>);

    const CommunicationTemplateEndpoints(this.path, this.method, this.responseType);

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
