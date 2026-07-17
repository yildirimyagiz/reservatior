import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/ai_search_repository.dart';

class AISearchScreen extends ConsumerStatefulWidget {
  const AISearchScreen({super.key});

  @override
  ConsumerState<AISearchScreen> createState() => _AISearchScreenState();
}

class _AISearchScreenState extends ConsumerState<AISearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _currentQuery = '';

  void _performSearch() {
    setState(() {
      _currentQuery = _searchController.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Property Search'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'e.g., Modern 3-bed with balcony under \$3k',
                      prefixIcon: const Icon(Icons.auto_awesome, color: Colors.deepPurple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onSubmitted: (_) => _performSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _performSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
          ),
          if (_currentQuery.isNotEmpty)
            Expanded(
              child: _buildSearchResults(),
            )
          else
            const Expanded(
              child: Center(
                child: Text(
                  'Describe your dream home.\nOur AI will find the perfect match.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final searchResults = ref.watch(aiSearchProvider(_currentQuery));

    return searchResults.when(
      data: (results) {
        if (results.isEmpty) {
          return const Center(child: Text('No matching properties found.'));
        }
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple[100],
                  child: Text(
                    '${(result.matchScore * 100).toInt()}%',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(result.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${result.location} • ${result.price}\n${result.description}'),
                isThreeLine: true,
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navigate to listing detail
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.deepPurple),
            SizedBox(height: 16),
            Text('Analyzing properties via AI...'),
          ],
        ),
      ),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
