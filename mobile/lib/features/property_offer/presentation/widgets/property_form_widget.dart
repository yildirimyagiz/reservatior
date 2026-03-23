import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Property Form Widget ──
// Fields: type, name, region, currency, addressLine1, addressLine2, city, state, zip, country, lat, lng, neighborhoodId, bedrooms, bathrooms, areaSqm, yearBuilt, notes, locationId, stateCode, propertyCategory, listingType, listingStatus, listingPrice, originalPrice, priceHistory, schoolDistrict, hoaFee, hoaFeeFrequency, propertyTaxRate, lastAssessmentValue, lastAssessmentYear, floodZone, zoningCode, lotSizeAcres, frontageFeet, depthFeet, basementType, basementFinishedSqFt, garageType, garageCapacity, parkingSpaces, parkingType, poolType, heatingType, coolingType, fireplaceType, fireplaceCount, viewType, waterfrontType, waterfrontFeet, constructionType, roofType, roofYear, sidingType, zipPlus4, countyFIPS, censusTract, mlsArea, propertyClass, buildingClass, totalRooms, livingAreaSqFt, lotSizeSqFt, stories, unitsPerBuilding, assessedValue, marketValue, propertyTax, insuranceAmount, mortgageBalance, lienAmount, electricityProvider, gasProvider, waterProvider, internetProvider, trashService, mlsNumber, mlsStatus, daysOnMarket, pricePerSqFt, rentalYield, yearRenovated, energyRating, zoningDescription, landUse, buildingRestrictions, futureDevelopment, leadPaintCompliance, moldInspectionDate, asbestosInspectionDate, radonTestDate, pestControlDate, fireInspectionDate, elevatorInspectionDate, poolInspectionDate, lastCodeComplianceDate, accessibilityCompliance

class PropertyFormWidget extends StatefulWidget {
  final Property? item;
  final void Function(Property)? onSubmit;
  const PropertyFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<PropertyFormWidget> createState() => _PropertyFormWidgetState();
}

class _PropertyFormWidgetState extends State<PropertyFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _type;
  String? _name;
  String? _region;
  String? _currency;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;
  String? _zip;
  String? _country;
  double? _lat;
  double? _lng;
  String? _neighborhoodId;
  int? _bedrooms;
  double? _bathrooms;
  double? _areaSqm;
  int? _yearBuilt;
  String? _notes;
  String? _locationId;
  String? _stateCode;
  String? _propertyCategory;
  String? _listingType;
  String? _listingStatus;
  double? _listingPrice;
  double? _originalPrice;
  String? _priceHistory;
  String? _schoolDistrict;
  double? _hoaFee;
  String? _hoaFeeFrequency;
  double? _propertyTaxRate;
  double? _lastAssessmentValue;
  int? _lastAssessmentYear;
  String? _floodZone;
  String? _zoningCode;
  double? _lotSizeAcres;
  double? _frontageFeet;
  double? _depthFeet;
  String? _basementType;
  double? _basementFinishedSqFt;
  String? _garageType;
  int? _garageCapacity;
  int? _parkingSpaces;
  String? _parkingType;
  String? _poolType;
  String? _heatingType;
  String? _coolingType;
  String? _fireplaceType;
  int? _fireplaceCount;
  String? _viewType;
  String? _waterfrontType;
  double? _waterfrontFeet;
  String? _constructionType;
  String? _roofType;
  int? _roofYear;
  String? _sidingType;
  String? _zipPlus4;
  String? _countyFIPS;
  String? _censusTract;
  String? _mlsArea;
  String? _propertyClass;
  String? _buildingClass;
  int? _totalRooms;
  double? _livingAreaSqFt;
  double? _lotSizeSqFt;
  int? _stories;
  int? _unitsPerBuilding;
  double? _assessedValue;
  double? _marketValue;
  double? _propertyTax;
  double? _insuranceAmount;
  double? _mortgageBalance;
  double? _lienAmount;
  String? _electricityProvider;
  String? _gasProvider;
  String? _waterProvider;
  String? _internetProvider;
  String? _trashService;
  String? _mlsNumber;
  String? _mlsStatus;
  int? _daysOnMarket;
  double? _pricePerSqFt;
  double? _rentalYield;
  int? _yearRenovated;
  String? _energyRating;
  String? _zoningDescription;
  String? _landUse;
  String? _buildingRestrictions;
  String? _futureDevelopment;
  bool _leadPaintCompliance = false;
  DateTime? _moldInspectionDate;
  DateTime? _asbestosInspectionDate;
  DateTime? _radonTestDate;
  DateTime? _pestControlDate;
  DateTime? _fireInspectionDate;
  DateTime? _elevatorInspectionDate;
  DateTime? _poolInspectionDate;
  DateTime? _lastCodeComplianceDate;
  bool _accessibilityCompliance = false;

  @override
  void initState() {
    super.initState();
    _type = widget.item?.type?.toString();
    _name = widget.item?.name?.toString();
    _region = widget.item?.region?.toString();
    _currency = widget.item?.currency?.toString();
    _addressLine1 = widget.item?.addressLine1?.toString();
    _addressLine2 = widget.item?.addressLine2?.toString();
    _city = widget.item?.city?.toString();
    _state = widget.item?.state?.toString();
    _zip = widget.item?.zip?.toString();
    _country = widget.item?.country?.toString();
    _lat = widget.item?.lat;
    _lng = widget.item?.lng;
    _neighborhoodId = widget.item?.neighborhoodId?.toString();
    _bedrooms = widget.item?.bedrooms;
    _bathrooms = widget.item?.bathrooms;
    _areaSqm = widget.item?.areaSqm;
    _yearBuilt = widget.item?.yearBuilt;
    _notes = widget.item?.notes?.toString();
    _locationId = widget.item?.locationId?.toString();
    _stateCode = widget.item?.stateCode?.toString();
    _propertyCategory = widget.item?.propertyCategory?.toString();
    _listingType = widget.item?.listingType?.toString();
    _listingStatus = widget.item?.listingStatus?.toString();
    _listingPrice = widget.item?.listingPrice;
    _originalPrice = widget.item?.originalPrice;
    _priceHistory = widget.item?.priceHistory?.toString();
    _schoolDistrict = widget.item?.schoolDistrict?.toString();
    _hoaFee = widget.item?.hoaFee;
    _hoaFeeFrequency = widget.item?.hoaFeeFrequency?.toString();
    _propertyTaxRate = widget.item?.propertyTaxRate;
    _lastAssessmentValue = widget.item?.lastAssessmentValue;
    _lastAssessmentYear = widget.item?.lastAssessmentYear;
    _floodZone = widget.item?.floodZone?.toString();
    _zoningCode = widget.item?.zoningCode?.toString();
    _lotSizeAcres = widget.item?.lotSizeAcres;
    _frontageFeet = widget.item?.frontageFeet;
    _depthFeet = widget.item?.depthFeet;
    _basementType = widget.item?.basementType?.toString();
    _basementFinishedSqFt = widget.item?.basementFinishedSqFt;
    _garageType = widget.item?.garageType?.toString();
    _garageCapacity = widget.item?.garageCapacity;
    _parkingSpaces = widget.item?.parkingSpaces;
    _parkingType = widget.item?.parkingType?.toString();
    _poolType = widget.item?.poolType?.toString();
    _heatingType = widget.item?.heatingType?.toString();
    _coolingType = widget.item?.coolingType?.toString();
    _fireplaceType = widget.item?.fireplaceType?.toString();
    _fireplaceCount = widget.item?.fireplaceCount;
    _viewType = widget.item?.viewType?.toString();
    _waterfrontType = widget.item?.waterfrontType?.toString();
    _waterfrontFeet = widget.item?.waterfrontFeet;
    _constructionType = widget.item?.constructionType?.toString();
    _roofType = widget.item?.roofType?.toString();
    _roofYear = widget.item?.roofYear;
    _sidingType = widget.item?.sidingType?.toString();
    _zipPlus4 = widget.item?.zipPlus4?.toString();
    _countyFIPS = widget.item?.countyFIPS?.toString();
    _censusTract = widget.item?.censusTract?.toString();
    _mlsArea = widget.item?.mlsArea?.toString();
    _propertyClass = widget.item?.propertyClass?.toString();
    _buildingClass = widget.item?.buildingClass?.toString();
    _totalRooms = widget.item?.totalRooms;
    _livingAreaSqFt = widget.item?.livingAreaSqFt;
    _lotSizeSqFt = widget.item?.lotSizeSqFt;
    _stories = widget.item?.stories;
    _unitsPerBuilding = widget.item?.unitsPerBuilding;
    _assessedValue = widget.item?.assessedValue;
    _marketValue = widget.item?.marketValue;
    _propertyTax = widget.item?.propertyTax;
    _insuranceAmount = widget.item?.insuranceAmount;
    _mortgageBalance = widget.item?.mortgageBalance;
    _lienAmount = widget.item?.lienAmount;
    _electricityProvider = widget.item?.electricityProvider?.toString();
    _gasProvider = widget.item?.gasProvider?.toString();
    _waterProvider = widget.item?.waterProvider?.toString();
    _internetProvider = widget.item?.internetProvider?.toString();
    _trashService = widget.item?.trashService?.toString();
    _mlsNumber = widget.item?.mlsNumber?.toString();
    _mlsStatus = widget.item?.mlsStatus?.toString();
    _daysOnMarket = widget.item?.daysOnMarket;
    _pricePerSqFt = widget.item?.pricePerSqFt;
    _rentalYield = widget.item?.rentalYield;
    _yearRenovated = widget.item?.yearRenovated;
    _energyRating = widget.item?.energyRating?.toString();
    _zoningDescription = widget.item?.zoningDescription?.toString();
    _landUse = widget.item?.landUse?.toString();
    _buildingRestrictions = widget.item?.buildingRestrictions?.toString();
    _futureDevelopment = widget.item?.futureDevelopment?.toString();
    _leadPaintCompliance = widget.item?.leadPaintCompliance ?? false;
    _moldInspectionDate = widget.item?.moldInspectionDate;
    _asbestosInspectionDate = widget.item?.asbestosInspectionDate;
    _radonTestDate = widget.item?.radonTestDate;
    _pestControlDate = widget.item?.pestControlDate;
    _fireInspectionDate = widget.item?.fireInspectionDate;
    _elevatorInspectionDate = widget.item?.elevatorInspectionDate;
    _poolInspectionDate = widget.item?.poolInspectionDate;
    _lastCodeComplianceDate = widget.item?.lastCodeComplianceDate;
    _accessibilityCompliance = widget.item?.accessibilityCompliance ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_type != null) 'type': _type,
        if (_name != null) 'name': _name,
        if (_region != null) 'region': _region,
        if (_currency != null) 'currency': _currency,
        if (_addressLine1 != null) 'addressLine1': _addressLine1,
        if (_addressLine2 != null) 'addressLine2': _addressLine2,
        if (_city != null) 'city': _city,
        if (_state != null) 'state': _state,
        if (_zip != null) 'zip': _zip,
        if (_country != null) 'country': _country,
        if (_lat != null) 'lat': _lat,
        if (_lng != null) 'lng': _lng,
        if (_neighborhoodId != null) 'neighborhoodId': _neighborhoodId,
        if (_bedrooms != null) 'bedrooms': _bedrooms,
        if (_bathrooms != null) 'bathrooms': _bathrooms,
        if (_areaSqm != null) 'areaSqm': _areaSqm,
        if (_yearBuilt != null) 'yearBuilt': _yearBuilt,
        if (_notes != null) 'notes': _notes,
        if (_locationId != null) 'locationId': _locationId,
        if (_stateCode != null) 'stateCode': _stateCode,
        if (_propertyCategory != null) 'propertyCategory': _propertyCategory,
        if (_listingType != null) 'listingType': _listingType,
        if (_listingStatus != null) 'listingStatus': _listingStatus,
        if (_listingPrice != null) 'listingPrice': _listingPrice,
        if (_originalPrice != null) 'originalPrice': _originalPrice,
        if (_priceHistory != null) 'priceHistory': _priceHistory,
        if (_schoolDistrict != null) 'schoolDistrict': _schoolDistrict,
        if (_hoaFee != null) 'hoaFee': _hoaFee,
        if (_hoaFeeFrequency != null) 'hoaFeeFrequency': _hoaFeeFrequency,
        if (_propertyTaxRate != null) 'propertyTaxRate': _propertyTaxRate,
        if (_lastAssessmentValue != null) 'lastAssessmentValue': _lastAssessmentValue,
        if (_lastAssessmentYear != null) 'lastAssessmentYear': _lastAssessmentYear,
        if (_floodZone != null) 'floodZone': _floodZone,
        if (_zoningCode != null) 'zoningCode': _zoningCode,
        if (_lotSizeAcres != null) 'lotSizeAcres': _lotSizeAcres,
        if (_frontageFeet != null) 'frontageFeet': _frontageFeet,
        if (_depthFeet != null) 'depthFeet': _depthFeet,
        if (_basementType != null) 'basementType': _basementType,
        if (_basementFinishedSqFt != null) 'basementFinishedSqFt': _basementFinishedSqFt,
        if (_garageType != null) 'garageType': _garageType,
        if (_garageCapacity != null) 'garageCapacity': _garageCapacity,
        if (_parkingSpaces != null) 'parkingSpaces': _parkingSpaces,
        if (_parkingType != null) 'parkingType': _parkingType,
        if (_poolType != null) 'poolType': _poolType,
        if (_heatingType != null) 'heatingType': _heatingType,
        if (_coolingType != null) 'coolingType': _coolingType,
        if (_fireplaceType != null) 'fireplaceType': _fireplaceType,
        if (_fireplaceCount != null) 'fireplaceCount': _fireplaceCount,
        if (_viewType != null) 'viewType': _viewType,
        if (_waterfrontType != null) 'waterfrontType': _waterfrontType,
        if (_waterfrontFeet != null) 'waterfrontFeet': _waterfrontFeet,
        if (_constructionType != null) 'constructionType': _constructionType,
        if (_roofType != null) 'roofType': _roofType,
        if (_roofYear != null) 'roofYear': _roofYear,
        if (_sidingType != null) 'sidingType': _sidingType,
        if (_zipPlus4 != null) 'zipPlus4': _zipPlus4,
        if (_countyFIPS != null) 'countyFIPS': _countyFIPS,
        if (_censusTract != null) 'censusTract': _censusTract,
        if (_mlsArea != null) 'mlsArea': _mlsArea,
        if (_propertyClass != null) 'propertyClass': _propertyClass,
        if (_buildingClass != null) 'buildingClass': _buildingClass,
        if (_totalRooms != null) 'totalRooms': _totalRooms,
        if (_livingAreaSqFt != null) 'livingAreaSqFt': _livingAreaSqFt,
        if (_lotSizeSqFt != null) 'lotSizeSqFt': _lotSizeSqFt,
        if (_stories != null) 'stories': _stories,
        if (_unitsPerBuilding != null) 'unitsPerBuilding': _unitsPerBuilding,
        if (_assessedValue != null) 'assessedValue': _assessedValue,
        if (_marketValue != null) 'marketValue': _marketValue,
        if (_propertyTax != null) 'propertyTax': _propertyTax,
        if (_insuranceAmount != null) 'insuranceAmount': _insuranceAmount,
        if (_mortgageBalance != null) 'mortgageBalance': _mortgageBalance,
        if (_lienAmount != null) 'lienAmount': _lienAmount,
        if (_electricityProvider != null) 'electricityProvider': _electricityProvider,
        if (_gasProvider != null) 'gasProvider': _gasProvider,
        if (_waterProvider != null) 'waterProvider': _waterProvider,
        if (_internetProvider != null) 'internetProvider': _internetProvider,
        if (_trashService != null) 'trashService': _trashService,
        if (_mlsNumber != null) 'mlsNumber': _mlsNumber,
        if (_mlsStatus != null) 'mlsStatus': _mlsStatus,
        if (_daysOnMarket != null) 'daysOnMarket': _daysOnMarket,
        if (_pricePerSqFt != null) 'pricePerSqFt': _pricePerSqFt,
        if (_rentalYield != null) 'rentalYield': _rentalYield,
        if (_yearRenovated != null) 'yearRenovated': _yearRenovated,
        if (_energyRating != null) 'energyRating': _energyRating,
        if (_zoningDescription != null) 'zoningDescription': _zoningDescription,
        if (_landUse != null) 'landUse': _landUse,
        if (_buildingRestrictions != null) 'buildingRestrictions': _buildingRestrictions,
        if (_futureDevelopment != null) 'futureDevelopment': _futureDevelopment,
        'leadPaintCompliance': _leadPaintCompliance,
        if (_moldInspectionDate != null) 'moldInspectionDate': _moldInspectionDate!.toIso8601String(),
        if (_asbestosInspectionDate != null) 'asbestosInspectionDate': _asbestosInspectionDate!.toIso8601String(),
        if (_radonTestDate != null) 'radonTestDate': _radonTestDate!.toIso8601String(),
        if (_pestControlDate != null) 'pestControlDate': _pestControlDate!.toIso8601String(),
        if (_fireInspectionDate != null) 'fireInspectionDate': _fireInspectionDate!.toIso8601String(),
        if (_elevatorInspectionDate != null) 'elevatorInspectionDate': _elevatorInspectionDate!.toIso8601String(),
        if (_poolInspectionDate != null) 'poolInspectionDate': _poolInspectionDate!.toIso8601String(),
        if (_lastCodeComplianceDate != null) 'lastCodeComplianceDate': _lastCodeComplianceDate!.toIso8601String(),
        'accessibilityCompliance': _accessibilityCompliance,
    };
    final result = widget.item != null
        ? Property.fromJson({...widget.item!.toJson(), ...data})
        : Property.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Region', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _region = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address Line1', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _addressLine1 = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address Line2', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _addressLine2 = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'City', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _city = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'State', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _state = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Zip', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _zip = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Country', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _country = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lat', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _lat = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lng', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _lng = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Neighborhood Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _neighborhoodId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bedrooms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _bedrooms = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bathrooms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _bathrooms = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Area Sqm', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _areaSqm = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year Built', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _yearBuilt = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _locationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'State Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _stateCode = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _propertyCategory = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _listingType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _listingStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Listing Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _listingPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Original Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _originalPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price History', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _priceHistory = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'School District', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _schoolDistrict = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Hoa Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _hoaFee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hoa Fee Frequency', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _hoaFeeFrequency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Property Tax Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _propertyTaxRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Assessment Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _lastAssessmentValue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Assessment Year', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _lastAssessmentYear = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Flood Zone', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _floodZone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Zoning Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _zoningCode = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lot Size Acres', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _lotSizeAcres = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Frontage Feet', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _frontageFeet = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Depth Feet', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _depthFeet = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Basement Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _basementType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Basement Finished Sq Ft', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _basementFinishedSqFt = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Garage Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _garageType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Garage Capacity', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _garageCapacity = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Parking Spaces', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _parkingSpaces = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Parking Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _parkingType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pool Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _poolType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Heating Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _heatingType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cooling Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _coolingType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fireplace Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _fireplaceType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fireplace Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _fireplaceCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'View Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _viewType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Waterfront Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _waterfrontType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Waterfront Feet', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _waterfrontFeet = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Construction Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _constructionType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Roof Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _roofType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Roof Year', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _roofYear = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Siding Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _sidingType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Zip Plus4', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _zipPlus4 = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'County F I P S', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _countyFIPS = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Census Tract', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _censusTract = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mls Area', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _mlsArea = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Class', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _propertyClass = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Building Class', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _buildingClass = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Rooms', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _totalRooms = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Living Area Sq Ft', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _livingAreaSqFt = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lot Size Sq Ft', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _lotSizeSqFt = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Stories', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _stories = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Units Per Building', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _unitsPerBuilding = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Assessed Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _assessedValue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Market Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _marketValue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Property Tax', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _propertyTax = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Insurance Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _insuranceAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mortgage Balance', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _mortgageBalance = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lien Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _lienAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Electricity Provider', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _electricityProvider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gas Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _gasProvider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Water Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _waterProvider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Internet Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _internetProvider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Trash Service', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _trashService = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mls Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _mlsNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mls Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _mlsStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Days On Market', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _daysOnMarket = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price Per Sq Ft', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _pricePerSqFt = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rental Yield', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _rentalYield = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year Renovated', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _yearRenovated = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Energy Rating', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _energyRating = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Zoning Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _zoningDescription = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Land Use', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _landUse = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Building Restrictions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _buildingRestrictions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Future Development', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _futureDevelopment = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Lead Paint Compliance'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _leadPaintCompliance,
                  onChanged: (v) { ss(() {}); setState(() => _leadPaintCompliance = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _moldInspectionDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _moldInspectionDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Mold Inspection Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_moldInspectionDate != null ? _fmt(_moldInspectionDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _asbestosInspectionDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _asbestosInspectionDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Asbestos Inspection Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_asbestosInspectionDate != null ? _fmt(_asbestosInspectionDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _radonTestDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _radonTestDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Radon Test Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_radonTestDate != null ? _fmt(_radonTestDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _pestControlDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _pestControlDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Pest Control Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_pestControlDate != null ? _fmt(_pestControlDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _fireInspectionDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _fireInspectionDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Fire Inspection Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_fireInspectionDate != null ? _fmt(_fireInspectionDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _elevatorInspectionDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _elevatorInspectionDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Elevator Inspection Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_elevatorInspectionDate != null ? _fmt(_elevatorInspectionDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _poolInspectionDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _poolInspectionDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Pool Inspection Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_poolInspectionDate != null ? _fmt(_poolInspectionDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _lastCodeComplianceDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastCodeComplianceDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Last Code Compliance Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_lastCodeComplianceDate != null ? _fmt(_lastCodeComplianceDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Accessibility Compliance'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _accessibilityCompliance,
                  onChanged: (v) { ss(() {}); setState(() => _accessibilityCompliance = v); },
                ),
              ),
              const SizedBox(height: 8),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
