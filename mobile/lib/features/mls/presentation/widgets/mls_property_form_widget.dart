import 'package:flutter/material.dart';
import '../../domain/entities/mls_entity.dart';

class MLSPropertyFormWidget extends StatefulWidget {
  final MLSProperty? Property;
  final Function(CreateMLSPropertyParams) onSubmit;

  const MLSPropertyFormWidget({
    Key? key,
    this.Property,
    required this.onSubmit,
  }) : super(key: key);

  
  State<MLSPropertyFormWidget> createState() => _MLSPropertyFormWidgetState();
}

class _MLSPropertyFormWidgetState extends State<MLSPropertyFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _squareFeetController = TextEditingController();
  final _organizationIdController = TextEditingController();
  final _agentIdController = TextEditingController();

  MLSPropertyType _selectedType = MLSPropertyType.residential;
  MLSStatus _selectedStatus = MLSStatus.active;
  List<MLSPlatformType> _selectedPlatforms = [];
  bool _isActive = true;
  Map<String, dynamic> _metadata = {};

  
  void initState() {
    super.initState();
    if (widget.Property != null) {
      _initializeFromProperty(widget.Property!);
    }
  }

  void _initializeFromProperty(MLSProperty Property) {
    _addressController.text = Property.address;
    _priceController.text = Property.price.toString();
    _bedroomsController.text = Property.bedrooms.toString();
    _bathroomsController.text = Property.bathrooms.toString();
    _squareFeetController.text = Property.squareFeet.toString();
    _selectedType = Property.type;
    _selectedStatus = Property.status;
    _selectedPlatforms = List.from(Property.platforms);
    _isActive = Property.isActive;
    _metadata = Map.from(Property.metadata);
  }

  
  void dispose() {
    _addressController.dispose();
    _priceController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _squareFeetController.dispose();
    _organizationIdController.dispose();
    _agentIdController.dispose();
    super.dispose();
  }

  
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter Property address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<MLSPropertyType>(
                      value: _selectedType,
                      decoration: const InputDecoration(
                        labelText: 'Property Type',
                        border: OutlineInputBorder(),
                      ),
                      items: MLSPropertyType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.displayName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<MLSStatus>(
                      value: _selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      items: MLSStatus.values.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status.displayName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter Property price',
                  prefixText: '\$',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _bedroomsController,
                      decoration: const InputDecoration(
                        labelText: 'Bedrooms',
                        hintText: 'Number of bedrooms',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter bedrooms';
                        }
                        final bedrooms = int.tryParse(value);
                        if (bedrooms == null || bedrooms < 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _bathroomsController,
                      decoration: const InputDecoration(
                        labelText: 'Bathrooms',
                        hintText: 'Number of bathrooms',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter bathrooms';
                        }
                        final bathrooms = double.tryParse(value);
                        if (bathrooms == null || bathrooms < 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _squareFeetController,
                decoration: const InputDecoration(
                  labelText: 'Square Feet',
                  hintText: 'Property square footage',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter square feet';
                  }
                  final squareFeet = int.tryParse(value);
                  if (squareFeet == null || squareFeet <= 0) {
                    return 'Please enter a valid square footage';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _organizationIdController,
                decoration: const InputDecoration(
                  labelText: 'Organization ID (Optional)',
                  hintText: 'Enter Organization ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _agentIdController,
                decoration: const InputDecoration(
                  labelText: 'Agent ID (Optional)',
                  hintText: 'Enter Agent ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Syndication Platforms',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: MLSPlatformType.values.map((platform) {
                  final isSelected = _selectedPlatforms.contains(platform);
                  return FilterChip(
                    label: Text(platform.displayName),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedPlatforms.add(platform);
                        } else {
                          _selectedPlatforms.remove(platform);
                        }
                      });
                    },
                    backgroundColor: platform.color.withOpacity(0.1),
                    selectedColor: platform.color.withOpacity(0.3),
                    checkmarkColor: platform.color,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Active'),
                subtitle: const Text('Property is active and available'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Metadata (JSON)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter additional metadata as JSON',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                  maxLines: null,
                  onChanged: (value) {
                    try {
                      if (value.isNotEmpty) {
                        _metadata = Map<String, dynamic>.from(
                          // Simple JSON parsing for demonstration
                          value.split(',').map((e) {
                            final parts = e.split(':');
                            if (parts.length == 2) {
                              return MapEntry(parts[0].trim(), parts[1].trim());
                            }
                            return MapEntry(e.trim(), '');
                          }).toList(),
                        );
                      }
                    } catch (e) {
                      // Handle parsing error
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(widget.Property == null ? 'Add Property' : 'Update Property'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final params = CreateMLSPropertyParams(
        address: _addressController.text.trim(),
        type: _selectedType,
        status: _selectedStatus,
        price: double.parse(_priceController.text),
        bedrooms: int.parse(_bedroomsController.text),
        bathrooms: double.parse(_bathroomsController.text),
        squareFeet: int.parse(_squareFeetController.text),
        organizationId: _organizationIdController.text.trim().isNotEmpty
            ? _organizationIdController.text.trim()
            : null,
        agentId: _agentIdController.text.trim().isNotEmpty
            ? _agentIdController.text.trim()
            : null,
        platforms: _selectedPlatforms,
        metadata: _metadata,
      );

      widget.onSubmit(params);
    }
  }
}

class CreateMLSPropertyParams {
  final String address;
  final MLSPropertyType type;
  final MLSStatus status;
  final double price;
  final int bedrooms;
  final double bathrooms;
  final int squareFeet;
  final String? organizationId;
  final String? agentId;
  final List<MLSPlatformType>? platforms;
  final Map<String, dynamic>? metadata;

  CreateMLSPropertyParams({
    required this.address,
    required this.type,
    required this.status,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareFeet,
    this.organizationId,
    this.agentId,
    this.platforms,
    this.metadata,
  });
}
