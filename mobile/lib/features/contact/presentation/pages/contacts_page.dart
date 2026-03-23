import 'package:flutter/material.dart';

/// Contacts Page - Manage client contacts
class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.primaries[index % Colors.primaries.length].withOpacity(0.2),
              child: Text('${String.fromCharCode(65 + index)}', style: TextStyle(color: Colors.primaries[index % Colors.primaries.length])),
            ),
            title: Text('Contact ${index + 1}'),
            subtitle: Text('contact${index + 1}@example.com'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.phone, size: 20), onPressed: () {}),
                IconButton(icon: const Icon(Icons.message, size: 20), onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.person_add),
        label: const Text('Add Contact'),
      ),
    );
  }
}
