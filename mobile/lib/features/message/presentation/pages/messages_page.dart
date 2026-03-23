import 'package:flutter/material.dart';

/// Messages Page - Inbox and conversations
class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(child: Text('${String.fromCharCode(65 + index)}')),
          title: Text('Client ${index + 1}'),
          subtitle: Text('Last message preview...', maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${index + 1}h ago', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              if (index % 3 == 0) Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }
}
