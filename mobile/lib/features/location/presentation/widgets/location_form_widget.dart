import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Location Form Widget ──
// Fields: propertyId, listingId, dealId, addressLine1, addressLine2, addressLine3, city, state, zip, zipPlus4, country, stateName, stateFIPS, censusTract, blockGroup, precinct, schoolDistrict, congressionalDistrict, latitude, longitude, accuracy, altitude, elevation, geocodingStatus, geocodedAt, geocodingProvider, confidenceScore, isVerified, verifiedAt, verifiedBy, uspsVerified, uspsVerifiedAt, dpvConfirmation, footnotes, isStandardized, isResidential, isCommercial, isValid, markerType, markerIcon, markerColor, markerSize, isVisible, zIndex, opacity, title, description, imageUrl, linkUrl, category, mondayOpen, mondayClose, tuesdayOpen, tuesdayClose, wednesdayOpen, wednesdayClose, thursdayOpen, thursdayClose, fridayOpen, fridayClose, saturdayOpen, saturdayClose, sundayOpen, sundayClose, metadata

class LocationFormWidget extends StatefulWidget {
  final Location? item;
  final void Function(Location)? onSubmit;
  const LocationFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<LocationFormWidget> createState() => _LocationFormWidgetState();
}

class _LocationFormWidgetState extends State<LocationFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _listingId;
  String? _dealId;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _city;
  String? _state;
  String? _zip;
  String? _zipPlus4;
  String? _country;
  String? _stateName;
  String? _stateFIPS;
  String? _censusTract;
  String? _blockGroup;
  String? _precinct;
  String? _schoolDistrict;
  String? _congressionalDistrict;
  double? _latitude;
  double? _longitude;
  String? _accuracy;
  double? _altitude;
  double? _elevation;
  String? _geocodingStatus;
  DateTime? _geocodedAt;
  String? _geocodingProvider;
  double? _confidenceScore;
  bool _isVerified = false;
  DateTime? _verifiedAt;
  String? _verifiedBy;
  bool _uspsVerified = false;
  DateTime? _uspsVerifiedAt;
  String? _dpvConfirmation;
  String? _footnotes;
  bool _isStandardized = false;
  bool _isResidential = false;
  bool _isCommercial = false;
  bool _isValid = false;
  String? _markerType;
  String? _markerIcon;
  String? _markerColor;
  int? _markerSize;
  bool _isVisible = false;
  int? _zIndex;
  double? _opacity;
  String? _title;
  String? _description;
  String? _imageUrl;
  String? _linkUrl;
  String? _category;
  String? _mondayOpen;
  String? _mondayClose;
  String? _tuesdayOpen;
  String? _tuesdayClose;
  String? _wednesdayOpen;
  String? _wednesdayClose;
  String? _thursdayOpen;
  String? _thursdayClose;
  String? _fridayOpen;
  String? _fridayClose;
  String? _saturdayOpen;
  String? _saturdayClose;
  String? _sundayOpen;
  String? _sundayClose;
  String? _metadata;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _dealId = widget.item?.dealId?.toString();
    _addressLine1 = widget.item?.addressLine1?.toString();
    _addressLine2 = widget.item?.addressLine2?.toString();
    _addressLine3 = widget.item?.addressLine3?.toString();
    _city = widget.item?.city?.toString();
    _state = widget.item?.state?.toString();
    _zip = widget.item?.zip?.toString();
    _zipPlus4 = widget.item?.zipPlus4?.toString();
    _country = widget.item?.country?.toString();
    _stateName = widget.item?.stateName?.toString();
    _stateFIPS = widget.item?.stateFIPS?.toString();
    _censusTract = widget.item?.censusTract?.toString();
    _blockGroup = widget.item?.blockGroup?.toString();
    _precinct = widget.item?.precinct?.toString();
    _schoolDistrict = widget.item?.schoolDistrict?.toString();
    _congressionalDistrict = widget.item?.congressionalDistrict?.toString();
    _latitude = widget.item?.latitude;
    _longitude = widget.item?.longitude;
    _accuracy = widget.item?.accuracy?.toString();
    _altitude = widget.item?.altitude;
    _elevation = widget.item?.elevation;
    _geocodingStatus = widget.item?.geocodingStatus?.toString();
    _geocodedAt = widget.item?.geocodedAt;
    _geocodingProvider = widget.item?.geocodingProvider?.toString();
    _confidenceScore = widget.item?.confidenceScore;
    _isVerified = widget.item?.isVerified ?? false;
    _verifiedAt = widget.item?.verifiedAt;
    _verifiedBy = widget.item?.verifiedBy?.toString();
    _uspsVerified = widget.item?.uspsVerified ?? false;
    _uspsVerifiedAt = widget.item?.uspsVerifiedAt;
    _dpvConfirmation = widget.item?.dpvConfirmation?.toString();
    _footnotes = widget.item?.footnotes?.toString();
    _isStandardized = widget.item?.isStandardized ?? false;
    _isResidential = widget.item?.isResidential ?? false;
    _isCommercial = widget.item?.isCommercial ?? false;
    _isValid = widget.item?.isValid ?? false;
    _markerType = widget.item?.markerType?.toString();
    _markerIcon = widget.item?.markerIcon?.toString();
    _markerColor = widget.item?.markerColor?.toString();
    _markerSize = widget.item?.markerSize;
    _isVisible = widget.item?.isVisible ?? false;
    _zIndex = widget.item?.zIndex;
    _opacity = widget.item?.opacity;
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _imageUrl = widget.item?.imageUrl?.toString();
    _linkUrl = widget.item?.linkUrl?.toString();
    _category = widget.item?.category?.toString();
    _mondayOpen = widget.item?.mondayOpen?.toString();
    _mondayClose = widget.item?.mondayClose?.toString();
    _tuesdayOpen = widget.item?.tuesdayOpen?.toString();
    _tuesdayClose = widget.item?.tuesdayClose?.toString();
    _wednesdayOpen = widget.item?.wednesdayOpen?.toString();
    _wednesdayClose = widget.item?.wednesdayClose?.toString();
    _thursdayOpen = widget.item?.thursdayOpen?.toString();
    _thursdayClose = widget.item?.thursdayClose?.toString();
    _fridayOpen = widget.item?.fridayOpen?.toString();
    _fridayClose = widget.item?.fridayClose?.toString();
    _saturdayOpen = widget.item?.saturdayOpen?.toString();
    _saturdayClose = widget.item?.saturdayClose?.toString();
    _sundayOpen = widget.item?.sundayOpen?.toString();
    _sundayClose = widget.item?.sundayClose?.toString();
    _metadata = widget.item?.metadata?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId != null) 'propertyId': _propertyId,
        if (_listingId != null) 'listingId': _listingId,
        if (_dealId != null) 'dealId': _dealId,
        if (_addressLine1 != null) 'addressLine1': _addressLine1,
        if (_addressLine2 != null) 'addressLine2': _addressLine2,
        if (_addressLine3 != null) 'addressLine3': _addressLine3,
        if (_city != null) 'city': _city,
        if (_state != null) 'state': _state,
        if (_zip != null) 'zip': _zip,
        if (_zipPlus4 != null) 'zipPlus4': _zipPlus4,
        if (_country != null) 'country': _country,
        if (_stateName != null) 'stateName': _stateName,
        if (_stateFIPS != null) 'stateFIPS': _stateFIPS,
        if (_censusTract != null) 'censusTract': _censusTract,
        if (_blockGroup != null) 'blockGroup': _blockGroup,
        if (_precinct != null) 'precinct': _precinct,
        if (_schoolDistrict != null) 'schoolDistrict': _schoolDistrict,
        if (_congressionalDistrict != null) 'congressionalDistrict': _congressionalDistrict,
        if (_latitude != null) 'latitude': _latitude,
        if (_longitude != null) 'longitude': _longitude,
        if (_accuracy != null) 'accuracy': _accuracy,
        if (_altitude != null) 'altitude': _altitude,
        if (_elevation != null) 'elevation': _elevation,
        if (_geocodingStatus != null) 'geocodingStatus': _geocodingStatus,
        if (_geocodedAt != null) 'geocodedAt': _geocodedAt!.toIso8601String(),
        if (_geocodingProvider != null) 'geocodingProvider': _geocodingProvider,
        if (_confidenceScore != null) 'confidenceScore': _confidenceScore,
        'isVerified': _isVerified,
        if (_verifiedAt != null) 'verifiedAt': _verifiedAt!.toIso8601String(),
        if (_verifiedBy != null) 'verifiedBy': _verifiedBy,
        'uspsVerified': _uspsVerified,
        if (_uspsVerifiedAt != null) 'uspsVerifiedAt': _uspsVerifiedAt!.toIso8601String(),
        if (_dpvConfirmation != null) 'dpvConfirmation': _dpvConfirmation,
        if (_footnotes != null) 'footnotes': _footnotes,
        'isStandardized': _isStandardized,
        'isResidential': _isResidential,
        'isCommercial': _isCommercial,
        'isValid': _isValid,
        if (_markerType != null) 'markerType': _markerType,
        if (_markerIcon != null) 'markerIcon': _markerIcon,
        if (_markerColor != null) 'markerColor': _markerColor,
        if (_markerSize != null) 'markerSize': _markerSize,
        'isVisible': _isVisible,
        if (_zIndex != null) 'zIndex': _zIndex,
        if (_opacity != null) 'opacity': _opacity,
        if (_title != null) 'title': _title,
        if (_description != null) 'description': _description,
        if (_imageUrl != null) 'imageUrl': _imageUrl,
        if (_linkUrl != null) 'linkUrl': _linkUrl,
        if (_category != null) 'category': _category,
        if (_mondayOpen != null) 'mondayOpen': _mondayOpen,
        if (_mondayClose != null) 'mondayClose': _mondayClose,
        if (_tuesdayOpen != null) 'tuesdayOpen': _tuesdayOpen,
        if (_tuesdayClose != null) 'tuesdayClose': _tuesdayClose,
        if (_wednesdayOpen != null) 'wednesdayOpen': _wednesdayOpen,
        if (_wednesdayClose != null) 'wednesdayClose': _wednesdayClose,
        if (_thursdayOpen != null) 'thursdayOpen': _thursdayOpen,
        if (_thursdayClose != null) 'thursdayClose': _thursdayClose,
        if (_fridayOpen != null) 'fridayOpen': _fridayOpen,
        if (_fridayClose != null) 'fridayClose': _fridayClose,
        if (_saturdayOpen != null) 'saturdayOpen': _saturdayOpen,
        if (_saturdayClose != null) 'saturdayClose': _saturdayClose,
        if (_sundayOpen != null) 'sundayOpen': _sundayOpen,
        if (_sundayClose != null) 'sundayClose': _sundayClose,
        if (_metadata != null) 'metadata': _metadata,
    };
    final result = widget.item != null
        ? Location.fromJson({...widget.item!.toJson(), ...data})
        : Location.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Address Line3', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _addressLine3 = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Zip Plus4', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _zipPlus4 = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Country', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _country = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'State Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _stateName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'State F I P S', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _stateFIPS = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Census Tract', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _censusTract = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Block Group', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _blockGroup = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Precinct', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _precinct = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'School District', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _schoolDistrict = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Congressional District', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _congressionalDistrict = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Latitude', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _latitude = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Longitude', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _longitude = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Accuracy', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _accuracy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Altitude', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _altitude = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Elevation', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _elevation = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Geocoding Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _geocodingStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _geocodedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _geocodedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Geocoded At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_geocodedAt != null ? _fmt(_geocodedAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Geocoding Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _geocodingProvider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _confidenceScore = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Verified'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isVerified,
                  onChanged: (v) { ss(() {}); setState(() => _isVerified = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _verifiedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _verifiedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Verified At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_verifiedAt != null ? _fmt(_verifiedAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Verified By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _verifiedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Usps Verified'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _uspsVerified,
                  onChanged: (v) { ss(() {}); setState(() => _uspsVerified = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _uspsVerifiedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _uspsVerifiedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Usps Verified At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_uspsVerifiedAt != null ? _fmt(_uspsVerifiedAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dpv Confirmation', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _dpvConfirmation = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Footnotes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _footnotes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Standardized'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isStandardized,
                  onChanged: (v) { ss(() {}); setState(() => _isStandardized = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Residential'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isResidential,
                  onChanged: (v) { ss(() {}); setState(() => _isResidential = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Commercial'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isCommercial,
                  onChanged: (v) { ss(() {}); setState(() => _isCommercial = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Valid'),
                  secondary: const Icon(Icons.link),
                  value: _isValid,
                  onChanged: (v) { ss(() {}); setState(() => _isValid = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Marker Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _markerType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Marker Icon', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _markerIcon = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Marker Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _markerColor = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Marker Size', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _markerSize = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Visible'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isVisible,
                  onChanged: (v) { ss(() {}); setState(() => _isVisible = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Z Index', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _zIndex = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Opacity', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _opacity = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _imageUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Link Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _linkUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _category = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Monday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _mondayOpen = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Monday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _mondayClose = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tuesday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _tuesdayOpen = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tuesday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _tuesdayClose = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Wednesday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _wednesdayOpen = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Wednesday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _wednesdayClose = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Thursday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _thursdayOpen = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Thursday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _thursdayClose = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Friday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _fridayOpen = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Friday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _fridayClose = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Saturday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _saturdayOpen = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Saturday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _saturdayClose = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sunday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _sundayOpen = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sunday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _sundayClose = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Location'),
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
