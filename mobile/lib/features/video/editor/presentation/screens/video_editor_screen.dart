import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../shared/widgets/app_widgets.dart';
import '../widgets/room_navigator_widget.dart';
import '../widgets/video_controls_widget.dart';
import '../../data/models/room_model.dart';

class VideoEditorScreen extends StatefulWidget {
  final String listingId;
  const VideoEditorScreen({super.key, required this.listingId});

  
  State<VideoEditorScreen> createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  int _selectedScene = 0;
  double _playhead = 0.35;
  bool _isPlaying = false;
  String _aspectRatio = '16:9';
  String _selectedSubtitleLang = 'en';
  bool _showSubtitles = true;
  
  // Video player controller
  VideoPlayerController? _videoController;
  bool _showRoomNavigator = true;
  bool _showPropertyInfo = false;
  
  // Sample room data
  final List<RoomSection> _rooms = [
    RoomSection(
      id: '1',
      displayName: 'Living Room',
      icon: '🛋️',
      videoTimestamp: 0.0,
      status: RoomCaptureStatus.captured,
      color: const Color(0xFF4A6FA5),
    ),
    RoomSection(
      id: '2',
      displayName: 'Kitchen',
      icon: '🍳',
      videoTimestamp: 3.2,
      status: RoomCaptureStatus.captured,
      color: const Color(0xFF47A35A),
    ),
    RoomSection(
      id: '3',
      displayName: 'Master Bedroom',
      icon: '🛏️',
      videoTimestamp: 6.0,
      status: RoomCaptureStatus.captured,
      color: const Color(0xFF9B59B6),
    ),
    RoomSection(
      id: '4',
      displayName: 'Terrace',
      icon: '🌅',
      videoTimestamp: 9.5,
      status: RoomCaptureStatus.captured,
      color: const Color(0xFFC9A84C),
    ),
    RoomSection(
      id: '5',
      displayName: 'Exterior',
      icon: '🏠',
      videoTimestamp: 13.6,
      status: RoomCaptureStatus.captured,
      color: const Color(0xFFE74C3C),
    ),
  ];

  final List<_SceneClip> _scenes = [
    _SceneClip('Living Room', 3.2, 0xFF4A6FA5),
    _SceneClip('Kitchen', 2.8, 0xFF47A35A),
    _SceneClip('Master Bedroom', 3.5, 0xFF9B59B6),
    _SceneClip('Terrace', 4.1, 0xFFC9A84C),
    _SceneClip('Exterior', 2.9, 0xFFE74C3C),
  ];

  double get _totalDuration =>
    _scenes.fold(0.0, (sum, s) => sum + s.duration);

  
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 4, vsync: this);
    _initializeVideo();
  }
  
  Future<void> _initializeVideo() async {
    // Sample video URL - replace with actual video
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
    );
    
    try {
      await _videoController!.initialize();
      _videoController!.addListener(_videoListener);
      setState(() {});
    } catch (e) {
      print('Video initialization error: $e');
    }
  }
  
  void _videoListener() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      final newPosition = _videoController!.value.position.inMilliseconds / 1000.0;
      final totalDuration = _videoController!.value.duration.inMilliseconds / 1000.0;
      
      if (newPosition <= totalDuration) {
        setState(() {
          _playhead = totalDuration > 0 ? newPosition / totalDuration : 0.0;
        });
      }
    }
  }

  
  void dispose() {
    _tabCtrl.dispose();
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    super.dispose();
  }

  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Column(
        children: [
          // ── Video Preview ───────────────────────────────────────
          Stack(
            children: [
              _VideoPreview(
                aspectRatio: _aspectRatio,
                isPlaying: _isPlaying,
                playhead: _playhead,
                onPlayPause: _togglePlayPause,
                showSubtitles: _showSubtitles,
                onBack: () => Navigator.pop(context),
                videoController: _videoController,
                onSeek: _seekTo,
                onSkipForward: _skipForward,
                onSkipBackward: _skipBackward,
              ),
              
              // Property info overlay
              PropertyInfoOverlay(
                isVisible: _showPropertyInfo,
                onClose: () => setState(() => _showPropertyInfo = false),
              ),
              
              // Property info button
              if (_videoController != null && _videoController!.value.isInitialized)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: PropertyInfoButton(
                    icon: Icons.info_outline_rounded,
                    label: 'Property',
                    value: 'Info',
                    onTap: () => setState(() => _showPropertyInfo = !_showPropertyInfo),
                  ),
                ),
            ],
          ),
          
          // ── Room Navigator ───────────────────────────────────────────────
          if (_showRoomNavigator && _videoController != null && _videoController!.value.isInitialized)
            RoomNavigatorWidget(
              rooms: _rooms,
              onSeek: (timestamp) {
                _seekTo(timestamp);
              },
              currentTimestamp: _videoController!.value.position.inSeconds.toDouble(),
            ),

          // ── Tabs ────────────────────────────────────────────────
          Container(
            color: AppColors.darkSurface,
            child: TabBar(
              controller: _tabCtrl,
              labelColor: AppColors.gold,
              unselectedLabelColor: AppColors.textSecondaryDark,
              indicatorColor: AppColors.gold,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Timeline'),
                Tab(text: 'Subtitles'),
                Tab(text: 'Audio'),
                Tab(text: 'Export'),
              ],
            ),
          ),

          // ── Tab Content ─────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                _buildTimeline(),
                _buildSubtitlesTab(),
                _buildAudioTab(),
                _buildExportTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Timeline Tab ───────────────────────────────────────────────────────────────
  Widget _buildTimeline() {
    return Column(
      children: [
        // Playhead bar
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatTime(_playhead * _totalDuration),
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontSize: 12, fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    _formatTime(_totalDuration),
                    style: const TextStyle(
                      color: AppColors.textSecondaryDark, fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              SliderTheme(
                data: SliderThemeData(
                  thumbColor: AppColors.gold,
                  activeTrackColor: AppColors.gold,
                  inactiveTrackColor: AppColors.darkBorder,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  trackHeight: 3,
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                ),
                child: Slider(
                  value: _playhead,
                  onChanged: (v) {
                    _seekTo(v * _totalDuration);
                  },
                ),
              ),
            ],
          ),
        ),

        // Scene clips timeline
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            children: _scenes.asMap().entries.map((e) {
              final i = e.key;
              final scene = e.value;
              final isSelected = _selectedScene == i;
              final width = (scene.duration / _totalDuration) *
                (MediaQuery.of(context).size.width - AppSpacing.md * 2);

              return GestureDetector(
                onTap: () => setState(() => _selectedScene = i),
                child: AnimatedContainer(
                  duration: 200.ms,
                  width: width.clamp(80, double.infinity),
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    color: Color(scene.color).withOpacity(isSelected ? 0.3 : 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                    border: Border.all(
                      color: isSelected
                        ? Color(scene.color) : Color(scene.color).withOpacity(0.3),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scene.name,
                          style: TextStyle(
                            color: isSelected
                              ? Color(scene.color) : AppColors.textSecondaryDark,
                            fontSize: 10, fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          '${scene.duration.toStringAsFixed(1)}s',
                          style: TextStyle(
                            color: Color(scene.color).withOpacity(0.7),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const Divider(color: AppColors.darkBorder, height: 1),

        // Scene editor tools
        if (_selectedScene < _scenes.length)
          Expanded(
            child: _SceneEditor(
              scene: _scenes[_selectedScene],
              onDelete: () {
                if (_scenes.length > 1) {
                  setState(() {
                    _scenes.removeAt(_selectedScene);
                    _selectedScene = (_selectedScene - 1).clamp(0, _scenes.length - 1);
                  });
                }
              },
              onMoveLeft: _selectedScene > 0 ? () {
                setState(() {
                  final s = _scenes.removeAt(_selectedScene);
                  _scenes.insert(_selectedScene - 1, s);
                  _selectedScene--;
                });
              } : null,
              onMoveRight: _selectedScene < _scenes.length - 1 ? () {
                setState(() {
                  final s = _scenes.removeAt(_selectedScene);
                  _scenes.insert(_selectedScene + 1, s);
                  _selectedScene++;
                });
              } : null,
            ),
          ),
      ],
    );
  }

  // ── Subtitles Tab ──────────────────────────────────────────────────────────────
  Widget _buildSubtitlesTab() {
    final subtitles = [
      ('00:02', '00:04', 'Welcome to this stunning penthouse'),
      ('00:05', '00:08', 'with breathtaking Bosphorus views.'),
      ('00:09', '00:13', 'The spacious living area features'),
      ('00:14', '00:17', 'floor-to-ceiling panoramic windows.'),
      ('00:18', '00:22', 'The modern kitchen with island'),
      ('00:23', '00:27', 'is perfect for entertaining guests.'),
    ];

    return Column(
      children: [
        // Language + toggle bar
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm,
          ),
          color: AppColors.darkSurface,
          child: Row(
            children: [
              // Language selector
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ('🇺🇸','en'), ('🇹🇷','tr'), ('🇸🇦','ar'),
                      ('🇩🇪','de'), ('🇫🇷','fr'),
                    ].map((l) {
                      final (flag, code) = l;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSubtitleLang = code),
                        child: AnimatedContainer(
                          duration: 200.ms,
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedSubtitleLang == code
                              ? AppColors.gold.withOpacity(0.15) : AppColors.darkCard,
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            border: Border.all(
                              color: _selectedSubtitleLang == code
                                ? AppColors.gold : AppColors.darkBorder,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(flag, style: const TextStyle(fontSize: 13)),
                              const SizedBox(width: 4),
                              Text(code.toUpperCase(),
                                style: TextStyle(
                                  color: _selectedSubtitleLang == code
                                    ? AppColors.gold : AppColors.textSecondaryDark,
                                  fontSize: 11, fontWeight: FontWeight.w700,
                                )),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  Text('Show',
                    style: const TextStyle(
                      color: AppColors.textSecondaryDark, fontSize: 12,
                    )),
                  const SizedBox(width: 6),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: _showSubtitles,
                      onChanged: (v) => setState(() => _showSubtitles = v),
                      activeColor: AppColors.gold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Subtitle list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: subtitles.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final (start, end, text) = subtitles[i];
              return _SubtitleRow(
                index: i + 1, start: start, end: end, text: text,
                lang: _selectedSubtitleLang,
              ).animate().fadeIn(delay: Duration(milliseconds: i * 40));
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: GoldButton(
            label: '+ Add AI Translation Language',
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  // ── Audio Tab ──────────────────────────────────────────────────────────────────
  Widget _buildAudioTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Background Music',
            style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),

          ...['Luxury Ambience', 'Elegant Piano', 'Modern Cinematic', 'No Music']
            .asMap().entries.map((e) {
            final isSelected = e.key == 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: PremiumCard(
                onTap: () {},
                borderColor: isSelected ? AppColors.gold : null,
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                          ? AppColors.gold.withOpacity(0.1) : AppColors.darkMuted,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        e.key == 3
                          ? Icons.music_off_rounded
                          : Icons.music_note_rounded,
                        color: isSelected ? AppColors.gold : AppColors.textSecondaryDark,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(e.value,
                        style: TextStyle(
                          color: isSelected
                            ? AppColors.gold : AppColors.textPrimaryDark,
                          fontSize: 14, fontWeight: FontWeight.w500,
                        )),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle_rounded,
                        color: AppColors.gold, size: 20),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: AppSpacing.xl),
          Text('Volume Mix', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),

          _VolumeSlider(label: 'Music', value: 0.4, icon: Icons.music_note_rounded,
            color: AppColors.info),
          const SizedBox(height: 10),
          _VolumeSlider(label: 'Voiceover', value: 0.85, icon: Icons.record_voice_over_rounded,
            color: AppColors.gold),
        ],
      ),
    );
  }

  // ── Export Tab ─────────────────────────────────────────────────────────────────
  Widget _buildExportTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Aspect Ratio', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),

          Row(
            children: ['16:9', '9:16', '1:1'].map((r) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: r != '1:1' ? AppSpacing.sm : 0,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => _aspectRatio = r),
                  child: AnimatedContainer(
                    duration: 200.ms,
                    height: 70,
                    decoration: BoxDecoration(
                      color: _aspectRatio == r
                        ? AppColors.gold.withOpacity(0.1) : AppColors.darkCard,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(
                        color: _aspectRatio == r
                          ? AppColors.gold : AppColors.darkBorder,
                        width: _aspectRatio == r ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _RatioIcon(ratio: r,
                          isSelected: _aspectRatio == r),
                        const SizedBox(height: 6),
                        Text(r,
                          style: TextStyle(
                            color: _aspectRatio == r
                              ? AppColors.gold : AppColors.textSecondaryDark,
                            fontSize: 11, fontWeight: FontWeight.w700,
                          )),
                      ],
                    ),
                  ),
                ),
              ),
            )).toList(),
          ),

          const SizedBox(height: AppSpacing.xl),

          Text('Quality', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),

          ...['4K Ultra HD', '1080p Full HD', '720p HD'].asMap().entries.map((e) {
            final isSelected = e.key == 1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: PremiumCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(e.value,
                                style: const TextStyle(
                                  color: AppColors.textPrimaryDark,
                                  fontSize: 14, fontWeight: FontWeight.w600,
                                )),
                              if (e.key == 0) ...[
                                const SizedBox(width: 8),
                                const PlanBadge(label: 'Pro'),
                              ],
                            ],
                          ),
                          Text(
                            e.key == 0 ? 'Best quality' : e.key == 1 ? 'Recommended' : 'Smallest size',
                            style: const TextStyle(
                              color: AppColors.textSecondaryDark, fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<int>(
                      value: e.key, groupValue: 1, onChanged: (_) {},
                      activeColor: AppColors.gold,
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: AppSpacing.xl),

          Text('Share To', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),

          Row(
            children: [
              ('📸','Instagram'), ('🎵','TikTok'), ('▶️','YouTube'), ('⬇️','Download'),
            ].map((p) {
              final (emoji, name) = p;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.darkCard,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: Border.all(color: AppColors.darkBorder),
                      ),
                      child: Column(
                        children: [
                          Text(emoji, style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 4),
                          Text(name,
                            style: const TextStyle(
                              color: AppColors.textSecondaryDark,
                              fontSize: 9, fontWeight: FontWeight.w600,
                            )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.xl),

          GoldButton(
            label: 'Export Video',
            icon: Icons.download_rounded,
            onPressed: () {},
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  String _formatTime(double secs) {
    final m = (secs ~/ 60).toString().padLeft(2, '0');
    final s = (secs % 60).toInt().toString().padLeft(2, '0');
    return '$m:$s';
  }
  
  void _togglePlayPause() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      setState(() {
        _isPlaying = !_isPlaying;
        if (_isPlaying) {
          _videoController!.play();
        } else {
          _videoController!.pause();
        }
      });
    }
  }
  
  void _seekTo(double seconds) {
    if (_videoController != null && _videoController!.value.isInitialized) {
      final duration = _videoController!.value.duration.inSeconds.toDouble();
      final clampedSeconds = seconds.clamp(0.0, duration);
      _videoController!.seekTo(Duration(seconds: clampedSeconds.toInt()));
    }
  }
  
  void _skipForward() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      final currentPos = _videoController!.value.position.inSeconds;
      _seekTo((currentPos + 10).toDouble());
    }
  }
  
  void _skipBackward() {
    if (_videoController != null && _videoController!.value.isInitialized) {
      final currentPos = _videoController!.value.position.inSeconds;
      _seekTo((currentPos - 10).toDouble());
    }
  }
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────────

class _VideoPreview extends StatelessWidget {
  final String aspectRatio;
  final bool isPlaying, showSubtitles;
  final double playhead;
  final VoidCallback onPlayPause, onBack, onSkipForward, onSkipBackward;
  final VideoPlayerController? videoController;
  final Function(double) onSeek;

  const _VideoPreview({
    required this.aspectRatio, required this.isPlaying,
    required this.showSubtitles, required this.playhead,
    required this.onPlayPause, required this.onBack,
    required this.videoController, required this.onSeek,
    required this.onSkipForward, required this.onSkipBackward,
  });

  
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = switch (aspectRatio) {
      '9:16' => width * 1.2,
      '1:1'  => width * 0.6,
      _      => width * 0.56, // 16:9
    };

    return Container(
      width: width,
      height: height.clamp(0, 240),
      color: Colors.black,
      child: Stack(
        children: [
          // Video player or gradient bg
          if (videoController != null && videoController!.value.isInitialized)
            SizedBox(
              width: width,
              height: height.clamp(0, 240),
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: videoController!.value.size.width,
                  height: videoController!.value.size.height,
                  child: VideoPlayer(videoController!),
                ),
              ),
            )
          else
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0C0D10), Color(0xFF1C1F27)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(Icons.home_work_rounded,
                  size: 60, color: AppColors.darkBorder),
              ),
            ),

          // Subtitle overlay
          if (showSubtitles)
            Positioned(
              bottom: 40, left: 16, right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Welcome to this stunning penthouse',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

          // Playhead indicator
          Positioned(
            bottom: 0, left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * playhead,
              height: 3,
              color: AppColors.gold,
            ),
          ),

          // Top bar
          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm, vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white, size: 18),
                    onPressed: onBack,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.fullscreen_rounded,
                      color: Colors.white, size: 22),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Skip buttons
          if (videoController != null && videoController!.value.isInitialized)
            Positioned(
              left: 16,
              top: height.clamp(0, 240) / 2 - 30,
              child: _SkipButton(
                icon: Icons.replay_10_rounded,
                onTap: onSkipBackward,
              ),
            ),
          
          if (videoController != null && videoController!.value.isInitialized)
            Positioned(
              right: 16,
              top: height.clamp(0, 240) / 2 - 30,
              child: _SkipButton(
                icon: Icons.forward_10_rounded,
                onTap: onSkipForward,
              ),
            ),

          // Play button
          Center(
            child: GestureDetector(
              onTap: onPlayPause,
              child: AnimatedContainer(
                duration: 200.ms,
                width: 52, height: 52,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                ),
                child: Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: Colors.white, size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SceneEditor extends StatelessWidget {
  final _SceneClip scene;
  final VoidCallback onDelete;
  final VoidCallback? onMoveLeft, onMoveRight;

  const _SceneEditor({
    required this.scene, required this.onDelete,
    this.onMoveLeft, this.onMoveRight,
  });

  
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkSurface,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: Color(scene.color),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(scene.name,
                style: const TextStyle(
                  color: AppColors.textPrimaryDark,
                  fontSize: 15, fontWeight: FontWeight.w600,
                )),
              const Spacer(),
              Text('${scene.duration.toStringAsFixed(1)}s',
                style: const TextStyle(
                  color: AppColors.textSecondaryDark, fontSize: 13,
                )),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _EditorAction(
                icon: Icons.arrow_back_rounded,
                label: 'Move Left',
                onTap: onMoveLeft,
              ),
              const SizedBox(width: 8),
              _EditorAction(
                icon: Icons.arrow_forward_rounded,
                label: 'Move Right',
                onTap: onMoveRight,
              ),
              const SizedBox(width: 8),
              _EditorAction(
                icon: Icons.content_cut_rounded,
                label: 'Trim',
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _EditorAction(
                icon: Icons.delete_outline_rounded,
                label: 'Delete',
                onTap: onDelete,
                color: AppColors.error,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EditorAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? color;

  const _EditorAction({
    required this.icon, required this.label,
    this.onTap, this.color,
  });

  
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textSecondaryDark;
    final isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: 200.ms,
        opacity: isEnabled ? 1.0 : 0.3,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: c.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: c.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: c, size: 14),
              const SizedBox(width: 4),
              Text(label, style: TextStyle(
                color: c, fontSize: 12, fontWeight: FontWeight.w600,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubtitleRow extends StatelessWidget {
  final int index;
  final String start, end, text, lang;

  const _SubtitleRow({
    required this.index, required this.start, required this.end,
    required this.text, required this.lang,
  });

  
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index',
            style: const TextStyle(
              color: AppColors.textSecondaryDark,
              fontSize: 12, fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(start,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontSize: 11, fontWeight: FontWeight.w700,
                      )),
                    const Text(' → ',
                      style: TextStyle(
                        color: AppColors.textSecondaryDark, fontSize: 11,
                      )),
                    Text(end,
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontSize: 11, fontWeight: FontWeight.w700,
                      )),
                  ],
                ),
                const SizedBox(height: 4),
                Directionality(
                  textDirection: lang == 'ar'
                    ? TextDirection.rtl : TextDirection.ltr,
                  child: Text(text,
                    style: const TextStyle(
                      color: AppColors.textPrimaryDark,
                      fontSize: 13,
                    )),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined,
              color: AppColors.textSecondaryDark, size: 16),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _VolumeSlider extends StatefulWidget {
  final String label;
  final double value;
  final IconData icon;
  final Color color;

  const _VolumeSlider({
    required this.label, required this.value,
    required this.icon, required this.color,
  });

  
  State<_VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<_VolumeSlider> {
  late double _value;

  
  void initState() {
    super.initState();
    _value = widget.value;
  }

  
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(widget.icon, color: widget.color, size: 18),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(widget.label,
            style: const TextStyle(
              color: AppColors.textPrimaryDark,
              fontSize: 13, fontWeight: FontWeight.w500,
            )),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              thumbColor: widget.color,
              activeTrackColor: widget.color,
              inactiveTrackColor: AppColors.darkBorder,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              trackHeight: 3,
            ),
            child: Slider(
              value: _value,
              onChanged: (v) => setState(() => _value = v),
            ),
          ),
        ),
        SizedBox(
          width: 36,
          child: Text(
            '${(_value * 100).toInt()}%',
            style: TextStyle(
              color: widget.color, fontSize: 11, fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _RatioIcon extends StatelessWidget {
  final String ratio;
  final bool isSelected;

  const _RatioIcon({required this.ratio, required this.isSelected});

  
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.gold : AppColors.textSecondaryDark;
    final (w, h) = switch (ratio) {
      '9:16' => (14.0, 22.0),
      '1:1'  => (18.0, 18.0),
      _      => (24.0, 14.0),
    };
    return Container(
      width: w, height: h,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _SceneClip {
  final String name;
  final double duration;
  final int color;

  _SceneClip(this.name, this.duration, this.color);
}
