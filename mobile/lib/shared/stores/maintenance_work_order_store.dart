
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MaintenanceWorkOrderStore extends ModelStreamStore<String, MaintenanceWorkOrder> {

  static MaintenanceWorkOrderStore? _instance;

  static MaintenanceWorkOrderStore get instance {
    _instance ??= MaintenanceWorkOrderStore();
    return _instance!;
  }

  MaintenanceWorkOrderStore() : super(MaintenanceWorkOrder.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MaintenanceWorkOrderStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MaintenanceWorkOrderStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MaintenanceWorkOrderStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMaintenanceWorkOrderId(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.id;

	String? getMaintenanceWorkOrderPropertyId(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.propertyId;

	String? getMaintenanceWorkOrderTenantId(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.tenantId;

	String? getMaintenanceWorkOrderReportedBy(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.reportedBy;

	String? getMaintenanceWorkOrderTitle(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.title;

	String? getMaintenanceWorkOrderDescription(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.description;

	Priority? getMaintenanceWorkOrderPriority(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.priority;

	String? getMaintenanceWorkOrderCategory(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.category;

	WorkOrderStatus? getMaintenanceWorkOrderStatus(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.status;

	DateTime? getMaintenanceWorkOrderReportedAt(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.reportedAt;

	DateTime? getMaintenanceWorkOrderDueDate(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.dueDate;

	String? getMaintenanceWorkOrderAssignedTo(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.assignedTo;

	String? getMaintenanceWorkOrderAssignedVendor(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.assignedVendor;

	double? getMaintenanceWorkOrderEstimatedCost(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.estimatedCost;

	double? getMaintenanceWorkOrderActualCost(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.actualCost;

	String? getMaintenanceWorkOrderUserId(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.userId;

	String? getMaintenanceWorkOrderOrganizationId(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.organizationId;

	bool? getMaintenanceWorkOrderIsActive(MaintenanceWorkOrder maintenanceWorkOrder) => maintenanceWorkOrder.isActive;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MaintenanceWorkOrder> getByPropertyId(
    String propertyId,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByTenantId(
    String tenantId,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderTenantId, tenantId, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByReportedBy(
    String reportedBy,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderReportedBy, reportedBy, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByTitle(
    String title,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderTitle, title, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByDescription(
    String description,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderDescription, description, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByPriority(
    Priority priority,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderPriority, priority, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByCategory(
    String category,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderCategory, category, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByStatus(
    WorkOrderStatus status,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderStatus, status, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByReportedAt(
    DateTime reportedAt,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderReportedAt, reportedAt, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByDueDate(
    DateTime dueDate,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderDueDate, dueDate, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByAssignedTo(
    String assignedTo,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderAssignedTo, assignedTo, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByAssignedVendor(
    String assignedVendor,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderAssignedVendor, assignedVendor, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByEstimatedCost(
    double estimatedCost,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderEstimatedCost, estimatedCost, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByActualCost(
    double actualCost,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderActualCost, actualCost, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByUserId(
    String userId,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByOrganizationId(
    String organizationId,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderOrganizationId, organizationId, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceWorkOrder> getByIsActive(
    bool isActive,
    {ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceWorkOrderIsActive, isActive, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrganization(
    MaintenanceWorkOrder maintenanceWorkOrder, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (maintenanceWorkOrder.organizationId == null) {
        return null;
    } else {
        final organization = OrganizationStore.instance.getById(maintenanceWorkOrder.organizationId!, includes: includes);
        maintenanceWorkOrder.organization = organization;
        // setIncludedReferences(organization, includes: includes);
        return organization;
    }
}

	Property? getProperty(
    MaintenanceWorkOrder maintenanceWorkOrder, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (maintenanceWorkOrder.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(maintenanceWorkOrder.propertyId!, includes: includes);
        maintenanceWorkOrder.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

	Tenant? getTenant(
    MaintenanceWorkOrder maintenanceWorkOrder, {ModelFilter? modelFilter, List<TenantInclude>? includes}) {
    if (maintenanceWorkOrder.tenantId == null) {
        return null;
    } else {
        final tenant = TenantStore.instance.getById(maintenanceWorkOrder.tenantId!, includes: includes);
        maintenanceWorkOrder.tenant = tenant;
        // setIncludedReferences(tenant, includes: includes);
        return tenant;
    }
}

	User? getUser(
    MaintenanceWorkOrder maintenanceWorkOrder, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (maintenanceWorkOrder.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(maintenanceWorkOrder.userId!, includes: includes);
        maintenanceWorkOrder.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

	User? getAssignedToUser(
    MaintenanceWorkOrder maintenanceWorkOrder, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (maintenanceWorkOrder.assignedTo == null) {
        return null;
    } else {
        final assignedToUser = UserStore.instance.getById(maintenanceWorkOrder.assignedTo!, includes: includes);
        maintenanceWorkOrder.assignedToUser = assignedToUser;
        // setIncludedReferences(assignedToUser, includes: includes);
        return assignedToUser;
    }
}

  /// GET RELATED MODELS 

  List<Contact> getContact(
    MaintenanceWorkOrder maintenanceWorkOrder, {ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    final Contact = ContactStore.instance.getBy(maintenanceWorkOrder.$uid!, modelFilter: modelFilter, includes: includes);
    maintenanceWorkOrder.Contact = Contact;
    // setIncludedReferencesForList(Contact, includes: includes);
    return Contact;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MaintenanceWorkOrder>> getAll$({bool useCache = true, ModelFilter<MaintenanceWorkOrder>? modelFilter, List<MaintenanceWorkOrderInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MaintenanceWorkOrderEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MaintenanceWorkOrder?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MaintenanceWorkOrder>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByTenantId$(
        String tenantId,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderTenantId,
        value: tenantId,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByTenantId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByReportedBy$(
        String reportedBy,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderReportedBy,
        value: reportedBy,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByReportedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByPriority$(
        Priority priority,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<Priority>(
        getPropVal: getMaintenanceWorkOrderPriority,
        value: priority,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByPriority,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByCategory$(
        String category,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderCategory,
        value: category,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByStatus$(
        WorkOrderStatus status,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<WorkOrderStatus>(
        getPropVal: getMaintenanceWorkOrderStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByReportedAt$(
        DateTime reportedAt,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMaintenanceWorkOrderReportedAt,
        value: reportedAt,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByReportedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByDueDate$(
        DateTime dueDate,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMaintenanceWorkOrderDueDate,
        value: dueDate,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByDueDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByAssignedTo$(
        String assignedTo,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderAssignedTo,
        value: assignedTo,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByAssignedTo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByAssignedVendor$(
        String assignedVendor,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderAssignedVendor,
        value: assignedVendor,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByAssignedVendor,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByEstimatedCost$(
        double estimatedCost,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMaintenanceWorkOrderEstimatedCost,
        value: estimatedCost,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByEstimatedCost,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByActualCost$(
        double actualCost,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMaintenanceWorkOrderActualCost,
        value: actualCost,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByActualCost,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByOrganizationId$(
        String organizationId,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceWorkOrderOrganizationId,
        value: organizationId,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByOrganizationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceWorkOrder>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<MaintenanceWorkOrder>? modelFilter,
        List<MaintenanceWorkOrderInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMaintenanceWorkOrderIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: MaintenanceWorkOrderEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrganization$(
    MaintenanceWorkOrder maintenanceWorkOrder, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (maintenanceWorkOrder.organizationId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            maintenanceWorkOrder.organizationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((organization) {
            maintenanceWorkOrder.organization = organization;
        });
    }
}

	Stream<Property?> getProperty$(
    MaintenanceWorkOrder maintenanceWorkOrder, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (maintenanceWorkOrder.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            maintenanceWorkOrder.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            maintenanceWorkOrder.property = property;
        });
    }
}

	Stream<Tenant?> getTenant$(
    MaintenanceWorkOrder maintenanceWorkOrder, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    if (maintenanceWorkOrder.tenantId == null) {
        return Stream.value(null);
    } else {
        return TenantStore.instance.getById$(
            maintenanceWorkOrder.tenantId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((tenant) {
            maintenanceWorkOrder.tenant = tenant;
        });
    }
}

	Stream<User?> getUser$(
    MaintenanceWorkOrder maintenanceWorkOrder, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (maintenanceWorkOrder.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            maintenanceWorkOrder.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            maintenanceWorkOrder.user = user;
        });
    }
}

	Stream<User?> getAssignedToUser$(
    MaintenanceWorkOrder maintenanceWorkOrder, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (maintenanceWorkOrder.assignedTo == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            maintenanceWorkOrder.assignedTo!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((assignedToUser) {
            maintenanceWorkOrder.assignedToUser = assignedToUser;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Contact>> getContact$(
    MaintenanceWorkOrder maintenanceWorkOrder, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    return ContactStore.instance.getBy$(
        maintenanceWorkOrder.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Contact) {
        maintenanceWorkOrder.Contact = Contact;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
MaintenanceWorkOrder recursiveUpsert(MaintenanceWorkOrder maintenanceWorkOrder, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MaintenanceWorkOrder'} 
        : const {};
    if (maintenanceWorkOrder.organization != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        maintenanceWorkOrder.organization = OrganizationStore.instance.recursiveUpsert(maintenanceWorkOrder.organization!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (maintenanceWorkOrder.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        maintenanceWorkOrder.property = PropertyStore.instance.recursiveUpsert(maintenanceWorkOrder.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (maintenanceWorkOrder.tenant != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        maintenanceWorkOrder.tenant = TenantStore.instance.recursiveUpsert(maintenanceWorkOrder.tenant!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (maintenanceWorkOrder.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        maintenanceWorkOrder.user = UserStore.instance.recursiveUpsert(maintenanceWorkOrder.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (maintenanceWorkOrder.assignedToUser != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        maintenanceWorkOrder.assignedToUser = UserStore.instance.recursiveUpsert(maintenanceWorkOrder.assignedToUser!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (maintenanceWorkOrder.Contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        maintenanceWorkOrder.Contact = ContactStore.instance.recursiveListUpsert(maintenanceWorkOrder.Contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(maintenanceWorkOrder);
}

  List<MaintenanceWorkOrder> recursiveListUpsert(List<MaintenanceWorkOrder> maintenanceWorkOrders, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMaintenanceWorkOrders = <MaintenanceWorkOrder>[];
    for (var maintenanceWorkOrder in maintenanceWorkOrders) {
        updatedMaintenanceWorkOrders.add(recursiveUpsert(maintenanceWorkOrder, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMaintenanceWorkOrders;
}

//   @override
//   MaintenanceWorkOrder upsert(MaintenanceWorkOrder item) {
//     return recursiveUpsert(item);
//   }

}


class MaintenanceWorkOrderInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MaintenanceWorkOrderInclude.organization({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getOrganization$(maintenanceWorkOrder, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getOrganization(maintenanceWorkOrder, modelFilter: modelFilter, includes: includes);
      }
}

	MaintenanceWorkOrderInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getProperty$(maintenanceWorkOrder, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getProperty(maintenanceWorkOrder, modelFilter: modelFilter, includes: includes);
      }
}

	MaintenanceWorkOrderInclude.tenant({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getTenant$(maintenanceWorkOrder, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getTenant(maintenanceWorkOrder, modelFilter: modelFilter, includes: includes);
      }
}

	MaintenanceWorkOrderInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getUser$(maintenanceWorkOrder, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getUser(maintenanceWorkOrder, modelFilter: modelFilter, includes: includes);
      }
}

	MaintenanceWorkOrderInclude.assignedToUser({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getAssignedToUser$(maintenanceWorkOrder, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getAssignedToUser(maintenanceWorkOrder, modelFilter: modelFilter, includes: includes);
      }
}

	MaintenanceWorkOrderInclude.Contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getContact$(maintenanceWorkOrder, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (maintenanceWorkOrder) => MaintenanceWorkOrderStore.instance
            .getContact(maintenanceWorkOrder, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MaintenanceWorkOrderEndpoints implements Endpoint {

    getAll('/maintenanceWorkOrder', HttpMethod.post, List<MaintenanceWorkOrder>),
	getById('/maintenanceWorkOrder/byId/:id', HttpMethod.post, MaintenanceWorkOrder),
	getManyByPropertyId('/maintenanceWorkOrder/byPropertyId/:propertyId', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByTenantId('/maintenanceWorkOrder/byTenantId/:tenantId', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByReportedBy('/maintenanceWorkOrder/byReportedBy/:reportedBy', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByTitle('/maintenanceWorkOrder/byTitle/:title', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByDescription('/maintenanceWorkOrder/byDescription/:description', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByPriority('/maintenanceWorkOrder/byPriority/:priority', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByCategory('/maintenanceWorkOrder/byCategory/:category', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByStatus('/maintenanceWorkOrder/byStatus/:status', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByReportedAt('/maintenanceWorkOrder/byReportedAt/:reportedAt', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByDueDate('/maintenanceWorkOrder/byDueDate/:dueDate', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByAssignedTo('/maintenanceWorkOrder/byAssignedTo/:assignedTo', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByAssignedVendor('/maintenanceWorkOrder/byAssignedVendor/:assignedVendor', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByEstimatedCost('/maintenanceWorkOrder/byEstimatedCost/:estimatedCost', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByActualCost('/maintenanceWorkOrder/byActualCost/:actualCost', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByUserId('/maintenanceWorkOrder/byUserId/:userId', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByOrganizationId('/maintenanceWorkOrder/byOrganizationId/:organizationId', HttpMethod.post, List<MaintenanceWorkOrder>),
	getManyByIsActive('/maintenanceWorkOrder/byIsActive/:isActive', HttpMethod.post, List<MaintenanceWorkOrder>);

    const MaintenanceWorkOrderEndpoints(this.path, this.method, this.responseType);

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
