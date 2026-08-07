import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/referral_stat_card.dart';

class ReferralNetworkPage extends StatefulWidget {
  const ReferralNetworkPage({Key? key}) : super(key: key);

  @override
  State<ReferralNetworkPage> createState() => _ReferralNetworkPageState();
}

class _ReferralNetworkPageState extends State<ReferralNetworkPage> {
  final String referralCode = "AGENT-2026-X";
  final double totalEarnings = 12500.00;
  final int totalReferrals = 24;
  final int activeReferrals = 18;

  // Mock data for referred agents
  final List<Map<String, dynamic>> network = [
    {"name": "Sarah Jenkins", "email": "sarah@example.com", "active": true, "joined": "2026-05-12"},
    {"name": "David Chen", "email": "david@example.com", "active": true, "joined": "2026-06-01"},
    {"name": "Elena Rodriguez", "email": "elena@example.com", "active": false, "joined": "2026-06-15"},
    {"name": "Marcus Johnson", "email": "marcus@example.com", "active": true, "joined": "2026-07-02"},
  ];

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: referralCode)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Referral code copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  void _shareCode() {
    // In a real app, use the share_plus package
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening share dialog...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Referral Network'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Referral Code Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Referral Code',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        referralCode,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _copyToClipboard,
                          icon: const Icon(Icons.copy, size: 18, color: Color(0xFF4F46E5)),
                          label: const Text('Copy', style: TextStyle(color: Color(0xFF4F46E5))),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _shareCode,
                          icon: const Icon(Icons.share, size: 18, color: Color(0xFF4F46E5)),
                          label: const Text('Share', style: TextStyle(color: Color(0xFF4F46E5))),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Stats Grid
            Row(
              children: [
                Expanded(
                  child: ReferralStatCard(
                    title: 'Passive Income',
                    value: '\$${totalEarnings.toStringAsFixed(0)}',
                    subtitle: '+0% this month',
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ReferralStatCard(
                    title: 'Active Agents',
                    value: activeReferrals.toString(),
                    subtitle: 'of $totalReferrals total',
                    icon: Icons.group,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Network List
            const Text(
              'My Network',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Agents who joined using your code',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            
            ...network.map((agent) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFEEF2FF),
                  foregroundColor: const Color(0xFF4F46E5),
                  child: Text(agent['name'].substring(0, 1)),
                ),
                title: Text(agent['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(agent['email'], style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 2),
                    Text('Joined ${agent['joined']}', style: const TextStyle(fontSize: 12, color: Colors.black38)),
                  ],
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: agent['active'] ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: agent['active'] ? Colors.green.withOpacity(0.5) : Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    agent['active'] ? 'Active' : 'Inactive',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: agent['active'] ? Colors.green[700] : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
