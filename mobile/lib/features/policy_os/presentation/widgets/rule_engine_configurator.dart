import 'package:flutter/material.dart';

class RuleEngineConfigurator extends StatefulWidget {
  final String entityId;
  final String entityType;

  const RuleEngineConfigurator({
    super.key,
    required this.entityId,
    required this.entityType,
  });

  @override
  State<RuleEngineConfigurator> createState() => _RuleEngineConfiguratorState();
}

class _RuleEngineConfiguratorState extends State<RuleEngineConfigurator> {
  final List<Map<String, dynamic>> _rules = [
    {
      'id': 'rule-1',
      'name': 'Require Identity Verification',
      'condition': 'transaction.amount > 10000',
      'action': 'trigger_kyc',
      'active': true,
    },
    {
      'id': 'rule-2',
      'name': 'Block High Risk Regions',
      'condition': 'user.risk_score > 80',
      'action': 'deny_transaction',
      'active': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Policy OS Engine',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                  Text(
                    'Managing rules for ${widget.entityType} ${widget.entityId}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Rule'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _rules.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final rule = _rules[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                rule['name'],
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: rule['active'] ? Colors.green[50] : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: rule['active'] ? Colors.green[200]! : Colors.grey[300]!),
                                ),
                                child: Text(
                                  rule['active'] ? 'Active' : 'Draft',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: rule['active'] ? Colors.green[700] : Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text('IF', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.indigo)),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  rule['condition'],
                                  style: TextStyle(fontSize: 12, fontFamily: 'monospace', color: Colors.indigo[700]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Text('THEN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.orange)),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  rule['action'],
                                  style: TextStyle(fontSize: 12, fontFamily: 'monospace', color: Colors.orange[800]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: rule['active'],
                      onChanged: (val) {
                        setState(() {
                          _rules[index]['active'] = val;
                        });
                      },
                      activeColor: Colors.indigo,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
