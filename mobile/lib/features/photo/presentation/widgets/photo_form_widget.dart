import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Photo Form Widget  |  Fields: url, originalName, filename, type, caption, alt, src, featured, width, height, fileSize, mimeType, dominantColor, mlMetadata, userId, agencyId, propertyId, agentId, postId

class PhotoFormWidget extends StatefulWidget {
  final Photo? item;
  final void Function(Photo)? onSubmit;
  const PhotoFormWidget({super.key, this.item, this.onSubmit});
  @override State<PhotoFormWidget> createState() => _PhotoFormWidgetState();
}

class _PhotoFormWidgetState extends State<PhotoFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _url;
  String? _originalName;
  String? _filename;
  String? _type;
  String? _caption;
  String? _alt;
  String? _src;
  bool _featured = false;
  int? _width;
  int? _height;
  int? _fileSize;
  String? _mimeType;
  String? _dominantColor;
  String? _mlMetadata;
  String? _userId;
  String? _agencyId;
  String? _propertyId;
  String? _agentId;
  String? _postId;

  @override
  void initState() {
    super.initState();
    _url = widget.item?.url?.toString();
    _originalName = widget.item?.originalName?.toString();
    _filename = widget.item?.filename?.toString();
    _type = widget.item?.type?.toString();
    _caption = widget.item?.caption?.toString();
    _alt = widget.item?.alt?.toString();
    _src = widget.item?.src?.toString();
    _featured = widget.item?.featured ?? false;
    _width = widget.item?.width;
    _height = widget.item?.height;
    _fileSize = widget.item?.fileSize;
    _mimeType = widget.item?.mimeType?.toString();
    _dominantColor = widget.item?.dominantColor?.toString();
    _mlMetadata = widget.item?.mlMetadata?.toString();
    _userId = widget.item?.userId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _agentId = widget.item?.agentId?.toString();
    _postId = widget.item?.postId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_url?.isNotEmpty == true) 'url': _url,
        if (_originalName?.isNotEmpty == true) 'originalName': _originalName,
        if (_filename?.isNotEmpty == true) 'filename': _filename,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_caption?.isNotEmpty == true) 'caption': _caption,
        if (_alt?.isNotEmpty == true) 'alt': _alt,
        if (_src?.isNotEmpty == true) 'src': _src,
        'featured': _featured,
        if (_width != null) 'width': _width,
        if (_height != null) 'height': _height,
        if (_fileSize != null) 'fileSize': _fileSize,
        if (_mimeType?.isNotEmpty == true) 'mimeType': _mimeType,
        if (_dominantColor?.isNotEmpty == true) 'dominantColor': _dominantColor,
        if (_mlMetadata?.isNotEmpty == true) 'mlMetadata': _mlMetadata,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
        if (_postId?.isNotEmpty == true) 'postId': _postId,
    };
    final result = widget.item != null
        ? Photo.fromJson({...widget.item!.toJson(), ...data})
        : Photo.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _url = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Original Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _originalName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Filename', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _filename = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Caption', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _caption = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alt', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _alt = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Src', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _src = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Featured'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _featured,
                  onChanged: (v) { ss(() {}); setState(() => _featured = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Width', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _width = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Height', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _height = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'File Size', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _fileSize = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mime Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mimeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dominant Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _dominantColor = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ml Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mlMetadata = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Post Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _postId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Photo'),
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
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}