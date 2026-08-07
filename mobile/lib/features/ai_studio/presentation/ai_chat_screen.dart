import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/ai_studio/data/ai_sse_client.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _ChatEntry {
  bool isUser;
  String text;
  List<Map<String, dynamic>>? properties;
  String? stage;
  bool streaming;

  _ChatEntry({
    required this.isUser,
    required this.text,
    this.streaming = false,
  });
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _entries = <_ChatEntry>[];
  bool _streaming = false;

  static const _client = AiSseClient();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    final query = _controller.text.trim();
    if (query.isEmpty || _streaming) return;
    _controller.clear();
    setState(() {
      _entries.add(_ChatEntry(isUser: true, text: query));
      _entries.add(_ChatEntry(isUser: false, text: '', streaming: true));
      _streaming = true;
    });
    _scrollToBottom();

    final assistant = _entries.last;
    _client.streamSearch(
      query,
      (event) {
        if (!mounted) return;
        setState(() {
          assistant.stage = event.event;
          switch (event.event) {
            case 'stage:started':
              assistant.text =
                  event.data['message'] as String? ?? 'Processing...';
              break;
            case 'stage:intent':
              assistant.text =
                  'Filters: ${jsonEncode(event.data['filters'] ?? {})}';
              break;
            case 'stage:properties':
              final list = event.data['properties'] as List? ?? [];
              assistant.properties =
                  list.cast<Map<String, dynamic>>();
              assistant.text =
                  '${event.data['count'] ?? list.length} properties found.';
              break;
            case 'stage:analysis':
              final text = event.data['text'] as String? ?? '';
              if (text.isNotEmpty) {
                assistant.text = text;
                assistant.properties = null;
              }
              break;
            case 'stage:complete':
              final data = event.data;
              final text = data['text'] as String?;
              if (text != null && text.isNotEmpty) {
                assistant.text = text;
              }
              break;
            case 'stage:error':
              assistant.text =
                  'Error: ${event.data['error'] ?? 'Search failed'}';
              break;
          }
          assistant.streaming = false;
          _streaming = false;
        });
        _scrollToBottom();
      },
      onError: (error) {
        if (!mounted) return;
        setState(() {
          assistant.text = 'Connection error: $error';
          assistant.streaming = false;
          _streaming = false;
        });
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _entries.isEmpty
                  ? _buildEmpty()
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _entries.length,
                      itemBuilder: (context, index) =>
                          _MessageBubble(entry: _entries[index]),
                    ),
            ),
            _buildComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        border: Border(bottom: BorderSide(color: AppColors.darkBorder)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.maybePop(context),
          ),
          const SizedBox(width: 4),
          Icon(Icons.auto_awesome, color: AppColors.primary, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Chat',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                Text(
                  _streaming ? 'Streaming...' : 'Property intelligence assistant',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.auto_awesome, color: AppColors.primary, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            'Describe your dream home',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'e.g. Modern 3-bed with balcony under \$3k',
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
          ),
        ],
      ).animate().fadeIn(),
    );
  }

  Widget _buildComposer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        border: Border(top: BorderSide(color: AppColors.darkBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
              decoration: InputDecoration(
                hintText: 'Ask about properties, market or investment...',
                hintStyle: GoogleFonts.outfit(color: Colors.white38),
                filled: true,
                fillColor: AppColors.darkSurface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: _streaming ? null : _send,
            icon: Icon(
              _streaming ? Icons.hourglass_top : Icons.send,
              color: _streaming ? Colors.white38 : Colors.white,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: AppColors.darkBorder,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final _ChatEntry entry;
  const _MessageBubble({required this.entry});

  @override
  Widget build(BuildContext context) {
    final isUser = entry.isUser;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = isUser ? AppColors.primary : AppColors.darkCard;
    final radius = isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(4),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(16),
          );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.82,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: radius,
              border: isUser
                  ? null
                  : Border.all(color: AppColors.darkBorder),
            ),
            child: Text(
              entry.text.isEmpty && entry.streaming
                  ? 'Thinking...'
                  : entry.text,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
          ),
          if (entry.properties != null && entry.properties!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: entry.properties!
                    .take(3)
                    .map((p) => _PropertyChip(property: p))
                    .toList(),
              ),
            ),
          if (entry.stage != null && !isUser)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(
                entry.stage!.replaceFirst('stage:', ''),
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 10),
              ),
            ),
        ],
      ),
    );
  }
}

class _PropertyChip extends StatelessWidget {
  final Map<String, dynamic> property;
  const _PropertyChip({required this.property});

  @override
  Widget build(BuildContext context) {
    final title = (property['title'] ?? property['name'] ?? 'Property')
        .toString();
    final price = property['price']?.toString() ?? '—';
    final location = (property['city'] ?? property['location'] ?? '')
        .toString();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 0.82,
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.apartment, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  location.isEmpty ? price : '$location · $price',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
