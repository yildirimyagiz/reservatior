import 'dart:ui' as ui; 
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_animate/flutter_animate.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Map<String, dynamic> property;
  final Function(String) onRoomChange;
  final double bottomPadding;

  const VideoPlayerWidget({
    super.key,
    required this.property,
    required this.onRoomChange,
    this.bottomPadding = 0,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  String _selectedRoom = 'mobile.leftovers.living_room'.tr();
  bool _isFullScreen = false;

  final List<String> _rooms = [
    'mobile.leftovers.living_room'.tr(),
    'Kitchen',
    'mobile.leftovers.master_bedroom'.tr(),
    'Bathroom',
    'Balcony',
  ];

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    final videoUrl =
        widget.property['videoUrl'] as String? ??
        'https://assets.mixkit.co/videos/preview/mixkit-modern-apartment-interior-design-27415-large.mp4';

    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.play();
          _controller.setLooping(true);
        });
      });

    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void _changeRoom(String room) {
    setState(() {
      _selectedRoom = room;
    });
    // For demo, we just seek to different positions based on room
    final Map<String, int> roomOffsets = {
      'mobile.leftovers.living_room'.tr(): 0,
      'Kitchen': 10,
      'mobile.leftovers.master_bedroom'.tr(): 20,
      'Bathroom': 30,
      'Balcony': 40,
    };
    _controller.seekTo(Duration(seconds: roomOffsets[room] ?? 0));
    widget.onRoomChange(room);
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height, // Always full screen for Reels
      color: Colors.black,
      child: Stack(
        children: [
          // Video Player or Placeholder
          Positioned.fill(
            child: _isInitialized
                ? Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(
                    color: Colors.black,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white24),
                    ),
                  ),
          ),

          // Gradient overlay for controls
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Room navigation tabs
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                itemCount: _rooms.length,
                itemBuilder: (context, index) {
                  final room = _rooms[index];
                  final isSelected = room == _selectedRoom;
                  return GestureDetector(
                    onTap: () => _changeRoom(room),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        room,
                        style: GoogleFonts.outfit(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Center play/pause button overlay
          if (!_controller.value.isPlaying || !_isInitialized)
            Center(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),

          // Invisible touch layer to allow tapping anywhere to play/pause if no overlapping controls
          GestureDetector(
            onTap: _togglePlayPause,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }

  // Unused methods removed
}
