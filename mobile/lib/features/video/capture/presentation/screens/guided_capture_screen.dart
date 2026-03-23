// features/video_capture/presentation/screens/guided_capture_screen.dart
// GERÇEK kamera entegrasyonu ile rehberli çekim ekranı
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/services/camera_service.dart';
import '../../../../../core/services/video_merge_service.dart';
import '../../data/models/room_model.dart';

class GuidedCaptureScreen extends StatefulWidget {
  final List<RoomSection> rooms;
  const GuidedCaptureScreen({super.key, required this.rooms});

  
  State<GuidedCaptureScreen> createState() => _GuidedCaptureScreenState();
}

class _GuidedCaptureScreenState extends State<GuidedCaptureScreen>
    with WidgetsBindingObserver {

  final _cameraService = CameraService();
  final _mergeService = VideoMergeService();

  late final List<RoomSection> _rooms;
  int _currentIndex = 0;
  bool _isRecording = false;
  int _recordingSeconds = 0;
  Timer? _timer;
  int _tipIndex = 0;
  Timer? _tipTimer;

  // Gerçek kayıt verileri
  final Map<String, String> _recordedPaths = {};  // roomId → video path
  bool _isCameraReady = false;
  bool _isMerging = false;
  String? _cameraError;

  FlashMode _flashMode = FlashMode.auto;
  double _currentZoom = 1.0;

  RoomSection get _current => _rooms[_currentIndex];
  bool get _isLastRoom => _currentIndex == _rooms.length - 1;

  
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _rooms = widget.rooms.map((r) => r.copyWith()).toList();
    _initCamera();
    _startTipCycle();
  }

  
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) _cameraService.dispose();
    if (state == AppLifecycleState.resumed && !_isCameraReady) _initCamera();
  }

  Future<void> _initCamera() async {
    // İzinleri iste
    final camStatus = await Permission.camera.request();
    final micStatus = await Permission.microphone.request();

    if (camStatus.isDenied || micStatus.isDenied) {
      setState(() => _cameraError = 'Kamera ve mikrofon izni gerekli');
      return;
    }

    try {
      await _cameraService.initialize(resolution: ResolutionPreset.high);
      if (mounted) setState(() => _isCameraReady = true);
    } catch (e) {
      if (mounted) setState(() => _cameraError = 'Kamera başlatılamadı: $e');
    }
  }

  void _startTipCycle() {
    _tipTimer?.cancel();
    _tipIndex = 0;
    _tipTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || _current.tips.isEmpty) return;
      setState(() => _tipIndex = (_tipIndex + 1) % _current.tips.length);
    });
  }

  // ── GERÇEK Kayıt başlat ──────────────────────────────────────────────────
  Future<void> _startRecording() async {
    if (!_isCameraReady || _isRecording) return;
    try {
      await _cameraService.startRecording();
      setState(() {
        _isRecording = true;
        _recordingSeconds = 0;
        _rooms[_currentIndex] = _rooms[_currentIndex].copyWith(
          status: RoomCaptureStatus.recording,
        );
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() => _recordingSeconds++);
      });
    } catch (e) {
      _showError('Kayıt başlatılamadı: $e');
    }
  }

  // ── GERÇEK Kayıt durdur ──────────────────────────────────────────────────
  Future<void> _stopRecording() async {
    if (!_isRecording) return;
    _timer?.cancel();
    try {
      final recorded = await _cameraService.stopRecording();
      if (recorded == null) return;

      setState(() {
        _isRecording = false;
        _recordedPaths[_current.id] = recorded.path;
        _rooms[_currentIndex] = _rooms[_currentIndex].copyWith(
          status: RoomCaptureStatus.captured,
          capturedVideoPath: recorded.path,
          videoTimestamp: _calculateTimestamp(),
        );
      });

      if (!_isLastRoom) {
        await Future.delayed(1500.ms);
        if (mounted) _nextRoom();
      } else {
        await Future.delayed(800.ms);
        if (mounted) _showCompletionSheet();
      }
    } catch (e) {
      setState(() => _isRecording = false);
      _showError('Kayıt durdurulamadı: $e');
    }
  }

  void _toggleRecord() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  double _calculateTimestamp() {
    double ts = 0;
    for (int i = 0; i < _currentIndex; i++) {
      if (_rooms[i].status == RoomCaptureStatus.captured) {
        ts += _rooms[i].recommendedDuration.inSeconds.toDouble();
      }
    }
    return ts;
  }

  void _nextRoom() {
    if (_currentIndex < _rooms.length - 1) {
      setState(() {
        _currentIndex++;
        _recordingSeconds = 0;
        _isRecording = false;
      });
      _startTipCycle();
    }
  }

  void _prevRoom() {
    if (_currentIndex > 0 && !_isRecording) {
      setState(() {
        _currentIndex--;
        _recordingSeconds = 0;
      });
      _startTipCycle();
    }
  }

  void _skipRoom() {
    setState(() {
      _rooms[_currentIndex] = _rooms[_currentIndex].copyWith(
        status: RoomCaptureStatus.skipped,
      );
    });
    if (!_isLastRoom) _nextRoom();
    else _showCompletionSheet();
  }

  // ── Flaş değiştir ────────────────────────────────────────────────────────
  Future<void> _toggleFlash() async {
    final modes = [FlashMode.auto, FlashMode.always, FlashMode.off];
    final next = modes[(modes.indexOf(_flashMode) + 1) % modes.length];
    await _cameraService.setFlashMode(next);
    setState(() => _flashMode = next);
  }

  // ── Zoom (pinch) ──────────────────────────────────────────────────────────
  void _handleScaleUpdate(ScaleUpdateDetails d) {
    final newZoom = (_currentZoom * d.scale).clamp(1.0, 8.0);
    _cameraService.setZoom(newZoom);
    setState(() => _currentZoom = newZoom);
  }

  // ── Tıklayarak odaklama ───────────────────────────────────────────────────
  void _handleTapFocus(TapDownDetails d) {
    if (_cameraService.controller == null) return;
    final size = MediaQuery.of(context).size;
    final normalized = Offset(
      d.localPosition.dx / size.width,
      d.localPosition.dy / size.height,
    );
    _cameraService.focusAt(normalized);
    _showFocusRing(d.localPosition);
  }

  // Geçici odak halkası göster
  OverlayEntry? _focusOverlay;
  void _showFocusRing(Offset pos) {
    _focusOverlay?.remove();
    _focusOverlay = OverlayEntry(
      builder: (_) => Positioned(
        left: pos.dx - 30,
        top: pos.dy - 30,
        child: Container(
          width: 60, height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.yellowAccent, width: 1.5),
            shape: BoxShape.circle,
          ),
        ).animate().fadeOut(duration: 1200.ms, delay: 600.ms),
      ),
    );
    Overlay.of(context).insert(_focusOverlay!);
    Future.delayed(const Duration(milliseconds: 1800), () => _focusOverlay?.remove());
  }

  // ── Tamamlama Sheet ───────────────────────────────────────────────────────
  void _showCompletionSheet() {
    final capturedRooms = _rooms.where(
      (r) => r.status == RoomCaptureStatus.captured,
    ).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CompletionSheet(
        rooms: _rooms,
        capturedCount: capturedRooms.length,
        onBuildVideo: () => _buildFinalVideo(capturedRooms),
        onRetake: (idx) {
          Navigator.pop(context);
          setState(() {
            _currentIndex = idx;
            _rooms[idx] = _rooms[idx].copyWith(
              status: RoomCaptureStatus.pending,
              capturedVideoPath: null,
            );
          });
          _startTipCycle();
        },
      ),
    );
  }

  // ── Final video oluştur (FFmpeg merge) ───────────────────────────────────
  Future<void> _buildFinalVideo(List<RoomSection> capturedRooms) async {
    Navigator.pop(context); // sheet kapat
    setState(() => _isMerging = true);

    try {
      final paths = capturedRooms
          .where((r) => r.capturedVideoPath != null)
          .map((r) => r.capturedVideoPath!)
          .toList();

      final finalPath = await _mergeService.buildFinalVideo(paths);

      if (mounted) {
        setState(() => _isMerging = false);
        Navigator.pop(context, finalPath); // capture ekranından çık, yolu döndür
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isMerging = false);
        _showError('Video oluşturulamadı: $e');
      }
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red.shade800),
    );
  }

  String _formatTime(int secs) {
    final m = (secs ~/ 60).toString().padLeft(2, '0');
    final s = (secs % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  IconData get _flashIcon => switch (_flashMode) {
    FlashMode.always => Icons.flash_on_rounded,
    FlashMode.off    => Icons.flash_off_rounded,
    _                => Icons.flash_auto_rounded,
  };

  
  void dispose() {
    _timer?.cancel();
    _tipTimer?.cancel();
    _cameraService.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  
  Widget build(BuildContext context) {
    // Merge yükleme ekranı
    if (_isMerging) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Color(0xFFC9A84C)),
              SizedBox(height: 20),
              Text('Videolar birleştiriliyor...',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(height: 8),
              Text('Bu birkaç saniye sürebilir',
                  style: TextStyle(color: Colors.white54, fontSize: 13)),
            ],
          ),
        ),
      );
    }

    // Hata ekranı
    if (_cameraError != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.camera_alt_rounded,
                    color: Colors.white38, size: 64),
                const SizedBox(height: 16),
                Text(_cameraError!,
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () { setState(() => _cameraError = null); _initCamera(); },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC9A84C)),
                  child: const Text('Tekrar Dene', style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => openAppSettings(),
                  child: const Text('Ayarları Aç', style: TextStyle(color: Colors.white54)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onScaleUpdate: _handleScaleUpdate,
        onTapDown: _handleTapFocus,
        child: Stack(
          children: [
            // ── GERÇEK Kamera Önizleme ─────────────────────────────────
            if (_isCameraReady && _cameraService.controller != null)
              Positioned.fill(
                child: CameraPreview(_cameraService.controller!),
              )
            else
              Container(
                color: Colors.black,
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFFC9A84C)),
                ),
              ),

            // ── Üçte bir kural ızgarası ────────────────────────────────
            if (_isCameraReady && !_isRecording)
              Positioned.fill(child: _GridOverlay()),

            // ── Kırmızı kayıt sınırı ──────────────────────────────────
            if (_isRecording)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade400, width: 3),
                    ),
                  ).animate(onPlay: (c) => c.repeat(reverse: true))
                      .custom(duration: 900.ms, builder: (_, v, child) =>
                          Opacity(opacity: v > 0.5 ? 1.0 : 0.4, child: child)),
                ),
              ),

            // ── Üst kontroller ─────────────────────────────────────────
            _TopBar(
              rooms: _rooms,
              currentIndex: _currentIndex,
              isRecording: _isRecording,
              recordingSeconds: _recordingSeconds,
              flashIcon: _flashIcon,
              zoom: _currentZoom,
              formatTime: _formatTime,
              onBack: _isRecording ? null : () => Navigator.pop(context),
              onFlip: _isRecording ? null : _cameraService.flipCamera,
              onFlash: _isRecording ? null : _toggleFlash,
              onJump: (i) {
                if (!_isRecording) {
                  setState(() { _currentIndex = i; });
                  _startTipCycle();
                }
              },
            ),

            // ── İpucu kartı ───────────────────────────────────────────
            if (!_isRecording && _current.tips.isNotEmpty)
              Positioned(
                left: 16, right: 16, top: 160,
                child: _TipCard(room: _current, tipIndex: _tipIndex)
                    .animate().fadeIn(duration: 400.ms),
              ),

            // ── Çekim tamamlandı banner ───────────────────────────────
            if (_current.status == RoomCaptureStatus.captured && !_isRecording)
              Positioned(
                left: 16, right: 16, top: 160,
                child: _CapturedBanner(
                  roomName: _current.displayName,
                  duration: _recordingSeconds,
                  formatTime: _formatTime,
                ).animate().scale(
                  begin: const Offset(0.8, 0.8), duration: 400.ms,
                  curve: Curves.elasticOut,
                ),
              ),

            // ── Alt kontroller ────────────────────────────────────────
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: _BottomControls(
                room: _current,
                isRecording: _isRecording,
                isLastRoom: _isLastRoom,
                currentIndex: _currentIndex,
                totalRooms: _rooms.length,
                isCameraReady: _isCameraReady,
                onRecord: _toggleRecord,
                onNext: _isRecording ? null : _nextRoom,
                onPrev: (_isRecording || _currentIndex == 0) ? null : _prevRoom,
                onSkip: _isRecording ? null : _skipRoom,
                onFinish: (_isLastRoom && !_isRecording) ? _showCompletionSheet : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Grid overlay ─────────────────────────────────────────────────────────────
class _GridOverlay extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _GridPainter(),
    );
  }
}

class _GridPainter extends CustomPainter {
  
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..strokeWidth = 0.8;
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(Offset(size.width * i / 3, 0), Offset(size.width * i / 3, size.height), paint);
      canvas.drawLine(Offset(0, size.height * i / 3), Offset(size.width, size.height * i / 3), paint);
    }
  }
   bool shouldRepaint(_) => false;
}

// ── Üst bar ───────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final List<RoomSection> rooms;
  final int currentIndex;
  final bool isRecording;
  final int recordingSeconds;
  final IconData flashIcon;
  final double zoom;
  final String Function(int) formatTime;
  final VoidCallback? onBack, onFlip, onFlash;
  final ValueChanged<int> onJump;

  const _TopBar({
    required this.rooms, required this.currentIndex,
    required this.isRecording, required this.recordingSeconds,
    required this.flashIcon, required this.zoom,
    required this.formatTime, required this.onJump,
    this.onBack, this.onFlip, this.onFlash,
  });

  
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _IconBtn(icon: Icons.close_rounded, onTap: onBack),
                const Spacer(),
                if (isRecording)
                  _RecBadge(seconds: recordingSeconds, formatTime: formatTime)
                else ...[
                  if (zoom > 1.01)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('${zoom.toStringAsFixed(1)}x',
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  Text('${currentIndex + 1} / ${rooms.length}',
                    style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600)),
                ],
                const Spacer(),
                _IconBtn(icon: Icons.flip_camera_ios_rounded, onTap: onFlip),
                const SizedBox(width: 8),
                _IconBtn(icon: flashIcon, onTap: onFlash),
              ],
            ),
            const SizedBox(height: 10),
            // Oda şeridi
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: rooms.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (_, i) {
                  final r = rooms[i];
                  final isCurrent = i == currentIndex;
                  final isDone = r.status == RoomCaptureStatus.captured;
                  return GestureDetector(
                    onTap: () => onJump(i),
                    child: AnimatedContainer(
                      duration: 200.ms,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isCurrent ? r.color.withOpacity(0.8) : isDone ? Colors.green.withOpacity(0.25) : Colors.black38,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isCurrent ? r.color : isDone ? Colors.green.withOpacity(0.5) : Colors.white.withOpacity(0.15),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isDone)
                            const Icon(Icons.check_rounded, size: 12, color: Colors.green)
                          else
                            Text(r.icon, style: const TextStyle(fontSize: 13)),
                          const SizedBox(width: 4),
                          Text(r.displayName, style: TextStyle(
                            color: isCurrent ? Colors.white : isDone ? Colors.green : Colors.white.withOpacity(0.5),
                            fontSize: 11, fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w400,
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _IconBtn({required this.icon, this.onTap});
  
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedOpacity(
      duration: 200.ms, opacity: onTap == null ? 0.3 : 1.0,
      child: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          color: Colors.black45, shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    ),
  );
}

class _RecBadge extends StatelessWidget {
  final int seconds;
  final String Function(int) formatTime;
  const _RecBadge({required this.seconds, required this.formatTime});
  
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: Colors.red.withOpacity(0.9), borderRadius: BorderRadius.circular(20)),
    child: Row(
      children: [
        Container(width: 7, height: 7, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))
            .animate(onPlay: (c) => c.repeat()).fadeOut(duration: 600.ms),
        const SizedBox(width: 6),
        Text('REC  ${formatTime(seconds)}', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1)),
      ],
    ),
  );
}

// ── İpucu kartı ───────────────────────────────────────────────────────────────
class _TipCard extends StatelessWidget {
  final RoomSection room;
  final int tipIndex;
  const _TipCard({required this.room, required this.tipIndex});
  
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.75),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: room.color.withOpacity(0.4)),
      boxShadow: [BoxShadow(color: room.color.withOpacity(0.18), blurRadius: 18, spreadRadius: 1)],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          Container(
            width: 30, height: 30,
            decoration: BoxDecoration(color: room.color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text(room.icon, style: const TextStyle(fontSize: 15))),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(room.displayName, style: TextStyle(color: room.color, fontSize: 13, fontWeight: FontWeight.w700))),
          Text('${tipIndex + 1}/${room.tips.length}', style: TextStyle(color: room.color, fontSize: 10, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 10),
        AnimatedSwitcher(
          duration: 300.ms,
          child: Row(
            key: ValueKey(tipIndex),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline_rounded, color: Color(0xFFC9A84C), size: 14),
              const SizedBox(width: 8),
              Expanded(child: Text(room.tips[tipIndex], style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.5))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(room.tips.length, (i) => AnimatedContainer(
            duration: 200.ms,
            width: i == tipIndex ? 14 : 5, height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: i == tipIndex ? room.color : Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(3),
            ),
          )),
        ),
      ],
    ),
  );
}

// ── Çekim tamamlandı banner ───────────────────────────────────────────────────
class _CapturedBanner extends StatelessWidget {
  final String roomName; final int duration; final String Function(int) formatTime;
  const _CapturedBanner({required this.roomName, required this.duration, required this.formatTime});
  
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.green.withOpacity(0.5)),
    ),
    child: Row(children: [
      Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.green.withOpacity(0.15), shape: BoxShape.circle, border: Border.all(color: Colors.green)), child: const Icon(Icons.check_rounded, color: Colors.green, size: 22)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$roomName çekildi ✓', style: const TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.w700)),
        Text('Süre: ${formatTime(duration)} · Sonraki odaya geçiliyor...', style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ])),
    ]),
  );
}

// ── Alt kontroller ────────────────────────────────────────────────────────────
class _BottomControls extends StatelessWidget {
  final RoomSection room;
  final bool isRecording, isLastRoom, isCameraReady;
  final int currentIndex, totalRooms;
  final VoidCallback onRecord;
  final VoidCallback? onNext, onPrev, onSkip, onFinish;

  const _BottomControls({
    required this.room, required this.isRecording,
    required this.isLastRoom, required this.isCameraReady,
    required this.currentIndex, required this.totalRooms,
    required this.onRecord,
    this.onNext, this.onPrev, this.onSkip, this.onFinish,
  });

  
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.transparent, Colors.black.withOpacity(0.95)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      padding: EdgeInsets.only(left: 24, right: 24, bottom: MediaQuery.of(context).padding.bottom + 24, top: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isRecording) ...[
            Text(room.displayName, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('~${room.recommendedDuration.inSeconds}s önerilir', style: const TextStyle(color: Colors.white54, fontSize: 13)),
            const SizedBox(height: 16),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SmallBtn(icon: Icons.skip_previous_rounded, onTap: isRecording ? null : onPrev),
              // Ana kayıt butonu
              GestureDetector(
                onTap: isCameraReady ? onRecord : null,
                child: AnimatedContainer(
                  duration: 200.ms,
                  width: 80, height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: !isCameraReady ? Colors.grey : isRecording ? Colors.red : Colors.white,
                    boxShadow: [BoxShadow(color: (isRecording ? Colors.red : Colors.white).withOpacity(0.4), blurRadius: isRecording ? 28 : 14, spreadRadius: isRecording ? 4 : 0)],
                  ),
                  child: isRecording
                      ? const Icon(Icons.stop_rounded, color: Colors.white, size: 36)
                      : Container(margin: const EdgeInsets.all(6), decoration: BoxDecoration(shape: BoxShape.circle, color: room.color)),
                ).animate(onPlay: isRecording ? (c) => c.repeat(reverse: true) : (c) => c.stop())
                 .scale(begin: const Offset(1, 1), end: const Offset(1.06, 1.06), duration: 800.ms),
              ),
              isLastRoom && !isRecording
                  ? _SmallBtn(icon: Icons.check_rounded, onTap: onFinish, color: Colors.green.withOpacity(0.3), iconColor: Colors.green)
                  : _SmallBtn(icon: Icons.skip_next_rounded, onTap: isRecording ? null : onNext),
            ],
          ),
          if (!isRecording) ...[
            const SizedBox(height: 16),
            GestureDetector(
              onTap: onSkip,
              child: Text('Bu bölümü atla', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13, decoration: TextDecoration.underline, decorationColor: Colors.white.withOpacity(0.3))),
            ),
          ],
        ],
      ),
    );
  }
}

class _SmallBtn extends StatelessWidget {
  final IconData icon; final VoidCallback? onTap; final Color? color, iconColor;
  const _SmallBtn({required this.icon, this.onTap, this.color, this.iconColor});
  
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedOpacity(
      duration: 200.ms, opacity: onTap == null ? 0.3 : 1.0,
      child: Container(
        width: 52, height: 52,
        decoration: BoxDecoration(color: color ?? Colors.white.withOpacity(0.15), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.2))),
        child: Icon(icon, color: iconColor ?? Colors.white, size: 24),
      ),
    ),
  );
}

// ── Tamamlama sheet ──────────────────────────────────────────────────────────
class _CompletionSheet extends StatelessWidget {
  final List<RoomSection> rooms;
  final int capturedCount;
  final VoidCallback onBuildVideo;
  final ValueChanged<int> onRetake;

  const _CompletionSheet({required this.rooms, required this.capturedCount, required this.onBuildVideo, required this.onRetake});

  
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75, maxChildSize: 0.92, minChildSize: 0.5, expand: false,
      builder: (_, ctrl) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(width: 36, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), shape: BoxShape.circle, border: Border.all(color: Colors.green, width: 2)),
              child: const Icon(Icons.videocam_rounded, color: Colors.green, size: 28),
            ).animate().scale(begin: const Offset(0, 0), duration: 500.ms, curve: Curves.elasticOut),
            const SizedBox(height: 12),
            Text('Çekim Tamamlandı!', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
            Text('$capturedCount / ${rooms.length} bölüm kaydedildi', style: const TextStyle(color: Colors.white54, fontSize: 14)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                controller: ctrl,
                itemCount: rooms.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.white12, height: 1),
                itemBuilder: (_, i) {
                  final r = rooms[i];
                  final done = r.status == RoomCaptureStatus.captured;
                  return ListTile(
                    dense: true,
                    leading: Container(width: 36, height: 36, decoration: BoxDecoration(color: done ? r.color.withOpacity(0.12) : Colors.white10, borderRadius: BorderRadius.circular(8)), child: Center(child: Text(r.icon, style: const TextStyle(fontSize: 16)))),
                    title: Text(r.displayName, style: TextStyle(color: done ? Colors.white : Colors.white38, fontSize: 13, fontWeight: FontWeight.w600)),
                    subtitle: Text(done ? '✓ Kaydedildi' : '— Atlandı', style: TextStyle(color: done ? Colors.green : Colors.white24, fontSize: 11)),
                    trailing: done ? TextButton(
                      onPressed: () => onRetake(i),
                      style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), minimumSize: Size.zero),
                      child: const Text('Yeniden Çek', style: TextStyle(color: Color(0xFFC9A84C), fontSize: 11)),
                    ) : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: onBuildVideo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC9A84C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('✨  Video Oluştur & Paylaş', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
