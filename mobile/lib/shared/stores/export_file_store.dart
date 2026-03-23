
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ExportFileStore extends ModelStreamStore<String, ExportFile> {

  static ExportFileStore? _instance;

  static ExportFileStore get instance {
    _instance ??= ExportFileStore();
    return _instance!;
  }

  ExportFileStore() : super(ExportFile.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ExportFileStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ExportFileStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ExportFileStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getExportFileId(ExportFile exportFile) => exportFile.id;

	String? getExportFileOrgId(ExportFile exportFile) => exportFile.orgId;

	String? getExportFileExportJobId(ExportFile exportFile) => exportFile.exportJobId;

	String? getExportFileFileName(ExportFile exportFile) => exportFile.fileName;

	String? getExportFileStorageKey(ExportFile exportFile) => exportFile.storageKey;

	String? getExportFileMimeType(ExportFile exportFile) => exportFile.mimeType;

	int? getExportFileSizeBytes(ExportFile exportFile) => exportFile.sizeBytes;

	DateTime? getExportFileCreatedAt(ExportFile exportFile) => exportFile.createdAt;

	DateTime? getExportFileUpdatedAt(ExportFile exportFile) => exportFile.updatedAt;

	DateTime? getExportFileDeletedAt(ExportFile exportFile) => exportFile.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ExportFile> getByOrgId(
    String orgId,
    {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}
    ) =>
    getManyIncluding(getExportFileOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ExportFile> getByExportJobId(
    String exportJobId,
    {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}
    ) =>
    getManyIncluding(getExportFileExportJobId, exportJobId, modelFilter: modelFilter, includes: includes);

	
List<ExportFile> getByFileName(
    String fileName,
    {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}
    ) =>
    getManyIncluding(getExportFileFileName, fileName, modelFilter: modelFilter, includes: includes);

	
List<ExportFile> getByStorageKey(
    String storageKey,
    {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}
    ) =>
    getManyIncluding(getExportFileStorageKey, storageKey, modelFilter: modelFilter, includes: includes);

	
List<ExportFile> getByMimeType(
    String mimeType,
    {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}
    ) =>
    getManyIncluding(getExportFileMimeType, mimeType, modelFilter: modelFilter, includes: includes);

	
List<ExportFile> getBySizeBytes(
    int sizeBytes,
    {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}
    ) =>
    getManyIncluding(getExportFileSizeBytes, sizeBytes, modelFilter: modelFilter, includes: includes);

	
List<ExportFile> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}
    ) =>
    getManyIncluding(getExportFileCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ExportFile> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}
    ) =>
    getManyIncluding(getExportFileUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ExportFile> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}
    ) =>
    getManyIncluding(getExportFileDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  ExportJob? getExportJob(
    ExportFile exportFile, {ModelFilter? modelFilter, List<ExportJobInclude>? includes}) {
    if (exportFile.exportJobId == null) {
        return null;
    } else {
        final exportJob = ExportJobStore.instance.getById(exportFile.exportJobId!, includes: includes);
        exportFile.exportJob = exportJob;
        // setIncludedReferences(exportJob, includes: includes);
        return exportJob;
    }
}

	Organization? getOrg(
    ExportFile exportFile, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (exportFile.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(exportFile.orgId!, includes: includes);
        exportFile.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ExportFile>> getAll$({bool useCache = true, ModelFilter<ExportFile>? modelFilter, List<ExportFileInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ExportFileEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ExportFile?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getExportFileId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ExportFile>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExportFileOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportFile>> getByExportJobId$(
        String exportJobId,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExportFileExportJobId,
        value: exportJobId,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getManyByExportJobId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportFile>> getByFileName$(
        String fileName,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExportFileFileName,
        value: fileName,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getManyByFileName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportFile>> getByStorageKey$(
        String storageKey,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExportFileStorageKey,
        value: storageKey,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getManyByStorageKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportFile>> getByMimeType$(
        String mimeType,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getExportFileMimeType,
        value: mimeType,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getManyByMimeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportFile>> getBySizeBytes$(
        int sizeBytes,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getExportFileSizeBytes,
        value: sizeBytes,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getManyBySizeBytes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportFile>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExportFileCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportFile>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExportFileUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ExportFile>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ExportFile>? modelFilter,
        List<ExportFileInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getExportFileDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ExportFileEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<ExportJob?> getExportJob$(
    ExportFile exportFile, {bool useCache = true, ModelFilter<ExportJob>? modelFilter, List<ExportJobInclude>? includes}) {
    if (exportFile.exportJobId == null) {
        return Stream.value(null);
    } else {
        return ExportJobStore.instance.getById$(
            exportFile.exportJobId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((exportJob) {
            exportFile.exportJob = exportJob;
        });
    }
}

	Stream<Organization?> getOrg$(
    ExportFile exportFile, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (exportFile.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            exportFile.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            exportFile.org = org;
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
ExportFile recursiveUpsert(ExportFile exportFile, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ExportFile'} 
        : const {};
    if (exportFile.exportJob != null && (!preventCircularSerialization || !upsertedTypes.contains('ExportJob'))) {
        exportFile.exportJob = ExportJobStore.instance.recursiveUpsert(exportFile.exportJob!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (exportFile.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        exportFile.org = OrganizationStore.instance.recursiveUpsert(exportFile.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(exportFile);
}

  List<ExportFile> recursiveListUpsert(List<ExportFile> exportFiles, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedExportFiles = <ExportFile>[];
    for (var exportFile in exportFiles) {
        updatedExportFiles.add(recursiveUpsert(exportFile, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedExportFiles;
}

//   @override
//   ExportFile upsert(ExportFile item) {
//     return recursiveUpsert(item);
//   }

}


class ExportFileInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ExportFileInclude.exportJob({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExportJob>? modelFilter,
    List<ExportJobInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (exportFile) => ExportFileStore.instance
            .getExportJob$(exportFile, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (exportFile) => ExportFileStore.instance
            .getExportJob(exportFile, modelFilter: modelFilter, includes: includes);
      }
}

	ExportFileInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (exportFile) => ExportFileStore.instance
            .getOrg$(exportFile, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (exportFile) => ExportFileStore.instance
            .getOrg(exportFile, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ExportFileEndpoints implements Endpoint {

    getAll('/exportFile', HttpMethod.post, List<ExportFile>),
	getById('/exportFile/byId/:id', HttpMethod.post, ExportFile),
	getManyByOrgId('/exportFile/byOrgId/:orgId', HttpMethod.post, List<ExportFile>),
	getManyByExportJobId('/exportFile/byExportJobId/:exportJobId', HttpMethod.post, List<ExportFile>),
	getManyByFileName('/exportFile/byFileName/:fileName', HttpMethod.post, List<ExportFile>),
	getManyByStorageKey('/exportFile/byStorageKey/:storageKey', HttpMethod.post, List<ExportFile>),
	getManyByMimeType('/exportFile/byMimeType/:mimeType', HttpMethod.post, List<ExportFile>),
	getManyBySizeBytes('/exportFile/bySizeBytes/:sizeBytes', HttpMethod.post, List<ExportFile>),
	getManyByCreatedAt('/exportFile/byCreatedAt/:createdAt', HttpMethod.post, List<ExportFile>),
	getManyByUpdatedAt('/exportFile/byUpdatedAt/:updatedAt', HttpMethod.post, List<ExportFile>),
	getManyByDeletedAt('/exportFile/byDeletedAt/:deletedAt', HttpMethod.post, List<ExportFile>);

    const ExportFileEndpoints(this.path, this.method, this.responseType);

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
