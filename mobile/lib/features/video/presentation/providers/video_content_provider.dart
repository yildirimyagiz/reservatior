import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/video_content_entity.dart';
import '../../domain/repositories/video_content_repository.dart';
import '../../domain/usecases/get_video_content.dart';
import '../../domain/usecases/get_video_content_by_id.dart';
import '../../domain/usecases/create_video_content.dart';
import '../../domain/usecases/update_video_content.dart';
import '../../domain/usecases/delete_video_content.dart';
import '../../domain/usecases/start_processing.dart';
import '../../domain/usecases/train_lora.dart';

// Video Content State
class VideoContentState {
  final List<VideoContentEntity> videos;
  final VideoContentEntity? selectedVideo;
  final bool isLoading;
  final bool isCreating;
  final bool isUpdating;
  final bool isDeleting;
  final bool isProcessing;
  final bool isTrainingLoRA;
  final String? error;
  final Map<String, dynamic> filters;
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final bool hasMore;
  final Map<String, dynamic> videoAnalytics;
  final List<VideoContentEntity> publishedVideos;
  final List<VideoContentEntity> processingVideos;
  final List<VideoContentEntity> failedVideos;
  final List<VideoContentEntity> featuredVideos;
  final List<VideoContentEntity> videosWithLoRA;

  const VideoContentState({
    this.videos = const [],
    this.selectedVideo,
    this.isLoading = false,
    this.isCreating = false,
    this.isUpdating = false,
    this.isDeleting = false,
    this.isProcessing = false,
    this.isTrainingLoRA = false,
    this.error,
    this.filters = const {},
    this.totalCount = 0,
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasMore = false,
    this.videoAnalytics = const {},
    this.publishedVideos = const [],
    this.processingVideos = const [],
    this.failedVideos = const [],
    this.featuredVideos = const [],
    this.videosWithLoRA = const [],
  });

  VideoContentState copyWith({
    List<VideoContentEntity>? videos,
    VideoContentEntity? selectedVideo,
    bool? isLoading,
    bool? isCreating,
    bool? isUpdating,
    bool? isDeleting,
    bool? isProcessing,
    bool? isTrainingLoRA,
    String? error,
    Map<String, dynamic>? filters,
    int? totalCount,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
    Map<String, dynamic>? videoAnalytics,
    List<VideoContentEntity>? publishedVideos,
    List<VideoContentEntity>? processingVideos,
    List<VideoContentEntity>? failedVideos,
    List<VideoContentEntity>? featuredVideos,
    List<VideoContentEntity>? videosWithLoRA,
  }) {
    return VideoContentState(
      videos: videos ?? this.videos,
      selectedVideo: selectedVideo ?? this.selectedVideo,
      isLoading: isLoading ?? this.isLoading,
      isCreating: isCreating ?? this.isCreating,
      isUpdating: isUpdating ?? this.isUpdating,
      isDeleting: isDeleting ?? this.isDeleting,
      isProcessing: isProcessing ?? this.isProcessing,
      isTrainingLoRA: isTrainingLoRA ?? this.isTrainingLoRA,
      error: error ?? this.error,
      filters: filters ?? this.filters,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
      videoAnalytics: videoAnalytics ?? this.videoAnalytics,
      publishedVideos: publishedVideos ?? this.publishedVideos,
      processingVideos: processingVideos ?? this.processingVideos,
      failedVideos: failedVideos ?? this.failedVideos,
      featuredVideos: featuredVideos ?? this.featuredVideos,
      videosWithLoRA: videosWithLoRA ?? this.videosWithLoRA,
    );
  }

  
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VideoContentState &&
        other.videos == videos &&
        other.selectedVideo == selectedVideo &&
        other.isLoading == isLoading &&
        other.isCreating == isCreating &&
        other.isUpdating == isUpdating &&
        other.isDeleting == isDeleting &&
        other.isProcessing == isProcessing &&
        other.isTrainingLoRA == isTrainingLoRA &&
        other.error == error &&
        other.filters == filters &&
        other.totalCount == totalCount &&
        other.currentPage == currentPage &&
        other.totalPages == totalPages &&
        other.hasMore == hasMore &&
        other.videoAnalytics == videoAnalytics &&
        other.publishedVideos == publishedVideos &&
        other.processingVideos == processingVideos &&
        other.failedVideos == failedVideos &&
        other.featuredVideos == featuredVideos &&
        other.videosWithLoRA == videosWithLoRA;
  }

  
  int get hashCode {
    return videos.hashCode ^
        selectedVideo.hashCode ^
        isLoading.hashCode ^
        isCreating.hashCode ^
        isUpdating.hashCode ^
        isDeleting.hashCode ^
        isProcessing.hashCode ^
        isTrainingLoRA.hashCode ^
        error.hashCode ^
        filters.hashCode ^
        totalCount.hashCode ^
        currentPage.hashCode ^
        totalPages.hashCode ^
        hasMore.hashCode ^
        videoAnalytics.hashCode ^
        publishedVideos.hashCode ^
        processingVideos.hashCode ^
        failedVideos.hashCode ^
        featuredVideos.hashCode ^
        videosWithLoRA.hashCode;
  }
}

// LoRA Config State
class LoRAConfigState {
  final List<LoRAConfig> configs;
  final LoRAConfig? selectedConfig;
  final bool isLoading;
  final bool isCreating;
  final bool isUpdating;
  final bool isDeleting;
  final bool isTraining;
  final String? error;
  final int totalCount;

  const LoRAConfigState({
    this.configs = const [],
    this.selectedConfig,
    this.isLoading = false,
    this.isCreating = false,
    this.isUpdating = false,
    this.isDeleting = false,
    this.isTraining = false,
    this.error,
    this.totalCount = 0,
  });

  LoRAConfigState copyWith({
    List<LoRAConfig>? configs,
    LoRAConfig? selectedConfig,
    bool? isLoading,
    bool? isCreating,
    bool? isUpdating,
    bool? isDeleting,
    bool? isTraining,
    String? error,
    int? totalCount,
  }) {
    return LoRAConfigState(
      configs: configs ?? this.configs,
      selectedConfig: selectedConfig ?? this.selectedConfig,
      isLoading: isLoading ?? this.isLoading,
      isCreating: isCreating ?? this.isCreating,
      isUpdating: isUpdating ?? this.isUpdating,
      isDeleting: isDeleting ?? this.isDeleting,
      isTraining: isTraining ?? this.isTraining,
      error: error ?? this.error,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoRAConfigState &&
        other.configs == configs &&
        other.selectedConfig == selectedConfig &&
        other.isLoading == isLoading &&
        other.isCreating == isCreating &&
        other.isUpdating == isUpdating &&
        other.isDeleting == isDeleting &&
        other.isTraining == isTraining &&
        other.error == error &&
        other.totalCount == totalCount;
  }

  
  int get hashCode {
    return configs.hashCode ^
        selectedConfig.hashCode ^
        isLoading.hashCode ^
        isCreating.hashCode ^
        isUpdating.hashCode ^
        isDeleting.hashCode ^
        isTraining.hashCode ^
        error.hashCode ^
        totalCount.hashCode;
  }
}

// Video Content Notifier
class VideoContentNotifier extends StateNotifier<VideoContentState> {
  final GetVideoContent getVideoContent;
  final GetVideoContentById getVideoContentById;
  final CreateVideoContent createVideoContent;
  final UpdateVideoContent updateVideoContent;
  final DeleteVideoContent deleteVideoContent;
  final StartProcessing startProcessing;
  final TrainLoRA trainLoRA;

  VideoContentNotifier({
    required this.getVideoContent,
    required this.getVideoContentById,
    required this.createVideoContent,
    required this.updateVideoContent,
    required this.deleteVideoContent,
    required this.startProcessing,
    required this.trainLoRA,
  }) : super(const VideoContentState());

  Future<void> loadVideoContent(String orgId, {Map<String, dynamic>? filters}) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await getVideoContent(GetVideoContentParams(
      orgId: orgId,
      ...filters ?? {},
    ));

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
      (videos) {
        final publishedVideos = videos.where((v) => v.isPublished).toList();
        final processingVideos = videos.where((v) => v.isProcessing).toList();
        final failedVideos = videos.where((v) => v.hasProblem).toList();
        final featuredVideos = videos.where((v) => v.isFeatured).toList();
        final videosWithLoRA = videos.where((v) => v.hasLoRAConfig).toList();
        
        state = state.copyWith(
          isLoading: false,
          videos: videos,
          publishedVideos: publishedVideos,
          processingVideos: processingVideos,
          failedVideos: failedVideos,
          featuredVideos: featuredVideos,
          videosWithLoRA: videosWithLoRA,
          totalCount: videos.length,
          filters: filters ?? {},
        );
      },
    );
  }

  Future<void> loadVideoContentById(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await getVideoContentById(id);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
      (video) => state = state.copyWith(
        isLoading: false,
        selectedVideo: video,
      ),
    );
  }

  Future<void> createVideoContent(CreateVideoContentParams params) async {
    state = state.copyWith(isCreating: true, error: null);
    
    final result = await createVideoContent(params);

    result.fold(
      (failure) => state = state.copyWith(isCreating: false, error: failure.message),
      (video) {
        final updatedVideos = [...state.videos, video];
        final processingVideos = updatedVideos.where((v) => v.isProcessing).toList();
        final videosWithLoRA = updatedVideos.where((v) => v.hasLoRAConfig).toList();
        
        state = state.copyWith(
          isCreating: false,
          videos: updatedVideos,
          selectedVideo: video,
          processingVideos: processingVideos,
          videosWithLoRA: videosWithLoRA,
          totalCount: state.totalCount + 1,
        );
      },
    );
  }

  Future<void> updateVideoContent(UpdateVideoContentParams params) async {
    state = state.copyWith(isUpdating: true, error: null);
    
    final result = await updateVideoContent(params);

    result.fold(
      (failure) => state = state.copyWith(isUpdating: false, error: failure.message),
      (video) {
        final updatedVideos = state.videos.map((v) => v.id == video.id ? video : v).toList();
        final publishedVideos = updatedVideos.where((v) => v.isPublished).toList();
        final processingVideos = updatedVideos.where((v) => v.isProcessing).toList();
        final failedVideos = updatedVideos.where((v) => v.hasProblem).toList();
        final featuredVideos = updatedVideos.where((v) => v.isFeatured).toList();
        final videosWithLoRA = updatedVideos.where((v) => v.hasLoRAConfig).toList();
        
        state = state.copyWith(
          isUpdating: false,
          videos: updatedVideos,
          selectedVideo: state.selectedVideo?.id == video.id ? video : state.selectedVideo,
          publishedVideos: publishedVideos,
          processingVideos: processingVideos,
          failedVideos: failedVideos,
          featuredVideos: featuredVideos,
          videosWithLoRA: videosWithLoRA,
        );
      },
    );
  }

  Future<void> deleteVideoContent(String id) async {
    state = state.copyWith(isDeleting: true, error: null);
    
    final result = await deleteVideoContent(id);

    result.fold(
      (failure) => state = state.copyWith(isDeleting: false, error: failure.message),
      (_) {
        final updatedVideos = state.videos.where((v) => v.id != id).toList();
        final publishedVideos = updatedVideos.where((v) => v.isPublished).toList();
        final processingVideos = updatedVideos.where((v) => v.isProcessing).toList();
        final failedVideos = updatedVideos.where((v) => v.hasProblem).toList();
        final featuredVideos = updatedVideos.where((v) => v.isFeatured).toList();
        final videosWithLoRA = updatedVideos.where((v) => v.hasLoRAConfig).toList();
        
        state = state.copyWith(
          isDeleting: false,
          videos: updatedVideos,
          selectedVideo: state.selectedVideo?.id == id ? null : state.selectedVideo,
          publishedVideos: publishedVideos,
          processingVideos: processingVideos,
          failedVideos: failedVideos,
          featuredVideos: featuredVideos,
          videosWithLoRA: videosWithLoRA,
          totalCount: state.totalCount - 1,
        );
      },
    );
  }

  Future<void> startVideoProcessing(String id, ProcessVideoParams params) async {
    state = state.copyWith(isProcessing: true, error: null);
    
    final result = await startProcessing(id, params);

    result.fold(
      (failure) => state = state.copyWith(isProcessing: false, error: failure.message),
      (video) {
        final updatedVideos = state.videos.map((v) => v.id == video.id ? video : v).toList();
        final processingVideos = updatedVideos.where((v) => v.isProcessing).toList();
        
        state = state.copyWith(
          isProcessing: false,
          videos: updatedVideos,
          selectedVideo: state.selectedVideo?.id == video.id ? video : state.selectedVideo,
          processingVideos: processingVideos,
        );
      },
    );
  }

  Future<void> startLoRATraining(String id, TrainLoRAParams params) async {
    state = state.copyWith(isTrainingLoRA: true, error: null);
    
    final result = await trainLoRA(id, params);

    result.fold(
      (failure) => state = state.copyWith(isTrainingLoRA: false, error: failure.message),
      (video) {
        final updatedVideos = state.videos.map((v) => v.id == video.id ? video : v).toList();
        final videosWithLoRA = updatedVideos.where((v) => v.hasLoRAConfig).toList();
        
        state = state.copyWith(
          isTrainingLoRA: false,
          videos: updatedVideos,
          selectedVideo: state.selectedVideo?.id == video.id ? video : state.selectedVideo,
          videosWithLoRA: videosWithLoRA,
        );
      },
    );
  }

  void updateProcessingProgress(String videoId, ProcessingStage stage, double progress) {
    final updatedVideos = state.videos.map((v) {
      if (v.id == videoId) {
        return v.copyWith(processingStage: stage, processingProgress: progress);
      }
      return v;
    }).toList();
    
    final processingVideos = updatedVideos.where((v) => v.isProcessing).toList();
    final completedVideos = updatedVideos.where((v) => v.isProcessingCompleted).toList();
    
    state = state.copyWith(
      videos: updatedVideos,
      selectedVideo: state.selectedVideo?.id == videoId 
          ? updatedVideos.where((v) => v.id == videoId).firstWhere
          : state.selectedVideo,
      processingVideos: processingVideos,
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSelectedVideo() {
    state = state.copyWith(selectedVideo: null);
  }

  void resetState() {
    state = const VideoContentState();
  }

  void updateFilters(Map<String, dynamic> newFilters) {
    state = state.copyWith(filters: newFilters);
  }

  void selectVideo(VideoContentEntity video) {
    state = state.copyWith(selectedVideo: video);
  }

  void publishVideo(String videoId) {
    final updatedVideos = state.videos.map((v) {
      if (v.id == videoId) {
        return v.copyWith(publishedAt: DateTime.now(), isPublic: true);
      }
      return v;
    }).toList();
    
    final publishedVideos = updatedVideos.where((v) => v.isPublished).toList();
    
    state = state.copyWith(
      videos: updatedVideos,
      selectedVideo: state.selectedVideo?.id == videoId 
          ? updatedVideos.where((v) => v.id == videoId).firstWhere
          : state.selectedVideo,
      publishedVideos: publishedVideos,
    );
  }

  void unpublishVideo(String videoId) {
    final updatedVideos = state.videos.map((v) {
      if (v.id == videoId) {
        return v.copyWith(publishedAt: null, isPublic: false);
      }
      return v;
    }).toList();
    
    final publishedVideos = updatedVideos.where((v) => v.isPublished).toList();
    
    state = state.copyWith(
      videos: updatedVideos,
      selectedVideo: state.selectedVideo?.id == videoId 
          ? updatedVideos.where((v) => v.id == videoId).firstWhere
          : state.selectedVideo,
      publishedVideos: publishedVideos,
    );
  }

  void featureVideo(String videoId) {
    final updatedVideos = state.videos.map((v) {
      if (v.id == videoId) {
        return v.copyWith(isFeatured: true);
      }
      return v;
    }).toList();
    
    final featuredVideos = updatedVideos.where((v) => v.isFeatured).toList();
    
    state = state.copyWith(
      videos: updatedVideos,
      selectedVideo: state.selectedVideo?.id == videoId 
          ? updatedVideos.where((v) => v.id == videoId).firstWhere
          : state.selectedVideo,
      featuredVideos: featuredVideos,
    );
  }

  void unfeatureVideo(String videoId) {
    final updatedVideos = state.videos.map((v) {
      if (v.id == videoId) {
        return v.copyWith(isFeatured: false);
      }
      return v;
    }).toList();
    
    final featuredVideos = updatedVideos.where((v) => v.isFeatured).toList();
    
    state = state.copyWith(
      videos: updatedVideos,
      selectedVideo: state.selectedVideo?.id == videoId 
          ? updatedVideos.where((v) => v.id == videoId).firstWhere
          : state.selectedVideo,
      featuredVideos: featuredVideos,
    );
  }

  void incrementViewCount(String videoId) {
    final updatedVideos = state.videos.map((v) {
      if (v.id == videoId) {
        return v.copyWith(viewCount: v.viewCount + 1);
      }
      return v;
    }).toList();
    
    state = state.copyWith(
      videos: updatedVideos,
      selectedVideo: state.selectedVideo?.id == videoId 
          ? updatedVideos.where((v) => v.id == videoId).firstWhere
          : state.selectedVideo,
    );
  }

  void incrementLikeCount(String videoId) {
    final updatedVideos = state.videos.map((v) {
      if (v.id == videoId) {
        return v.copyWith(likeCount: v.likeCount + 1);
      }
      return v;
    }).toList();
    
    state = state.copyWith(
      videos: updatedVideos,
      selectedVideo: state.selectedVideo?.id == videoId 
          ? updatedVideos.where((v) => v.id == videoId).firstWhere
          : state.selectedVideo,
    );
  }
}

// LoRA Config Notifier
class LoRAConfigNotifier extends StateNotifier<LoRAConfigState> {
  final VideoContentRepository repository;

  LoRAConfigNotifier({
    required this.repository,
  }) : super(const LoRAConfigState());

  Future<void> loadLoRAConfigs(String orgId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await repository.getLoRAConfigs(orgId);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.message),
      (configs) => state = state.copyWith(
        isLoading: false,
        configs: configs,
        totalCount: configs.length,
      ),
    );
  }

  Future<void> createLoRAConfig(CreateLoRAConfigParams params) async {
    state = state.copyWith(isCreating: true, error: null);
    
    final result = await repository.createLoRAConfig(params);

    result.fold(
      (failure) => state = state.copyWith(isCreating: false, error: failure.message),
      (config) => state = state.copyWith(
        isCreating: false,
        configs: [...state.configs, config],
        selectedConfig: config,
        totalCount: state.totalCount + 1,
      ),
    );
  }

  Future<void> updateLoRAConfig(UpdateLoRAConfigParams params) async {
    state = state.copyWith(isUpdating: true, error: null);
    
    final result = await repository.updateLoRAConfig(params);

    result.fold(
      (failure) => state = state.copyWith(isUpdating: false, error: failure.message),
      (config) {
        final updatedConfigs = state.configs.map((c) => c.id == config.id ? config : c).toList();
        state = state.copyWith(
          isUpdating: false,
          configs: updatedConfigs,
          selectedConfig: state.selectedConfig?.id == config.id ? config : state.selectedConfig,
        );
      },
    );
  }

  Future<void> deleteLoRAConfig(String id) async {
    state = state.copyWith(isDeleting: true, error: null);
    
    final result = await repository.deleteLoRAConfig(id);

    result.fold(
      (failure) => state = state.copyWith(isDeleting: false, error: failure.message),
      (_) {
        final updatedConfigs = state.configs.where((c) => c.id != id).toList();
        state = state.copyWith(
          isDeleting: false,
          configs: updatedConfigs,
          selectedConfig: state.selectedConfig?.id == id ? null : state.selectedConfig,
          totalCount: state.totalCount - 1,
        );
      },
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSelectedConfig() {
    state = state.copyWith(selectedConfig: null);
  }

  void resetState() {
    state = const LoRAConfigState();
  }

  void selectConfig(LoRAConfig config) {
    state = state.copyWith(selectedConfig: config);
  }
}

// Providers
final videoContentRepositoryProvider = Provider<VideoContentRepository>((ref) {
  // This should be implemented with the actual repository implementation
  throw UnimplementedError('VideoContentRepository provider not implemented');
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  // This should be implemented with the actual NetworkInfo implementation
  throw UnimplementedError('NetworkInfo provider not implemented');
});

// Video Content use case providers
final getVideoContentProvider = Provider<GetVideoContent>((ref) {
  final repository = ref.watch(videoContentRepositoryProvider);
  return GetVideoContent(repository);
});

final getVideoContentByIdProvider = Provider<GetVideoContentById>((ref) {
  final repository = ref.watch(videoContentRepositoryProvider);
  return GetVideoContentById(repository);
});

final createVideoContentProvider = Provider<CreateVideoContent>((ref) {
  final repository = ref.watch(videoContentRepositoryProvider);
  return CreateVideoContent(repository);
});

final updateVideoContentProvider = Provider<UpdateVideoContent>((ref) {
  final repository = ref.watch(videoContentRepositoryProvider);
  return UpdateVideoContent(repository);
});

final deleteVideoContentProvider = Provider<DeleteVideoContent>((ref) {
  final repository = ref.watch(videoContentRepositoryProvider);
  return DeleteVideoContent(repository);
});

final startProcessingProvider = Provider<StartProcessing>((ref) {
  final repository = ref.watch(videoContentRepositoryProvider);
  return StartProcessing(repository);
});

final trainLoRAProvider = Provider<TrainLoRA>((ref) {
  final repository = ref.watch(videoContentRepositoryProvider);
  return TrainLoRA(repository);
});

// Notifier providers
final videoContentNotifierProvider = StateNotifierProvider<VideoContentNotifier, VideoContentState>((ref) {
  return VideoContentNotifier(
    getVideoContent: ref.watch(getVideoContentProvider),
    getVideoContentById: ref.watch(getVideoContentByIdProvider),
    createVideoContent: ref.watch(createVideoContentProvider),
    updateVideoContent: ref.watch(updateVideoContentProvider),
    deleteVideoContent: ref.watch(deleteVideoContentProvider),
    startProcessing: ref.watch(startProcessingProvider),
    trainLoRA: ref.watch(trainLoRAProvider),
  );
});

final loraConfigNotifierProvider = StateNotifierProvider<LoRAConfigNotifier, LoRAConfigState>((ref) {
  return LoRAConfigNotifier(
    repository: ref.watch(videoContentRepositoryProvider),
  );
});

// Derived providers for commonly used data
final publishedVideosProvider = Provider<List<VideoContentEntity>>((ref) {
  return ref.watch(videoContentNotifierProvider).publishedVideos;
});

final processingVideosProvider = Provider<List<VideoContentEntity>>((ref) {
  return ref.watch(videoContentNotifierProvider).processingVideos;
});

final failedVideosProvider = Provider<List<VideoContentEntity>>((ref) {
  return ref.watch(videoContentNotifierProvider).failedVideos;
});

final featuredVideosProvider = Provider<List<VideoContentEntity>>((ref) {
  return ref.watch(videoContentNotifierProvider).featuredVideos;
});

final videosWithLoRAProvider = Provider<List<VideoContentEntity>>((ref) {
  return ref.watch(videoContentNotifierProvider).videosWithLoRA;
});

final selectedVideoProvider = Provider<VideoContentEntity?>((ref) {
  return ref.watch(videoContentNotifierProvider).selectedVideo;
});

final videoErrorProvider = Provider<String?>((ref) {
  return ref.watch(videoContentNotifierProvider).error;
});

final isVideoLoadingProvider = Provider<bool>((ref) {
  return ref.watch(videoContentNotifierProvider).isLoading;
});

final isProcessingProvider = Provider<bool>((ref) {
  return ref.watch(videoContentNotifierProvider).isProcessing;
});

final isTrainingLoRAProvider = Provider<bool>((ref) {
  return ref.watch(videoContentNotifierProvider).isTrainingLoRA;
});

final selectedLoRAConfigProvider = Provider<LoRAConfig?>((ref) {
  return ref.watch(loraConfigNotifierProvider).selectedConfig;
});

final loraConfigErrorProvider = Provider<String?>((ref) {
  return ref.watch(loraConfigNotifierProvider).error;
});

final isLoRALoadingProvider = Provider<bool>((ref) {
  return ref.watch(loraConfigNotifierProvider).isLoading;
});
