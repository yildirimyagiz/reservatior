
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'rental_platform.dart';
import 'rental_status.dart';
import 'api_integration.dart';
import 'organization.dart';


class ExternalRentalListing implements PrismaModel<String, ExternalRentalListing> , Id<String> {
    @override
String? id;
	String? orgId;
	String? integrationId;
	RentalPlatform? platform;
	String? externalId;
	String? externalUrl;
	String? title;
	String? description;
	RentalStatus? status;
	String? address;
	String? city;
	String? state;
	String? zip;
	String? country;
	double? latitude;
	double? longitude;
	double? nightlyRate;
	String? currency;
	double? cleaningFee;
	double? serviceFee;
	String? checkInTime;
	String? checkOutTime;
	int? minStay;
	int? maxStay;
	int? bedrooms;
	double? bathrooms;
	int? maxGuests;
	List<String>? amenities;
	dynamic rawData;
	DateTime? lastSyncedAt;
	bool? isActive;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	ApiIntegration? integration;
	Organization? org;
	int? $amenitiesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ExternalRentalListing({ this.id,
	 this.orgId,
	 this.integrationId,
	 this.platform,
	 this.externalId,
	 this.externalUrl,
	 this.title,
	 this.description,
	 this.status = RentalStatus.DRAFT,
	 this.address,
	 this.city,
	 this.state,
	 this.zip,
	 this.country = "US",
	 this.latitude,
	 this.longitude,
	 this.nightlyRate,
	 this.currency = "USD",
	 this.cleaningFee,
	 this.serviceFee,
	 this.checkInTime,
	 this.checkOutTime,
	 this.minStay,
	 this.maxStay,
	 this.bedrooms,
	 this.bathrooms,
	 this.maxGuests,
	 this.amenities,
	required this.rawData,
	 this.lastSyncedAt,
	 this.isActive = true,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.integration,
	 this.org,
	this.$amenitiesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ExternalRentalListing, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"integrationId": (m) => m.integrationId,

	"platform": (m) => m.platform,

	"externalId": (m) => m.externalId,

	"externalUrl": (m) => m.externalUrl,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"status": (m) => m.status,

	"address": (m) => m.address,

	"city": (m) => m.city,

	"state": (m) => m.state,

	"zip": (m) => m.zip,

	"country": (m) => m.country,

	"latitude": (m) => m.latitude,

	"longitude": (m) => m.longitude,

	"nightlyRate": (m) => m.nightlyRate,

	"currency": (m) => m.currency,

	"cleaningFee": (m) => m.cleaningFee,

	"serviceFee": (m) => m.serviceFee,

	"checkInTime": (m) => m.checkInTime,

	"checkOutTime": (m) => m.checkOutTime,

	"minStay": (m) => m.minStay,

	"maxStay": (m) => m.maxStay,

	"bedrooms": (m) => m.bedrooms,

	"bathrooms": (m) => m.bathrooms,

	"maxGuests": (m) => m.maxGuests,

	"amenities": (m) => m.amenities,

	"rawData": (m) => m.rawData,

	"lastSyncedAt": (m) => m.lastSyncedAt,

	"isActive": (m) => m.isActive,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"integration": (m) => m.integration,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ExternalRentalListing) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ExternalRentalListing');
    }
    return propFunction as V? Function(ExternalRentalListing);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ExternalRentalListing.fromJson(JsonMap json) =>
      ExternalRentalListing(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	integrationId: json['integrationId'] as String?,
	platform: json['platform'] != null ? RentalPlatform.fromJson(json['platform']) : null,
	externalId: json['externalId'] as String?,
	externalUrl: json['externalUrl'] as String?,
	title: json['title'] as String?,
	description: json['description'] as String?,
	status: json['status'] != null ? RentalStatus.fromJson(json['status']) : null,
	address: json['address'] as String?,
	city: json['city'] as String?,
	state: json['state'] as String?,
	zip: json['zip'] as String?,
	country: json['country'] as String?,
	latitude: json['latitude']?.toDouble(),
	longitude: json['longitude']?.toDouble(),
	nightlyRate: json['nightlyRate'] as double?,
	currency: json['currency'] as String?,
	cleaningFee: json['cleaningFee'] as double?,
	serviceFee: json['serviceFee'] as double?,
	checkInTime: json['checkInTime'] as String?,
	checkOutTime: json['checkOutTime'] as String?,
	minStay: int.tryParse(json['minStay'].toString()),
	maxStay: int.tryParse(json['maxStay'].toString()),
	bedrooms: int.tryParse(json['bedrooms'].toString()),
	bathrooms: json['bathrooms']?.toDouble(),
	maxGuests: int.tryParse(json['maxGuests'].toString()),
	amenities: json['amenities'] != null ? (json['amenities'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	rawData: json['rawData'] as dynamic,
	lastSyncedAt: json['lastSyncedAt'] != null ? DateTime.parse(json['lastSyncedAt']) : null,
	isActive: json['isActive'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	integration: json['integration'] != null ? ApiIntegration.fromJson(json['integration'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	$amenitiesCount: json['_count']?['amenities'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ExternalRentalListing copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? integrationId,
		Value<RentalPlatform?>? platform,
		Value<String?>? externalId,
		Value<String?>? externalUrl,
		Value<String?>? title,
		Value<String?>? description,
		Value<RentalStatus?>? status,
		Value<String?>? address,
		Value<String?>? city,
		Value<String?>? state,
		Value<String?>? zip,
		Value<String?>? country,
		Value<double?>? latitude,
		Value<double?>? longitude,
		Value<double?>? nightlyRate,
		Value<String?>? currency,
		Value<double?>? cleaningFee,
		Value<double?>? serviceFee,
		Value<String?>? checkInTime,
		Value<String?>? checkOutTime,
		Value<int?>? minStay,
		Value<int?>? maxStay,
		Value<int?>? bedrooms,
		Value<double?>? bathrooms,
		Value<int?>? maxGuests,
		Value<List<String>?>? amenities,
		Value<dynamic>? rawData,
		Value<DateTime?>? lastSyncedAt,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<ApiIntegration?>? integration,
		Value<Organization?>? org,
		int? $amenitiesCount,
        }) {
        return ExternalRentalListing(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		integrationId: integrationId != null ? integrationId.value : this.integrationId,
		platform: platform != null ? platform.value : this.platform,
		externalId: externalId != null ? externalId.value : this.externalId,
		externalUrl: externalUrl != null ? externalUrl.value : this.externalUrl,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		status: status != null ? status.value : this.status,
		address: address != null ? address.value : this.address,
		city: city != null ? city.value : this.city,
		state: state != null ? state.value : this.state,
		zip: zip != null ? zip.value : this.zip,
		country: country != null ? country.value : this.country,
		latitude: latitude != null ? latitude.value : this.latitude,
		longitude: longitude != null ? longitude.value : this.longitude,
		nightlyRate: nightlyRate != null ? nightlyRate.value : this.nightlyRate,
		currency: currency != null ? currency.value : this.currency,
		cleaningFee: cleaningFee != null ? cleaningFee.value : this.cleaningFee,
		serviceFee: serviceFee != null ? serviceFee.value : this.serviceFee,
		checkInTime: checkInTime != null ? checkInTime.value : this.checkInTime,
		checkOutTime: checkOutTime != null ? checkOutTime.value : this.checkOutTime,
		minStay: minStay != null ? minStay.value : this.minStay,
		maxStay: maxStay != null ? maxStay.value : this.maxStay,
		bedrooms: bedrooms != null ? bedrooms.value : this.bedrooms,
		bathrooms: bathrooms != null ? bathrooms.value : this.bathrooms,
		maxGuests: maxGuests != null ? maxGuests.value : this.maxGuests,
		amenities: amenities != null ? amenities.value : this.amenities,
		rawData: rawData != null ? rawData.value : this.rawData,
		lastSyncedAt: lastSyncedAt != null ? lastSyncedAt.value : this.lastSyncedAt,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		integration: integration != null ? integration.value : this.integration,
		org: org != null ? org.value : this.org,
		$amenitiesCount: $amenitiesCount ?? this.$amenitiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ExternalRentalListing copyWithInstanceValues(ExternalRentalListing externalRentalListing) {
        return ExternalRentalListing(
            id: externalRentalListing.id ?? id,
		orgId: externalRentalListing.orgId ?? orgId,
		integrationId: externalRentalListing.integrationId ?? integrationId,
		platform: externalRentalListing.platform ?? platform,
		externalId: externalRentalListing.externalId ?? externalId,
		externalUrl: externalRentalListing.externalUrl ?? externalUrl,
		title: externalRentalListing.title ?? title,
		description: externalRentalListing.description ?? description,
		status: externalRentalListing.status ?? status,
		address: externalRentalListing.address ?? address,
		city: externalRentalListing.city ?? city,
		state: externalRentalListing.state ?? state,
		zip: externalRentalListing.zip ?? zip,
		country: externalRentalListing.country ?? country,
		latitude: externalRentalListing.latitude ?? latitude,
		longitude: externalRentalListing.longitude ?? longitude,
		nightlyRate: externalRentalListing.nightlyRate ?? nightlyRate,
		currency: externalRentalListing.currency ?? currency,
		cleaningFee: externalRentalListing.cleaningFee ?? cleaningFee,
		serviceFee: externalRentalListing.serviceFee ?? serviceFee,
		checkInTime: externalRentalListing.checkInTime ?? checkInTime,
		checkOutTime: externalRentalListing.checkOutTime ?? checkOutTime,
		minStay: externalRentalListing.minStay ?? minStay,
		maxStay: externalRentalListing.maxStay ?? maxStay,
		bedrooms: externalRentalListing.bedrooms ?? bedrooms,
		bathrooms: externalRentalListing.bathrooms ?? bathrooms,
		maxGuests: externalRentalListing.maxGuests ?? maxGuests,
		amenities: externalRentalListing.amenities ?? amenities,
		rawData: externalRentalListing.rawData ?? rawData,
		lastSyncedAt: externalRentalListing.lastSyncedAt ?? lastSyncedAt,
		isActive: externalRentalListing.isActive ?? isActive,
		createdBy: externalRentalListing.createdBy ?? createdBy,
		createdAt: externalRentalListing.createdAt ?? createdAt,
		updatedAt: externalRentalListing.updatedAt ?? updatedAt,
		deletedAt: externalRentalListing.deletedAt ?? deletedAt,
		integration: externalRentalListing.integration ?? integration,
		org: externalRentalListing.org ?? org,
		$amenitiesCount: externalRentalListing.$amenitiesCount ?? $amenitiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ExternalRentalListing mergeWithInstanceValues(ExternalRentalListing externalRentalListing) {
        return ExternalRentalListing(
            id: externalRentalListing.$assignedFields.contains('id') ? externalRentalListing.id : id,
		orgId: externalRentalListing.$assignedFields.contains('orgId') ? externalRentalListing.orgId : orgId,
		integrationId: externalRentalListing.$assignedFields.contains('integrationId') ? externalRentalListing.integrationId : integrationId,
		platform: externalRentalListing.$assignedFields.contains('platform') ? externalRentalListing.platform : platform,
		externalId: externalRentalListing.$assignedFields.contains('externalId') ? externalRentalListing.externalId : externalId,
		externalUrl: externalRentalListing.$assignedFields.contains('externalUrl') ? externalRentalListing.externalUrl : externalUrl,
		title: externalRentalListing.$assignedFields.contains('title') ? externalRentalListing.title : title,
		description: externalRentalListing.$assignedFields.contains('description') ? externalRentalListing.description : description,
		status: externalRentalListing.$assignedFields.contains('status') ? externalRentalListing.status : status,
		address: externalRentalListing.$assignedFields.contains('address') ? externalRentalListing.address : address,
		city: externalRentalListing.$assignedFields.contains('city') ? externalRentalListing.city : city,
		state: externalRentalListing.$assignedFields.contains('state') ? externalRentalListing.state : state,
		zip: externalRentalListing.$assignedFields.contains('zip') ? externalRentalListing.zip : zip,
		country: externalRentalListing.$assignedFields.contains('country') ? externalRentalListing.country : country,
		latitude: externalRentalListing.$assignedFields.contains('latitude') ? externalRentalListing.latitude : latitude,
		longitude: externalRentalListing.$assignedFields.contains('longitude') ? externalRentalListing.longitude : longitude,
		nightlyRate: externalRentalListing.$assignedFields.contains('nightlyRate') ? externalRentalListing.nightlyRate : nightlyRate,
		currency: externalRentalListing.$assignedFields.contains('currency') ? externalRentalListing.currency : currency,
		cleaningFee: externalRentalListing.$assignedFields.contains('cleaningFee') ? externalRentalListing.cleaningFee : cleaningFee,
		serviceFee: externalRentalListing.$assignedFields.contains('serviceFee') ? externalRentalListing.serviceFee : serviceFee,
		checkInTime: externalRentalListing.$assignedFields.contains('checkInTime') ? externalRentalListing.checkInTime : checkInTime,
		checkOutTime: externalRentalListing.$assignedFields.contains('checkOutTime') ? externalRentalListing.checkOutTime : checkOutTime,
		minStay: externalRentalListing.$assignedFields.contains('minStay') ? externalRentalListing.minStay : minStay,
		maxStay: externalRentalListing.$assignedFields.contains('maxStay') ? externalRentalListing.maxStay : maxStay,
		bedrooms: externalRentalListing.$assignedFields.contains('bedrooms') ? externalRentalListing.bedrooms : bedrooms,
		bathrooms: externalRentalListing.$assignedFields.contains('bathrooms') ? externalRentalListing.bathrooms : bathrooms,
		maxGuests: externalRentalListing.$assignedFields.contains('maxGuests') ? externalRentalListing.maxGuests : maxGuests,
		amenities: externalRentalListing.$assignedFields.contains('amenities') ? externalRentalListing.amenities : amenities,
		rawData: externalRentalListing.$assignedFields.contains('rawData') ? externalRentalListing.rawData : rawData,
		lastSyncedAt: externalRentalListing.$assignedFields.contains('lastSyncedAt') ? externalRentalListing.lastSyncedAt : lastSyncedAt,
		isActive: externalRentalListing.$assignedFields.contains('isActive') ? externalRentalListing.isActive : isActive,
		createdBy: externalRentalListing.$assignedFields.contains('createdBy') ? externalRentalListing.createdBy : createdBy,
		createdAt: externalRentalListing.$assignedFields.contains('createdAt') ? externalRentalListing.createdAt : createdAt,
		updatedAt: externalRentalListing.$assignedFields.contains('updatedAt') ? externalRentalListing.updatedAt : updatedAt,
		deletedAt: externalRentalListing.$assignedFields.contains('deletedAt') ? externalRentalListing.deletedAt : deletedAt,
		integration: externalRentalListing.$assignedFields.contains('integration') ? externalRentalListing.integration : integration,
		org: externalRentalListing.$assignedFields.contains('org') ? externalRentalListing.org : org,
		$amenitiesCount: externalRentalListing.$amenitiesCount ?? $amenitiesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ExternalRentalListing updateWithInstanceValues(ExternalRentalListing externalRentalListing) {
        if (externalRentalListing.$assignedFields.contains('id')) { id = externalRentalListing.id; }
		if (externalRentalListing.$assignedFields.contains('orgId')) { orgId = externalRentalListing.orgId; }
		if (externalRentalListing.$assignedFields.contains('integrationId')) { integrationId = externalRentalListing.integrationId; }
		if (externalRentalListing.$assignedFields.contains('platform')) { platform = externalRentalListing.platform; }
		if (externalRentalListing.$assignedFields.contains('externalId')) { externalId = externalRentalListing.externalId; }
		if (externalRentalListing.$assignedFields.contains('externalUrl')) { externalUrl = externalRentalListing.externalUrl; }
		if (externalRentalListing.$assignedFields.contains('title')) { title = externalRentalListing.title; }
		if (externalRentalListing.$assignedFields.contains('description')) { description = externalRentalListing.description; }
		if (externalRentalListing.$assignedFields.contains('status')) { status = externalRentalListing.status; }
		if (externalRentalListing.$assignedFields.contains('address')) { address = externalRentalListing.address; }
		if (externalRentalListing.$assignedFields.contains('city')) { city = externalRentalListing.city; }
		if (externalRentalListing.$assignedFields.contains('state')) { state = externalRentalListing.state; }
		if (externalRentalListing.$assignedFields.contains('zip')) { zip = externalRentalListing.zip; }
		if (externalRentalListing.$assignedFields.contains('country')) { country = externalRentalListing.country; }
		if (externalRentalListing.$assignedFields.contains('latitude')) { latitude = externalRentalListing.latitude; }
		if (externalRentalListing.$assignedFields.contains('longitude')) { longitude = externalRentalListing.longitude; }
		if (externalRentalListing.$assignedFields.contains('nightlyRate')) { nightlyRate = externalRentalListing.nightlyRate; }
		if (externalRentalListing.$assignedFields.contains('currency')) { currency = externalRentalListing.currency; }
		if (externalRentalListing.$assignedFields.contains('cleaningFee')) { cleaningFee = externalRentalListing.cleaningFee; }
		if (externalRentalListing.$assignedFields.contains('serviceFee')) { serviceFee = externalRentalListing.serviceFee; }
		if (externalRentalListing.$assignedFields.contains('checkInTime')) { checkInTime = externalRentalListing.checkInTime; }
		if (externalRentalListing.$assignedFields.contains('checkOutTime')) { checkOutTime = externalRentalListing.checkOutTime; }
		if (externalRentalListing.$assignedFields.contains('minStay')) { minStay = externalRentalListing.minStay; }
		if (externalRentalListing.$assignedFields.contains('maxStay')) { maxStay = externalRentalListing.maxStay; }
		if (externalRentalListing.$assignedFields.contains('bedrooms')) { bedrooms = externalRentalListing.bedrooms; }
		if (externalRentalListing.$assignedFields.contains('bathrooms')) { bathrooms = externalRentalListing.bathrooms; }
		if (externalRentalListing.$assignedFields.contains('maxGuests')) { maxGuests = externalRentalListing.maxGuests; }
		if (externalRentalListing.$assignedFields.contains('amenities')) { amenities = externalRentalListing.amenities; }
		if (externalRentalListing.$assignedFields.contains('rawData')) { rawData = externalRentalListing.rawData; }
		if (externalRentalListing.$assignedFields.contains('lastSyncedAt')) { lastSyncedAt = externalRentalListing.lastSyncedAt; }
		if (externalRentalListing.$assignedFields.contains('isActive')) { isActive = externalRentalListing.isActive; }
		if (externalRentalListing.$assignedFields.contains('createdBy')) { createdBy = externalRentalListing.createdBy; }
		if (externalRentalListing.$assignedFields.contains('createdAt')) { createdAt = externalRentalListing.createdAt; }
		if (externalRentalListing.$assignedFields.contains('updatedAt')) { updatedAt = externalRentalListing.updatedAt; }
		if (externalRentalListing.$assignedFields.contains('deletedAt')) { deletedAt = externalRentalListing.deletedAt; }
		if (externalRentalListing.$assignedFields.contains('integration')) { integration = externalRentalListing.integration; }
		if (externalRentalListing.$assignedFields.contains('org')) { org = externalRentalListing.org; }
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
          ? {...?serializedTypes, 'ExternalRentalListing'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(integrationId != null) 'integrationId': integrationId,
	if(platform != null) 'platform': platform?.toJson(),
	if(externalId != null) 'externalId': externalId,
	if(externalUrl != null) 'externalUrl': externalUrl,
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(status != null) 'status': status?.toJson(),
	if(address != null) 'address': address,
	if(city != null) 'city': city,
	if(state != null) 'state': state,
	if(zip != null) 'zip': zip,
	if(country != null) 'country': country,
	if(latitude != null) 'latitude': latitude,
	if(longitude != null) 'longitude': longitude,
	if(nightlyRate != null) 'nightlyRate': nightlyRate,
	if(currency != null) 'currency': currency,
	if(cleaningFee != null) 'cleaningFee': cleaningFee,
	if(serviceFee != null) 'serviceFee': serviceFee,
	if(checkInTime != null) 'checkInTime': checkInTime,
	if(checkOutTime != null) 'checkOutTime': checkOutTime,
	if(minStay != null) 'minStay': minStay,
	if(maxStay != null) 'maxStay': maxStay,
	if(bedrooms != null) 'bedrooms': bedrooms,
	if(bathrooms != null) 'bathrooms': bathrooms,
	if(maxGuests != null) 'maxGuests': maxGuests,
	if(amenities != null) 'amenities': amenities,
	if(rawData != null) 'rawData': rawData,
	if(lastSyncedAt != null) 'lastSyncedAt': lastSyncedAt?.toIso8601String(),
	if(isActive != null) 'isActive': isActive,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(integration != null && (!preventCircularSerialization || !serializedModels.contains('ApiIntegration'))) 'integration': integration?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($amenitiesCount != null) '_count': { 
		if ($amenitiesCount != null) 'amenities': $amenitiesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ExternalRentalListing &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    