import 'package:flutter/material.dart';

/// Payments Page - Manage transactions and payments
class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Balance Card
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Available Balance', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  const SizedBox(height: 8),
                  Text('\$45,280', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer),
                          child: const Text('Withdraw'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Add Funds'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Quick Stats
          Row(
            children: [
              Expanded(child: _buildStatCard(context, 'Income', '\$52K', '+12%', true)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(context, 'Expenses', '\$6.8K', '-5%', false)),
            ],
          ),
          const SizedBox(height: 24),
          
          // Recent Transactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Transactions', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('See All')),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(8, (i) => _buildTransactionItem(context, i)),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, String change, bool isPositive) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(change, style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, int index) {
    final types = ['Commission', 'Expense', 'Commission', 'Payment', 'Commission', 'Refund', 'Commission', 'Expense'];
    final amounts = ['+\$2,400', '-\$150', '+\$1,800', '-\$500', '+\$3,200', '+\$200', '+\$2,100', '-\$80'];
    final isPositive = amounts[index].startsWith('+');
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isPositive ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
          child: Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, color: isPositive ? Colors.green : Colors.red, size: 20),
        ),
        title: Text(types[index]),
        subtitle: Text('${index + 1} day${index > 0 ? 's' : ''} ago'),
        trailing: Text(amounts[index], style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
