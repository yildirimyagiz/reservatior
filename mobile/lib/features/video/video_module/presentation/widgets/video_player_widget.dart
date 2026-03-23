import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entities/video_content_entity.dart';

// ── Video Player Widget ─────────────────────────────────────────
// Gerçek video_player paketi entegrasyonu. URL veya lokal path destekler.

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  final VideoContentEntity? video;
  final bool autoPlay;
  final bool showControls;
  final bool looping;
  final double aspectRatio;
  final VoidCallback? onCompleted;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
    this.video,
    this.autoPlay = false,
    this.showControls = true,
    this.looping = false,
    this.aspectRatio = 16 / 9,
    this.onCompleted,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _ctrl;
  bool _initialized = false;
  bool _showControls = true;
  bool _isFullscreen = false;
  double _volume = 1.0;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    final uri = Uri.tryParse(widget.videoUrl);
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      _ctrl = VideoPlayerController.networkUrl(uri);
    } else {
      _ctrl = VideoPlayerController.contentUri(Uri.parse(widget.videoUrl));
    }

    await _ctrl.initialize();
    _ctrl.addListener(_listener);
    _duration = _ctrl.value.duration;
    if (widget.autoPlay) _ctrl.play();
    if (widget.looping) _ctrl.setLooping(true);
    if (mounted) setState(() => _initialized = true);
  }

  void _listener() {
    if (!mounted) return;
    setState(() => _position = _ctrl.value.position);
    if (_ctrl.value.position >= _ctrl.value.duration && !_ctrl.value.isLooping) {
      widget.onCompleted?.call();
    }
  }

  @override
  void dispose() {
    _ctrl.removeListener(_listener);
    _ctrl.dispose();
    if (_isFullscreen) SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  String _fmtDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${d.inHours > 0 ? '${d.inHours}:' : ''}$m:$s';
  }

  void _toggleFullscreen() {
    setState(() => _isFullscreen = !_isFullscreen);
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Container(
          color: Colors.black,
          child: widget.thumbnailUrl != null
              ? Stack(children: [
                  Positioned.fill(
                    child: Image.network(widget.thumbnailUrl!, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white30)),
                  ),
                  const Center(child: CircularProgressIndicator(color: Colors.white)),
                ])
              : const Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
      );
    }

    final player = AspectRatio(
      aspectRatio: _isFullscreen ? (_ctrl.value.aspectRatio) : widget.aspectRatio,
      child: GestureDetector(
        onTap: () => setState(() => _showControls = !_showControls),
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_ctrl),
            // Controls overlay
            if (widget.showControls && _showControls) _buildControls(),
          ],
        ),
      ),
    );

    if (_isFullscreen) {
      return Scaffold(backgroundColor: Colors.black, body: Center(child: player));
    }
    return player;
  }

  Widget _buildControls() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black87],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(children: [
              Text(_fmtDuration(_position), style: const TextStyle(color: Colors.white, fontSize: 12)),
              Expanded(
                child: Slider(
                  value: _duration.inMilliseconds > 0
                      ? _position.inMilliseconds / _duration.inMilliseconds
                      : 0,
                  onChanged: (v) {
                    _ctrl.seekTo(Duration(milliseconds: (v * _duration.inMilliseconds).round()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white38,
                  thumbColor: Colors.white,
                ),
              ),
              Text(_fmtDuration(_duration), style: const TextStyle(color: Colors.white, fontSize: 12)),
            ]),
          ),
          // Buttons row
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(children: [
              // Rewind 10s
              IconButton(
                icon: const Icon(Icons.replay_10, color: Colors.white),
                onPressed: () => _ctrl.seekTo(_position - const Duration(seconds: 10)),
              ),
              // Play/Pause
              IconButton(
                icon: Icon(
                  _ctrl.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  color: Colors.white, size: 40,
                ),
                onPressed: () => setState(() => _ctrl.value.isPlaying ? _ctrl.pause() : _ctrl.play()),
              ),
              // Forward 10s
              IconButton(
                icon: const Icon(Icons.forward_10, color: Colors.white),
                onPressed: () => _ctrl.seekTo(_position + const Duration(seconds: 10)),
              ),
              const Spacer(),
              // Volume
              IconButton(
                icon: Icon(_volume == 0 ? Icons.volume_off : Icons.volume_up, color: Colors.white),
                onPressed: () => setState(() {
                  _volume = _volume == 0 ? 1.0 : 0.0;
                  _ctrl.setVolume(_volume);
                }),
              ),
              // Fullscreen
              IconButton(
                icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white),
                onPressed: _toggleFullscreen,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
