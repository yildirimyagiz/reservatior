import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class CommandItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final String category;

  const CommandItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    this.category = 'Action',
  });
}

// Static quick actions
final quickActions = <CommandItem>[
  CommandItem(
    title: 'mobile.admin.command.new_tenant'.tr(),
    subtitle: 'Kiracılar Modülü',
    icon: Icons.person_add,
    route: '/admin/tenants', // Will trigger a specific action inside the module later
    category: 'Tenants',
  ),
  CommandItem(
    title: 'mobile.admin.command.new_property'.tr(),
    subtitle: 'Emlak Modülü',
    icon: Icons.add_home,
    route: '/admin/property',
    category: 'Property',
  ),
  CommandItem(
    title: 'mobile.admin.command.new_invoice'.tr(),
    subtitle: 'Finans Modülü',
    icon: Icons.receipt,
    route: '/admin/financial',
    category: 'Financial',
  ),
  CommandItem(
    title: 'mobile.admin.command.view_messages'.tr(),
    subtitle: 'İletişim Modülü',
    icon: Icons.message,
    route: '/admin/message',
    category: 'Communication',
  ),
  CommandItem(
    title: 'mobile.admin.command.open_analytics'.tr(),
    subtitle: 'Sistem Performansı',
    icon: Icons.analytics,
    route: '/admin/analytics',
    category: 'Analytics',
  ),
  CommandItem(
    title: 'mobile.admin.command.settings'.tr(),
    subtitle: 'Güvenlik ve Yapılandırma',
    icon: Icons.settings,
    route: '/admin/system',
    category: 'System',
  ),
];

final commandSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredCommandsProvider = Provider<List<CommandItem>>((ref) {
  final query = ref.watch(commandSearchQueryProvider).toLowerCase();
  
  if (query.isEmpty) {
    return quickActions;
  }

  // In Phase 1, we filter only the quick actions.
  // In Phase 2, we can fetch real dynamic data (like actual users or properties) and append here.
  return quickActions.where((cmd) {
    return cmd.title.toLowerCase().contains(query) ||
           cmd.subtitle.toLowerCase().contains(query) ||
           cmd.category.toLowerCase().contains(query);
  }).toList();
});
