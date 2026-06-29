import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

/// Displays actionable AI Opportunities directly in the Agent's mobile feed.
class OpportunityCardFeed extends StatefulWidget {
  const OpportunityCardFeed({Key? key}) : super(key: key);

  @override
  State<OpportunityCardFeed> createState() => _OpportunityCardFeedState();
}

class _OpportunityCardFeedState extends State<OpportunityCardFeed> {
  List<dynamic> _opportunities = [];
  bool _isLoading = true;
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _fetchOpportunities();
    // Poll every 30 seconds for the freshest AI hypothesis
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _fetchOpportunities();
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchOpportunities() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.reservatior.com/api/v1/telemetry/opportunities'),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _opportunities = data['opportunities'] ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      print('[OpportunityCardFeed] Error fetching opportunities: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _opportunities.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_opportunities.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        alignment: Alignment.center,
        child: const Text(
          'No pending opportunities. System is observing...',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _opportunities.length,
      itemBuilder: (context, index) {
        final task = _opportunities[index];
        final actionMap = task['action'] ?? {};
        final actionName = (actionMap['action'] ?? 'UNKNOWN').replaceAll('_', ' ');
        final expectedGain = actionMap['expectedGain'] ?? 0;
        final score = task['opportunityScore'] ?? 0;
        final reason = task['decisionReason'] ?? '';

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.indigo.withOpacity(0.2)),
                      ),
                      child: Text(
                        actionName,
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '+\$$expectedGain',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Score: $score',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  reason,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Trigger execution intent
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Execute'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        // TODO: Dismiss opportunity
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[600],
                      ),
                      child: const Text('Dismiss'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
