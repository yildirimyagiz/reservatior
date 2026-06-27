import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationFormWidget extends ConsumerStatefulWidget {
  final Location? item;
  final Function(Location) onSubmit;
  const LocationFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<LocationFormWidget> createState() => _LocationFormWidgetState();
}

class _LocationFormWidgetState extends ConsumerState<LocationFormWidget> {
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
  double? _altitude;
  double? _elevation;
  DateTime? _geocodedAt;
  double? _confidenceScore;
  bool? _isVerified;
  DateTime? _verifiedAt;
  String? _verifiedBy;
  bool? _uspsVerified;
  DateTime? _uspsVerifiedAt;
  String? _dpvConfirmation;
  String? _footnotes;
  bool? _isStandardized;
  bool? _isResidential;
  bool? _isCommercial;
  bool? _isValid;
  String? _markerColor;
  int? _markerSize;
  bool? _isVisible;
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
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _dealId = widget.item?.dealId;
    _addressLine1 = widget.item?.addressLine1;
    _addressLine2 = widget.item?.addressLine2;
    _addressLine3 = widget.item?.addressLine3;
    _city = widget.item?.city;
    _state = widget.item?.state;
    _zip = widget.item?.zip;
    _zipPlus4 = widget.item?.zipPlus4;
    _country = widget.item?.country;
    _stateName = widget.item?.stateName;
    _stateFIPS = widget.item?.stateFIPS;
    _censusTract = widget.item?.censusTract;
    _blockGroup = widget.item?.blockGroup;
    _precinct = widget.item?.precinct;
    _schoolDistrict = widget.item?.schoolDistrict;
    _congressionalDistrict = widget.item?.congressionalDistrict;
    _latitude = widget.item?.latitude;
    _longitude = widget.item?.longitude;
    _altitude = widget.item?.altitude;
    _elevation = widget.item?.elevation;
    _geocodedAt = widget.item?.geocodedAt;
    _confidenceScore = widget.item?.confidenceScore;
    _isVerified = widget.item?.isVerified;
    _verifiedAt = widget.item?.verifiedAt;
    _verifiedBy = widget.item?.verifiedBy;
    _uspsVerified = widget.item?.uspsVerified;
    _uspsVerifiedAt = widget.item?.uspsVerifiedAt;
    _dpvConfirmation = widget.item?.dpvConfirmation;
    _footnotes = widget.item?.footnotes;
    _isStandardized = widget.item?.isStandardized;
    _isResidential = widget.item?.isResidential;
    _isCommercial = widget.item?.isCommercial;
    _isValid = widget.item?.isValid;
    _markerColor = widget.item?.markerColor;
    _markerSize = widget.item?.markerSize;
    _isVisible = widget.item?.isVisible;
    _zIndex = widget.item?.zIndex;
    _opacity = widget.item?.opacity;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _imageUrl = widget.item?.imageUrl;
    _linkUrl = widget.item?.linkUrl;
    _category = widget.item?.category;
    _mondayOpen = widget.item?.mondayOpen;
    _mondayClose = widget.item?.mondayClose;
    _tuesdayOpen = widget.item?.tuesdayOpen;
    _tuesdayClose = widget.item?.tuesdayClose;
    _wednesdayOpen = widget.item?.wednesdayOpen;
    _wednesdayClose = widget.item?.wednesdayClose;
    _thursdayOpen = widget.item?.thursdayOpen;
    _thursdayClose = widget.item?.thursdayClose;
    _fridayOpen = widget.item?.fridayOpen;
    _fridayClose = widget.item?.fridayClose;
    _saturdayOpen = widget.item?.saturdayOpen;
    _saturdayClose = widget.item?.saturdayClose;
    _sundayOpen = widget.item?.sundayOpen;
    _sundayClose = widget.item?.sundayClose;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.location'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.location'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _dealId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dealid'.tr()),
              onChanged: (v) => _dealId = v,
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
              initialValue: _addressLine3?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.addressline3'.tr()),
              onChanged: (v) => _addressLine3 = v,
            ),
            TextFormField(
              initialValue: _city?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.city'.tr()),
              onChanged: (v) => _city = v,
            ),
            TextFormField(
              initialValue: _state?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.state'.tr()),
              onChanged: (v) => _state = v,
            ),
            TextFormField(
              initialValue: _zip?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zip'.tr()),
              onChanged: (v) => _zip = v,
            ),
            TextFormField(
              initialValue: _zipPlus4?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zipplus4'.tr()),
              onChanged: (v) => _zipPlus4 = v,
            ),
            TextFormField(
              initialValue: _country?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.country'.tr()),
              onChanged: (v) => _country = v,
            ),
            TextFormField(
              initialValue: _stateName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.statename'.tr()),
              onChanged: (v) => _stateName = v,
            ),
            TextFormField(
              initialValue: _stateFIPS?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.statefips'.tr()),
              onChanged: (v) => _stateFIPS = v,
            ),
            TextFormField(
              initialValue: _censusTract?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.censustract'.tr()),
              onChanged: (v) => _censusTract = v,
            ),
            TextFormField(
              initialValue: _blockGroup?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.blockgroup'.tr()),
              onChanged: (v) => _blockGroup = v,
            ),
            TextFormField(
              initialValue: _precinct?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.precinct'.tr()),
              onChanged: (v) => _precinct = v,
            ),
            TextFormField(
              initialValue: _schoolDistrict?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.schooldistrict'.tr()),
              onChanged: (v) => _schoolDistrict = v,
            ),
            TextFormField(
              initialValue: _congressionalDistrict?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.congressionaldistrict'.tr(),
              ),
              onChanged: (v) => _congressionalDistrict = v,
            ),
            TextFormField(
              initialValue: _latitude?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.latitude'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _latitude = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _longitude?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.longitude'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _longitude = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _altitude?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.altitude'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _altitude = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _elevation?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.elevation'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _elevation = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_geocoded_at'.tr()}: ${_geocodedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _geocodedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _geocodedAt = d);
              },
            ),
            TextFormField(
              initialValue: _confidenceScore?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidencescore'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidenceScore = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isverified'.tr()),
              value: _isVerified ?? false,
              onChanged: (v) => setState(() => _isVerified = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_verified_at'.tr()}: ${_verifiedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _verifiedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _verifiedAt = d);
              },
            ),
            TextFormField(
              initialValue: _verifiedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.verifiedby'.tr()),
              onChanged: (v) => _verifiedBy = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.uspsverified'.tr()),
              value: _uspsVerified ?? false,
              onChanged: (v) => setState(() => _uspsVerified = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_usps_verified_at'.tr()}: ${_uspsVerifiedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _uspsVerifiedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _uspsVerifiedAt = d);
              },
            ),
            TextFormField(
              initialValue: _dpvConfirmation?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dpvconfirmation'.tr()),
              onChanged: (v) => _dpvConfirmation = v,
            ),
            TextFormField(
              initialValue: _footnotes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.footnotes'.tr()),
              onChanged: (v) => _footnotes = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isstandardized'.tr()),
              value: _isStandardized ?? false,
              onChanged: (v) => setState(() => _isStandardized = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isresidential'.tr()),
              value: _isResidential ?? false,
              onChanged: (v) => setState(() => _isResidential = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.iscommercial'.tr()),
              value: _isCommercial ?? false,
              onChanged: (v) => setState(() => _isCommercial = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isvalid'.tr()),
              value: _isValid ?? false,
              onChanged: (v) => setState(() => _isValid = v),
            ),
            TextFormField(
              initialValue: _markerColor?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.markercolor'.tr()),
              onChanged: (v) => _markerColor = v,
            ),
            TextFormField(
              initialValue: _markerSize?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.markersize'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _markerSize = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isvisible'.tr()),
              value: _isVisible ?? false,
              onChanged: (v) => setState(() => _isVisible = v),
            ),
            TextFormField(
              initialValue: _zIndex?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zindex'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _zIndex = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _opacity?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.opacity'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _opacity = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _imageUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.imageurl'.tr()),
              onChanged: (v) => _imageUrl = v,
            ),
            TextFormField(
              initialValue: _linkUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.linkurl'.tr()),
              onChanged: (v) => _linkUrl = v,
            ),
            TextFormField(
              initialValue: _category?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.category'.tr()),
              onChanged: (v) => _category = v,
            ),
            TextFormField(
              initialValue: _mondayOpen?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mondayopen'.tr()),
              onChanged: (v) => _mondayOpen = v,
            ),
            TextFormField(
              initialValue: _mondayClose?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mondayclose'.tr()),
              onChanged: (v) => _mondayClose = v,
            ),
            TextFormField(
              initialValue: _tuesdayOpen?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tuesdayopen'.tr()),
              onChanged: (v) => _tuesdayOpen = v,
            ),
            TextFormField(
              initialValue: _tuesdayClose?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tuesdayclose'.tr()),
              onChanged: (v) => _tuesdayClose = v,
            ),
            TextFormField(
              initialValue: _wednesdayOpen?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.wednesdayopen'.tr()),
              onChanged: (v) => _wednesdayOpen = v,
            ),
            TextFormField(
              initialValue: _wednesdayClose?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.wednesdayclose'.tr()),
              onChanged: (v) => _wednesdayClose = v,
            ),
            TextFormField(
              initialValue: _thursdayOpen?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.thursdayopen'.tr()),
              onChanged: (v) => _thursdayOpen = v,
            ),
            TextFormField(
              initialValue: _thursdayClose?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.thursdayclose'.tr()),
              onChanged: (v) => _thursdayClose = v,
            ),
            TextFormField(
              initialValue: _fridayOpen?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fridayopen'.tr()),
              onChanged: (v) => _fridayOpen = v,
            ),
            TextFormField(
              initialValue: _fridayClose?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fridayclose'.tr()),
              onChanged: (v) => _fridayClose = v,
            ),
            TextFormField(
              initialValue: _saturdayOpen?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.saturdayopen'.tr()),
              onChanged: (v) => _saturdayOpen = v,
            ),
            TextFormField(
              initialValue: _saturdayClose?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.saturdayclose'.tr()),
              onChanged: (v) => _saturdayClose = v,
            ),
            TextFormField(
              initialValue: _sundayOpen?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sundayopen'.tr()),
              onChanged: (v) => _sundayOpen = v,
            ),
            TextFormField(
              initialValue: _sundayClose?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sundayclose'.tr()),
              onChanged: (v) => _sundayClose = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
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
                  if (_schoolDistrict != null)
                    'schoolDistrict': _schoolDistrict,
                  if (_congressionalDistrict != null)
                    'congressionalDistrict': _congressionalDistrict,
                  if (_latitude != null) 'latitude': _latitude,
                  if (_longitude != null) 'longitude': _longitude,
                  if (_altitude != null) 'altitude': _altitude,
                  if (_elevation != null) 'elevation': _elevation,
                  if (_geocodedAt != null)
                    'geocodedAt': _geocodedAt!.toIso8601String(),
                  if (_confidenceScore != null)
                    'confidenceScore': _confidenceScore,
                  'isVerified': _isVerified,
                  if (_verifiedAt != null)
                    'verifiedAt': _verifiedAt!.toIso8601String(),
                  if (_verifiedBy != null) 'verifiedBy': _verifiedBy,
                  'uspsVerified': _uspsVerified,
                  if (_uspsVerifiedAt != null)
                    'uspsVerifiedAt': _uspsVerifiedAt!.toIso8601String(),
                  if (_dpvConfirmation != null)
                    'dpvConfirmation': _dpvConfirmation,
                  if (_footnotes != null) 'footnotes': _footnotes,
                  'isStandardized': _isStandardized,
                  'isResidential': _isResidential,
                  'isCommercial': _isCommercial,
                  'isValid': _isValid,
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
                  if (_wednesdayClose != null)
                    'wednesdayClose': _wednesdayClose,
                  if (_thursdayOpen != null) 'thursdayOpen': _thursdayOpen,
                  if (_thursdayClose != null) 'thursdayClose': _thursdayClose,
                  if (_fridayOpen != null) 'fridayOpen': _fridayOpen,
                  if (_fridayClose != null) 'fridayClose': _fridayClose,
                  if (_saturdayOpen != null) 'saturdayOpen': _saturdayOpen,
                  if (_saturdayClose != null) 'saturdayClose': _saturdayClose,
                  if (_sundayOpen != null) 'sundayOpen': _sundayOpen,
                  if (_sundayClose != null) 'sundayClose': _sundayClose,
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
                  widget.onSubmit(Location.fromJson(json));
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
