import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/core/providers/region_provider.dart';
import 'package:reservatior/core/config/region_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/widgets/ai_reusable_widgets.dart';

class PropertyFormWidget extends ConsumerStatefulWidget {
  final Property? item;
  final Function(Property) onSubmit;
  const PropertyFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<PropertyFormWidget> createState() => _PropertyFormWidgetState();
}

class _PropertyFormWidgetState extends ConsumerState<PropertyFormWidget> {
  late final TextEditingController _notesController;
  String? _name;
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
  double? _listingPrice;
  double? _originalPrice;
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
  String? _propertyClas;
  String? _buildingClas;
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
  bool? _leadPaintCompliance;
  DateTime? _moldInspectionDate;
  DateTime? _asbestosInspectionDate;
  DateTime? _radonTestDate;
  DateTime? _pestControlDate;
  DateTime? _fireInspectionDate;
  DateTime? _elevatorInspectionDate;
  DateTime? _poolInspectionDate;
  DateTime? _lastCodeComplianceDate;
  bool? _accessibilityCompliance;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _currency = widget.item?.currency;
    _addressLine1 = widget.item?.addressLine1;
    _addressLine2 = widget.item?.addressLine2;
    _city = widget.item?.city;
    _state = widget.item?.state;
    _zip = widget.item?.zip;
    _country = widget.item?.country;
    _lat = widget.item?.lat;
    _lng = widget.item?.lng;
    _neighborhoodId = widget.item?.neighborhoodId;
    _bedrooms = widget.item?.bedrooms;
    _bathrooms = widget.item?.bathrooms;
    _areaSqm = widget.item?.areaSqm;
    _yearBuilt = widget.item?.yearBuilt;
    _notes = widget.item?.notes;
    _locationId = widget.item?.locationId;
    _listingPrice = widget.item?.listingPrice;
    _originalPrice = widget.item?.originalPrice;
    _schoolDistrict = widget.item?.schoolDistrict;
    _hoaFee = widget.item?.hoaFee;
    _hoaFeeFrequency = widget.item?.hoaFeeFrequency;
    _propertyTaxRate = widget.item?.propertyTaxRate;
    _lastAssessmentValue = widget.item?.lastAssessmentValue;
    _lastAssessmentYear = widget.item?.lastAssessmentYear;
    _floodZone = widget.item?.floodZone;
    _zoningCode = widget.item?.zoningCode;
    _lotSizeAcres = widget.item?.lotSizeAcres;
    _frontageFeet = widget.item?.frontageFeet;
    _depthFeet = widget.item?.depthFeet;
    _basementType = widget.item?.basementType;
    _basementFinishedSqFt = widget.item?.basementFinishedSqFt;
    _garageType = widget.item?.garageType;
    _garageCapacity = widget.item?.garageCapacity;
    _parkingSpaces = widget.item?.parkingSpaces;
    _parkingType = widget.item?.parkingType;
    _poolType = widget.item?.poolType;
    _heatingType = widget.item?.heatingType;
    _coolingType = widget.item?.coolingType;
    _fireplaceType = widget.item?.fireplaceType;
    _fireplaceCount = widget.item?.fireplaceCount;
    _viewType = widget.item?.viewType;
    _waterfrontType = widget.item?.waterfrontType;
    _waterfrontFeet = widget.item?.waterfrontFeet;
    _constructionType = widget.item?.constructionType;
    _roofType = widget.item?.roofType;
    _roofYear = widget.item?.roofYear;
    _sidingType = widget.item?.sidingType;
    _zipPlus4 = widget.item?.zipPlus4;
    _countyFIPS = widget.item?.countyFIPS;
    _censusTract = widget.item?.censusTract;
    _mlsArea = widget.item?.mlsArea;
    _propertyClas = widget.item?.propertyClas;
    _buildingClas = widget.item?.buildingClas;
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
    _electricityProvider = widget.item?.electricityProvider;
    _gasProvider = widget.item?.gasProvider;
    _waterProvider = widget.item?.waterProvider;
    _internetProvider = widget.item?.internetProvider;
    _trashService = widget.item?.trashService;
    _mlsNumber = widget.item?.mlsNumber;
    _mlsStatus = widget.item?.mlsStatus;
    _daysOnMarket = widget.item?.daysOnMarket;
    _pricePerSqFt = widget.item?.pricePerSqFt;
    _rentalYield = widget.item?.rentalYield;
    _yearRenovated = widget.item?.yearRenovated;
    _energyRating = widget.item?.energyRating;
    _zoningDescription = widget.item?.zoningDescription;
    _landUse = widget.item?.landUse;
    _buildingRestrictions = widget.item?.buildingRestrictions;
    _futureDevelopment = widget.item?.futureDevelopment;
    _leadPaintCompliance = widget.item?.leadPaintCompliance;
    _moldInspectionDate = widget.item?.moldInspectionDate;
    _asbestosInspectionDate = widget.item?.asbestosInspectionDate;
    _radonTestDate = widget.item?.radonTestDate;
    _pestControlDate = widget.item?.pestControlDate;
    _fireInspectionDate = widget.item?.fireInspectionDate;
    _elevatorInspectionDate = widget.item?.elevatorInspectionDate;
    _poolInspectionDate = widget.item?.poolInspectionDate;
    _accessibilityCompliance = widget.item?.accessibilityCompliance;
    _notesController = TextEditingController(text: _notes ?? '');
    _notesController.addListener(() {
      _notes = _notesController.text;
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final region = ref.watch(regionProvider);
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.property'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.property'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(
                labelText: 'currency (${region?.currencySymbol ?? r"$"})',
              ),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _addressLine1?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.addressline1'.tr()),
              onChanged: (v) => _addressLine1 = v,
            ),
            TextFormField(
              initialValue: _addressLine2?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.addressline2'.tr()),
              onChanged: (v) => _addressLine2 = v,
            ),
            TextFormField(
              initialValue: _city?.toString(),
              decoration: InputDecoration(
                labelText: region?.addressFormat.adminLevel2 ?? 'city',
              ),
              onChanged: (v) => _city = v,
            ),
            TextFormField(
              initialValue: _state?.toString(),
              decoration: InputDecoration(
                labelText: region?.addressFormat.adminLevel1 ?? 'state',
              ),
              onChanged: (v) => _state = v,
            ),
            TextFormField(
              initialValue: _zip?.toString(),
              decoration: InputDecoration(
                labelText:
                    'zip/postcode ${region?.addressFormat.zipCodeRequired ?? true ? "*" : ""}',
              ),
              onChanged: (v) => _zip = v,
            ),
            TextFormField(
              initialValue: _country?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.country'.tr()),
              onChanged: (v) => _country = v,
            ),
            TextFormField(
              initialValue: _lat?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lat'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lat = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lng?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lng'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lng = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _neighborhoodId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.neighborhoodid'.tr()),
              onChanged: (v) => _neighborhoodId = v,
            ),
            TextFormField(
              initialValue: _bedrooms?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bedrooms'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _bedrooms = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _bathrooms?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bathrooms'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _bathrooms = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _areaSqm?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.areasqm'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _areaSqm = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _yearBuilt?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.yearbuilt'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _yearBuilt = int.tryParse(v ?? ""),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AiMagicWandButton(
                    controller: _notesController,
                    promptContext: 'Property: ${_name ?? "Real Estate"}, rooms: ${_totalRooms ?? 3}, sqm: ${_areaSqm ?? 120}',
                    label: 'Write with AI',
                  ),
                ],
              ),
            ),
            TextFormField(
              initialValue: _locationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.locationid'.tr()),
              onChanged: (v) => _locationId = v,
            ),
            TextFormField(
              initialValue: _listingPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _listingPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _originalPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.originalprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _originalPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _schoolDistrict?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.schooldistrict'.tr()),
              onChanged: (v) => _schoolDistrict = v,
            ),
            TextFormField(
              initialValue: _hoaFee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.hoafee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _hoaFee = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _hoaFeeFrequency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.hoafeefrequency'.tr()),
              onChanged: (v) => _hoaFeeFrequency = v,
            ),
            TextFormField(
              initialValue: _propertyTaxRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertytaxrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _propertyTaxRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lastAssessmentValue?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.lastassessmentvalue'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lastAssessmentValue = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lastAssessmentYear?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.lastassessmentyear'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lastAssessmentYear = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _floodZone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.floodzone'.tr()),
              onChanged: (v) => _floodZone = v,
            ),
            TextFormField(
              initialValue: _zoningCode?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zoningcode'.tr()),
              onChanged: (v) => _zoningCode = v,
            ),
            TextFormField(
              initialValue: _lotSizeAcres?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lotsizeacres'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lotSizeAcres = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _frontageFeet?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.frontagefeet'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _frontageFeet = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _depthFeet?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.depthfeet'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _depthFeet = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _basementType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.basementtype'.tr()),
              onChanged: (v) => _basementType = v,
            ),
            TextFormField(
              initialValue: _basementFinishedSqFt?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.basementfinishedsqft'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) =>
                  _basementFinishedSqFt = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _garageType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.garagetype'.tr()),
              onChanged: (v) => _garageType = v,
            ),
            TextFormField(
              initialValue: _garageCapacity?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.garagecapacity'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _garageCapacity = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _parkingSpaces?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.parkingspaces'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _parkingSpaces = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _parkingType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.parkingtype'.tr()),
              onChanged: (v) => _parkingType = v,
            ),
            TextFormField(
              initialValue: _poolType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pooltype'.tr()),
              onChanged: (v) => _poolType = v,
            ),
            TextFormField(
              initialValue: _heatingType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.heatingtype'.tr()),
              onChanged: (v) => _heatingType = v,
            ),
            TextFormField(
              initialValue: _coolingType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.coolingtype'.tr()),
              onChanged: (v) => _coolingType = v,
            ),
            TextFormField(
              initialValue: _fireplaceType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fireplacetype'.tr()),
              onChanged: (v) => _fireplaceType = v,
            ),
            TextFormField(
              initialValue: _fireplaceCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fireplacecount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _fireplaceCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _viewType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.viewtype'.tr()),
              onChanged: (v) => _viewType = v,
            ),
            TextFormField(
              initialValue: _waterfrontType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.waterfronttype'.tr()),
              onChanged: (v) => _waterfrontType = v,
            ),
            TextFormField(
              initialValue: _waterfrontFeet?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.waterfrontfeet'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _waterfrontFeet = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _constructionType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.constructiontype'.tr()),
              onChanged: (v) => _constructionType = v,
            ),
            TextFormField(
              initialValue: _roofType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rooftype'.tr()),
              onChanged: (v) => _roofType = v,
            ),
            TextFormField(
              initialValue: _roofYear?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.roofyear'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _roofYear = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _sidingType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sidingtype'.tr()),
              onChanged: (v) => _sidingType = v,
            ),
            TextFormField(
              initialValue: _zipPlus4?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zipplus4'.tr()),
              onChanged: (v) => _zipPlus4 = v,
            ),
            TextFormField(
              initialValue: _countyFIPS?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.countyfips'.tr()),
              onChanged: (v) => _countyFIPS = v,
            ),
            TextFormField(
              initialValue: _censusTract?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.censustract'.tr()),
              onChanged: (v) => _censusTract = v,
            ),
            TextFormField(
              initialValue: _mlsArea?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mlsarea'.tr()),
              onChanged: (v) => _mlsArea = v,
            ),
            TextFormField(
              initialValue: _propertyClas?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyclas'.tr()),
              onChanged: (v) => _propertyClas = v,
            ),
            TextFormField(
              initialValue: _buildingClas?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.buildingclas'.tr()),
              onChanged: (v) => _buildingClas = v,
            ),
            TextFormField(
              initialValue: _totalRooms?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalrooms'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalRooms = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _livingAreaSqFt?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.livingareasqft'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _livingAreaSqFt = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lotSizeSqFt?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lotsizesqft'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lotSizeSqFt = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _stories?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.stories'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _stories = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _unitsPerBuilding?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.unitsperbuilding'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _unitsPerBuilding = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _assessedValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.assessedvalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _assessedValue = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _marketValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.marketvalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _marketValue = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _propertyTax?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertytax'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _propertyTax = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _insuranceAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.insuranceamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _insuranceAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _mortgageBalance?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mortgagebalance'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _mortgageBalance = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lienAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lienamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lienAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _electricityProvider?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.electricityprovider'.tr(),
              ),
              onChanged: (v) => _electricityProvider = v,
            ),
            TextFormField(
              initialValue: _gasProvider?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.gasprovider'.tr()),
              onChanged: (v) => _gasProvider = v,
            ),
            TextFormField(
              initialValue: _waterProvider?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.waterprovider'.tr()),
              onChanged: (v) => _waterProvider = v,
            ),
            TextFormField(
              initialValue: _internetProvider?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.internetprovider'.tr()),
              onChanged: (v) => _internetProvider = v,
            ),
            TextFormField(
              initialValue: _trashService?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.trashservice'.tr()),
              onChanged: (v) => _trashService = v,
            ),
            TextFormField(
              initialValue: _mlsNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mlsnumber'.tr()),
              onChanged: (v) => _mlsNumber = v,
            ),
            TextFormField(
              initialValue: _mlsStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mlsstatus'.tr()),
              onChanged: (v) => _mlsStatus = v,
            ),
            TextFormField(
              initialValue: _daysOnMarket?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.daysonmarket'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _daysOnMarket = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _pricePerSqFt?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pricepersqft'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _pricePerSqFt = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _rentalYield?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rentalyield'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rentalYield = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _yearRenovated?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.yearrenovated'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _yearRenovated = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _energyRating?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.energyrating'.tr()),
              onChanged: (v) => _energyRating = v,
            ),
            TextFormField(
              initialValue: _zoningDescription?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zoningdescription'.tr()),
              onChanged: (v) => _zoningDescription = v,
            ),
            TextFormField(
              initialValue: _landUse?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.landuse'.tr()),
              onChanged: (v) => _landUse = v,
            ),
            TextFormField(
              initialValue: _buildingRestrictions?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.buildingrestrictions'.tr(),
              ),
              onChanged: (v) => _buildingRestrictions = v,
            ),
            TextFormField(
              initialValue: _futureDevelopment?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.futuredevelopment'.tr()),
              onChanged: (v) => _futureDevelopment = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.leadpaintcompliance'.tr()),
              value: _leadPaintCompliance ?? false,
              onChanged: (v) => setState(() => _leadPaintCompliance = v),
            ),
            ListTile(
              title: Text(
                'moldInspectionDate: ${_moldInspectionDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _moldInspectionDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _moldInspectionDate = d);
              },
            ),
            ListTile(
              title: Text(
                'asbestosInspectionDate: ${_asbestosInspectionDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _asbestosInspectionDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _asbestosInspectionDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_radon_test_date'.tr()}: ${_radonTestDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _radonTestDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _radonTestDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_pest_control_date'.tr()}: ${_pestControlDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _pestControlDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _pestControlDate = d);
              },
            ),
            ListTile(
              title: Text(
                'fireInspectionDate: ${_fireInspectionDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _fireInspectionDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _fireInspectionDate = d);
              },
            ),
            ListTile(
              title: Text(
                'elevatorInspectionDate: ${_elevatorInspectionDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _elevatorInspectionDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _elevatorInspectionDate = d);
              },
            ),
            ListTile(
              title: Text(
                'poolInspectionDate: ${_poolInspectionDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _poolInspectionDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _poolInspectionDate = d);
              },
            ),
            ListTile(
              title: Text(
                'lastCodeComplianceDate: ${_lastCodeComplianceDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastCodeComplianceDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastCodeComplianceDate = d);
              },
            ),
            SwitchListTile(
              title: Text('mobile.auto.accessibilitycompliance'.tr()),
              value: _accessibilityCompliance ?? false,
              onChanged: (v) => setState(() => _accessibilityCompliance = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_currency != null) 'currency': _currency,
                  if (_addressLine1 != null) 'addressLine1': _addressLine1,
                  if (_addressLine2 != null) 'addressLine2': _addressLine2,
                  if (_city != null) 'city': _city,
                  if (_state != null) 'state': _state,
                  if (_zip != null) 'zip': _zip,
                  if (_country != null) 'country': _country,
                  if (_lat != null) 'lat': _lat,
                  if (_lng != null) 'lng': _lng,
                  if (_neighborhoodId != null)
                    'neighborhoodId': _neighborhoodId,
                  if (_bedrooms != null) 'bedrooms': _bedrooms,
                  if (_bathrooms != null) 'bathrooms': _bathrooms,
                  if (_areaSqm != null) 'areaSqm': _areaSqm,
                  if (_yearBuilt != null) 'yearBuilt': _yearBuilt,
                  if (_notes != null) 'notes': _notes,
                  if (_locationId != null) 'locationId': _locationId,
                  if (_listingPrice != null) 'listingPrice': _listingPrice,
                  if (_originalPrice != null) 'originalPrice': _originalPrice,
                  if (_schoolDistrict != null)
                    'schoolDistrict': _schoolDistrict,
                  if (_hoaFee != null) 'hoaFee': _hoaFee,
                  if (_hoaFeeFrequency != null)
                    'hoaFeeFrequency': _hoaFeeFrequency,
                  if (_propertyTaxRate != null)
                    'propertyTaxRate': _propertyTaxRate,
                  if (_lastAssessmentValue != null)
                    'lastAssessmentValue': _lastAssessmentValue,
                  if (_lastAssessmentYear != null)
                    'lastAssessmentYear': _lastAssessmentYear,
                  if (_floodZone != null) 'floodZone': _floodZone,
                  if (_zoningCode != null) 'zoningCode': _zoningCode,
                  if (_lotSizeAcres != null) 'lotSizeAcres': _lotSizeAcres,
                  if (_frontageFeet != null) 'frontageFeet': _frontageFeet,
                  if (_depthFeet != null) 'depthFeet': _depthFeet,
                  if (_basementType != null) 'basementType': _basementType,
                  if (_basementFinishedSqFt != null)
                    'basementFinishedSqFt': _basementFinishedSqFt,
                  if (_garageType != null) 'garageType': _garageType,
                  if (_garageCapacity != null)
                    'garageCapacity': _garageCapacity,
                  if (_parkingSpaces != null) 'parkingSpaces': _parkingSpaces,
                  if (_parkingType != null) 'parkingType': _parkingType,
                  if (_poolType != null) 'poolType': _poolType,
                  if (_heatingType != null) 'heatingType': _heatingType,
                  if (_coolingType != null) 'coolingType': _coolingType,
                  if (_fireplaceType != null) 'fireplaceType': _fireplaceType,
                  if (_fireplaceCount != null)
                    'fireplaceCount': _fireplaceCount,
                  if (_viewType != null) 'viewType': _viewType,
                  if (_waterfrontType != null)
                    'waterfrontType': _waterfrontType,
                  if (_waterfrontFeet != null)
                    'waterfrontFeet': _waterfrontFeet,
                  if (_constructionType != null)
                    'constructionType': _constructionType,
                  if (_roofType != null) 'roofType': _roofType,
                  if (_roofYear != null) 'roofYear': _roofYear,
                  if (_sidingType != null) 'sidingType': _sidingType,
                  if (_zipPlus4 != null) 'zipPlus4': _zipPlus4,
                  if (_countyFIPS != null) 'countyFIPS': _countyFIPS,
                  if (_censusTract != null) 'censusTract': _censusTract,
                  if (_mlsArea != null) 'mlsArea': _mlsArea,
                  if (_propertyClas != null) 'propertyClas': _propertyClas,
                  if (_buildingClas != null) 'buildingClas': _buildingClas,
                  if (_totalRooms != null) 'totalRooms': _totalRooms,
                  if (_livingAreaSqFt != null)
                    'livingAreaSqFt': _livingAreaSqFt,
                  if (_lotSizeSqFt != null) 'lotSizeSqFt': _lotSizeSqFt,
                  if (_stories != null) 'stories': _stories,
                  if (_unitsPerBuilding != null)
                    'unitsPerBuilding': _unitsPerBuilding,
                  if (_assessedValue != null) 'assessedValue': _assessedValue,
                  if (_marketValue != null) 'marketValue': _marketValue,
                  if (_propertyTax != null) 'propertyTax': _propertyTax,
                  if (_insuranceAmount != null)
                    'insuranceAmount': _insuranceAmount,
                  if (_mortgageBalance != null)
                    'mortgageBalance': _mortgageBalance,
                  if (_lienAmount != null) 'lienAmount': _lienAmount,
                  if (_electricityProvider != null)
                    'electricityProvider': _electricityProvider,
                  if (_gasProvider != null) 'gasProvider': _gasProvider,
                  if (_waterProvider != null) 'waterProvider': _waterProvider,
                  if (_internetProvider != null)
                    'internetProvider': _internetProvider,
                  if (_trashService != null) 'trashService': _trashService,
                  if (_mlsNumber != null) 'mlsNumber': _mlsNumber,
                  if (_mlsStatus != null) 'mlsStatus': _mlsStatus,
                  if (_daysOnMarket != null) 'daysOnMarket': _daysOnMarket,
                  if (_pricePerSqFt != null) 'pricePerSqFt': _pricePerSqFt,
                  if (_rentalYield != null) 'rentalYield': _rentalYield,
                  if (_yearRenovated != null) 'yearRenovated': _yearRenovated,
                  if (_energyRating != null) 'energyRating': _energyRating,
                  if (_zoningDescription != null)
                    'zoningDescription': _zoningDescription,
                  if (_landUse != null) 'landUse': _landUse,
                  if (_buildingRestrictions != null)
                    'buildingRestrictions': _buildingRestrictions,
                  if (_futureDevelopment != null)
                    'futureDevelopment': _futureDevelopment,
                  'leadPaintCompliance': _leadPaintCompliance,
                  if (_moldInspectionDate != null)
                    'moldInspectionDate': _moldInspectionDate!
                        .toIso8601String(),
                  if (_asbestosInspectionDate != null)
                    'asbestosInspectionDate': _asbestosInspectionDate!
                        .toIso8601String(),
                  if (_radonTestDate != null)
                    'radonTestDate': _radonTestDate!.toIso8601String(),
                  if (_pestControlDate != null)
                    'pestControlDate': _pestControlDate!.toIso8601String(),
                  if (_fireInspectionDate != null)
                    'fireInspectionDate': _fireInspectionDate!
                        .toIso8601String(),
                  if (_elevatorInspectionDate != null)
                    'elevatorInspectionDate': _elevatorInspectionDate!
                        .toIso8601String(),
                  if (_poolInspectionDate != null)
                    'poolInspectionDate': _poolInspectionDate!
                        .toIso8601String(),
                  if (_lastCodeComplianceDate != null)
                    'lastCodeComplianceDate': _lastCodeComplianceDate!
                        .toIso8601String(),
                  'accessibilityCompliance': _accessibilityCompliance,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(Property.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
