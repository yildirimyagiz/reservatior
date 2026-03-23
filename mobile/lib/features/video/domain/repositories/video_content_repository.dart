import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/video_content_entity.dart';

// Video Content Parameters
class GetVideoContentParams {
  final String? orgId;
  final String? createdBy;
  final VideoType? type;
  final VideoStatus? status;
  final VideoQuality? quality;
  final VideoFormat? format;
  final ProcessingStage? processingStage;
  final bool? isPublic;
  final bool? isFeatured;
  final bool? hasLoRAConfig;
  final DateTime? publishedFrom;
  final DateTime? publishedTo;
  final DateTime? createdFrom;
  final DateTime? createdTo;
  final List<String>? tags;
  final List<String>? categories;
  final int? minDuration;
  final int? maxDuration;
  final int? minFileSize;
  final int? maxFileSize;
  final String? search;
  final int? limit;
  final int? offset;
  final String? sortBy;
  final bool? sortAscending;

  const GetVideoContentParams({
    this.orgId,
    this.createdBy,
    this.type,
    this.status,
    this.quality,
    this.format,
    this.processingStage,
    this.isPublic,
    this.isFeatured,
    this.hasLoRAConfig,
    this.publishedFrom,
    this.publishedTo,
    this.createdFrom,
    this.createdTo,
    this.tags,
    this.categories,
    this.minDuration,
    this.maxDuration,
    this.minFileSize,
    this.maxFileSize,
    this.search,
    this.limit,
    this.offset,
    this.sortBy,
    this.sortAscending,
  });
}

class CreateVideoContentParams {
  final String orgId;
  final String title;
  final String? description;
  final VideoType type;
  final VideoQuality quality;
  final VideoFormat format;
  final String filePath;
  final String? thumbnailPath;
  final int duration;
  final int fileSize;
  final double aspectRatio;
  final int width;
  final int height;
  final double frameRate;
  final String? codec;
  final double bitrate;
  final String? createdBy;
  final List<String> tags;
  final List<String> categories;
  final bool isPublic;
  final bool isFeatured;
  final LoRAConfig? loraConfig;
  final Map<String, dynamic> metadata;

  const CreateVideoContentParams({
    required this.orgId,
    required this.title,
    this.description,
    required this.type,
    required this.quality,
    required this.format,
    required this.filePath,
    this.thumbnailPath,
    required this.duration,
    required this.fileSize,
    required this.aspectRatio,
    required this.width,
    required this.height,
    required this.frameRate,
    this.codec,
    required this.bitrate,
    this.createdBy,
    this.tags = const [],
    this.categories = const [],
    this.isPublic = false,
    this.isFeatured = false,
    this.loraConfig,
    this.metadata = const {},
  });
}

class UpdateVideoContentParams {
  final String id;
  final String? title;
  final String? description;
  final VideoType? type;
  final VideoStatus? status;
  final VideoQuality? quality;
  final String? thumbnailPath;
  final List<String>? tags;
  final List<String>? categories;
  final bool? isPublic;
  final bool? isFeatured;
  final LoRAConfig? loraConfig;
  final Map<String, dynamic>? metadata;

  const UpdateVideoContentParams({
    required this.id,
    this.title,
    this.description,
    this.type,
    this.status,
    this.quality,
    this.thumbnailPath,
    this.tags,
    this.categories,
    this.isPublic,
    this.isFeatured,
    this.loraConfig,
    this.metadata,
  });
}

// LoRA Config Parameters
class CreateLoRAConfigParams {
  final String name;
  final LoRAType type;
  final String description;
  final double strength;
  final int steps;
  final double learningRate;
  final String? triggerWord;
  final List<String> tags;
  final Map<String, dynamic> parameters;

  const CreateLoRAConfigParams({
    required this.name,
    required this.type,
    required this.description,
    required this.strength,
    required this.steps,
    required this.learningRate,
    this.triggerWord,
    this.tags = const [],
    this.parameters = const {},
  });
}

class UpdateLoRAConfigParams {
  final String id;
  final String? name;
  final LoRAType? type;
  final String? description;
  final double? strength;
  final int? steps;
  final double? learningRate;
  final String? triggerWord;
  final List<String>? tags;
  final Map<String, dynamic>? parameters;

  const UpdateLoRAConfigParams({
    required this.id,
    this.name,
    this.type,
    this.description,
    this.strength,
    this.steps,
    this.learningRate,
    this.triggerWord,
    this.tags,
    this.parameters,
  });
}

// Video Processing Parameters
class ProcessVideoParams {
  final String videoId;
  final List<VideoQuality> outputQualities;
  final List<VideoFormat> outputFormats;
  final bool generateThumbnail;
  final bool generatePreview;
  final bool optimizeForWeb;
  final Map<String, dynamic> processingOptions;

  const ProcessVideoParams({
    required this.videoId,
    this.outputQualities = const [],
    this.outputFormats = const [],
    this.generateThumbnail = true,
    this.generatePreview = false,
    this.optimizeForWeb = true,
    this.processingOptions = const {},
  });
}

class TrainLoRAParams {
  final String videoId;
  final LoRAType type;
  final String name;
  final String description;
  final double strength;
  final int steps;
  final double learningRate;
  final String? triggerWord;
  final List<String> trainingImages;
  final Map<String, dynamic> trainingOptions;

  const TrainLoRAParams({
    required this.videoId,
    required this.type,
    required this.name,
    required this.description,
    required this.strength,
    required this.steps,
    required this.learningRate,
    this.triggerWord,
    this.trainingImages = const [],
    this.trainingOptions = const {},
  });
}

abstract class VideoContentRepository {
  // Video Content CRUD operations
  Future<Either<Failure, List<VideoContentEntity>>> getVideoContent(GetVideoContentParams params);
  Future<Either<Failure, VideoContentEntity>> getVideoContentById(String id);
  Future<Either<Failure, VideoContentEntity>> createVideoContent(CreateVideoContentParams params);
  Future<Either<Failure, VideoContentEntity>> updateVideoContent(UpdateVideoContentParams params);
  Future<Either<Failure, void>> deleteVideoContent(String id);
  Future<Either<Failure, void>> softDeleteVideoContent(String id);
  Future<Either<Failure, VideoContentEntity>> restoreVideoContent(String id);

  // Video Content status and processing management
  Future<Either<Failure, VideoContentEntity>> startProcessing(String id, ProcessVideoParams params);
  Future<Either<Failure, VideoContentEntity>> updateProcessingStage(String id, ProcessingStage stage, {double? progress});
  Future<Either<Failure, VideoContentEntity>> completeProcessing(String id);
  Future<Either<Failure, VideoContentEntity>> failProcessing(String id, String error);
  Future<Either<Failure, VideoContentEntity>> retryProcessing(String id);
  Future<Either<Failure, VideoContentEntity>> publishVideo(String id);
  Future<Either<Failure, VideoContentEntity>> unpublishVideo(String id);
  Future<Either<Failure, VideoContentEntity>> featureVideo(String id);
  Future<Either<Failure, VideoContentEntity>> unfeatureVideo(String id);

  // Video Content search and filtering
  Future<Either<Failure, List<VideoContentEntity>>> searchVideoContent(String orgId, String query, {GetVideoContentParams? filters});
  Future<Either<Failure, List<VideoContentEntity>>> getVideosByType(String orgId, VideoType type);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosByStatus(String orgId, VideoStatus status);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosByQuality(String orgId, VideoQuality quality);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosByFormat(String orgId, VideoFormat format);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosByCreator(String orgId, String createdBy);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosByTags(String orgId, List<String> tags);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosByCategories(String orgId, List<String> categories);
  Future<Either<Failure, List<VideoContentEntity>>> getPublicVideos(String orgId);
  Future<Either<Failure, List<VideoContentEntity>>> getFeaturedVideos(String orgId);
  Future<Either<Failure, List<VideoContentEntity>>> getPublishedVideos(String orgId, {DateTime? since});
  Future<Either<Failure, List<VideoContentEntity>>> getProcessingVideos(String orgId);
  Future<Either<Failure, List<VideoContentEntity>>> getFailedVideos(String orgId);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosWithLoRA(String orgId);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosInDateRange(String orgId, DateTime from, DateTime to);
  Future<Either<Failure, List<VideoContentEntity>>> getRecentVideos(String orgId, {int? days});
  Future<Either<Failure, List<VideoContentEntity>>> getPopularVideos(String orgId, {int? limit});
  Future<Either<Failure, List<VideoContentEntity>>> getViralVideos(String orgId, {int? limit});

  // Video Content Analytics and reporting
  Future<Either<Failure, Map<String, dynamic>>> getVideoAnalytics(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, Map<String, dynamic>>> getVideoStatistics(String orgId);
  Future<Either<Failure, Map<String, dynamic>>> getVideoPerformanceMetrics(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, Map<String, dynamic>>> getVideoEngagementAnalytics(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, Map<String, dynamic>>> getVideoTypeAnalytics(String orgId, VideoType type, DateTime startDate, DateTime endDate);
  Future<Either<Failure, Map<String, dynamic>>> getVideoQualityAnalytics(String orgId, VideoQuality quality, DateTime startDate, DateTime endDate);
  Future<Either<Failure, Map<String, dynamic>>> getProcessingAnalytics(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, Map<String, dynamic>>> getStorageAnalytics(String orgId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoTypeReport(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoStatusReport(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoQualityReport(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoEngagementReport(String orgId, DateTime startDate, DateTime endDate);

  // Video Content engagement management
  Future<Either<Failure, VideoContentEntity>> incrementViewCount(String id);
  Future<Either<Failure, VideoContentEntity>> incrementLikeCount(String id);
  Future<Either<Failure, VideoContentEntity>> decrementLikeCount(String id);
  Future<Either<Failure, VideoContentEntity>> incrementCommentCount(String id);
  Future<Either<Failure, Map<String, dynamic>>> getEngagementMetrics(String id);
  Future<Either<Failure, List<Map<String, dynamic>>>> getViewHistory(String id, {DateTime? since});
  Future<Either<Failure, List<Map<String, dynamic>>>> getLikeHistory(String id, {DateTime? since});
  Future<Either<Failure, List<Map<String, dynamic>>>> getCommentHistory(String id, {DateTime? since});

  // LoRA Config management
  Future<Either<Failure, LoRAConfig>> createLoRAConfig(CreateLoRAConfigParams params);
  Future<Either<Failure, LoRAConfig>> getLoRAConfigById(String id);
  Future<Either<Failure, List<LoRAConfig>>> getLoRAConfigs(String orgId);
  Future<Either<Failure, LoRAConfig>> updateLoRAConfig(UpdateLoRAConfigParams params);
  Future<Either<Failure, void>> deleteLoRAConfig(String id);
  Future<Either<Failure, List<LoRAConfig>>> getLoRAConfigsByType(String orgId, LoRAType type);
  Future<Either<Failure, List<LoRAConfig>>> searchLoRAConfigs(String orgId, String query);
  Future<Either<Failure, VideoContentEntity>> attachLoRAConfig(String videoId, String loraConfigId);
  Future<Either<Failure, VideoContentEntity>> detachLoRAConfig(String videoId);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosWithLoRAConfig(String orgId, String loraConfigId);

  // LoRA Training operations
  Future<Either<Failure, VideoContentEntity>> startLoRATraining(String videoId, TrainLoRAParams params);
  Future<Either<Failure, VideoContentEntity>> updateLoRATrainingProgress(String videoId, double progress);
  Future<Either<Failure, VideoContentEntity>> completeLoRATraining(String videoId, LoRAConfig config);
  Future<Either<Failure, VideoContentEntity>> failLoRATraining(String videoId, String error);
  Future<Either<Failure, Map<String, dynamic>>> getLoRATrainingStatus(String videoId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getLoRATrainingHistory(String orgId);
  Future<Either<Failure, void>> cancelLoRATraining(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> testLoRAConfig(String loraConfigId, Map<String, dynamic> testParams);

  // Video processing operations
  Future<Either<Failure, VideoContentEntity>> transcodeVideo(String id, List<VideoQuality> qualities, List<VideoFormat> formats);
  Future<Either<Failure, VideoContentEntity>> generateThumbnail(String id, {int? timestamp});
  Future<Either<Failure, VideoContentEntity>> generatePreview(String id, {int? duration});
  Future<Either<Failure, VideoContentEntity>> optimizeForWeb(String id);
  Future<Either<Failure, VideoContentEntity>> compressVideo(String id, {double? targetSize, VideoQuality? targetQuality});
  Future<Either<Failure, VideoContentEntity>> extractAudio(String id);
  Future<Either<Failure, VideoContentEntity>> addWatermark(String id, String watermarkPath);
  Future<Either<Failure, VideoContentEntity>> addSubtitles(String id, String subtitlePath);
  Future<Either<Failure, Map<String, dynamic>>> getProcessingStatus(String id);
  Future<Either<Failure, List<Map<String, dynamic>>>> getProcessingHistory(String orgId);
  Future<Either<Failure, void>> cancelProcessing(String id);

  // Video Content export and import
  Future<Either<Failure, String>> exportVideoContent(String orgId, String format, {GetVideoContentParams? filters});
  Future<Either<Failure, String>> exportVideo(String id, String format);
  Future<Either<Failure, String>> exportVideoMetadata(String id, String format);
  Future<Either<Failure, String>> exportLoRAConfigs(String orgId, String format);
  Future<Either<Failure, List<VideoContentEntity>>> importVideoContent(String orgId, List<Map<String, dynamic>> videoData, String format);
  Future<Either<Failure, VideoContentEntity>> importVideo(String orgId, Map<String, dynamic> videoData, String format);
  Future<Either<Failure, Map<String, dynamic>>> validateImportData(String orgId, Map<String, dynamic> data);
  Future<Either<Failure, List<Map<String, dynamic>>>> getImportHistory(String orgId);
  Future<Either<Failure, Map<String, dynamic>>> getImportStatistics(String orgId);

  // Video Content backup and recovery
  Future<Either<Failure, String>> backupVideo(String id);
  Future<Either<Failure, String>> backupVideos(String orgId, {GetVideoContentParams? filters});
  Future<Either<Failure, VideoContentEntity>> restoreVideo(String orgId, String backupData);
  Future<Either<Failure, List<VideoContentEntity>>> restoreVideos(String orgId, String backupData);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoBackups(String orgId);
  Future<Either<Failure, void>> deleteVideoBackup(String orgId, String backupId);
  Future<Either<Failure, void>> scheduleVideoBackup(String orgId, String schedule);
  Future<Either<Failure, Map<String, dynamic>>> getVideoBackupStatistics(String orgId);

  // Video Content real-time operations
  Future<Either<Failure, void>> subscribeToVideoUpdates(String videoId, String userId);
  Future<Either<Failure, void>> unsubscribeFromVideoUpdates(String videoId, String userId);
  Future<Either<Failure, void>> subscribeToProcessingUpdates(String videoId, String userId);
  Future<Either<Failure, void>> unsubscribeFromProcessingUpdates(String videoId, String userId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoUpdates(String videoId, {DateTime? since});
  Future<Either<Failure, List<Map<String, dynamic>>>> getProcessingUpdates(String videoId, {DateTime? since});
  Future<Either<Failure, void>> sendVideoUpdateNotification(String videoId, Map<String, dynamic> update);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoSubscriptions(String userId);
  Future<Either<Failure, Map<String, dynamic>>> getVideoSubscriptionConfig(String videoId);
  Future<Either<Failure, void>> configureVideoSubscription(String videoId, Map<String, dynamic> subscriptionConfig);

  // Video Content permissions and security
  Future<Either<Failure, bool>> hasVideoAccess(String userId, String videoId, String action);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoPermissions(String userId, String videoId);
  Future<Either<Failure, void>> grantVideoAccess(String userId, String videoId, String Permission);
  Future<Either<Failure, void>> revokeVideoAccess(String userId, String videoId, String Permission);
  Future<Either<Failure, Map<String, dynamic>>> getVideoAuditTrail(String videoId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, bool>> canViewVideo(String userId, String videoId);
  Future<Either<Failure, bool>> canEditVideo(String userId, String videoId);
  Future<Either<Failure, bool>> canDeleteVideo(String userId, String videoId);
  Future<Either<Failure, bool>> canPublishVideo(String userId, String videoId);
  Future<Either<Failure, bool>> canProcessVideo(String userId, String videoId);

  // Video Content collaboration features
  Future<Either<Failure, VideoContentEntity>> shareVideo(String videoId, List<String> userIds, {String? Message});
  Future<Either<Failure, void>> unshareVideo(String videoId, List<String> userIds);
  Future<Either<Failure, List<Map<String, dynamic>>>> getSharedVideos(String userId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoShares(String videoId);
  Future<Either<Failure, void>> acceptSharedVideo(String userId, String videoId);
  Future<Either<Failure, void>> declineSharedVideo(String userId, String videoId);
  Future<Either<Failure, VideoContentEntity>> duplicateVideo(String videoId, String newTitle, {String? newCreator});
  Future<Either<Failure, List<VideoContentEntity>>> bulkDuplicateVideos(List<String> videoIds, {Map<String, String>? newCreators});

  // Video Content custom fields and metadata
  Future<Either<Failure, VideoContentEntity>> setCustomField(String videoId, String key, dynamic value);
  Future<Either<Failure, VideoContentEntity>> removeCustomField(String videoId, String key);
  Future<Either<Failure, Map<String, dynamic>>> getCustomFields(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> setMetadata(String videoId, String key, dynamic value);
  Future<Either<Failure, Map<String, dynamic>>> getMetadata(String videoId);
  Future<Either<Failure, List<VideoContentEntity>>> getVideosByCustomField(String orgId, String key, dynamic value);
  Future<Either<Failure, List<VideoContentEntity>>> searchVideosByCustomFields(String orgId, Map<String, dynamic> criteria);
  Future<Either<Failure, List<Map<String, dynamic>>>> getCustomFieldDefinitions(String orgId);
  Future<Either<Failure, Map<String, dynamic>>> createCustomFieldDefinition(String orgId, Map<String, dynamic> definition);

  // Video Content bulk operations
  Future<Either<Failure, List<VideoContentEntity>>> bulkUpdateVideos(List<String> videoIds, UpdateVideoContentParams params);
  Future<Either<Failure, void>> bulkDeleteVideos(List<String> videoIds);
  Future<Either<Failure, List<VideoContentEntity>>> bulkPublishVideos(List<String> videoIds);
  Future<Either<Failure, List<VideoContentEntity>>> bulkUnpublishVideos(List<String> videoIds);
  Future<Either<Failure, List<VideoContentEntity>>> bulkFeatureVideos(List<String> videoIds);
  Future<Either<Failure, List<VideoContentEntity>>> bulkUnfeatureVideos(List<String> videoIds);
  Future<Either<Failure, List<VideoContentEntity>>> bulkProcessVideos(List<String> videoIds, ProcessVideoParams params);
  Future<Either<Failure, Map<String, dynamic>>> getBulkOperationStatus(String operationId);
  Future<Either<Failure, void>> cancelBulkOperation(String operationId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getBulkOperationHistory(String orgId);

  // Video Content integration with other systems
  Future<Either<Failure, void>> syncVideoWithCMS(String videoId, String cmsId);
  Future<Either<Failure, void>> unsyncVideoFromCMS(String videoId, String cmsId);
  Future<Either<Failure, void>> publishToSocialMedia(String videoId, List<String> platforms);
  Future<Either<Failure, void>> unpublishFromSocialMedia(String videoId, List<String> platforms);
  Future<Either<Failure, List<Map<String, dynamic>>>> getSocialMediaStats(String videoId);
  Future<Either<Failure, void>> integrateWithCDN(String videoId, String cdnProvider);
  Future<Either<Failure, Map<String, dynamic>>> getCDNStats(String videoId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getVideoIntegrations(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> getVideoIntegrationSettings(String orgId);

  // Video Content AI and ML features
  Future<Either<Failure, Map<String, dynamic>>> analyzeVideoContent(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> generateVideoSummary(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> extractVideoKeywords(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> detectVideoObjects(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> transcribeVideo(String videoId, {String? Language});
  Future<Either<Failure, Map<String, dynamic>>> translateVideo(String videoId, String targetLanguage);
  Future<Either<Failure, Map<String, dynamic>>> generateVideoCaptions(String videoId, {String? Language});
  Future<Either<Failure, Map<String, dynamic>>> classifyVideoContent(String videoId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getSimilarVideos(String videoId, {int? limit});
  Future<Either<Failure, Map<String, dynamic>>> recommendVideoTags(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> predictVideoPerformance(String videoId);

  // Video Content storage and CDN management
  Future<Either<Failure, Map<String, dynamic>>> getStorageUsage(String orgId);
  Future<Either<Failure, Map<String, dynamic>>> getCDNUsage(String orgId);
  Future<Either<Failure, void>> optimizeStorage(String orgId);
  Future<Either<Failure, void>> cleanupOldFiles(String orgId, {DateTime? olderThan});
  Future<Either<Failure, Map<String, dynamic>>> getBandwidthUsage(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, void>> configureCDNSettings(String orgId, Map<String, dynamic> settings);
  Future<Either<Failure, Map<String, dynamic>>> getCDNSettings(String orgId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getCDNPerformanceMetrics(String orgId, DateTime startDate, DateTime endDate);

  // Video Content compliance and moderation
  Future<Either<Failure, Map<String, dynamic>>> moderateVideo(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> checkContentCompliance(String videoId);
  Future<Either<Failure, void>> flagContent(String videoId, String reason, String? description);
  Future<Either<Failure, List<Map<String, dynamic>>>> getFlaggedContent(String orgId, {bool? resolved});
  Future<Either<Failure, void>> resolveContentFlag(String flagId, String resolution);
  Future<Either<Failure, Map<String, dynamic>>> getComplianceReport(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, List<Map<String, dynamic>>>> getModerationHistory(String orgId);
  Future<Either<Failure, void>> updateModerationSettings(String orgId, Map<String, dynamic> settings);
  Future<Either<Failure, Map<String, dynamic>>> getModerationSettings(String orgId);

  // Video Content monetization
  Future<Either<Failure, Map<String, dynamic>>> enableMonetization(String videoId, Map<String, dynamic> monetizationSettings);
  Future<Either<Failure, void>> disableMonetization(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> getMonetizationStatus(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> getRevenueAnalytics(String videoId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, Map<String, dynamic>>> getMonetizationReport(String orgId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, List<Map<String, dynamic>>>> getMonetizedVideos(String orgId);
  Future<Either<Failure, void>> updateMonetizationSettings(String orgId, Map<String, dynamic> settings);
  Future<Either<Failure, Map<String, dynamic>>> getMonetizationSettings(String orgId);

  // Video Content live streaming
  Future<Either<Failure, Map<String, dynamic>>> startLiveStream(String videoId, Map<String, dynamic> streamConfig);
  Future<Either<Failure, void>> stopLiveStream(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> getLiveStreamStatus(String videoId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getLiveStreamViewers(String videoId);
  Future<Either<Failure, Map<String, dynamic>>> getLiveStreamAnalytics(String videoId, DateTime startDate, DateTime endDate);
  Future<Either<Failure, void>> recordLiveStream(String videoId, bool enableRecording);
  Future<Either<Failure, List<Map<String, dynamic>>>> getLiveStreamRecordings(String videoId);
}
