import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class ChapterNavigationWidget extends StatefulWidget {
  final String currentChapter;
  final List<String> completedChapters;
  final Function(String) onChapterSelect;

  const ChapterNavigationWidget({
    super.key,
    required this.currentChapter,
    required this.completedChapters,
    required this.onChapterSelect,
  });

  @override
  State<ChapterNavigationWidget> createState() =>
      _ChapterNavigationWidgetState();
}

class _ChapterNavigationWidgetState extends State<ChapterNavigationWidget>
    with SingleTickerProviderStateMixin {
  bool _expandedOnMobile = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Chapter> get chapters => [
    Chapter(
      id: 'exterior',
      name: 'Exterior',
      icon: Icons.home,
      estimatedTime: 'mobile.leftovers.2_3_min'.tr(),
      required: true,
    ),
    Chapter(
      id: 'entrance',
      name: 'Entrance',
      icon: Icons.arrow_forward,
      estimatedTime: 'mobile.leftovers.1_2_min'.tr(),
      required: true,
    ),
    Chapter(
      id: 'living',
      name: 'mobile.leftovers.living_areas'.tr(),
      icon: Icons.tv,
      estimatedTime: 'mobile.leftovers.3_4_min'.tr(),
      required: true,
    ),
    Chapter(
      id: 'bedrooms',
      name: 'Bedrooms',
      icon: Icons.bed,
      estimatedTime: 'mobile.leftovers.4_5_min'.tr(),
      required: true,
    ),
    Chapter(
      id: 'kitchen',
      name: 'Kitchen',
      icon: Icons.kitchen,
      estimatedTime: 'mobile.leftovers.2_3_min'.tr(),
      required: true,
    ),
    Chapter(
      id: 'bathrooms',
      name: 'Bathrooms',
      icon: Icons.bathtub,
      estimatedTime: 'mobile.leftovers.2_3_min'.tr(),
      required: true,
    ),
    Chapter(
      id: 'extras',
      name: 'mobile.leftovers.extra_spaces'.tr(),
      icon: Icons.add_circle,
      estimatedTime: 'mobile.leftovers.3_4_min'.tr(),
      required: false,
    ),
  ];

  String get totalEstimatedTime => 'mobile.leftovers.17_24_minutes'.tr();
  int get completionPercentage =>
      ((widget.completedChapters.length / chapters.length) * 100).round();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return _buildDesktopNavigation();
        } else {
          return _buildMobileNavigation();
        }
      },
    );
  }

  Widget _buildDesktopNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Column(children: [_buildHeader(), _buildChapterList()]),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('mobile.auto.recording_progress'.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$completionPercentage%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: completionPercentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total time: $totalEstimatedTime',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondaryDark),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterList() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: chapters.asMap().entries.map((entry) {
          final index = entry.key;
          final chapter = entry.value;
          final isCompleted = widget.completedChapters.contains(chapter.id);
          final isCurrent = widget.currentChapter == chapter.id;
          final isLocked =
              index > 0 &&
              !widget.completedChapters.contains(chapters[index - 1].id) &&
              !isCurrent;

          return _buildChapterItem(chapter, isCompleted, isCurrent, isLocked);
        }).toList(),
      ),
    );
  }

  Widget _buildChapterItem(
    Chapter chapter,
    bool isCompleted,
    bool isCurrent,
    bool isLocked,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLocked ? null : () => widget.onChapterSelect(chapter.id),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCurrent
                  ? AppColors.gold
                  : isCompleted
                  ? AppColors.gold.withOpacity(0.1)
                  : isLocked
                  ? AppColors.darkSurface
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isCurrent
                    ? AppColors.gold
                    : isCompleted
                    ? AppColors.gold.withOpacity(0.3)
                    : AppColors.darkBorder.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                _buildChapterIcon(chapter, isCompleted, isCurrent, isLocked),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            chapter.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isCurrent
                                  ? AppColors.darkBg
                                  : isLocked
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textPrimaryDark,
                            ),
                          ),
                          if (chapter.required) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('mobile.auto.required'.tr(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        chapter.estimatedTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: isCurrent
                              ? AppColors.darkBg.withOpacity(0.8)
                              : AppColors.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isLocked)
                  Icon(
                    Icons.lock,
                    size: 20,
                    color: AppColors.textSecondaryDark,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChapterIcon(
    Chapter chapter,
    bool isCompleted,
    bool isCurrent,
    bool isLocked,
  ) {
    IconData iconData;
    Color iconColor;
    Color backgroundColor;

    if (isCompleted) {
      iconData = Icons.check_circle;
      iconColor = AppColors.gold;
      backgroundColor = AppColors.gold.withOpacity(0.2);
    } else {
      iconData = chapter.icon;
      iconColor = isCurrent
          ? AppColors.darkBg
          : isLocked
          ? AppColors.textSecondaryDark
          : AppColors.textPrimaryDark;
      backgroundColor = isCurrent
          ? AppColors.darkBg.withOpacity(0.2)
          : AppColors.darkSurface;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, size: 24, color: iconColor),
    );
  }

  Widget _buildMobileNavigation() {
    if (!_expandedOnMobile) {
      return Positioned(
        bottom: 80,
        left: 16,
        right: 16,
        child: _buildCollapsedMobileNavigation(),
      );
    } else {
      return Positioned(
        bottom: 80,
        left: 16,
        right: 16,
        child: _buildExpandedMobileNavigation(),
      );
    }
  }

  Widget _buildCollapsedMobileNavigation() {
    final currentChapterData = chapters.firstWhere(
      (c) => c.id == widget.currentChapter,
      orElse: () => chapters.first,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _expandedOnMobile = true;
              _animationController.forward();
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    currentChapterData.icon,
                    size: 24,
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentChapterData.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                      Text(
                        '$completionPercentage% Complete',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_up,
                  size: 20,
                  color: AppColors.textSecondaryDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedMobileNavigation() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.darkBorder.withOpacity(0.3),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('mobile.auto.chapters'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _expandedOnMobile = false;
                        _animationController.reverse();
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: chapters.map((chapter) {
                  final isCompleted = widget.completedChapters.contains(
                    chapter.id,
                  );
                  final isCurrent = widget.currentChapter == chapter.id;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.onChapterSelect(chapter.id);
                          setState(() {
                            _expandedOnMobile = false;
                            _animationController.reverse();
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isCurrent
                                ? AppColors.gold
                                : isCompleted
                                ? AppColors.gold.withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isCurrent
                                  ? AppColors.gold
                                  : isCompleted
                                  ? AppColors.gold.withOpacity(0.3)
                                  : AppColors.darkBorder.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isCompleted ? Icons.check_circle : chapter.icon,
                                size: 24,
                                color: isCurrent
                                    ? AppColors.darkBg
                                    : isCompleted
                                    ? AppColors.gold
                                    : AppColors.textPrimaryDark,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chapter.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isCurrent
                                            ? AppColors.darkBg
                                            : AppColors.textPrimaryDark,
                                      ),
                                    ),
                                    Text(
                                      chapter.estimatedTime,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isCurrent
                                            ? AppColors.darkBg.withOpacity(0.8)
                                            : AppColors.textSecondaryDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Chapter {
  final String id;
  final String name;
  final IconData icon;
  final String estimatedTime;
  final bool required;

  Chapter({
    required this.id,
    required this.name,
    required this.icon,
    required this.estimatedTime,
    required this.required,
  });
}
