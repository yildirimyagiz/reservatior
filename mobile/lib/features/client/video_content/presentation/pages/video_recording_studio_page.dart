import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/client/video_content/presentation/widgets/camera_preview_widget.dart';
import 'package:reservatior/features/client/video_content/presentation/widgets/ai_prompt_panel_widget.dart';
import 'package:reservatior/features/client/video_content/presentation/widgets/chapter_navigation_widget.dart';
import 'package:reservatior/features/client/video_content/presentation/widgets/recording_controls_widget.dart';
import 'package:reservatior/features/client/video_content/presentation/widgets/recording_settings_widget.dart';
import 'package:reservatior/features/client/video_content/presentation/widgets/subtitle_preview_widget.dart';

class VideoRecordingStudioPage extends StatefulWidget {
  const VideoRecordingStudioPage({super.key});

  @override
  State<VideoRecordingStudioPage> createState() =>
      _VideoRecordingStudioPageState();
}

class _VideoRecordingStudioPageState extends State<VideoRecordingStudioPage>
    with TickerProviderStateMixin {
  bool _isHydrated = false;
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordingDuration = 0;
  String _currentChapter = 'exterior';
  List<String> _completedChapters = [];
  CameraController? _cameraController;
  String _videoQuality = 'medium';
  bool _autoFocus = true;
  bool _showBlurring = true;
  bool _consentGiven = false;
  String _subtitleLanguage = 'en';
  String _currentSubtitle = '';
  bool _showSaveModal = false;
  Timer? _recordingTimer;
  Timer? _subtitleTimer;

  @override
  void initState() {
    super.initState();
    _isHydrated = true;
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _subtitleTimer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  void _startRecordingTimer() {
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _recordingDuration++;
        });
      }
    });
  }

  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
  }

  void _startSubtitleSimulation() {
    final mockSubtitles = [
      'mobile.leftovers.welcome_to_this_beautiful_property_locat'.tr(),
      'mobile.leftovers.as_you_can_see_the_exterior_features_mod'.tr(),
      'mobile.leftovers.the_property_includes_a_spacious_drivewa'.tr(),
      'mobile.leftovers.let_me_show_you_the_main_entrance_and_th'.tr(),
      'mobile.leftovers.notice_the_high_ceilings_and_abundant_na'.tr(),
    ];

    _subtitleTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted && _isRecording && !_isPaused) {
        final randomSubtitle =
            mockSubtitles[(DateTime.now().millisecond) % mockSubtitles.length];
        setState(() {
          _currentSubtitle = randomSubtitle;
        });
      }
    });
  }

  void _stopSubtitleSimulation() {
    _subtitleTimer?.cancel();
  }

  void handleStartRecording() {
    if (!_consentGiven) return;

    setState(() {
      _isRecording = true;
      _isPaused = false;
      _recordingDuration = 0;
    });
    _startRecordingTimer();
    _startSubtitleSimulation();
  }

  void handleStopRecording() {
    setState(() {
      _isRecording = false;
      _isPaused = false;
      _showSaveModal = true;
    });
    _stopRecordingTimer();
    _stopSubtitleSimulation();
  }

  void handlePauseRecording() {
    setState(() {
      _isPaused = true;
    });
  }

  void handleResumeRecording() {
    setState(() {
      _isPaused = false;
    });
  }

  void handleAddChapterMarker() {
    if (!_completedChapters.contains(_currentChapter)) {
      setState(() {
        _completedChapters = [..._completedChapters, _currentChapter];
      });
    }
  }

  void handleNextPrompt() {
    final chapters = [
      'exterior',
      'entrance',
      'living',
      'bedrooms',
      'kitchen',
      'bathrooms',
      'extras',
    ];
    final currentIndex = chapters.indexOf(_currentChapter);

    if (currentIndex < chapters.length - 1) {
      if (!_completedChapters.contains(_currentChapter)) {
        setState(() {
          _completedChapters = [..._completedChapters, _currentChapter];
        });
      }
      setState(() {
        _currentChapter = chapters[currentIndex + 1];
      });
    }
  }

  void handleSkipPrompt() {
    handleNextPrompt();
  }

  void handleChapterSelect(String chapter) {
    setState(() {
      _currentChapter = chapter;
    });
  }

  void handleSaveAndPublish() {
    setState(() {
      _showSaveModal = false;
    });
    Navigator.of(context).pushNamed('/property-details');
  }

  void handleSaveDraft() {
    setState(() {
      _showSaveModal = false;
    });
    Navigator.of(context).pushNamed('/property-feed');
  }

  void handleDiscard() {
    setState(() {
      _showSaveModal = false;
      _recordingDuration = 0;
      _completedChapters = [];
      _currentChapter = 'exterior';
      _currentSubtitle = '';
    });
  }

  String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final mins = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (!_isHydrated) {
      return Scaffold(
        backgroundColor: AppColors.darkBg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.videocam, size: 48, color: AppColors.gold),
              SizedBox(height: 16),
              Text('mobile.auto.loading_recording_studio'.tr(),
                style: TextStyle(
                  color: AppColors.textSecondaryDark,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 1024) {
                return _buildDesktopLayout();
              } else {
                return _buildMobileLayout();
              }
            },
          ),
          if (_showSaveModal) _buildSaveModal(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left Sidebar - Chapter Navigation
        SizedBox(
          width: 320,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ChapterNavigationWidget(
              currentChapter: _currentChapter,
              completedChapters: _completedChapters,
              onChapterSelect: handleChapterSelect,
            ),
          ),
        ),

        // Center - Camera Preview & Controls
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: CameraPreviewWidget(
                    isRecording: _isRecording,
                    isPaused: _isPaused,
                    onCameraReady: (controller) {
                      setState(() {
                        _cameraController = controller;
                      });
                    },
                    showBlurring: _showBlurring,
                    videoQuality: _videoQuality,
                  ),
                ),
                const SizedBox(height: 16),
                SubtitlePreviewWidget(
                  isRecording: _isRecording,
                  currentText: _currentSubtitle,
                  language: _subtitleLanguage,
                  onLanguageChange: (language) {
                    setState(() {
                      _subtitleLanguage = language;
                    });
                  },
                ),
                const SizedBox(height: 16),
                RecordingControlsWidget(
                  isRecording: _isRecording,
                  isPaused: _isPaused,
                  recordingDuration: _recordingDuration,
                  onStartRecording: handleStartRecording,
                  onStopRecording: handleStopRecording,
                  onPauseRecording: handlePauseRecording,
                  onResumeRecording: handleResumeRecording,
                  onAddChapterMarker: handleAddChapterMarker,
                ),
              ],
            ),
          ),
        ),

        // Right Sidebar - AI Prompts & Settings
        SizedBox(
          width: 320,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                AIPromptPanelWidget(
                  currentChapter: _currentChapter,
                  onNextPrompt: handleNextPrompt,
                  onSkipPrompt: handleSkipPrompt,
                ),
                const SizedBox(height: 16),
                RecordingSettingsWidget(
                  videoQuality: _videoQuality,
                  autoFocus: _autoFocus,
                  showBlurring: _showBlurring,
                  consentGiven: _consentGiven,
                  onVideoQualityChange: (quality) {
                    setState(() {
                      _videoQuality = quality;
                    });
                  },
                  onAutoFocusChange: (enabled) {
                    setState(() {
                      _autoFocus = enabled;
                    });
                  },
                  onBlurringChange: (enabled) {
                    setState(() {
                      _showBlurring = enabled;
                    });
                  },
                  onConsentChange: (given) {
                    setState(() {
                      _consentGiven = given;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Camera Preview
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              CameraPreviewWidget(
                isRecording: _isRecording,
                isPaused: _isPaused,
                onCameraReady: (controller) {
                  setState(() {
                    _cameraController = controller;
                  });
                },
                showBlurring: _showBlurring,
                videoQuality: _videoQuality,
              ),

              // Floating AI Prompt
              if (_isRecording)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.darkCard.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: AppColors.darkBorder.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      _getCurrentPrompt(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Subtitle Preview
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: SubtitlePreviewWidget(
            isRecording: _isRecording,
            currentText: _currentSubtitle,
            language: _subtitleLanguage,
            onLanguageChange: (language) {
              setState(() {
                _subtitleLanguage = language;
              });
            },
          ),
        ),

        // Recording Controls
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: RecordingControlsWidget(
            isRecording: _isRecording,
            isPaused: _isPaused,
            recordingDuration: _recordingDuration,
            onStartRecording: handleStartRecording,
            onStopRecording: handleStopRecording,
            onPauseRecording: handlePauseRecording,
            onResumeRecording: handleResumeRecording,
            onAddChapterMarker: handleAddChapterMarker,
          ),
        ),

        // Chapter Navigation
        ChapterNavigationWidget(
          currentChapter: _currentChapter,
          completedChapters: _completedChapters,
          onChapterSelect: handleChapterSelect,
        ),

        // Settings Button
        if (!_isRecording)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: RecordingSettingsWidget(
              videoQuality: _videoQuality,
              autoFocus: _autoFocus,
              showBlurring: _showBlurring,
              consentGiven: _consentGiven,
              onVideoQualityChange: (quality) {
                setState(() {
                  _videoQuality = quality;
                });
              },
              onAutoFocusChange: (enabled) {
                setState(() {
                  _autoFocus = enabled;
                });
              },
              onBlurringChange: (enabled) {
                setState(() {
                  _showBlurring = enabled;
                });
              },
              onConsentChange: (given) {
                setState(() {
                  _consentGiven = given;
                });
              },
            ),
          ),
      ],
    );
  }

  String _getCurrentPrompt() {
    switch (_currentChapter) {
      case 'exterior':
        return 'mobile.leftovers.start_with_a_wide_shot_of_the_entire_pro'.tr();
      case 'entrance':
        return 'mobile.leftovers.show_the_entryway_and_welcome_viewers_in'.tr();
      case 'living':
        return 'mobile.leftovers.showcase_the_main_living_spaces_and_layo'.tr();
      case 'bedrooms':
        return 'mobile.leftovers.present_the_private_bedroom_spaces'.tr();
      case 'kitchen':
        return 'mobile.leftovers.highlight_the_kitchen_features_and_appli'.tr();
      case 'bathrooms':
        return 'mobile.leftovers.tour_the_bathroom_facilities'.tr();
      case 'extras':
        return 'mobile.leftovers.show_any_additional_features_and_spaces'.tr();
      default:
        return 'mobile.leftovers.start_with_a_wide_shot_of_the_entire_pro'.tr();
    }
  }

  Widget _buildSaveModal() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSaveModalHeader(),
            _buildSaveModalStats(),
            _buildSaveModalActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveModalHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.check_circle, size: 28, color: Colors.green),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mobile.auto.recording_complete'.tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                SizedBox(height: 4),
                Text('mobile.auto.your_property_walkthrough_has_been_recorded_successfully'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveModalStats() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.darkSurface),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(formatDuration(_recordingDuration), 'Duration'),
          _buildStatItem(_completedChapters.length.toString(), 'Chapters'),
          _buildStatItem(
            _videoQuality == 'high'
                ? '1080p'
                : _videoQuality == 'medium'
                ? '720p'
                : '480p',
            'Quality',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondaryDark),
        ),
      ],
    );
  }

  Widget _buildSaveModalActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: handleSaveAndPublish,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload, size: 20, color: AppColors.darkBg),
                    SizedBox(width: 8),
                    Text('mobile.auto.save_publish'.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkBg,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: handleSaveDraft,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.gold.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description, size: 20, color: AppColors.gold),
                    SizedBox(width: 8),
                    Text('mobile.auto.save_as_draft'.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: handleDiscard,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.darkBorder.withOpacity(0.3),
                  ),
                ),
                child: Text('mobile.auto.discard_recording'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
