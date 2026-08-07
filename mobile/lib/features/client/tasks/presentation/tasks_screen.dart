import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/priority.dart';
import 'package:reservatior/shared/enums/task_status.dart';
import 'package:reservatior/shared/enums/task_type.dart';
import 'package:reservatior/shared/models/task.dart';
import 'package:reservatior/shared/providers/task_provider.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  TaskStatus? _statusFilter;

  @override
  Widget build(BuildContext context) {
    final asyncTasks = ref.watch(taskListProvider);
    final tasks = asyncTasks.value ?? <Task>[];

    final visible = _statusFilter == null
        ? tasks
        : tasks.where((t) => t.status == _statusFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Tasks',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: _statusFilter == null,
                      onTap: () => setState(() => _statusFilter = null),
                    ),
                    ...TaskStatus.values.map((s) => _FilterChip(
                          label: s.name.replaceAll('_', ' '),
                          selected: _statusFilter == s,
                          onTap: () =>
                              setState(() => _statusFilter = s),
                        )),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                asyncTasks.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load tasks',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (tasks) {
                    if (visible.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(Icons.task_alt, color: Colors.white24, size: 32),
                            const SizedBox(height: 10),
                            Text('No tasks here',
                                style: GoogleFonts.outfit(
                                    color: Colors.white38, fontSize: 13)),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: visible
                          .map((t) => _TaskTile(task: t))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: AppColors.darkSurface,
        selectedColor: AppColors.primary.withValues(alpha: 0.3),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.darkBorder,
        ),
        labelStyle: GoogleFonts.outfit(
          color: selected ? Colors.white : Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;
  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(task.status);
    final priorityColor = _priorityColor(task.priority);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_typeIcon(task.type), color: color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      '${task.type.name.replaceAll('_', ' ')} · '
                      '${task.property?.name ?? 'General'}',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withValues(alpha: 0.4)),
                ),
                child: Text(
                  task.status.name.replaceAll('_', ' '),
                  style: GoogleFonts.outfit(
                      color: color, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          if (task.description != null) ...[
            const SizedBox(height: 8),
            Text(
              task.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.flag_outlined, color: priorityColor, size: 13),
              const SizedBox(width: 4),
              Text(
                task.priority.name,
                style: GoogleFonts.outfit(
                    color: priorityColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Icon(Icons.schedule, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                task.dueAt != null
                    ? DateFormat.yMMMd().add_Hm().format(task.dueAt!)
                    : 'No due date',
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(),
    );
  }

  Color _statusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.OPEN:
        return AppColors.info;
      case TaskStatus.IN_PROGRESS:
        return AppColors.warning;
      case TaskStatus.DONE:
        return AppColors.success;
      case TaskStatus.CANCELLED:
        return Colors.white38;
      case TaskStatus.BLOCKED:
        return AppColors.error;
    }
  }

  Color _priorityColor(Priority priority) {
    switch (priority) {
      case Priority.LOW:
        return AppColors.info;
      case Priority.MEDIUM:
        return AppColors.warning;
      case Priority.HIGH:
        return AppColors.error;
      case Priority.URGENT:
        return Colors.redAccent;
    }
  }

  IconData _typeIcon(TaskType type) {
    switch (type) {
      case TaskType.CLEANING:
        return Icons.cleaning_services_outlined;
      case TaskType.INSPECTION:
        return Icons.visibility_outlined;
      case TaskType.REPAIR:
        return Icons.build_outlined;
      case TaskType.ADMIN:
        return Icons.folder_outlined;
      case TaskType.LEGAL:
        return Icons.gavel_outlined;
      case TaskType.OTHER:
        return Icons.task_alt;
    }
  }
}
