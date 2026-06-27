import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PhotoFormWidget extends ConsumerStatefulWidget {
  final Photo? item;
  final Function(Photo) onSubmit;
  const PhotoFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<PhotoFormWidget> createState() => _PhotoFormWidgetState();
}

class _PhotoFormWidgetState extends ConsumerState<PhotoFormWidget> {
  String? _url;
  String? _originalName;
  String? _filename;
  String? _caption;
  String? _alt;
  String? _src;
  bool? _featured;
  int? _width;
  int? _height;
  int? _fileSize;
  String? _mimeType;
  String? _dominantColor;
  String? _userId;
  String? _agencyId;
  String? _propertyId;
  String? _agentId;
  String? _postId;
  @override
  void initState() {
    super.initState();
    _url = widget.item?.url;
    _originalName = widget.item?.originalName;
    _filename = widget.item?.filename;
    _caption = widget.item?.caption;
    _alt = widget.item?.alt;
    _src = widget.item?.src;
    _featured = widget.item?.featured;
    _width = widget.item?.width;
    _height = widget.item?.height;
    _fileSize = widget.item?.fileSize;
    _mimeType = widget.item?.mimeType;
    _dominantColor = widget.item?.dominantColor;
    _userId = widget.item?.userId;
    _agencyId = widget.item?.agencyId;
    _propertyId = widget.item?.propertyId;
    _agentId = widget.item?.agentId;
    _postId = widget.item?.postId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.photo'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.photo'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _url?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.url'.tr()),
              onChanged: (v) => _url = v,
            ),
            TextFormField(
              initialValue: _originalName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.originalname'.tr()),
              onChanged: (v) => _originalName = v,
            ),
            TextFormField(
              initialValue: _filename?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.filename'.tr()),
              onChanged: (v) => _filename = v,
            ),
            TextFormField(
              initialValue: _caption?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.caption'.tr()),
              onChanged: (v) => _caption = v,
            ),
            TextFormField(
              initialValue: _alt?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.alt'.tr()),
              onChanged: (v) => _alt = v,
            ),
            TextFormField(
              initialValue: _src?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.src'.tr()),
              onChanged: (v) => _src = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.featured'.tr()),
              value: _featured ?? false,
              onChanged: (v) => setState(() => _featured = v),
            ),
            TextFormField(
              initialValue: _width?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.width'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _width = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _height?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.height'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _height = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _fileSize?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.filesize'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _fileSize = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _mimeType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mimetype'.tr()),
              onChanged: (v) => _mimeType = v,
            ),
            TextFormField(
              initialValue: _dominantColor?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dominantcolor'.tr()),
              onChanged: (v) => _dominantColor = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _agentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentid'.tr()),
              onChanged: (v) => _agentId = v,
            ),
            TextFormField(
              initialValue: _postId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.postid'.tr()),
              onChanged: (v) => _postId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_url != null) 'url': _url,
                  if (_originalName != null) 'originalName': _originalName,
                  if (_filename != null) 'filename': _filename,
                  if (_caption != null) 'caption': _caption,
                  if (_alt != null) 'alt': _alt,
                  if (_src != null) 'src': _src,
                  'featured': _featured,
                  if (_width != null) 'width': _width,
                  if (_height != null) 'height': _height,
                  if (_fileSize != null) 'fileSize': _fileSize,
                  if (_mimeType != null) 'mimeType': _mimeType,
                  if (_dominantColor != null) 'dominantColor': _dominantColor,
                  if (_userId != null) 'userId': _userId,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_agentId != null) 'agentId': _agentId,
                  if (_postId != null) 'postId': _postId,
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
                  widget.onSubmit(Photo.fromJson(json));
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
