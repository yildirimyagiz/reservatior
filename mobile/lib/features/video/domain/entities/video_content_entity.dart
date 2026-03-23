enum VideoStatus {
  processing,
  ready,
  failed,
  archived,
  deleted,
}

enum VideoType {
  tutorial,
  promotional,
  educational,
  entertainment,
  documentary,
  interview,
  presentation,
  demo,
  Review,
  testimonial,
}

enum VideoQuality {
  low,
  medium,
  high,
  ultra,
  cinematic,
}

enum VideoFormat {
  mp4,
  mov,
  avi,
  mkv,
  webm,
  flv,
  wmv,
  m4v,
}

enum LoRAStatus {
  training,
  ready,
  failed,
  testing,
  deployed,
  archived,
}

enum LoRAType {
  style,
  character,
  concept,
  object,
  background,
  lighting,
  composition,
  color,
}

enum ProcessingStage {
  uploaded,
  transcoding,
  analysis,
  thumbnail,
  optimization,
  completed,
}

extension VideoStatusExtension on VideoStatus {
  String get displayName {
    switch (this) {
      case VideoStatus.processing:
        return 'İşleniyor';
      case VideoStatus.ready:
        return 'Hazır';
      case VideoStatus.failed:
        return 'Başarısız';
      case VideoStatus.archived:
        return 'Arşivlendi';
      case VideoStatus.deleted:
        return 'Silindi';
    }
  }

  String get color {
    switch (this) {
      case VideoStatus.processing:
        return '#FF9800';
      case VideoStatus.ready:
        return '#4CAF50';
      case VideoStatus.failed:
        return '#F44336';
      case VideoStatus.archived:
        return '#607D8B';
      case VideoStatus.deleted:
        return '#9E9E9E';
    }
  }

  String get icon {
    switch (this) {
      case VideoStatus.processing:
        return '⚙️';
      case VideoStatus.ready:
        return '✅';
      case VideoStatus.failed:
        return '❌';
      case VideoStatus.archived:
        return '📦';
      case VideoStatus.deleted:
        return '🗑️';
    }
  }

  bool get isActive {
    return [
      VideoStatus.processing,
      VideoStatus.ready,
    ].contains(this);
  }

  bool get isFinal {
    return [
      VideoStatus.failed,
      VideoStatus.archived,
      VideoStatus.deleted,
    ].contains(this);
  }

  bool get isAccessible {
    return this == VideoStatus.ready;
  }

  bool get hasProblem {
    return this == VideoStatus.failed;
  }
}

extension VideoTypeExtension on VideoType {
  String get displayName {
    switch (this) {
      case VideoType.tutorial:
        return 'Eğitim';
      case VideoType.promotional:
        return 'Tanıtım';
      case VideoType.educational:
        return 'Eğitici';
      case VideoType.entertainment:
        return 'Eğlence';
      case VideoType.documentary:
        return 'Belgesel';
      case VideoType.interview:
        return 'Röportaj';
      case VideoType.presentation:
        return 'Sunum';
      case VideoType.demo:
        return 'Demo';
      case VideoType.Review:
        return 'İnceleme';
      case VideoType.testimonial:
        return 'Referans';
    }
  }

  String get description {
    switch (this) {
      case VideoType.tutorial:
        return 'Nasıl yapılır videoları';
      case VideoType.promotional:
        return 'Ürün/hizmet tanıtımı';
      case VideoType.educational:
        return 'Eğitim içerikleri';
      case VideoType.entertainment:
        return 'Eğlence videoları';
      case VideoType.documentary:
        return 'Belgesel içerikler';
      case VideoType.interview:
        return 'Mülakat ve röportajlar';
      case VideoType.presentation:
        return 'Sunum ve konferanslar';
      case VideoType.demo:
        return 'Ürün demo videoları';
      case VideoType.Review:
        return 'Ürün incelemeleri';
      case VideoType.testimonial:
        return 'Müşteri referansları';
    }
  }

  String get icon {
    switch (this) {
      case VideoType.tutorial:
        return '📚';
      case VideoType.promotional:
        return '📢';
      case VideoType.educational:
        return '🎓';
      case VideoType.entertainment:
        return '🎬';
      case VideoType.documentary:
        return '📹';
      case VideoType.interview:
        return '🎤';
      case VideoType.presentation:
        return '📊';
      case VideoType.demo:
        return '🖥️';
      case VideoType.Review:
        return '🔍';
      case VideoType.testimonial:
        return '⭐';
    }
  }

  String get color {
    switch (this) {
      case VideoType.tutorial:
        return '#2196F3';
      case VideoType.promotional:
        return '#FF9800';
      case VideoType.educational:
        return '#4CAF50';
      case VideoType.entertainment:
        return '#9C27B0';
      case VideoType.documentary:
        return '#607D8B';
      case VideoType.interview:
        return '#F44336';
      case VideoType.presentation:
        return '#00BCD4';
      case VideoType.demo:
        return '#795548';
      case VideoType.Review:
        return '#FF5722';
      case VideoType.testimonial:
        return '#FFC107';
    }
  }

  bool get isEducational {
    return [
      VideoType.tutorial,
      VideoType.educational,
      VideoType.presentation,
    ].contains(this);
  }

  bool get isMarketing {
    return [
      VideoType.promotional,
      VideoType.demo,
      VideoType.testimonial,
    ].contains(this);
  }

  bool get isContent {
    return [
      VideoType.entertainment,
      VideoType.documentary,
      VideoType.interview,
      VideoType.Review,
    ].contains(this);
  }
}

extension VideoQualityExtension on VideoQuality {
  String get displayName {
    switch (this) {
      case VideoQuality.low:
        return 'Düşük';
      case VideoQuality.medium:
        return 'Orta';
      case VideoQuality.high:
        return 'Yüksek';
      case VideoQuality.ultra:
        return 'Ultra';
      case VideoQuality.cinematic:
        return 'Sinematik';
    }
  }

  String get resolution {
    switch (this) {
      case VideoQuality.low:
        return '480p';
      case VideoQuality.medium:
        return '720p';
      case VideoQuality.high:
        return '1080p';
      case VideoQuality.ultra:
        return '4K';
      case VideoQuality.cinematic:
        return '8K';
    }
  }

  String get icon {
    switch (this) {
      case VideoQuality.low:
        return '📱';
      case VideoQuality.medium:
        return '📺';
      case VideoQuality.high:
        return '💻';
      case VideoQuality.ultra:
        return '🖥️';
      case VideoQuality.cinematic:
        return '🎬';
    }
  }

  String get color {
    switch (this) {
      case VideoQuality.low:
        return '#4CAF50';
      case VideoQuality.medium:
        return '#FF9800';
      case VideoQuality.high:
        return '#2196F3';
      case VideoQuality.ultra:
        return '#9C27B0';
      case VideoQuality.cinematic:
        return '#F44336';
    }
  }

  int get bitrate {
    switch (this) {
      case VideoQuality.low:
        return 1000;
      case VideoQuality.medium:
        return 2500;
      case VideoQuality.high:
        return 5000;
      case VideoQuality.ultra:
        return 15000;
      case VideoQuality.cinematic:
        return 25000;
    }
  }

  bool get isHD {
    return [
      VideoQuality.high,
      VideoQuality.ultra,
      VideoQuality.cinematic,
    ].contains(this);
  }

  bool get is4KOrHigher {
    return [
      VideoQuality.ultra,
      VideoQuality.cinematic,
    ].contains(this);
  }
}

extension VideoFormatExtension on VideoFormat {
  String get displayName {
    switch (this) {
      case VideoFormat.mp4:
        return 'MP4';
      case VideoFormat.mov:
        return 'MOV';
      case VideoFormat.avi:
        return 'AVI';
      case VideoFormat.mkv:
        return 'MKV';
      case VideoFormat.webm:
        return 'WebM';
      case VideoFormat.flv:
        return 'FLV';
      case VideoFormat.wmv:
        return 'WMV';
      case VideoFormat.m4v:
        return 'M4V';
    }
  }

  String get mimeType {
    switch (this) {
      case VideoFormat.mp4:
        return 'video/mp4';
      case VideoFormat.mov:
        return 'video/quicktime';
      case VideoFormat.avi:
        return 'video/x-msvideo';
      case VideoFormat.mkv:
        return 'video/x-matroska';
      case VideoFormat.webm:
        return 'video/webm';
      case VideoFormat.flv:
        return 'video/x-flv';
      case VideoFormat.wmv:
        return 'video/x-ms-wmv';
      case VideoFormat.m4v:
        return 'video/x-m4v';
    }
  }

  String get icon {
    switch (this) {
      case VideoFormat.mp4:
        return '🎥';
      case VideoFormat.mov:
        return '🍎';
      case VideoFormat.avi:
        return '📹';
      case VideoFormat.mkv:
        return '📦';
      case VideoFormat.webm:
        return '🌐';
      case VideoFormat.flv:
        return '📺';
      case VideoFormat.wmv:
        return '🪟';
      case VideoFormat.m4v:
        return '📱';
    }
  }

  bool get isWebOptimized {
    return [
      VideoFormat.mp4,
      VideoFormat.webm,
    ].contains(this);
  }

  bool get isAppleFormat {
    return this == VideoFormat.mov;
  }

  bool get isOpenSource {
    return [
      VideoFormat.mkv,
      VideoFormat.webm,
    ].contains(this);
  }
}

extension LoRAStatusExtension on LoRAStatus {
  String get displayName {
    switch (this) {
      case LoRAStatus.training:
        return 'Eğitiliyor';
      case LoRAStatus.ready:
        return 'Hazır';
      case LoRAStatus.failed:
        return 'Başarısız';
      case LoRAStatus.testing:
        return 'Test Ediliyor';
      case LoRAStatus.deployed:
        return 'Dağıtıldı';
      case LoRAStatus.archived:
        return 'Arşivlendi';
    }
  }

  String get color {
    switch (this) {
      case LoRAStatus.training:
        return '#FF9800';
      case LoRAStatus.ready:
        return '#4CAF50';
      case LoRAStatus.failed:
        return '#F44336';
      case LoRAStatus.testing:
        return '#2196F3';
      case LoRAStatus.deployed:
        return '#9C27B0';
      case LoRAStatus.archived:
        return '#607D8B';
    }
  }

  String get icon {
    switch (this) {
      case LoRAStatus.training:
        return '🧠';
      case LoRAStatus.ready:
        return '✅';
      case LoRAStatus.failed:
        return '❌';
      case LoRAStatus.testing:
        return '🧪';
      case LoRAStatus.deployed:
        return '🚀';
      case LoRAStatus.archived:
        return '📦';
    }
  }

  bool get isActive {
    return [
      LoRAStatus.training,
      LoRAStatus.testing,
      LoRAStatus.deployed,
    ].contains(this);
  }

  bool get isFinal {
    return [
      LoRAStatus.ready,
      LoRAStatus.failed,
      LoRAStatus.archived,
    ].contains(this);
  }

  bool get isUsable {
    return [
      LoRAStatus.ready,
      LoRAStatus.deployed,
    ].contains(this);
  }

  bool get hasProblem {
    return this == LoRAStatus.failed;
  }
}

extension LoRATypeExtension on LoRAType {
  String get displayName {
    switch (this) {
      case LoRAType.style:
        return 'Stil';
      case LoRAType.character:
        return 'Karakter';
      case LoRAType.concept:
        return 'Konsept';
      case LoRAType.object:
        return 'Nesne';
      case LoRAType.background:
        return 'Arka Plan';
      case LoRAType.lighting:
        return 'Aydınlatma';
      case LoRAType.composition:
        return 'Kompozisyon';
      case LoRAType.color:
        return 'Renk';
    }
  }

  String get description {
    switch (this) {
      case LoRAType.style:
        return 'Görsel stil transferi';
      case LoRAType.character:
        return 'Karakter özellikleri';
      case LoRAType.concept:
        return 'Konsept ve fikirler';
      case LoRAType.object:
        return 'Nesne tanıma ve oluşturma';
      case LoRAType.background:
        return 'Arka Plan ve sahne oluşturma';
      case LoRAType.lighting:
        return 'Işıklandırma efektleri';
      case LoRAType.composition:
        return 'Kompozisyon ve düzen';
      case LoRAType.color:
        return 'Renk paleti ve tonlama';
    }
  }

  String get icon {
    switch (this) {
      case LoRAType.style:
        return '🎨';
      case LoRAType.character:
        return '👤';
      case LoRAType.concept:
        return '💡';
      case LoRAType.object:
        return '📦';
      case LoRAType.background:
        return '🏞️';
      case LoRAType.lighting:
        return '💡';
      case LoRAType.composition:
        return '📐';
      case LoRAType.color:
        return '🌈';
    }
  }

  String get color {
    switch (this) {
      case LoRAType.style:
        return '#9C27B0';
      case LoRAType.character:
        return '#2196F3';
      case LoRAType.concept:
        return '#FF9800';
      case LoRAType.object:
        return '#4CAF50';
      case LoRAType.background:
        return '#00BCD4';
      case LoRAType.lighting:
        return '#FFC107';
      case LoRAType.composition:
        return '#795548';
      case LoRAType.color:
        return '#E91E63';
    }
  }

  bool get isCreative {
    return [
      LoRAType.style,
      LoRAType.character,
      LoRAType.concept,
    ].contains(this);
  }

  bool get isTechnical {
    return [
      LoRAType.object,
      LoRAType.background,
      LoRAType.lighting,
      LoRAType.composition,
    ].contains(this);
  }

  bool get isAesthetic {
    return [
      LoRAType.style,
      LoRAType.color,
      LoRAType.composition,
    ].contains(this);
  }
}

extension ProcessingStageExtension on ProcessingStage {
  String get displayName {
    switch (this) {
      case ProcessingStage.uploaded:
        return 'Yüklendi';
      case ProcessingStage.transcoding:
        return 'Dönüştürülüyor';
      case ProcessingStage.analysis:
        return 'Analiz Ediliyor';
      case ProcessingStage.thumbnail:
        return 'Küçük Resim';
      case ProcessingStage.optimization:
        return 'Optimize Ediliyor';
      case ProcessingStage.completed:
        return 'Tamamlandı';
    }
  }

  String get description {
    switch (this) {
      case ProcessingStage.uploaded:
        return 'Video başarıyla yüklendi';
      case ProcessingStage.transcoding:
        return 'Video formatları dönüştürülüyor';
      case ProcessingStage.analysis:
        return 'Video içeriği analiz ediliyor';
      case ProcessingStage.thumbnail:
        return 'Küçük resimler oluşturuluyor';
      case ProcessingStage.optimization:
        return 'Video optimize ediliyor';
      case ProcessingStage.completed:
        return 'Tüm işlemler tamamlandı';
    }
  }

  String get icon {
    switch (this) {
      case ProcessingStage.uploaded:
        return '⬆️';
      case ProcessingStage.transcoding:
        return '🔄';
      case ProcessingStage.analysis:
        return '🔍';
      case ProcessingStage.thumbnail:
        return '🖼️';
      case ProcessingStage.optimization:
        return '⚡';
      case ProcessingStage.completed:
        return '✅';
    }
  }

  String get color {
    switch (this) {
      case ProcessingStage.uploaded:
        return '#4CAF50';
      case ProcessingStage.transcoding:
        return '#FF9800';
      case ProcessingStage.analysis:
        return '#2196F3';
      case ProcessingStage.thumbnail:
        return '#9C27B0';
      case ProcessingStage.optimization:
        return '#00BCD4';
      case ProcessingStage.completed:
        return '#4CAF50';
    }
  }

  bool get isActive {
    return [
      ProcessingStage.transcoding,
      ProcessingStage.analysis,
      ProcessingStage.thumbnail,
      ProcessingStage.optimization,
    ].contains(this);
  }

  bool get isCompleted {
    return this == ProcessingStage.completed;
  }

  bool get isInitial {
    return this == ProcessingStage.uploaded;
  }
}

class LoRAConfig {
  final String id;
  final String name;
  final LoRAType type;
  final String description;
  final double strength;
  final int steps;
  final double learningRate;
  final String? triggerWord;
  final List<String> tags;
  final Map<String, dynamic> parameters;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LoRAConfig({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.strength,
    required this.steps,
    required this.learningRate,
    this.triggerWord,
    this.tags = const [],
    this.parameters = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  LoRAConfig copyWith({
    String? id,
    String? name,
    LoRAType? type,
    String? description,
    double? strength,
    int? steps,
    double? learningRate,
    String? triggerWord,
    List<String>? tags,
    Map<String, dynamic>? parameters,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LoRAConfig(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      strength: strength ?? this.strength,
      steps: steps ?? this.steps,
      learningRate: learningRate ?? this.learningRate,
      triggerWord: triggerWord ?? this.triggerWord,
      tags: tags ?? this.tags,
      parameters: parameters ?? this.parameters,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get hasTriggerWord {
    return triggerWord != null && triggerWord!.isNotEmpty;
  }

  bool get hasTags {
    return tags.isNotEmpty;
  }

  bool get hasParameters {
    return parameters.isNotEmpty;
  }

  String get strengthDisplay {
    return '${strength.toStringAsFixed(2)}';
  }

  String get learningRateDisplay {
    return '${(learningRate * 1000000).toStringAsFixed(0)}e-6';
  }

  void addTag(String Tag) {
    if (!tags.contains(Tag)) {
      tags.add(Tag);
    }
  }

  void removeTag(String Tag) {
    tags.remove(Tag);
  }

  void setParameter(String key, dynamic value) {
    parameters[key] = value;
  }

  T? getParameter<T>(String key) {
    return parameters[key] as T?;
  }
}

class VideoContentEntity {
  String id;
  String orgId;
  String title;
  String? description;
  VideoType type;
  VideoStatus status;
  VideoQuality quality;
  VideoFormat format;
  String filePath;
  String? thumbnailPath;
  int duration;
  int fileSize;
  double aspectRatio;
  int width;
  int height;
  double frameRate;
  String? codec;
  double bitrate;
  String? createdBy;
  List<String> tags;
  List<String> categories;
  ProcessingStage processingStage;
  double processingProgress;
  String? errorMessage;
  bool isPublic;
  bool isFeatured;
  int viewCount;
  int likeCount;
  int commentCount;
  DateTime? publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  LoRAConfig? loraConfig;
  Map<String, dynamic> metadata;

  VideoContentEntity({
    required this.id,
    required this.orgId,
    required this.title,
    this.description,
    required this.type,
    required this.status,
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
    required this.processingStage,
    this.processingProgress = 0.0,
    this.errorMessage,
    this.isPublic = false,
    this.isFeatured = false,
    this.viewCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.loraConfig,
    this.metadata = const {},
  });

  VideoContentEntity copyWith({
    String? id,
    String? orgId,
    String? title,
    String? description,
    VideoType? type,
    VideoStatus? status,
    VideoQuality? quality,
    VideoFormat? format,
    String? filePath,
    String? thumbnailPath,
    int? duration,
    int? fileSize,
    double? aspectRatio,
    int? width,
    int? height,
    double? frameRate,
    String? codec,
    double? bitrate,
    String? createdBy,
    List<String>? tags,
    List<String>? categories,
    ProcessingStage? processingStage,
    double? processingProgress,
    String? errorMessage,
    bool? isPublic,
    bool? isFeatured,
    int? viewCount,
    int? likeCount,
    int? commentCount,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    LoRAConfig? loraConfig,
    Map<String, dynamic>? metadata,
  }) {
    return VideoContentEntity(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      quality: quality ?? this.quality,
      format: format ?? this.format,
      filePath: filePath ?? this.filePath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      duration: duration ?? this.duration,
      fileSize: fileSize ?? this.fileSize,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      width: width ?? this.width,
      height: height ?? this.height,
      frameRate: frameRate ?? this.frameRate,
      codec: codec ?? this.codec,
      bitrate: bitrate ?? this.bitrate,
      createdBy: createdBy ?? this.createdBy,
      tags: tags ?? this.tags,
      categories: categories ?? this.categories,
      processingStage: processingStage ?? this.processingStage,
      processingProgress: processingProgress ?? this.processingProgress,
      errorMessage: errorMessage ?? this.errorMessage,
      isPublic: isPublic ?? this.isPublic,
      isFeatured: isFeatured ?? this.isFeatured,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      publishedAt: publishedAt ?? this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      loraConfig: loraConfig ?? this.loraConfig,
      metadata: metadata ?? this.metadata,
    );
  }

  // Helper methods
  bool get isActive {
    return status.isActive;
  }

  bool get isFinal {
    return status.isFinal;
  }

  bool get isAccessible {
    return status.isAccessible;
  }

  bool get hasProblem {
    return status.hasProblem;
  }

  bool get isProcessing {
    return processingStage.isActive;
  }

  bool get isProcessingCompleted {
    return processingStage.isCompleted;
  }

  bool get hasDescription {
    return description != null && description!.isNotEmpty;
  }

  bool get hasThumbnail {
    return thumbnailPath != null && thumbnailPath!.isNotEmpty;
  }

  bool get hasCodec {
    return codec != null && codec!.isNotEmpty;
  }

  bool get hasCreator {
    return createdBy != null;
  }

  bool get hasTags {
    return tags.isNotEmpty;
  }

  bool get hasCategories {
    return categories.isNotEmpty;
  }

  bool get hasError {
    return errorMessage != null && errorMessage!.isNotEmpty;
  }

  bool get isPublished {
    return publishedAt != null;
  }

  bool get isDeleted {
    return deletedAt != null;
  }

  bool get hasLoRAConfig {
    return loraConfig != null;
  }

  bool get isHD {
    return quality.isHD;
  }

  bool get is4KOrHigher {
    return quality.is4KOrHigher;
  }

  bool get isWebOptimized {
    return format.isWebOptimized;
  }

  bool get isEducational {
    return type.isEducational;
  }

  bool get isMarketing {
    return type.isMarketing;
  }

  bool get isContent {
    return type.isContent;
  }

  bool get hasEngagement {
    return viewCount > 0 || likeCount > 0 || commentCount > 0;
  }

  bool get isPopular {
    return viewCount > 1000 || likeCount > 100;
  }

  bool get isViral {
    return viewCount > 10000 || likeCount > 1000;
  }

  String get durationDisplay {
    final hours = duration ~/ 3600;
    final minutes = (duration % 3600) ~/ 60;
    final seconds = duration % 60;
    
    if (hours > 0) {
      return '${hours}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  String get fileSizeDisplay {
    if (fileSize < 1024 * 1024) {
      return '${(fileSize / 1024).toStringAsFixed(1)} MB';
    } else {
      return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  String get resolutionDisplay {
    return '${width}x$height';
  }

  String get frameRateDisplay {
    return '${frameRate.toStringAsFixed(2)} fps';
  }

  String get bitrateDisplay {
    if (bitrate < 1000) {
      return '${bitrate.toStringAsFixed(0)} kbps';
    } else {
      return '${(bitrate / 1000).toStringAsFixed(1)} Mbps';
    }
  }

  String get processingProgressDisplay {
    return '${(processingProgress * 100).toStringAsFixed(1)}%';
  }

  String get typeDisplay {
    return type.displayName;
  }

  String get statusDisplay {
    return status.displayName;
  }

  String get qualityDisplay {
    return quality.displayName;
  }

  String get formatDisplay {
    return format.displayName;
  }

  String get processingStageDisplay {
    return processingStage.displayName;
  }

  String get engagementDisplay {
    return '👁️ $viewCount ❤️ $likeCount 💬 $commentCount';
  }

  void publish() {
    publishedAt = DateTime.now();
    isPublic = true;
  }

  void unpublish() {
    publishedAt = null;
    isPublic = false;
  }

  void feature() {
    isFeatured = true;
  }

  void unfeature() {
    isFeatured = false;
  }

  void delete() {
    deletedAt = DateTime.now();
    status = VideoStatus.deleted;
  }

  void restore() {
    deletedAt = null;
    status = VideoStatus.ready;
  }

  void updateProcessingStage(ProcessingStage newStage, {double? progress}) {
    processingStage = newStage;
    if (progress != null) {
      processingProgress = progress;
    }
    
    if (newStage.isCompleted) {
      status = VideoStatus.ready;
      processingProgress = 1.0;
    }
  }

  void setError(String error) {
    errorMessage = error;
    status = VideoStatus.failed;
    processingStage = ProcessingStage.completed;
  }

  void incrementViewCount() {
    viewCount++;
  }

  void incrementLikeCount() {
    likeCount++;
  }

  void decrementLikeCount() {
    if (likeCount > 0) likeCount--;
  }

  void incrementCommentCount() {
    commentCount++;
  }

  void addTag(String Tag) {
    if (!tags.contains(Tag)) {
      tags.add(Tag);
    }
  }

  void removeTag(String Tag) {
    tags.remove(Tag);
  }

  void addCategory(String category) {
    if (!categories.contains(category)) {
      categories.add(category);
    }
  }

  void removeCategory(String category) {
    categories.remove(category);
  }

  void setLoRAConfig(LoRAConfig config) {
    loraConfig = config;
  }

  void removeLoRAConfig() {
    loraConfig = null;
  }

  T? getMetadata<T>(String key) {
    return metadata[key] as T?;
  }

  void setMetadata(String key, dynamic value) {
    metadata[key] = value;
  }

  bool hasMetadata(String key) {
    return metadata.containsKey(key);
  }

  bool wasCreatedRecently() {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    return createdAt.isAfter(sevenDaysAgo);
  }

  bool wasUpdatedRecently() {
    final now = DateTime.now();
    final oneDayAgo = now.subtract(const Duration(days: 1));
    return updatedAt.isAfter(oneDayAgo);
  }

  bool wasPublishedRecently() {
    if (!isPublished) return false;
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    return publishedAt!.isAfter(sevenDaysAgo);
  }
}
