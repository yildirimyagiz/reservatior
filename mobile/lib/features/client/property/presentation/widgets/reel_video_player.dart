import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';

/// A dedicated Reels-style video player designed for full-screen vertical scroll.
/// Features: autoplay, mute, seek forward/back, scrubber, tap-to-pause, double-tap-to-like.
class ReelVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  final bool isActive;
  final VoidCallback? onDoubleTap;

  const ReelVideoPlayer({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
    this.isActive = true,
    this.onDoubleTap,
  });

  @override
  State<ReelVideoPlayer> createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isMuted = false;
  bool _showControls = false;
  bool _showHeartAnimation = false;
  bool _showSeekIndicator = false;
  String _seekDirection = '';
  Timer? _controlsTimer;
  Timer? _seekTimer;
  bool _hasError = false;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl.isNotEmpty) {
      _initializePlayer();
    } else {
      _hasError = true;
    }
  }

  @override
  void didUpdateWidget(ReelVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller?.play();
      } else {
        _controller?.pause();
      }
    }
  }

  Future<void> _initializePlayer() async {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      await _controller!.initialize();
      _controller!.setLooping(true);
      _controller!.setVolume(_isMuted ? 0 : 1);

      if (widget.isActive) {
        _controller!.play();
      }

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controlsTimer?.cancel();
    _seekTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller == null || !_isInitialized) return;
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        _showControls = true;
        _controlsTimer?.cancel(); // Keep controls visible while paused
      } else {
        _controller!.play();
        _startControlsTimer();
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startControlsTimer();
    }
  }

  void _startControlsTimer() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(const Duration(seconds: 4), () {
      if (mounted && _controller?.value.isPlaying == true) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _toggleMute() {
    if (_controller == null) return;
    setState(() {
      _isMuted = !_isMuted;
      _controller!.setVolume(_isMuted ? 0 : 1);
    });
  }

  void _seekForward() {
    if (_controller == null || !_isInitialized) return;
    final current = _controller!.value.position;
    final duration = _controller!.value.duration;
    final newPosition = current + const Duration(seconds: 10);
    _controller!.seekTo(newPosition > duration ? duration : newPosition);
    _showSeekFeedback('+10s');
  }

  void _seekBackward() {
    if (_controller == null || !_isInitialized) return;
    final current = _controller!.value.position;
    final newPosition = current - const Duration(seconds: 10);
    _controller!.seekTo(
      newPosition < Duration.zero ? Duration.zero : newPosition,
    );
    _showSeekFeedback('-10s');
  }

  void _showSeekFeedback(String direction) {
    setState(() {
      _showSeekIndicator = true;
      _seekDirection = direction;
    });
    _seekTimer?.cancel();
    _seekTimer = Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _showSeekIndicator = false;
        });
      }
    });
  }

  void _handleDoubleTap() {
    setState(() {
      _showHeartAnimation = true;
    });
    widget.onDoubleTap?.call();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() {
          _showHeartAnimation = false;
        });
      }
    });
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControls,
      onDoubleTap: _handleDoubleTap,
      child: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ─── Thumbnail while loading ───
            if (!_isInitialized && widget.thumbnailUrl != null)
              Image.network(
                widget.thumbnailUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: const Color(0xFF0A0A0A)),
              ),

            // ─── Video Player ───
            if (_isInitialized && _controller != null)
              Center(
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),

            // ─── Loading indicator ───
            if (!_isInitialized && !_hasError)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: CircularProgressIndicator(
                        color: AppColors.primary.withOpacity(0.7),
                        strokeWidth: 2.5,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text('mobile.auto.loading_video'.tr(),
                      style: GoogleFonts.outfit(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

            // ─── Error state ───
            if (_hasError)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.videocam_off_rounded,
                        color: Colors.white.withOpacity(0.25),
                        size: 32,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text('mobile.auto.video_unavailable'.tr(),
                      style: GoogleFonts.outfit(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

            // ─── Center Play/Pause Button (shown when paused or controls visible) ───
            if (_showControls && _isInitialized)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Seek backward
                    _buildControlCircle(
                      icon: Icons.replay_10_rounded,
                      size: 48,
                      iconSize: 28,
                      onTap: _seekBackward,
                    ),
                    // Play/Pause
                    _buildControlCircle(
                      icon: _controller?.value.isPlaying == true
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 64,
                      iconSize: 38,
                      onTap: _togglePlayPause,
                      isPrimary: true,
                    ),
                    // Seek forward
                    _buildControlCircle(
                      icon: Icons.forward_10_rounded,
                      size: 48,
                      iconSize: 28,
                      onTap: _seekForward,
                    ),
                  ],
                ).animate().fadeIn(duration: 200.ms),
              ),

            // ─── Seek indicator ───
            if (_showSeekIndicator)
              Center(
                child:
                    Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _seekDirection,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 150.ms)
                        .then()
                        .fadeOut(delay: 500.ms),
              ),

            // ─── Double-tap heart ───
            if (_showHeartAnimation)
              Center(
                child:
                    const Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 100,
                        )
                        .animate()
                        .scale(
                          begin: const Offset(0.5, 0.5),
                          end: const Offset(1.3, 1.3),
                          duration: 300.ms,
                        )
                        .then()
                        .fadeOut(duration: 400.ms),
              ),

            // ─── Mute button (top-right) ───
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: _toggleMute,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                  ),
                  child: Icon(
                    _isMuted
                        ? Icons.volume_off_rounded
                        : Icons.volume_up_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),

            // ─── Bottom Controls Bar (scrubber + time) ───
            if (_isInitialized && _controller != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildBottomBar(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlCircle({
    required IconData icon,
    required double size,
    required double iconSize,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.primary.withOpacity(0.8)
              : Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: isPrimary
                ? AppColors.primary
                : Colors.white.withOpacity(0.15),
            width: isPrimary ? 2 : 1,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 16,
                  ),
                ]
              : null,
        ),
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
    );
  }

  Widget _buildBottomBar() {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: _controller!,
      builder: (context, value, child) {
        final position = value.position;
        final duration = value.duration;
        final progress = duration.inMilliseconds > 0
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0;

        return AnimatedOpacity(
          opacity: _showControls || !value.isPlaying ? 1.0 : 0.6,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 4,
              top: 8,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Time display (when controls visible)
                if (_showControls)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(position),
                          style: GoogleFonts.outfit(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _formatDuration(duration),
                          style: GoogleFonts.outfit(
                            color: Colors.white38,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                // Scrubber / Progress bar
                SizedBox(
                  height: _showControls ? 18 : 4,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: _showControls ? 4 : 3,
                      thumbShape: _showControls
                          ? const RoundSliderThumbShape(enabledThumbRadius: 7)
                          : const RoundSliderThumbShape(enabledThumbRadius: 0),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 14,
                      ),
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: Colors.white.withOpacity(0.15),
                      thumbColor: AppColors.primary,
                      overlayColor: AppColors.primary.withOpacity(0.2),
                    ),
                    child: Slider(
                      value: progress.clamp(0.0, 1.0),
                      onChangeStart: (_) {
                        _isDragging = true;
                        _controlsTimer?.cancel();
                      },
                      onChanged: (v) {
                        final newPosition = Duration(
                          milliseconds: (v * duration.inMilliseconds).round(),
                        );
                        _controller!.seekTo(newPosition);
                      },
                      onChangeEnd: (_) {
                        _isDragging = false;
                        _startControlsTimer();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
