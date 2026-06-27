import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../data/models/hotel_alternative.dart';

class HotelAlternativesWidget extends StatefulWidget {
  final String destination;
  final String checkIn;
  final String checkOut;
  final int guests;

  const HotelAlternativesWidget({
    Key? key,
    required this.destination,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
  }) : super(key: key);

  @override
  State<HotelAlternativesWidget> createState() => _HotelAlternativesWidgetState();
}

class _HotelAlternativesWidgetState extends State<HotelAlternativesWidget> {
  final Dio _dio = DioClient.instance;
  bool _isLoading = true;
  List<HotelAlternative> _alternatives = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchAlternatives();
  }

  @override
  void didUpdateWidget(covariant HotelAlternativesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.destination != widget.destination ||
        oldWidget.checkIn != widget.checkIn ||
        oldWidget.checkOut != widget.checkOut ||
        oldWidget.guests != widget.guests) {
      _fetchAlternatives();
    }
  }

  Future<void> _fetchAlternatives() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _dio.get(
        ApiEndpoints.hotelBookingAlternatives,
        queryParameters: {
          'destination': widget.destination,
          'checkIn': widget.checkIn,
          'checkOut': widget.checkOut,
          'guests': widget.guests,
          'include_apartments': 'true',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        setState(() {
          _alternatives = data.map((e) => HotelAlternative.fromJson(e)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to fetch alternatives';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return const SizedBox.shrink(); // Hide silently on error as it's an upsell/alternative widget
    }

    if (_alternatives.isEmpty) {
      return const SizedBox.shrink();
    }

    final hasOwnInventory = _alternatives.any((alt) => alt.isOwnInventory);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasOwnInventory)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'hotel.alternatives.cheaperFound'.tr(fallback: 'We found cheaper accommodation options!'),
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Text(
            'hotel.alternatives.title'.tr(fallback: 'Available Properties & Hotels'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _alternatives.length,
            itemBuilder: (context, index) {
              return _buildAlternativeCard(_alternatives[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAlternativeCard(HotelAlternative alt) {
    final bool isOwn = alt.isOwnInventory;
    final Color primaryColor = isOwn ? Colors.purple.shade700 : Colors.blue.shade700;
    final Color bgColor = isOwn ? Colors.purple.shade50 : Colors.white;
    final String typeLabel = _getTypeLabel(alt.type, isOwn);
    final String imageUrl = alt.images.isNotEmpty 
        ? alt.images.first 
        : 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=500&q=80'; // Fallback

    return Container(
      width: 240,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isOwn ? Colors.purple.shade200 : Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 120,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
                if (isOwn)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.home, color: Colors.white, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            typeLabel,
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.hotel, color: Colors.white, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            typeLabel,
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (alt.priceComparison != null && alt.priceComparison!.cheaperThanAverage)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.trending_down, color: Colors.white, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            '-${alt.priceComparison!.savingsPercentage.toStringAsFixed(0)}%',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alt.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber.shade500, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        alt.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      if (isOwn)
                        Text(
                          '· ${alt.provider}',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                    ],
                  ),
                  if (isOwn && (alt.bedrooms != null || alt.areaSqm != null))
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          if (alt.bedrooms != null) ...[
                            Icon(Icons.bed, size: 12, color: Colors.grey.shade600),
                            const SizedBox(width: 2),
                            Text('${alt.bedrooms}', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                            const SizedBox(width: 8),
                          ],
                          if (alt.bathrooms != null) ...[
                            Icon(Icons.bathtub_outlined, size: 12, color: Colors.grey.shade600),
                            const SizedBox(width: 2),
                            Text('${alt.bathrooms}', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                            const SizedBox(width: 8),
                          ],
                          if (alt.areaSqm != null) ...[
                            Icon(Icons.square_foot, size: 12, color: Colors.grey.shade600),
                            const SizedBox(width: 2),
                            Text('${alt.areaSqm}m²', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                          ]
                        ],
                      ),
                    ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'hotel.alternatives.perNight'.tr(fallback: 'Total per night'),
                            style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                          ),
                          Text(
                            '${alt.currency} ${alt.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTypeLabel(String type, bool isOwn) {
    if (!isOwn) return 'hotel.type.hotel'.tr(fallback: 'HOTEL');
    switch (type) {
      case 'VILLA': return 'hotel.type.villa'.tr(fallback: 'VILLA');
      case 'CONDO_APARTMENT':
      case 'CONDO': return 'hotel.type.residence'.tr(fallback: 'RESIDENCE');
      case 'STUDIO': return 'hotel.type.studio'.tr(fallback: 'STUDIO');
      case 'PENTHOUSE': return 'hotel.type.penthouse'.tr(fallback: 'PENTHOUSE');
      default: return 'hotel.type.apartment'.tr(fallback: 'APARTMENT');
    }
  }
}
