import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

class GridViewWidget extends StatefulWidget {
  final Map<String, dynamic> filters;
  final Function(Map<String, dynamic>) onPropertyTap;

  const GridViewWidget({
    super.key,
    required this.filters,
    required this.onPropertyTap,
  });

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _properties = [];
  int _currentPage = 1;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadProperties();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_isLoading &&
        _hasMore) {
      _loadMoreProperties();
    }
  }

  Future<void> _loadProperties() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.get(
        Uri.parse(
          'https://api.example.com/properties?page=$_currentPage&limit=20',
        ),
        headers: {
          'mobile.leftovers.content_type'.tr(): 'application/json',
          'Authorization': 'mobile.leftovers.bearer_your_api_key'.tr(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newProperties = List<Map<String, dynamic>>.from(
          data['properties'] ?? [],
        );

        setState(() {
          if (_currentPage == 1) {
            _properties = newProperties;
          } else {
            _properties.addAll(newProperties);
          }
          _hasMore = newProperties.length == 20;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('mobile.auto.failed_to_load_properties'.tr())),
          );
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading properties: $e')));
      }
    }
  }

  Future<void> _loadMoreProperties() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _currentPage++;
      _isLoading = true;
    });

    await _loadProperties();
  }

  Future<void> _refreshProperties() async {
    setState(() {
      _currentPage = 1;
      _hasMore = true;
      _properties.clear();
    });
    await _loadProperties();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Results Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          color: theme.colorScheme.surface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_properties.length} Properties Found',
                style: theme.textTheme.titleMedium,
              ),
              Row(
                children: [
                  Text('mobile.auto.view'.tr(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text('mobile.auto.grid'.tr(), style: theme.textTheme.bodySmall),
                        SizedBox(width: 1.w),
                        Icon(
                          Icons.arrow_drop_down,
                          color: theme.colorScheme.onSurface,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Property Grid
        Expanded(
          child: _properties.isEmpty && _isLoading
              ? _buildLoadingState()
              : RefreshIndicator(
                  onRefresh: _refreshProperties,
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(2.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 2.w,
                      mainAxisSpacing: 2.h,
                    ),
                    itemCount: _properties.length + (_hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _properties.length) {
                        return _buildLoadingIndicator();
                      }
                      final property = _properties[index];
                      return _buildPropertyCard(context, theme, property);
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    final theme = Theme.of(context);
    return GridView.builder(
      padding: EdgeInsets.all(2.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.h,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildSkeletonCard(theme),
    );
  }

  Widget _buildSkeletonCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Skeleton
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.1),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
            ),
          ),
          // Content Skeleton
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60.w,
                    height: 1.5.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(
                        0.1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    width: 40.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(
                        0.1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    width: 30.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(
                        0.1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: theme.colorScheme.primary),
          SizedBox(height: 1.h),
          Text('mobile.auto.loading_more_properties'.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(
    BuildContext context,
    ThemeData theme,
    Map<String, dynamic> property,
  ) {
    return InkWell(
      onTap: () => widget.onPropertyTap(property),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      property['image'] ?? '',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                  // Video Freshness Badge
                  Positioned(
                    top: 1.h,
                    left: 2.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: property['videoFreshness'] == 'new'
                            ? Color(0xFF27AE60)
                            : property['videoFreshness'] == 'recent'
                            ? Color(0xFF4A90E2)
                            : Color(0xFF7F8C8D),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 12,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            property['videoFreshness'] == 'new'
                                ? 'New'
                                : property['videoFreshness'] == 'recent'
                                ? 'Recent'
                                : 'Older',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Property Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            property['title'] ?? '',
                            style: theme.textTheme.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (property['verified'] == true)
                          Container(
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: Color(0xFF4A90E2).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.verified,
                              color: Color(0xFF4A90E2),
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          child: Text(
                            property['location'] ?? '',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      property['price'] ?? '',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Color(0xFF4A90E2),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        _buildPropertyFeature(
                          theme,
                          Icons.king_bed,
                          '${property['bedrooms'] ?? 0}',
                        ),
                        SizedBox(width: 2.w),
                        _buildPropertyFeature(
                          theme,
                          Icons.bathtub,
                          '${property['bathrooms'] ?? 0}',
                        ),
                        SizedBox(width: 2.w),
                        _buildPropertyFeature(
                          theme,
                          Icons.square_foot,
                          property['area'] ?? '',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyFeature(ThemeData theme, IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 14),
        SizedBox(width: 1.w),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
