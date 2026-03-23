import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/video_bloc.dart';
import '../../domain/entities/video_content_entity.dart';

// --- STUBS for missing widgets ---
class VideoCardWidget extends StatelessWidget {
  final dynamic video;
  final VoidCallback? onTap;
  final VoidCallback? onLike, onShare, onDownload, onDelete;
  const VideoCardWidget({super.key, this.video, this.onTap, this.onLike, this.onShare, this.onDownload, this.onDelete});
   Widget build(BuildContext context) => Container();
}

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  final List<dynamic>? segments;
  final List<dynamic>? subtitles;
  const VideoPlayerWidget({super.key, required this.videoUrl, this.thumbnailUrl, this.segments, this.subtitles});
   Widget build(BuildContext context) => Container();
}

class VideoUploadWidget extends StatelessWidget {
  final Function(String, String, String) onUpload;
  const VideoUploadWidget({super.key, required this.onUpload});
   Widget build(BuildContext context) => Container();
}

class VideoSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  const VideoSearchWidget({super.key, required this.controller, required this.onSearch});
   Widget build(BuildContext context) => Container();
}

class VideoSegment {
  final String name;
  final Duration startTime;
  const VideoSegment({required this.name, required this.startTime});
}

class Subtitle {
  final String text;
  final Duration start;
  final Duration end;
  const Subtitle({required this.text, required this.start, required this.end});
}
// ---------------------------------

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';
  String _selectedStatus = 'all';

  
  void initState() {
    super.initState();
    context.read<VideoBloc>().add(LoadVideos());
  }

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: () => _showUploadDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Analytics':
                  _showAnalyticsDialog(context);
                  break;
                case 'refresh':
                  context.read<VideoBloc>().add(RefreshVideos());
                  break;
                case 'playlists':
                  _showPlaylistsDialog(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'playlists', child: Text('Playlists')),
              const PopupMenuItem(value: 'Analytics', child: Text('Analytics')),
              const PopupMenuItem(value: 'refresh', child: Text('Refresh')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          VideoSearchWidget(
            controller: _searchController,
            onSearch: (query) {
              if (query.isNotEmpty) {
                context.read<VideoBloc>().add(SearchVideos(query));
              } else {
                context.read<VideoBloc>().add(LoadVideos());
              }
            },
          ),
          
          // Category Filter
          _buildCategoryFilter(),
          
          // Videos List
          Expanded(
            child: BlocBuilder<VideoBloc, VideoState>(
              builder: (context, state) {
                if (state is VideoLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is VideoError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${state.Message}',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<VideoBloc>().add(LoadVideos());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is VideosLoaded || state is VideosSearchLoaded) {
                  final videos = state is VideosLoaded 
                      ? state.videos 
                      : (state as VideosSearchLoaded).videos;
                  
                  if (videos.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_library, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No videos found'),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<VideoBloc>().add(RefreshVideos());
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return VideoCardWidget(
                          video: video,
                          onTap: () => _showVideoPlayer(context, video),
                          onLike: () => _likeVideo(video),
                          onShare: () => _shareVideo(video),
                          onDownload: () => _downloadVideo(video),
                          onDelete: () => _showDeleteConfirmation(context, video),
                        );
                      },
                    ),
                  );
                }

                return const Center(child: Text('No data available'));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUploadDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      {'id': 'all', 'name': 'All', 'icon': Icons.video_library},
      {'id': 'Property', 'name': 'Property', 'icon': Icons.home},
      {'id': 'tour', 'name': 'Virtual Tour', 'icon': Icons.360},
      {'id': 'tutorial', 'name': 'Tutorial', 'icon': Icons.school},
      {'id': 'promotion', 'name': 'Promotion', 'icon': Icons.campaign},
      {'id': 'testimonial', 'name': 'Testimonial', 'icon': Icons.rate_review},
    ];

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category['id'];
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category['id'] as String;
                });
                _applyFilters();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Colors.red.withOpacity(0.2) 
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      size: 16,
                      color: isSelected ? Colors.red : Colors.grey[600],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category['name'] as String,
                      style: TextStyle(
                        color: isSelected ? Colors.red : Colors.grey[700],
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _applyFilters() {
    context.read<VideoBloc>().add(FilterVideos(
      category: _selectedCategory == 'all' ? null : _selectedCategory,
      status: _selectedStatus == 'all' ? null : _selectedStatus,
    ));
  }

  void _showVideoPlayer(BuildContext context, VideoContentEntity video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(video: video),
      ),
    );
  }

  void _showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => VideoUploadWidget(
        onUpload: (filePath, title, description) {
          context.read<VideoBloc>().add(UploadVideo(filePath, title, description));
          Navigator.pop(context);
        },
      ),
    );
  }

  void _likeVideo(VideoContentEntity video) {
    if (video.isLiked) {
      context.read<VideoBloc>().add(UnlikeVideo(video.id));
    } else {
      context.read<VideoBloc>().add(LikeVideo(video.id));
    }
  }

  void _shareVideo(VideoContentEntity video) {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing ${video.title}')),
    );
  }

  void _downloadVideo(VideoContentEntity video) {
    // TODO: Implement download functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading ${video.title}')),
    );
  }

  void _showDeleteConfirmation(BuildContext context, VideoContentEntity video) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete ${video.title}?'),
        content: const Text('Are you sure you want to delete this video? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<VideoBloc>().add(DeleteVideo(video.id));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Videos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'all', child: Text('All Status')),
                DropdownMenuItem(value: 'published', child: Text('Published')),
                DropdownMenuItem(value: 'draft', child: Text('Draft')),
                DropdownMenuItem(value: 'processing', child: Text('Processing')),
                DropdownMenuItem(value: 'failed', child: Text('Failed')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _applyFilters();
            },
            child: const Text('Apply Filters'),
          ),
        ],
      ),
    );
  }

  void _showAnalyticsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Video Analytics'),
        content: const Text('Analytics functionality coming soon'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPlaylistsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Playlists'),
        content: const Text('Playlist functionality coming soon'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final VideoContentEntity video;

  const VideoPlayerScreen({super.key, required this.video});

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Implement download functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Video Player
          VideoPlayerWidget(
            videoUrl: video.videoUrl,
            thumbnailUrl: video.thumbnailUrl,
            segments: const [
              VideoSegment(name: 'Living Room', startTime: Duration.zero),
              VideoSegment(name: 'Kitchen', startTime: Duration(seconds: 45)),
              VideoSegment(name: 'Balcony', startTime: Duration(minutes: 1, seconds: 30)),
              VideoSegment(name: 'Bathroom', startTime: Duration(minutes: 2, seconds: 15)),
            ],
            subtitles: const [
              Subtitle(text: 'Welcome to this beautiful 2-bedroom apartment.', start: Duration.zero, end: Duration(seconds: 5)),
              Subtitle(text: 'As we enter, you\'ll notice the spacious living area.', start: Duration(seconds: 6), end: Duration(seconds: 12)),
              Subtitle(text: 'Large floor-to-ceiling windows provide plenty of natural light.', start: Duration(seconds: 13), end: Duration(seconds: 20)),
              Subtitle(text: 'Now, let\'s move into the modern kitchen area.', start: Duration(seconds: 44), end: Duration(seconds: 50)),
            ],
          ),
          
          // Video Info
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    video.description ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Stats
                  Row(
                    children: [
                      Icon(Icons.visibility, size: 20, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${video.viewCount} views',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.thumb_up, size: 20, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${video.likeCount} likes',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.schedule, size: 20, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(video.createdAt),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement like functionality
                          },
                          icon: const Icon(Icons.thumb_up),
                          label: const Text('Like'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Implement share functionality
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
