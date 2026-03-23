import 'package:flutter/material.dart';
import '../../domain/entities/video_content_entity.dart';

class VideoCardWidget extends StatelessWidget {
  final VideoContentEntity video;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final VoidCallback onShare;
  final VoidCallback onDownload;
  final VoidCallback onDelete;

  const VideoCardWidget({
    super.key,
    required this.video,
    required this.onTap,
    required this.onLike,
    required this.onShare,
    required this.onDownload,
    required this.onDelete,
  });

  
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      image: video.thumbnailUrl != null
                          ? DecorationImage(
                              image: NetworkImage(video.thumbnailUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: Colors.grey[300],
                    ),
                    child: video.thumbnailUrl == null
                        ? const Center(
                            child: Icon(Icons.video_library, size: 48, color: Colors.grey),
                          )
                        : null,
                  ),
                  
                  // Play button overlay
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  
                  // Duration badge
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _formatDuration(video.duration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Video info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.description ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    
                    // Stats and actions
                    Row(
                      children: [
                        Icon(Icons.visibility, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 2),
                        Text(
                          _formatViewCount(video.viewCount),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            video.isLiked ? Icons.Favorite : Icons.favorite_border,
                            color: video.isLiked ? Colors.red : Colors.grey[600],
                            size: 16,
                          ),
                          onPressed: onLike,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            switch (value) {
                              case 'share':
                                onShare();
                                break;
                              case 'download':
                                onDownload();
                                break;
                              case 'delete':
                                onDelete();
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'share', child: Text('Share')),
                            const PopupMenuItem(value: 'download', child: Text('Download')),
                            const PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                          child: Icon(Icons.more_vert, size: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String _formatViewCount(int viewCount) {
    if (viewCount < 1000) {
      return viewCount.toString();
    } else if (viewCount < 1000000) {
      return '${(viewCount / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(viewCount / 1000000).toStringAsFixed(1)}M';
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  final List<VideoSegment>? segments;
  final List<Subtitle>? subtitles;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
    this.segments,
    this.subtitles,
  });

  
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool _isPlaying = false;
  bool _isMuted = false;
  Duration _position = Duration.zero;
  Duration _duration = const Duration(minutes: 5); // Mock duration
  bool _isBuffering = false;
  String _currentSubtitle = '';

  
  void initState() {
    super.initState();
    // Simulate position updates for subtitle demonstration
    _startPositionSimulation();
  }

  void _startPositionSimulation() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (_isPlaying && mounted) {
        setState(() {
          _position += const Duration(milliseconds: 500);
          if (_position >= _duration) {
            _position = Duration.zero;
            _isPlaying = false;
          }
          _updateSubtitle();
        });
      }
      return mounted;
    });
  }

  void _updateSubtitle() {
    if (widget.subtitles == null || widget.subtitles!.isEmpty) return;
    
    final currentSub = widget.subtitles!.firstWhere(
      (s) => _position >= s.start && _position <= s.end,
      orElse: () => const Subtitle(text: '', start: Duration.zero, end: Duration.zero),
    );
    
    if (_currentSubtitle != currentSub.text) {
      _currentSubtitle = currentSub.text;
    }
  }

  
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Video segments bar
        if (widget.segments != null && widget.segments!.isNotEmpty)
          _buildSegmentsBar(),
          
        Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Video player placeholder
              if (widget.thumbnailUrl != null && !_isPlaying)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.thumbnailUrl!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              
              // Subtitle Overlay
              if (_currentSubtitle.isNotEmpty)
                Positioned(
                  bottom: 60,
                  left: 20,
                  right: 20,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _currentSubtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              
              // Controls overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Play/Pause button
                      GestureDetector(
                        onTap: _togglePlayPause,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Progress bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                trackHeight: 3,
                                activeTrackColor: Colors.red,
                                inactiveTrackColor: Colors.white24,
                                thumbColor: Colors.red,
                                overlayColor: Colors.red.withOpacity(0.2),
                              ),
                              child: Slider(
                                value: _position.inSeconds.toDouble(),
                                max: _duration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  setState(() {
                                    _position = Duration(seconds: value.toInt());
                                    _updateSubtitle();
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDuration(_position),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _formatDuration(_duration),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Buffering indicator
              if (_isBuffering)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentsBar() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.segments!.length,
        itemBuilder: (context, index) {
          final segment = widget.segments![index];
          final isActive = _position >= segment.startTime && 
                          (index == widget.segments!.length - 1 || 
                           _position < widget.segments![index + 1].startTime);
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(
                segment.name,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black87,
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              backgroundColor: isActive ? Colors.red : Colors.grey[200],
              onPressed: () {
                setState(() {
                  _position = segment.startTime;
                  _isPlaying = true;
                  _updateSubtitle();
                });
              },
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
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

class VideoUploadWidget extends StatefulWidget {
  final Function(String, String, String) onUpload;

  const VideoUploadWidget({super.key, required this.onUpload});

  
  State<VideoUploadWidget> createState() => _VideoUploadWidgetState();
}

class _VideoUploadWidgetState extends State<VideoUploadWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedFilePath;
  bool _isUploading = false;

  
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Upload Video'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // File selection
                GestureDetector(
                  onTap: _selectVideoFile,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: _selectedFilePath != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.video_file, size: 48, color: Colors.blue),
                              const SizedBox(height: 8),
                              Text(
                                _selectedFilePath!.split('/').last,
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload, size: 48, color: Colors.grey[400]),
                              const SizedBox(height: 8),
                              Text(
                                'Tap to select video file',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value?.isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                
                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _selectedFilePath != null && !_isUploading ? _uploadVideo : null,
          child: _isUploading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Upload'),
        ),
      ],
    );
  }

  void _selectVideoFile() {
    // TODO: Implement file picker
    setState(() {
      _selectedFilePath = '/path/to/video.mp4'; // Placeholder
    });
  }

  void _uploadVideo() {
    if (_formKey.currentState!.validate() && _selectedFilePath != null) {
      setState(() {
        _isUploading = true;
      });

      widget.onUpload(
        _selectedFilePath!,
        _titleController.text,
        _descriptionController.text,
      );

      // Simulate upload completion
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isUploading = false;
        });
        Navigator.pop(context);
      });
    }
  }
}

class VideoSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const VideoSearchWidget({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search videos...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onSearch('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        onChanged: onSearch,
      ),
    );
  }
}

class VideoCategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const VideoCategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) => onTap(),
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.red.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? Colors.red : Colors.grey[700],
        fontSize: 12,
      ),
      side: BorderSide(
        color: isSelected ? Colors.red : Colors.grey[300]!,
      ),
    );
  }
}

class VideoStatsWidget extends StatelessWidget {
  final VideoContentEntity video;

  const VideoStatsWidget({super.key, required this.video});

  
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat('Views', video.viewCount.toString(), Icons.visibility),
          _buildStat('Likes', video.likeCount.toString(), Icons.thumb_up),
          _buildStat('Duration', _formatDuration(video.duration), Icons.schedule),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
