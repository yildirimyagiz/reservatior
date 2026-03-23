
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class DocumentTemplateStore extends ModelStreamStore<String, DocumentTemplate> {

  static DocumentTemplateStore? _instance;

  static DocumentTemplateStore get instance {
    _instance ??= DocumentTemplateStore();
    return _instance!;
  }

  DocumentTemplateStore() : super(DocumentTemplate.fromJson) {
    if (_instance != null) {
        throw Exception(
            'DocumentTemplateStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending DocumentTemplateStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use DocumentTemplateStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getDocumentTemplateId(DocumentTemplate documentTemplate) => documentTemplate.id;

	String? getDocumentTemplateOrgId(DocumentTemplate documentTemplate) => documentTemplate.orgId;

	String? getDocumentTemplateName(DocumentTemplate documentTemplate) => documentTemplate.name;

	String? getDocumentTemplateType(DocumentTemplate documentTemplate) => documentTemplate.type;

	String? getDocumentTemplateCategory(DocumentTemplate documentTemplate) => documentTemplate.category;

	String? getDocumentTemplateTemplateContent(DocumentTemplate documentTemplate) => documentTemplate.templateContent;

	dynamic? getDocumentTemplateVariables(DocumentTemplate documentTemplate) => documentTemplate.variables;

	bool? getDocumentTemplateIsActive(DocumentTemplate documentTemplate) => documentTemplate.isActive;

	String? getDocumentTemplateCreatedBy(DocumentTemplate documentTemplate) => documentTemplate.createdBy;

	DateTime? getDocumentTemplateCreatedAt(DocumentTemplate documentTemplate) => documentTemplate.createdAt;

	DateTime? getDocumentTemplateUpdatedAt(DocumentTemplate documentTemplate) => documentTemplate.updatedAt;

	DateTime? getDocumentTemplateDeletedAt(DocumentTemplate documentTemplate) => documentTemplate.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<DocumentTemplate> getByOrgId(
    String orgId,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByName(
    String name,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateName, name, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByType(
    String type,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateType, type, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByCategory(
    String category,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateCategory, category, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByTemplateContent(
    String templateContent,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateTemplateContent, templateContent, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByVariables(
    dynamic variables,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateVariables, variables, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByIsActive(
    bool isActive,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByCreatedBy(
    String createdBy,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<DocumentTemplate> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    DocumentTemplate documentTemplate, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (documentTemplate.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(documentTemplate.orgId!, includes: includes);
        documentTemplate.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<DocumentTemplate>> getAll$({bool useCache = true, ModelFilter<DocumentTemplate>? modelFilter, List<DocumentTemplateInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: DocumentTemplateEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<DocumentTemplate?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDocumentTemplateId,
        value: id,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<DocumentTemplate>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentTemplateOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentTemplateName,
        value: name,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByType$(
        String type,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentTemplateType,
        value: type,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByCategory$(
        String category,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentTemplateCategory,
        value: category,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByTemplateContent$(
        String templateContent,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentTemplateTemplateContent,
        value: templateContent,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByTemplateContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByVariables$(
        dynamic variables,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getDocumentTemplateVariables,
        value: variables,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByVariables,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDocumentTemplateIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentTemplateCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentTemplateCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentTemplateUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<DocumentTemplate>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<DocumentTemplate>? modelFilter,
        List<DocumentTemplateInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentTemplateDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: DocumentTemplateEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    DocumentTemplate documentTemplate, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (documentTemplate.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            documentTemplate.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            documentTemplate.org = org;
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
DocumentTemplate recursiveUpsert(DocumentTemplate documentTemplate, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'DocumentTemplate'} 
        : const {};
    if (documentTemplate.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        documentTemplate.org = OrganizationStore.instance.recursiveUpsert(documentTemplate.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(documentTemplate);
}

  List<DocumentTemplate> recursiveListUpsert(List<DocumentTemplate> documentTemplates, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedDocumentTemplates = <DocumentTemplate>[];
    for (var documentTemplate in documentTemplates) {
        updatedDocumentTemplates.add(recursiveUpsert(documentTemplate, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedDocumentTemplates;
}

//   @override
//   DocumentTemplate upsert(DocumentTemplate item) {
//     return recursiveUpsert(item);
//   }

}


class DocumentTemplateInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      DocumentTemplateInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (documentTemplate) => DocumentTemplateStore.instance
            .getOrg$(documentTemplate, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (documentTemplate) => DocumentTemplateStore.instance
            .getOrg(documentTemplate, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum DocumentTemplateEndpoints implements Endpoint {

    getAll('/documentTemplate', HttpMethod.post, List<DocumentTemplate>),
	getById('/documentTemplate/byId/:id', HttpMethod.post, DocumentTemplate),
	getManyByOrgId('/documentTemplate/byOrgId/:orgId', HttpMethod.post, List<DocumentTemplate>),
	getManyByName('/documentTemplate/byName/:name', HttpMethod.post, List<DocumentTemplate>),
	getManyByType('/documentTemplate/byType/:type', HttpMethod.post, List<DocumentTemplate>),
	getManyByCategory('/documentTemplate/byCategory/:category', HttpMethod.post, List<DocumentTemplate>),
	getManyByTemplateContent('/documentTemplate/byTemplateContent/:templateContent', HttpMethod.post, List<DocumentTemplate>),
	getManyByVariables('/documentTemplate/byVariables/:variables', HttpMethod.post, List<DocumentTemplate>),
	getManyByIsActive('/documentTemplate/byIsActive/:isActive', HttpMethod.post, List<DocumentTemplate>),
	getManyByCreatedBy('/documentTemplate/byCreatedBy/:createdBy', HttpMethod.post, List<DocumentTemplate>),
	getManyByCreatedAt('/documentTemplate/byCreatedAt/:createdAt', HttpMethod.post, List<DocumentTemplate>),
	getManyByUpdatedAt('/documentTemplate/byUpdatedAt/:updatedAt', HttpMethod.post, List<DocumentTemplate>),
	getManyByDeletedAt('/documentTemplate/byDeletedAt/:deletedAt', HttpMethod.post, List<DocumentTemplate>);

    const DocumentTemplateEndpoints(this.path, this.method, this.responseType);

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
