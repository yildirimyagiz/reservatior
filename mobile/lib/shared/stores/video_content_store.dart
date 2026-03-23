
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class VideoContentStore extends ModelStreamStore<String, VideoContent> {

  static VideoContentStore? _instance;

  static VideoContentStore get instance {
    _instance ??= VideoContentStore();
    return _instance!;
  }

  VideoContentStore() : super(VideoContent.fromJson) {
    if (_instance != null) {
        throw Exception(
            'VideoContentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending VideoContentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use VideoContentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getVideoContentId(VideoContent videoContent) => videoContent.id;

	String? getVideoContentOrgId(VideoContent videoContent) => videoContent.orgId;

	String? getVideoContentPropertyId(VideoContent videoContent) => videoContent.propertyId;

	String? getVideoContentListingId(VideoContent videoContent) => videoContent.listingId;

	String? getVideoContentAmbassadorId(VideoContent videoContent) => videoContent.ambassadorId;

	String? getVideoContentAmbassadorCampaignId(VideoContent videoContent) => videoContent.ambassadorCampaignId;

	String? getVideoContentTitle(VideoContent videoContent) => videoContent.title;

	VideoLoraStyle? getVideoContentPrimaryLoraStyle(VideoContent videoContent) => videoContent.primaryLoraStyle;

	VideoLoraStyle? getVideoContentSecondaryLoraStyle(VideoContent videoContent) => videoContent.secondaryLoraStyle;

	double? getVideoContentPrimaryLoraScale(VideoContent videoContent) => videoContent.primaryLoraScale;

	double? getVideoContentSecondaryLoraScale(VideoContent videoContent) => videoContent.secondaryLoraScale;

	VideoPipeline? getVideoContentPipeline(VideoContent videoContent) => videoContent.pipeline;

	String? getVideoContentPrompt(VideoContent videoContent) => videoContent.prompt;

	String? getVideoContentNegativePrompt(VideoContent videoContent) => videoContent.negativePrompt;

	VideoLoraStrategy? getVideoContentStrategy(VideoContent videoContent) => videoContent.strategy;

	int? getVideoContentDurationSeconds(VideoContent videoContent) => videoContent.durationSeconds;

	VideoTargetPlatform? getVideoContentPlatform(VideoContent videoContent) => videoContent.platform;

	VideoContentStatus? getVideoContentStatus(VideoContent videoContent) => videoContent.status;

	String? getVideoContentRenderingJobId(VideoContent videoContent) => videoContent.renderingJobId;

	String? getVideoContentStorageKey(VideoContent videoContent) => videoContent.storageKey;

	String? getVideoContentUrl(VideoContent videoContent) => videoContent.url;

	String? getVideoContentThumbnailUrl(VideoContent videoContent) => videoContent.thumbnailUrl;

	int? getVideoContentFileSize(VideoContent videoContent) => videoContent.fileSize;

	String? getVideoContentMimeType(VideoContent videoContent) => videoContent.mimeType;

	DateTime? getVideoContentPublishedAt(VideoContent videoContent) => videoContent.publishedAt;

	dynamic? getVideoContentEngagementData(VideoContent videoContent) => videoContent.engagementData;

	VideoCampaignType? getVideoContentCampaignType(VideoContent videoContent) => videoContent.campaignType;

	String? getVideoContentAbTestGroup(VideoContent videoContent) => videoContent.abTestGroup;

	String? getVideoContentCreatedBy(VideoContent videoContent) => videoContent.createdBy;

	DateTime? getVideoContentCreatedAt(VideoContent videoContent) => videoContent.createdAt;

	DateTime? getVideoContentUpdatedAt(VideoContent videoContent) => videoContent.updatedAt;

	DateTime? getVideoContentDeletedAt(VideoContent videoContent) => videoContent.deletedAt;

	String? getVideoContentCampaignId(VideoContent videoContent) => videoContent.campaignId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<VideoContent> getByOrgId(
    String orgId,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByPropertyId(
    String propertyId,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByListingId(
    String listingId,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByAmbassadorId(
    String ambassadorId,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentAmbassadorId, ambassadorId, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByAmbassadorCampaignId(
    String ambassadorCampaignId,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentAmbassadorCampaignId, ambassadorCampaignId, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByTitle(
    String title,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentTitle, title, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByPrimaryLoraStyle(
    VideoLoraStyle primaryLoraStyle,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentPrimaryLoraStyle, primaryLoraStyle, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getBySecondaryLoraStyle(
    VideoLoraStyle secondaryLoraStyle,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentSecondaryLoraStyle, secondaryLoraStyle, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByPrimaryLoraScale(
    double primaryLoraScale,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentPrimaryLoraScale, primaryLoraScale, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getBySecondaryLoraScale(
    double secondaryLoraScale,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentSecondaryLoraScale, secondaryLoraScale, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByPipeline(
    VideoPipeline pipeline,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentPipeline, pipeline, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByPrompt(
    String prompt,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentPrompt, prompt, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByNegativePrompt(
    String negativePrompt,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentNegativePrompt, negativePrompt, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByStrategy(
    VideoLoraStrategy strategy,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentStrategy, strategy, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByDurationSeconds(
    int durationSeconds,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentDurationSeconds, durationSeconds, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByPlatform(
    VideoTargetPlatform platform,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentPlatform, platform, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByStatus(
    VideoContentStatus status,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentStatus, status, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByRenderingJobId(
    String renderingJobId,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentRenderingJobId, renderingJobId, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByStorageKey(
    String storageKey,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentStorageKey, storageKey, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByUrl(
    String url,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentUrl, url, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByThumbnailUrl(
    String thumbnailUrl,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentThumbnailUrl, thumbnailUrl, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByFileSize(
    int fileSize,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentFileSize, fileSize, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByMimeType(
    String mimeType,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentMimeType, mimeType, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByPublishedAt(
    DateTime publishedAt,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentPublishedAt, publishedAt, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByEngagementData(
    dynamic engagementData,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentEngagementData, engagementData, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByCampaignType(
    VideoCampaignType campaignType,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentCampaignType, campaignType, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByAbTestGroup(
    String abTestGroup,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentAbTestGroup, abTestGroup, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByCreatedBy(
    String createdBy,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<VideoContent> getByCampaignId(
    String campaignId,
    {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}
    ) =>
    getManyIncluding(getVideoContentCampaignId, campaignId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    VideoContent videoContent, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (videoContent.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(videoContent.orgId!, includes: includes);
        videoContent.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    VideoContent videoContent, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (videoContent.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(videoContent.propertyId!, includes: includes);
        videoContent.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

	Listing? getListing(
    VideoContent videoContent, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (videoContent.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(videoContent.listingId!, includes: includes);
        videoContent.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	BrandAmbassador? getAmbassador(
    VideoContent videoContent, {ModelFilter? modelFilter, List<BrandAmbassadorInclude>? includes}) {
    if (videoContent.ambassadorId == null) {
        return null;
    } else {
        final ambassador = BrandAmbassadorStore.instance.getById(videoContent.ambassadorId!, includes: includes);
        videoContent.ambassador = ambassador;
        // setIncludedReferences(ambassador, includes: includes);
        return ambassador;
    }
}

	AmbassadorCampaign? getAmbassadorCampaign(
    VideoContent videoContent, {ModelFilter? modelFilter, List<AmbassadorCampaignInclude>? includes}) {
    if (videoContent.ambassadorCampaignId == null) {
        return null;
    } else {
        final ambassadorCampaign = AmbassadorCampaignStore.instance.getById(videoContent.ambassadorCampaignId!, includes: includes);
        videoContent.ambassadorCampaign = ambassadorCampaign;
        // setIncludedReferences(ambassadorCampaign, includes: includes);
        return ambassadorCampaign;
    }
}

	AmbassadorCampaign? getCampaign(
    VideoContent videoContent, {ModelFilter? modelFilter, List<AmbassadorCampaignInclude>? includes}) {
    if (videoContent.campaignId == null) {
        return null;
    } else {
        final campaign = AmbassadorCampaignStore.instance.getById(videoContent.campaignId!, includes: includes);
        videoContent.campaign = campaign;
        // setIncludedReferences(campaign, includes: includes);
        return campaign;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<VideoContent>> getAll$({bool useCache = true, ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: VideoContentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<VideoContent?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getVideoContentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<VideoContent>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByAmbassadorId$(
        String ambassadorId,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentAmbassadorId,
        value: ambassadorId,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByAmbassadorId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByAmbassadorCampaignId$(
        String ambassadorCampaignId,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentAmbassadorCampaignId,
        value: ambassadorCampaignId,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByAmbassadorCampaignId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByPrimaryLoraStyle$(
        VideoLoraStyle primaryLoraStyle,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<VideoLoraStyle>(
        getPropVal: getVideoContentPrimaryLoraStyle,
        value: primaryLoraStyle,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByPrimaryLoraStyle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getBySecondaryLoraStyle$(
        VideoLoraStyle secondaryLoraStyle,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<VideoLoraStyle>(
        getPropVal: getVideoContentSecondaryLoraStyle,
        value: secondaryLoraStyle,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyBySecondaryLoraStyle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByPrimaryLoraScale$(
        double primaryLoraScale,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getVideoContentPrimaryLoraScale,
        value: primaryLoraScale,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByPrimaryLoraScale,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getBySecondaryLoraScale$(
        double secondaryLoraScale,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getVideoContentSecondaryLoraScale,
        value: secondaryLoraScale,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyBySecondaryLoraScale,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByPipeline$(
        VideoPipeline pipeline,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<VideoPipeline>(
        getPropVal: getVideoContentPipeline,
        value: pipeline,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByPipeline,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByPrompt$(
        String prompt,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentPrompt,
        value: prompt,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByPrompt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByNegativePrompt$(
        String negativePrompt,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentNegativePrompt,
        value: negativePrompt,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByNegativePrompt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByStrategy$(
        VideoLoraStrategy strategy,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<VideoLoraStrategy>(
        getPropVal: getVideoContentStrategy,
        value: strategy,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByStrategy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByDurationSeconds$(
        int durationSeconds,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getVideoContentDurationSeconds,
        value: durationSeconds,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByDurationSeconds,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByPlatform$(
        VideoTargetPlatform platform,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<VideoTargetPlatform>(
        getPropVal: getVideoContentPlatform,
        value: platform,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByPlatform,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByStatus$(
        VideoContentStatus status,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<VideoContentStatus>(
        getPropVal: getVideoContentStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByRenderingJobId$(
        String renderingJobId,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentRenderingJobId,
        value: renderingJobId,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByRenderingJobId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByStorageKey$(
        String storageKey,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentStorageKey,
        value: storageKey,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByStorageKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByUrl$(
        String url,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentUrl,
        value: url,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByThumbnailUrl$(
        String thumbnailUrl,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentThumbnailUrl,
        value: thumbnailUrl,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByThumbnailUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByFileSize$(
        int fileSize,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getVideoContentFileSize,
        value: fileSize,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByFileSize,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByMimeType$(
        String mimeType,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentMimeType,
        value: mimeType,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByMimeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByPublishedAt$(
        DateTime publishedAt,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVideoContentPublishedAt,
        value: publishedAt,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByPublishedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByEngagementData$(
        dynamic engagementData,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getVideoContentEngagementData,
        value: engagementData,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByEngagementData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByCampaignType$(
        VideoCampaignType campaignType,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<VideoCampaignType>(
        getPropVal: getVideoContentCampaignType,
        value: campaignType,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByCampaignType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByAbTestGroup$(
        String abTestGroup,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentAbTestGroup,
        value: abTestGroup,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByAbTestGroup,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVideoContentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVideoContentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVideoContentDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VideoContent>> getByCampaignId$(
        String campaignId,
        {bool useCache = true,
        ModelFilter<VideoContent>? modelFilter,
        List<VideoContentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVideoContentCampaignId,
        value: campaignId,
        modelFilter: modelFilter,
        endpoint: VideoContentEndpoints.getManyByCampaignId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    VideoContent videoContent, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (videoContent.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            videoContent.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            videoContent.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    VideoContent videoContent, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (videoContent.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            videoContent.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            videoContent.property = property;
        });
    }
}

	Stream<Listing?> getListing$(
    VideoContent videoContent, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (videoContent.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            videoContent.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            videoContent.listing = listing;
        });
    }
}

	Stream<BrandAmbassador?> getAmbassador$(
    VideoContent videoContent, {bool useCache = true, ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}) {
    if (videoContent.ambassadorId == null) {
        return Stream.value(null);
    } else {
        return BrandAmbassadorStore.instance.getById$(
            videoContent.ambassadorId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((ambassador) {
            videoContent.ambassador = ambassador;
        });
    }
}

	Stream<AmbassadorCampaign?> getAmbassadorCampaign$(
    VideoContent videoContent, {bool useCache = true, ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}) {
    if (videoContent.ambassadorCampaignId == null) {
        return Stream.value(null);
    } else {
        return AmbassadorCampaignStore.instance.getById$(
            videoContent.ambassadorCampaignId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((ambassadorCampaign) {
            videoContent.ambassadorCampaign = ambassadorCampaign;
        });
    }
}

	Stream<AmbassadorCampaign?> getCampaign$(
    VideoContent videoContent, {bool useCache = true, ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}) {
    if (videoContent.campaignId == null) {
        return Stream.value(null);
    } else {
        return AmbassadorCampaignStore.instance.getById$(
            videoContent.campaignId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((campaign) {
            videoContent.campaign = campaign;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
VideoContent recursiveUpsert(VideoContent videoContent, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'VideoContent'} 
        : const {};
    if (videoContent.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        videoContent.org = OrganizationStore.instance.recursiveUpsert(videoContent.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (videoContent.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        videoContent.property = PropertyStore.instance.recursiveUpsert(videoContent.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (videoContent.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        videoContent.listing = ListingStore.instance.recursiveUpsert(videoContent.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (videoContent.ambassador != null && (!preventCircularSerialization || !upsertedTypes.contains('BrandAmbassador'))) {
        videoContent.ambassador = BrandAmbassadorStore.instance.recursiveUpsert(videoContent.ambassador!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (videoContent.ambassadorCampaign != null && (!preventCircularSerialization || !upsertedTypes.contains('AmbassadorCampaign'))) {
        videoContent.ambassadorCampaign = AmbassadorCampaignStore.instance.recursiveUpsert(videoContent.ambassadorCampaign!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (videoContent.campaign != null && (!preventCircularSerialization || !upsertedTypes.contains('AmbassadorCampaign'))) {
        videoContent.campaign = AmbassadorCampaignStore.instance.recursiveUpsert(videoContent.campaign!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(videoContent);
}

  List<VideoContent> recursiveListUpsert(List<VideoContent> videoContents, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedVideoContents = <VideoContent>[];
    for (var videoContent in videoContents) {
        updatedVideoContents.add(recursiveUpsert(videoContent, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedVideoContents;
}

//   @override
//   VideoContent upsert(VideoContent item) {
//     return recursiveUpsert(item);
//   }

}


class VideoContentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      VideoContentInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (videoContent) => VideoContentStore.instance
            .getOrg$(videoContent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (videoContent) => VideoContentStore.instance
            .getOrg(videoContent, modelFilter: modelFilter, includes: includes);
      }
}

	VideoContentInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (videoContent) => VideoContentStore.instance
            .getProperty$(videoContent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (videoContent) => VideoContentStore.instance
            .getProperty(videoContent, modelFilter: modelFilter, includes: includes);
      }
}

	VideoContentInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (videoContent) => VideoContentStore.instance
            .getListing$(videoContent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (videoContent) => VideoContentStore.instance
            .getListing(videoContent, modelFilter: modelFilter, includes: includes);
      }
}

	VideoContentInclude.ambassador({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<BrandAmbassador>? modelFilter,
    List<BrandAmbassadorInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (videoContent) => VideoContentStore.instance
            .getAmbassador$(videoContent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (videoContent) => VideoContentStore.instance
            .getAmbassador(videoContent, modelFilter: modelFilter, includes: includes);
      }
}

	VideoContentInclude.ambassadorCampaign({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AmbassadorCampaign>? modelFilter,
    List<AmbassadorCampaignInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (videoContent) => VideoContentStore.instance
            .getAmbassadorCampaign$(videoContent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (videoContent) => VideoContentStore.instance
            .getAmbassadorCampaign(videoContent, modelFilter: modelFilter, includes: includes);
      }
}

	VideoContentInclude.campaign({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AmbassadorCampaign>? modelFilter,
    List<AmbassadorCampaignInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (videoContent) => VideoContentStore.instance
            .getCampaign$(videoContent, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (videoContent) => VideoContentStore.instance
            .getCampaign(videoContent, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum VideoContentEndpoints implements Endpoint {

    getAll('/videoContent', HttpMethod.post, List<VideoContent>),
	getById('/videoContent/byId/:id', HttpMethod.post, VideoContent),
	getManyByOrgId('/videoContent/byOrgId/:orgId', HttpMethod.post, List<VideoContent>),
	getManyByPropertyId('/videoContent/byPropertyId/:propertyId', HttpMethod.post, List<VideoContent>),
	getManyByListingId('/videoContent/byListingId/:listingId', HttpMethod.post, List<VideoContent>),
	getManyByAmbassadorId('/videoContent/byAmbassadorId/:ambassadorId', HttpMethod.post, List<VideoContent>),
	getManyByAmbassadorCampaignId('/videoContent/byAmbassadorCampaignId/:ambassadorCampaignId', HttpMethod.post, List<VideoContent>),
	getManyByTitle('/videoContent/byTitle/:title', HttpMethod.post, List<VideoContent>),
	getManyByPrimaryLoraStyle('/videoContent/byPrimaryLoraStyle/:primaryLoraStyle', HttpMethod.post, List<VideoContent>),
	getManyBySecondaryLoraStyle('/videoContent/bySecondaryLoraStyle/:secondaryLoraStyle', HttpMethod.post, List<VideoContent>),
	getManyByPrimaryLoraScale('/videoContent/byPrimaryLoraScale/:primaryLoraScale', HttpMethod.post, List<VideoContent>),
	getManyBySecondaryLoraScale('/videoContent/bySecondaryLoraScale/:secondaryLoraScale', HttpMethod.post, List<VideoContent>),
	getManyByPipeline('/videoContent/byPipeline/:pipeline', HttpMethod.post, List<VideoContent>),
	getManyByPrompt('/videoContent/byPrompt/:prompt', HttpMethod.post, List<VideoContent>),
	getManyByNegativePrompt('/videoContent/byNegativePrompt/:negativePrompt', HttpMethod.post, List<VideoContent>),
	getManyByStrategy('/videoContent/byStrategy/:strategy', HttpMethod.post, List<VideoContent>),
	getManyByDurationSeconds('/videoContent/byDurationSeconds/:durationSeconds', HttpMethod.post, List<VideoContent>),
	getManyByPlatform('/videoContent/byPlatform/:platform', HttpMethod.post, List<VideoContent>),
	getManyByStatus('/videoContent/byStatus/:status', HttpMethod.post, List<VideoContent>),
	getManyByRenderingJobId('/videoContent/byRenderingJobId/:renderingJobId', HttpMethod.post, List<VideoContent>),
	getManyByStorageKey('/videoContent/byStorageKey/:storageKey', HttpMethod.post, List<VideoContent>),
	getManyByUrl('/videoContent/byUrl/:url', HttpMethod.post, List<VideoContent>),
	getManyByThumbnailUrl('/videoContent/byThumbnailUrl/:thumbnailUrl', HttpMethod.post, List<VideoContent>),
	getManyByFileSize('/videoContent/byFileSize/:fileSize', HttpMethod.post, List<VideoContent>),
	getManyByMimeType('/videoContent/byMimeType/:mimeType', HttpMethod.post, List<VideoContent>),
	getManyByPublishedAt('/videoContent/byPublishedAt/:publishedAt', HttpMethod.post, List<VideoContent>),
	getManyByEngagementData('/videoContent/byEngagementData/:engagementData', HttpMethod.post, List<VideoContent>),
	getManyByCampaignType('/videoContent/byCampaignType/:campaignType', HttpMethod.post, List<VideoContent>),
	getManyByAbTestGroup('/videoContent/byAbTestGroup/:abTestGroup', HttpMethod.post, List<VideoContent>),
	getManyByCreatedBy('/videoContent/byCreatedBy/:createdBy', HttpMethod.post, List<VideoContent>),
	getManyByCreatedAt('/videoContent/byCreatedAt/:createdAt', HttpMethod.post, List<VideoContent>),
	getManyByUpdatedAt('/videoContent/byUpdatedAt/:updatedAt', HttpMethod.post, List<VideoContent>),
	getManyByDeletedAt('/videoContent/byDeletedAt/:deletedAt', HttpMethod.post, List<VideoContent>),
	getManyByCampaignId('/videoContent/byCampaignId/:campaignId', HttpMethod.post, List<VideoContent>);

    const VideoContentEndpoints(this.path, this.method, this.responseType);

    @override
  final String path;

  @override
  final HttpMethod method;

  final Type responseType;

  static String withPathParameter(String path, dynamic param) {
    final regex = RegExp(r':([a-zA-Z]+)');
    return path.replaceFirst(regex, param.toString());
  }
}
