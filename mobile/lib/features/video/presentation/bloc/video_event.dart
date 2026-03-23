part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  
  List<Object?> get props => [];
}

class LoadVideos extends VideoEvent {
  final String? category;
  final String? status;
  final int? limit;
  final int? offset;

  const LoadVideos({
    this.category,
    this.status,
    this.limit,
    this.offset,
  });

  
  List<Object?> get props => [category, status, limit, offset];
}

class LoadVideoById extends VideoEvent {
  final String id;

  const LoadVideoById(this.id);

  
  List<Object?> get props => [id];
}

class CreateVideo extends VideoEvent {
  final VideoContentEntity video;

  const CreateVideo(this.video);

  
  List<Object?> get props => [video];
}

class UpdateVideo extends VideoEvent {
  final VideoContentEntity video;

  const UpdateVideo(this.video);

  
  List<Object?> get props => [video];
}

class DeleteVideo extends VideoEvent {
  final String id;

  const DeleteVideo(this.id);

  
  List<Object?> get props => [id];
}

class UploadVideo extends VideoEvent {
  final String filePath;
  final String title;
  final String description;

  const UploadVideo(this.filePath, this.title, this.description);

  
  List<Object?> get props => [filePath, title, description];
}

class SearchVideos extends VideoEvent {
  final String query;

  const SearchVideos(this.query);

  
  List<Object?> get props => [query];
}

class FilterVideos extends VideoEvent {
  final String? category;
  final String? status;
  final int? limit;
  final int? offset;

  const FilterVideos({
    this.category,
    this.status,
    this.limit,
    this.offset,
  });

  
  List<Object?> get props => [category, status, limit, offset];
}

class PlayVideo extends VideoEvent {
  final VideoContentEntity video;

  const PlayVideo(this.video);

  
  List<Object?> get props => [video];
}

class PauseVideo extends VideoEvent {
  final VideoContentEntity video;

  const PauseVideo(this.video);

  
  List<Object?> get props => [video];
}

class StopVideo extends VideoEvent {}

class RefreshVideos extends VideoEvent {}

class LikeVideo extends VideoEvent {
  final String videoId;

  const LikeVideo(this.videoId);

  
  List<Object?> get props => [videoId];
}

class UnlikeVideo extends VideoEvent {
  final String videoId;

  const UnlikeVideo(this.videoId);

  
  List<Object?> get props => [videoId];
}

class ShareVideo extends VideoEvent {
  final String videoId;
  final List<String> recipients;

  const ShareVideo(this.videoId, this.recipients);

  
  List<Object?> get props => [videoId, recipients];
}

class AddToPlaylist extends VideoEvent {
  final String videoId;
  final String playlistId;

  const AddToPlaylist(this.videoId, this.playlistId);

  
  List<Object?> get props => [videoId, playlistId];
}

class RemoveFromPlaylist extends VideoEvent {
  final String videoId;
  final String playlistId;

  const RemoveFromPlaylist(this.videoId, this.playlistId);

  
  List<Object?> get props => [videoId, playlistId];
}

class DownloadVideo extends VideoEvent {
  final String videoId;
  final String quality;

  const DownloadVideo(this.videoId, this.quality);

  
  List<Object?> get props => [videoId, quality];
}

class AddComment extends VideoEvent {
  final String videoId;
  final String comment;

  const AddComment(this.videoId, this.comment);

  
  List<Object?> get props => [videoId, comment];
}

class DeleteComment extends VideoEvent {
  final String videoId;
  final String commentId;

  const DeleteComment(this.videoId, this.commentId);

  
  List<Object?> get props => [videoId, commentId];
}

class ReportVideo extends VideoEvent {
  final String videoId;
  final String reason;

  const ReportVideo(this.videoId, this.reason);

  
  List<Object?> get props => [videoId, reason];
}

class GenerateThumbnail extends VideoEvent {
  final String videoId;
  final Duration? timestamp;

  const GenerateThumbnail(this.videoId, {this.timestamp});

  
  List<Object?> get props => [videoId, timestamp];
}

class TranscribeVideo extends VideoEvent {
  final String videoId;
  final String Language;

  const TranscribeVideo(this.videoId, this.Language);

  
  List<Object?> get props => [videoId, Language];
}

class AddSubtitles extends VideoEvent {
  final String videoId;
  final String Language;
  final String subtitleContent;

  const AddSubtitles(this.videoId, this.Language, this.subtitleContent);

  
  List<Object?> get props => [videoId, Language, subtitleContent];
}

class ProcessVideo extends VideoEvent {
  final String videoId;
  final List<String> processingOptions;

  const ProcessVideo(this.videoId, this.processingOptions);

  
  List<Object?> get props => [videoId, processingOptions];
}

class GetVideoAnalytics extends VideoEvent {
  final String videoId;
  final DateTime? startDate;
  final DateTime? endDate;

  const GetVideoAnalytics(this.videoId, {this.startDate, this.endDate});

  
  List<Object?> get props => [videoId, startDate, endDate];
}
