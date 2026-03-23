import 'package:flutter/material.dart';
import '../bloc/video_bloc.dart';
import '../../domain/entities/video_content_entity.dart';

class VideoProvider extends ChangeNotifier {
  final VideoBloc videoBloc;
  List<VideoContentEntity> _videos = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'all';
  String _selectedStatus = 'all';

  VideoProvider({required this.videoBloc}) {
    _listenToVideoBloc();
    videoBloc.add(LoadVideos());
  }

  List<VideoContentEntity> get videos => _videos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  String get selectedStatus => _selectedStatus;

  void _listenToVideoBloc() {
    videoBloc.stream.listen((state) {
      if (state is VideoLoading) {
        _isLoading = true;
        _errorMessage = null;
        notifyListeners();
      } else if (state is VideosLoaded) {
        _videos = state.videos;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      } else if (state is VideosSearchLoaded) {
        _videos = state.videos;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      } else if (state is VideoError) {
        _isLoading = false;
        _errorMessage = state.Message;
        notifyListeners();
      } else if (state is VideoDeleted) {
        _videos.removeWhere((video) => video.id == state.videoId);
        notifyListeners();
      } else if (state is VideoCreated) {
        _videos.insert(0, state.video);
        notifyListeners();
      } else if (state is VideoUpdated) {
        final index = _videos.indexWhere((video) => video.id == state.video.id);
        if (index != -1) {
          _videos[index] = state.video;
          notifyListeners();
        }
      } else if (state is VideoLiked) {
        final index = _videos.indexWhere((video) => video.id == state.videoId);
        if (index != -1) {
          _videos[index] = _videos[index].copyWith(
            isLiked: true,
            likeCount: state.likeCount,
          );
          notifyListeners();
        }
      } else if (state is VideoUnliked) {
        final index = _videos.indexWhere((video) => video.id == state.videoId);
        if (index != -1) {
          _videos[index] = _videos[index].copyWith(
            isLiked: false,
            likeCount: state.likeCount,
          );
          notifyListeners();
        }
      }
    });
  }

  void loadVideos() {
    videoBloc.add(LoadVideos());
  }

  void searchVideos(String query) {
    if (query.isEmpty) {
      videoBloc.add(LoadVideos());
    } else {
      videoBloc.add(SearchVideos(query));
    }
  }

  void filterVideos(String category, String status) {
    _selectedCategory = category;
    _selectedStatus = status;
    notifyListeners();

    videoBloc.add(FilterVideos(
      category: category == 'all' ? null : category,
      status: status == 'all' ? null : status,
    ));
  }

  void uploadVideo(String filePath, String title, String description) {
    videoBloc.add(UploadVideo(filePath, title, description));
  }

  void likeVideo(String videoId) {
    videoBloc.add(LikeVideo(videoId));
  }

  void unlikeVideo(String videoId) {
    videoBloc.add(UnlikeVideo(videoId));
  }

  void shareVideo(String videoId, List<String> recipients) {
    videoBloc.add(ShareVideo(videoId, recipients));
  }

  void downloadVideo(String videoId, String quality) {
    videoBloc.add(DownloadVideo(videoId, quality));
  }

  void deleteVideo(String videoId) {
    videoBloc.add(DeleteVideo(videoId));
  }

  void playVideo(VideoContentEntity video) {
    videoBloc.add(PlayVideo(video));
  }

  void pauseVideo(VideoContentEntity video) {
    videoBloc.add(PauseVideo(video));
  }

  void stopVideo() {
    videoBloc.add(StopVideo());
  }

  void refresh() {
    videoBloc.add(RefreshVideos());
  }

  List<VideoContentEntity> get filteredVideos {
    return _videos.where((video) {
      final categoryMatch = _selectedCategory == 'all' || video.category == _selectedCategory;
      final statusMatch = _selectedStatus == 'all' || video.status == _selectedStatus;
      return categoryMatch && statusMatch;
    }).toList();
  }

  List<VideoContentEntity> getVideosByCategory(String category) {
    return _videos.where((video) => video.category == category).toList();
  }

  VideoContentEntity? getVideoById(String id) {
    try {
      return _videos.firstWhere((video) => video.id == id);
    } catch (e) {
      return null;
    }
  }

  int get totalVideos => _videos.length;
  int get publishedVideos => _videos.where((video) => video.status == 'published').length;
  int get draftVideos => _videos.where((video) => video.status == 'draft').length;
  int get processingVideos => _videos.where((video) => video.status == 'processing').length;

  Map<String, int> get videosByCategory {
    final Map<String, int> categoryCount = {};
    for (final video in _videos) {
      categoryCount[video.category] = (categoryCount[video.category] ?? 0) + 1;
    }
    return categoryCount;
  }

  double getTotalDuration() {
    return _videos.fold(0.0, (sum, video) => sum + video.duration.inSeconds);
  }

  int getTotalViews() {
    return _videos.fold(0, (sum, video) => sum + video.viewCount);
  }

  int getTotalLikes() {
    return _videos.fold(0, (sum, video) => sum + video.likeCount);
  }
}

// Video Player Provider
class VideoPlayerProvider extends ChangeNotifier {
  VideoContentEntity? _currentVideo;
  bool _isPlaying = false;
  bool _isMuted = false;
  bool _isFullscreen = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _playbackSpeed = 1.0;
  bool _isBuffering = false;

  VideoContentEntity? get currentVideo => _currentVideo;
  bool get isPlaying => _isPlaying;
  bool get isMuted => _isMuted;
  bool get isFullscreen => _isFullscreen;
  Duration get position => _position;
  Duration get duration => _duration;
  double get playbackSpeed => _playbackSpeed;
  bool get isBuffering => _isBuffering;

  void setVideo(VideoContentEntity video) {
    _currentVideo = video;
    _position = Duration.zero;
    _duration = video.duration;
    notifyListeners();
  }

  void play() {
    _isPlaying = true;
    notifyListeners();
  }

  void pause() {
    _isPlaying = false;
    notifyListeners();
  }

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void mute() {
    _isMuted = true;
    notifyListeners();
  }

  void unmute() {
    _isMuted = false;
    notifyListeners();
  }

  void toggleMute() {
    _isMuted = !_isMuted;
    notifyListeners();
  }

  void setFullscreen(bool fullscreen) {
    _isFullscreen = fullscreen;
    notifyListeners();
  }

  void toggleFullscreen() {
    _isFullscreen = !_isFullscreen;
    notifyListeners();
  }

  void setPosition(Duration position) {
    _position = position;
    notifyListeners();
  }

  void setDuration(Duration duration) {
    _duration = duration;
    notifyListeners();
  }

  void setPlaybackSpeed(double speed) {
    _playbackSpeed = speed;
    notifyListeners();
  }

  void setBuffering(bool buffering) {
    _isBuffering = buffering;
    notifyListeners();
  }

  void seekTo(Duration position) {
    _position = position;
    notifyListeners();
  }

  void seekForward() {
    final newPosition = _position + const Duration(seconds: 10);
    if (newPosition < _duration) {
      _position = newPosition;
    } else {
      _position = _duration;
    }
    notifyListeners();
  }

  void seekBackward() {
    final newPosition = _position - const Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      _position = newPosition;
    } else {
      _position = Duration.zero;
    }
    notifyListeners();
  }

  double get progress {
    if (_duration.inSeconds == 0) return 0.0;
    return _position.inSeconds / _duration.inSeconds;
  }

  String get formattedPosition {
    return _formatDuration(_position);
  }

  String get formattedDuration {
    return _formatDuration(_duration);
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }

  void reset() {
    _currentVideo = null;
    _isPlaying = false;
    _isMuted = false;
    _isFullscreen = false;
    _position = Duration.zero;
    _duration = Duration.zero;
    _playbackSpeed = 1.0;
    _isBuffering = false;
    notifyListeners();
  }
}

// Video Upload Provider
class VideoUploadProvider extends ChangeNotifier {
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String? _uploadError;
  String? _uploadedVideoId;

  bool get isUploading => _isUploading;
  double get uploadProgress => _uploadProgress;
  String? get uploadError => _uploadError;
  String? get uploadedVideoId => _uploadedVideoId;

  void startUpload() {
    _isUploading = true;
    _uploadProgress = 0.0;
    _uploadError = null;
    _uploadedVideoId = null;
    notifyListeners();
  }

  void updateProgress(double progress) {
    _uploadProgress = progress;
    notifyListeners();
  }

  void completeUpload(String videoId) {
    _isUploading = false;
    _uploadProgress = 1.0;
    _uploadedVideoId = videoId;
    notifyListeners();
  }

  void setError(String error) {
    _isUploading = false;
    _uploadError = error;
    notifyListeners();
  }

  void reset() {
    _isUploading = false;
    _uploadProgress = 0.0;
    _uploadError = null;
    _uploadedVideoId = null;
    notifyListeners();
  }
}
