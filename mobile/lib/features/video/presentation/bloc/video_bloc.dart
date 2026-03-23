import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/video_content_entity.dart';
import '../../domain/repositories/video_content_repository.dart';
import '../../domain/usecases/video_usecases.dart';

part 'video_Event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoContentRepository repository;
  final GetVideosUseCase getVideosUseCase;
  final GetVideoByIdUseCase getVideoByIdUseCase;
  final CreateVideoUseCase createVideoUseCase;
  final UpdateVideoUseCase updateVideoUseCase;
  final DeleteVideoUseCase deleteVideoUseCase;
  final UploadVideoUseCase uploadVideoUseCase;

  VideoBloc({
    required this.repository,
    required this.getVideosUseCase,
    required this.getVideoByIdUseCase,
    required this.createVideoUseCase,
    required this.updateVideoUseCase,
    required this.deleteVideoUseCase,
    required this.uploadVideoUseCase,
  }) : super(VideoInitial()) {
    on<LoadVideos>(_onLoadVideos);
    on<LoadVideoById>(_onLoadVideoById);
    on<CreateVideo>(_onCreateVideo);
    on<UpdateVideo>(_onUpdateVideo);
    on<DeleteVideo>(_onDeleteVideo);
    on<UploadVideo>(_onUploadVideo);
    on<SearchVideos>(_onSearchVideos);
    on<FilterVideos>(_onFilterVideos);
    on<PlayVideo>(_onPlayVideo);
    on<PauseVideo>(_onPauseVideo);
    on<StopVideo>(_onStopVideo);
  }

  Future<void> _onLoadVideos(
    LoadVideos Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoLoading());
    final result = await getVideosUseCase();
    result.fold(
      (failure) => emit(VideoError(failure.message)),
      (videos) => emit(VideosLoaded(videos)),
    );
  }

  Future<void> _onLoadVideoById(
    LoadVideoById Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoLoading());
    final result = await getVideoByIdUseCase(Event.id);
    result.fold(
      (failure) => emit(VideoError(failure.message)),
      (video) => emit(VideoDetailLoaded(video)),
    );
  }

  Future<void> _onCreateVideo(
    CreateVideo Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoLoading());
    final result = await createVideoUseCase(Event.video);
    result.fold(
      (failure) => emit(VideoError(failure.message)),
      (video) => emit(VideoCreated(video)),
    );
  }

  Future<void> _onUpdateVideo(
    UpdateVideo Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoLoading());
    final result = await updateVideoUseCase(Event.video);
    result.fold(
      (failure) => emit(VideoError(failure.message)),
      (video) => emit(VideoUpdated(video)),
    );
  }

  Future<void> _onDeleteVideo(
    DeleteVideo Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoLoading());
    final result = await deleteVideoUseCase(Event.id);
    result.fold(
      (failure) => emit(VideoError(failure.message)),
      (_) => emit(VideoDeleted(Event.id)),
    );
  }

  Future<void> _onUploadVideo(
    UploadVideo Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoUploading());
    final result = await uploadVideoUseCase(Event.filePath, Event.title, Event.description);
    result.fold(
      (failure) => emit(VideoError(failure.message)),
      (video) => emit(VideoUploaded(video)),
    );
  }

  Future<void> _onSearchVideos(
    SearchVideos Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoLoading());
    final result = await repository.searchVideos(Event.query);
    result.fold(
      (failure) => emit(VideoError(failure.message)),
      (videos) => emit(VideosSearchLoaded(videos, Event.query)),
    );
  }

  Future<void> _onFilterVideos(
    FilterVideos Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoLoading());
    final result = await repository.getVideos(
      category: Event.category,
      status: Event.status != null ? Event.status : null,
      limit: Event.limit,
      offset: Event.offset,
    );
    result.fold(
      (failure) => emit(VideoError(failure.message)),
      (videos) => emit(VideosLoaded(videos)),
    );
  }

  Future<void> _onPlayVideo(
    PlayVideo Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoPlaying(Event.video));
  }

  Future<void> _onPauseVideo(
    PauseVideo Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoPaused(Event.video));
  }

  Future<void> _onStopVideo(
    StopVideo Event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoStopped());
  }
}
