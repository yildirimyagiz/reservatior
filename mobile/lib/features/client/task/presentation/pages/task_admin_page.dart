import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/features/client/task/presentation/providers/task_provider.dart';

class TaskAdminPage extends ConsumerWidget {
  const TaskAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            backgroundColor: AppColors.darkBg,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('mobile.auto.tasks_workflow'.tr(),
                style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlueAccent.withOpacity(0.2), AppColors.darkBg],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ref.watch(taskProvider).when(
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return Center(
                      child: Text('mobile.auto.no_tasks_found'.tr(),
                        style: GoogleFonts.outfit(color: Colors.white54),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final t = tasks[index];
                      return Dismissible(
                        key: Key(t.id),
                        background: Container(
                          color: Colors.redAccent,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          ref.read(taskProvider.notifier).deleteTask(t.id);
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.05),
                          margin: EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(t.title, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600)),
                            subtitle: Text(
                              '${t.type} • ${t.priority}',
                              style: GoogleFonts.outfit(color: t.priority == 'HIGH' ? Colors.redAccent : Colors.lightBlueAccent),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
                              child: Text(t.status, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 10)),
                            ),
                          ),
                        ),
                      ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.1);
                    },
                  );
                },
                loading: () => Center(
                  child: Text('mobile.auto.loading_tasks'.tr(),
                    style: GoogleFonts.outfit(color: Colors.white54),
                  ).animate().shimmer(duration: 2.seconds),
                ),
                error: (err, _) => Center(
                  child: Text(
                    '${'admin.shared.connectionError'.tr()}: $err',
                    style: GoogleFonts.outfit(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () => _showAddDialog(context, ref),
        child: Icon(Icons.add, color: Colors.white),
      ).animate().scale(delay: 500.ms),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final priorityCtrl = TextEditingController(text: 'MEDIUM');
    final typeCtrl = TextEditingController(text: 'ADMIN');
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkBg,
        title: Text('mobile.auto.new_task'.tr(), style: GoogleFonts.outfit(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mobile.auto.title'.tr(),
                labelStyle: GoogleFonts.outfit(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            TextField(
              controller: descCtrl,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mobile.auto.description'.tr(),
                labelStyle: GoogleFonts.outfit(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            TextField(
              controller: priorityCtrl,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mobile.auto.priority_low_medium_high'.tr(),
                labelStyle: GoogleFonts.outfit(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            TextField(
              controller: typeCtrl,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'mobile.auto.type_admin_cleaning_etc'.tr(),
                labelStyle: GoogleFonts.outfit(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('mobile.auto.cancel'.tr(), style: GoogleFonts.outfit(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              if (titleCtrl.text.isNotEmpty) {
                ref.read(taskProvider.notifier).createTask(
                  titleCtrl.text, descCtrl.text, typeCtrl.text, priorityCtrl.text
                );
                Navigator.pop(ctx);
              }
            },
            child: Text('mobile.auto.create'.tr(), style: GoogleFonts.outfit(color: Colors.lightBlueAccent)),
          ),
        ],
      ),
    );
  }
}
