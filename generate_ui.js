const fs = require('fs');

const header = `import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class AdminHubScreen extends ConsumerStatefulWidget {
  const AdminHubScreen({super.key});

  @override
  ConsumerState<AdminHubScreen> createState() => _AdminHubScreenState();
}

class _AdminHubScreenState extends ConsumerState<AdminHubScreen> {
  int _currentIndex = 0;
  String _searchQuery = '';
`;

const footer = `
  final List<String> _categories = [
    'System',
    'Users',
    'Properties',
    'Financials',
    'Operations'
  ];

  final List<IconData> _categoryIcons = [
    Icons.dashboard,
    Icons.people,
    Icons.apartment,
    Icons.account_balance,
    Icons.work_history
  ];

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final currentCategory = _categories[_currentIndex];

    final filteredModules = _allModules.where((m) {
      final matchesSearch = m['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _searchQuery.isNotEmpty || m['category'] == currentCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        title: Text(
          _searchQuery.isNotEmpty ? 'Arama Sonuçları' : 'Admin: $currentCategory',
          style: GoogleFonts.outfit(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search modules...',
                hintStyle: TextStyle(color: colors.textSecondary.withValues(alpha: 0.5)),
                prefixIcon: Icon(Icons.search, color: colors.textSecondary),
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: filteredModules.length,
              itemBuilder: (context, index) {
                final module = filteredModules[index];
                return InkWell(
                  onTap: () => context.push(module['route']),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.admin_panel_settings, color: AppColors.primary, size: 28),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          module['title'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            color: colors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _searchQuery = ''; // Clear search when switching tabs
          });
        },
        backgroundColor: colors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: List.generate(_categories.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(_categoryIcons[index]),
            label: _categories[index],
          );
        }),
      ),
    );
  }
}
`;

const dartModules = fs.readFileSync('dart_modules.txt', 'utf8');

fs.writeFileSync('mobile/lib/features/admin/admin_hub_screen.dart', header + dartModules + footer);
console.log('Successfully wrote admin_hub_screen.dart');
