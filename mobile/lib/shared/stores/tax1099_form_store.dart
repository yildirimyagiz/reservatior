
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class Tax1099FormStore extends ModelStreamStore<String, Tax1099Form> {

  static Tax1099FormStore? _instance;

  static Tax1099FormStore get instance {
    _instance ??= Tax1099FormStore();
    return _instance!;
  }

  Tax1099FormStore() : super(Tax1099Form.fromJson) {
    if (_instance != null) {
        throw Exception(
            'Tax1099FormStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending Tax1099FormStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use Tax1099FormStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getTax1099FormId(Tax1099Form tax1099Form) => tax1099Form.id;

	String? getTax1099FormOrgId(Tax1099Form tax1099Form) => tax1099Form.orgId;

	String? getTax1099FormRecipientId(Tax1099Form tax1099Form) => tax1099Form.recipientId;

	int? getTax1099FormTaxYear(Tax1099Form tax1099Form) => tax1099Form.taxYear;

	USTaxForm? getTax1099FormFormType(Tax1099Form tax1099Form) => tax1099Form.formType;

	double? getTax1099FormAmount(Tax1099Form tax1099Form) => tax1099Form.amount;

	String? getTax1099FormDescription(Tax1099Form tax1099Form) => tax1099Form.description;

	DateTime? getTax1099FormIssuedAt(Tax1099Form tax1099Form) => tax1099Form.issuedAt;

	DateTime? getTax1099FormMailedAt(Tax1099Form tax1099Form) => tax1099Form.mailedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Tax1099Form> getByOrgId(
    String orgId,
    {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}
    ) =>
    getManyIncluding(getTax1099FormOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Tax1099Form> getByRecipientId(
    String recipientId,
    {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}
    ) =>
    getManyIncluding(getTax1099FormRecipientId, recipientId, modelFilter: modelFilter, includes: includes);

	
List<Tax1099Form> getByTaxYear(
    int taxYear,
    {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}
    ) =>
    getManyIncluding(getTax1099FormTaxYear, taxYear, modelFilter: modelFilter, includes: includes);

	
List<Tax1099Form> getByFormType(
    USTaxForm formType,
    {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}
    ) =>
    getManyIncluding(getTax1099FormFormType, formType, modelFilter: modelFilter, includes: includes);

	
List<Tax1099Form> getByAmount(
    double amount,
    {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}
    ) =>
    getManyIncluding(getTax1099FormAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<Tax1099Form> getByDescription(
    String description,
    {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}
    ) =>
    getManyIncluding(getTax1099FormDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Tax1099Form> getByIssuedAt(
    DateTime issuedAt,
    {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}
    ) =>
    getManyIncluding(getTax1099FormIssuedAt, issuedAt, modelFilter: modelFilter, includes: includes);

	
List<Tax1099Form> getByMailedAt(
    DateTime mailedAt,
    {ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}
    ) =>
    getManyIncluding(getTax1099FormMailedAt, mailedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Tax1099Form tax1099Form, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (tax1099Form.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(tax1099Form.orgId!, includes: includes);
        tax1099Form.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Contact? getRecipient(
    Tax1099Form tax1099Form, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (tax1099Form.recipientId == null) {
        return null;
    } else {
        final recipient = ContactStore.instance.getById(tax1099Form.recipientId!, includes: includes);
        tax1099Form.recipient = recipient;
        // setIncludedReferences(recipient, includes: includes);
        return recipient;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Tax1099Form>> getAll$({bool useCache = true, ModelFilter<Tax1099Form>? modelFilter, List<Tax1099FormInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: Tax1099FormEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Tax1099Form?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Tax1099Form>? modelFilter,
        List<Tax1099FormInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTax1099FormId,
        value: id,
        modelFilter: modelFilter,
        endpoint: Tax1099FormEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Tax1099Form>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Tax1099Form>? modelFilter,
        List<Tax1099FormInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTax1099FormOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: Tax1099FormEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tax1099Form>> getByRecipientId$(
        String recipientId,
        {bool useCache = true,
        ModelFilter<Tax1099Form>? modelFilter,
        List<Tax1099FormInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTax1099FormRecipientId,
        value: recipientId,
        modelFilter: modelFilter,
        endpoint: Tax1099FormEndpoints.getManyByRecipientId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tax1099Form>> getByTaxYear$(
        int taxYear,
        {bool useCache = true,
        ModelFilter<Tax1099Form>? modelFilter,
        List<Tax1099FormInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getTax1099FormTaxYear,
        value: taxYear,
        modelFilter: modelFilter,
        endpoint: Tax1099FormEndpoints.getManyByTaxYear,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tax1099Form>> getByFormType$(
        USTaxForm formType,
        {bool useCache = true,
        ModelFilter<Tax1099Form>? modelFilter,
        List<Tax1099FormInclude>? includes}) {
    final items$ = getManyByFieldValue$<USTaxForm>(
        getPropVal: getTax1099FormFormType,
        value: formType,
        modelFilter: modelFilter,
        endpoint: Tax1099FormEndpoints.getManyByFormType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tax1099Form>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<Tax1099Form>? modelFilter,
        List<Tax1099FormInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getTax1099FormAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: Tax1099FormEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tax1099Form>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Tax1099Form>? modelFilter,
        List<Tax1099FormInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTax1099FormDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: Tax1099FormEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tax1099Form>> getByIssuedAt$(
        DateTime issuedAt,
        {bool useCache = true,
        ModelFilter<Tax1099Form>? modelFilter,
        List<Tax1099FormInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTax1099FormIssuedAt,
        value: issuedAt,
        modelFilter: modelFilter,
        endpoint: Tax1099FormEndpoints.getManyByIssuedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tax1099Form>> getByMailedAt$(
        DateTime mailedAt,
        {bool useCache = true,
        ModelFilter<Tax1099Form>? modelFilter,
        List<Tax1099FormInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTax1099FormMailedAt,
        value: mailedAt,
        modelFilter: modelFilter,
        endpoint: Tax1099FormEndpoints.getManyByMailedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Tax1099Form tax1099Form, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (tax1099Form.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            tax1099Form.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            tax1099Form.org = org;
        });
    }
}

	Stream<Contact?> getRecipient$(
    Tax1099Form tax1099Form, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (tax1099Form.recipientId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            tax1099Form.recipientId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((recipient) {
            tax1099Form.recipient = recipient;
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
Tax1099Form recursiveUpsert(Tax1099Form tax1099Form, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Tax1099Form'} 
        : const {};
    if (tax1099Form.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        tax1099Form.org = OrganizationStore.instance.recursiveUpsert(tax1099Form.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tax1099Form.recipient != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        tax1099Form.recipient = ContactStore.instance.recursiveUpsert(tax1099Form.recipient!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(tax1099Form);
}

  List<Tax1099Form> recursiveListUpsert(List<Tax1099Form> tax1099Forms, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedTax1099Forms = <Tax1099Form>[];
    for (var tax1099Form in tax1099Forms) {
        updatedTax1099Forms.add(recursiveUpsert(tax1099Form, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedTax1099Forms;
}

//   @override
//   Tax1099Form upsert(Tax1099Form item) {
//     return recursiveUpsert(item);
//   }

}


class Tax1099FormInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      Tax1099FormInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tax1099Form) => Tax1099FormStore.instance
            .getOrg$(tax1099Form, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tax1099Form) => Tax1099FormStore.instance
            .getOrg(tax1099Form, modelFilter: modelFilter, includes: includes);
      }
}

	Tax1099FormInclude.recipient({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tax1099Form) => Tax1099FormStore.instance
            .getRecipient$(tax1099Form, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tax1099Form) => Tax1099FormStore.instance
            .getRecipient(tax1099Form, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum Tax1099FormEndpoints implements Endpoint {

    getAll('/tax1099Form', HttpMethod.post, List<Tax1099Form>),
	getById('/tax1099Form/byId/:id', HttpMethod.post, Tax1099Form),
	getManyByOrgId('/tax1099Form/byOrgId/:orgId', HttpMethod.post, List<Tax1099Form>),
	getManyByRecipientId('/tax1099Form/byRecipientId/:recipientId', HttpMethod.post, List<Tax1099Form>),
	getManyByTaxYear('/tax1099Form/byTaxYear/:taxYear', HttpMethod.post, List<Tax1099Form>),
	getManyByFormType('/tax1099Form/byFormType/:formType', HttpMethod.post, List<Tax1099Form>),
	getManyByAmount('/tax1099Form/byAmount/:amount', HttpMethod.post, List<Tax1099Form>),
	getManyByDescription('/tax1099Form/byDescription/:description', HttpMethod.post, List<Tax1099Form>),
	getManyByIssuedAt('/tax1099Form/byIssuedAt/:issuedAt', HttpMethod.post, List<Tax1099Form>),
	getManyByMailedAt('/tax1099Form/byMailedAt/:mailedAt', HttpMethod.post, List<Tax1099Form>);

    const Tax1099FormEndpoints(this.path, this.method, this.responseType);

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
