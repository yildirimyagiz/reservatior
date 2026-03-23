import 'package:flutter/material.dart';

/// Notifications Page - View and manage notifications
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Mark all read')),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          // Today
          _buildSectionHeader(context, 'Today'),
          ...List.generate(3, (i) => _buildNotificationItem(context, i, true)),
          
          // Yesterday
          _buildSectionHeader(context, 'Yesterday'),
          ...List.generate(4, (i) => _buildNotificationItem(context, i + 3, false)),
          
          // Earlier
          _buildSectionHeader(context, 'Earlier'),
          ...List.generate(5, (i) => _buildNotificationItem(context, i + 7, false)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey[600], fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildNotificationItem(BuildContext context, int index, bool isUnread) {
    final icons = [Icons.message, Icons.calendar_today, Icons.home, Icons.payment, Icons.person_add, Icons.event_available, Icons.check_circle, Icons.info, Icons.star, Icons.new_releases, Icons.update, Icons.verified];
    final colors = [Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.teal, Colors.indigo, Colors.pink, Colors.cyan, Colors.amber, Colors.lime, Colors.red, Colors.deepPurple];
    final titles = ['New Message', 'Appointment Reminder', 'Property Update', 'Payment Received', 'New Contact', 'Booking Confirmed', 'Deal Closed', 'System Update', 'New Review', 'Featured Listing', 'Price Change', 'Verification Complete'];
    
    return Container(
      color: isUnread ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3) : null,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors[index % colors.length].withOpacity(0.2),
          child: Icon(icons[index % icons.length], color: colors[index % colors.length], size: 20),
        ),
        title: Row(
          children: [
            Expanded(child: Text(titles[index % titles.length], style: TextStyle(fontWeight: isUnread ? FontWeight.bold : FontWeight.normal))),
            if (isUnread) Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
          ],
        ),
        subtitle: Text('This is a notification message preview that shows some details...', maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Text('${index + 1}h', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ),
    );
  }
}
