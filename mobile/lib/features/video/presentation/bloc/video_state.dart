part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoError extends VideoState {
  final String Message;

  const VideoError(this.Message);

  
  List<Object?> get props => [Message];
}

class VideosLoaded extends VideoState {
  final List<VideoContentEntity> videos;

  const VideosLoaded(this.videos);

  
  List<Object?> get props => [videos];
}

class VideoDetailLoaded extends VideoState {
  final VideoContentEntity video;

  const VideoDetailLoaded(this.video);

  
  List<Object?> get props => [video];
}

class VideoCreated extends VideoState {
  final VideoContentEntity video;

  const VideoCreated(this.video);

  
  List<Object?> get props => [video];
}

class VideoUpdated extends VideoState {
  final VideoContentEntity video;

  const VideoUpdated(this.video);

  
  List<Object?> get props => [video];
}

class VideoDeleted extends VideoState {
  final String videoId;

  const VideoDeleted(this.videoId);

  
  List<Object?> get props => [videoId];
}

class VideoUploading extends VideoState {}

class VideoUploaded extends VideoState {
  final VideoContentEntity video;

  const VideoUploaded(this.video);

  
  List<Object?> get props => [video];
}

class VideosSearchLoaded extends VideoState {
  final List<VideoContentEntity> videos;
  final String query;

  const VideosSearchLoaded(this.videos, this.query);

  
  List<Object?> get props => [videos, query];
}

class VideoPlaying extends VideoState {
  final VideoContentEntity video;

  const VideoPlaying(this.video);

  
  List<Object?> get props => [video];
}

class VideoPaused extends VideoState {
  final VideoContentEntity video;

  const VideoPaused(this.video);

  
  List<Object?> get props => [video];
}

class VideoStopped extends VideoState {}

class VideoLiked extends VideoState {
  final String videoId;
  final int likeCount;

  const VideoLiked(this.videoId, this.likeCount);

  
  List<Object?> get props => [videoId, likeCount];
}

class VideoUnliked extends VideoState {
  final String videoId;
  final int likeCount;

  const VideoUnliked(this.videoId, this.likeCount);

  
  List<Object?> get props => [videoId, likeCount];
}

class VideoShared extends VideoState {
  final String videoId;

  const VideoShared(this.videoId);

  
  List<Object?> get props => [videoId];
}

class VideoAddedToPlaylist extends VideoState {
  final String videoId;
  final String playlistId;

  const VideoAddedToPlaylist(this.videoId, this.playlistId);

  
  List<Object?> get props => [videoId, playlistId];
}

class VideoRemovedFromPlaylist extends VideoState {
  final String videoId;
  final String playlistId;

  const VideoRemovedFromPlaylist(this.videoId, this.playlistId);

  
  List<Object?> get props => [videoId, playlistId];
}

class VideoDownloaded extends VideoState {
  final String videoId;
  final String downloadPath;

  const VideoDownloaded(this.videoId, this.downloadPath);

  
  List<Object?> get props => [videoId, downloadPath];
}

class VideoCommentAdded extends VideoState {
  final String videoId;
  final String commentId;

  const VideoCommentAdded(this.videoId, this.commentId);

  
  List<Object?> get props => [videoId, commentId];
}

class VideoCommentDeleted extends VideoState {
  final String videoId;
  final String commentId;

  const VideoCommentDeleted(this.videoId, this.commentId);

  
  List<Object?> get props => [videoId, commentId];
}

class VideoReported extends VideoState {
  final String videoId;

  const VideoReported(this.videoId);

  
  List<Object?> get props => [videoId];
}

class VideoThumbnailGenerated extends VideoState {
  final String videoId;
  final String thumbnailUrl;

  const VideoThumbnailGenerated(this.videoId, this.thumbnailUrl);

  
  List<Object?> get props => [videoId, thumbnailUrl];
}

class VideoTranscribed extends VideoState {
  final String videoId;
  final String transcription;

  const VideoTranscribed(this.videoId, this.transcription);

  
  List<Object?> get props => [videoId, transcription];
}

class VideoSubtitlesAdded extends VideoState {
  final String videoId;
  final String Language;

  const VideoSubtitlesAdded(this.videoId, this.Language);

  
  List<Object?> get props => [videoId, Language];
}

class VideoProcessed extends VideoState {
  final String videoId;
  final List<String> processedVersions;

  const VideoProcessed(this.videoId, this.processedVersions);

  
  List<Object?> get props => [videoId, processedVersions];
}

class VideoAnalyticsLoaded extends VideoState {
  final String videoId;
  final Map<String, dynamic> Analytics;

  const VideoAnalyticsLoaded(this.videoId, this.Analytics);

  
  List<Object?> get props => [videoId, Analytics];
}

class VideoActionSuccess extends VideoState {
  final String Message;

  const VideoActionSuccess(this.Message);

  
  List<Object?> get props => [Message];
}

class VideoActionFailure extends VideoState {
  final String Message;

  const VideoActionFailure(this.Message);

  
  List<Object?> get props => [Message];
}
