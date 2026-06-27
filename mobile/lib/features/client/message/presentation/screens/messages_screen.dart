import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/providers/admin/message_provider.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/providers/hashtag_provider.dart';
import 'package:reservatior/shared/providers/mention_provider.dart';
final dummyOrg = Organization(
  id: 'org1',
  name: 'mobile.leftovers.reservatior_neural'.tr(),
  type: OrgType.AGENCY,
  region: Region.USA_WEST,
  defaultCurrency: 'USD',
  defaultLocale: 'en',
  taxReportingEnabled: false,
  complianceTracking: false,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final messageListProvider = adminMessagesProvider;

class MessagesScreen extends ConsumerStatefulWidget {
  const MessagesScreen({super.key});
  @override
  ConsumerState<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  // AI Concierge State
  bool _isConciergeMode = false;
  final TextEditingController _aiTextController = TextEditingController();
  final List<Map<String, String>> _aiChatHistory = [];
  bool _aiIsTyping = false;
  
  // Triggers / AI Tasks Tracker State
  List<dynamic> _activeTriggers = [];
  bool _isLoadingTriggers = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchTriggers();
  }

  Future<void> _fetchTriggers() async {
    setState(() => _isLoadingTriggers = true);
    try {
      final dio = DioClient();
      final response = await dio.get('/api/v1/system/triggers?userId=u1');
      if (response.statusCode == 200 && response.data['success'] == true) {
        if (mounted) {
          setState(() {
            _activeTriggers = response.data['data'] as List<dynamic>;
          });
        }
      }
    } catch (e) {
      debugPrint("Failed to fetch triggers: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoadingTriggers = false);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _aiTextController.dispose();
    super.dispose();
  }

  Future<void> _handleAiSend() async {
    if (_aiTextController.text.trim().isEmpty) return;
    final userMsg = _aiTextController.text.trim();
    setState(() {
      _aiChatHistory.add({"role": "user", "text": userMsg});
      _aiTextController.clear();
      _aiIsTyping = true;
    });

    try {
      final dio = DioClient();
      final response = await dio.post(
        '/api/v1/ai/concierge',
        data: {
          'message': userMsg,
          'chatHistory': _aiChatHistory,
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        setState(() {
          _aiIsTyping = false;
          _aiChatHistory.add({
            "role": "ai",
            "text": data['reply'] ?? 'mobile.leftovers.i_couldn_t_process_that_could_you_try_ag'.tr()
          });
        });
      } else {
        setState(() {
          _aiIsTyping = false;
          _aiChatHistory.add({
            "role": "ai",
            "text": "Server Error: ${response.statusCode}"
          });
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _aiIsTyping = false;
        _aiChatHistory.add({
          "role": "ai",
          "text": "Network Error. Please check your backend connection. ($e)"
        });
      });
    }
  }

  Future<void> _sendConciergeRequest(String label, String details) async {
    setState(() {
      _aiChatHistory.add({"role": "user", "text": label});
      _aiIsTyping = true;
    });

    try {
      final dio = DioClient();
      await dio.post(
        '/api/v1/concierge/request',
        data: {
          'details': details,
        },
      );

      if (!mounted) return;
      setState(() {
        _aiIsTyping = false;
        _aiChatHistory.add({
          "role": "ai",
          "text": "Talebiniz başarıyla Super App yapay zekamıza iletildi. En kısa sürede organize edilecek!"
        });
      });
      _fetchTriggers(); // Refresh triggers after requesting
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _aiIsTyping = false;
        _aiChatHistory.add({
          "role": "ai",
          "text": "Sistem geçici olarak meşgul, lütfen tekrar deneyin: $e"
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final messagesAsync = ref.watch(messageListProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          _isConciergeMode ? 'mobile.leftovers.estate_concierge'.tr() : 'mobile.message.title'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
            fontSize: 24,
          ),
        ),
        actions: [
          // Mode Toggle Button
          Container(
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: _isConciergeMode ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                _isConciergeMode ? Icons.inbox_rounded : Icons.auto_awesome_rounded,
                color: AppColors.primary,
              ),
              tooltip: _isConciergeMode ? 'mobile.leftovers.switch_to_inbox'.tr() : 'mobile.leftovers.switch_to_concierge'.tr(),
              onPressed: () => setState(() => _isConciergeMode = !_isConciergeMode),
            ),
          ),
          if (!_isConciergeMode)
            IconButton(
              icon: Icon(Icons.edit_square, color: AppColors.primary),
              onPressed: () => _showComposeSheet(context, colors),
            ),
          SizedBox(width: 8),
        ],
        bottom: _isConciergeMode 
          ? null // No search/tabs in Concierge mode
          : PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      style: TextStyle(color: colors.textPrimary, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'mobile.auto.mobile_message_search'.tr(),
                        hintStyle: TextStyle(color: colors.textSecondary),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: colors.textSecondary,
                        ),
                        filled: true,
                        fillColor: colors.card,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: colors.textSecondary,
                    indicatorColor: AppColors.primary,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    tabs: [
                      Tab(text: 'mobile.message.tabAll'.tr()),
                      Tab(text: 'mobile.message.tabUnread'.tr()),
                      Tab(text: 'mobile.message.tabStarred'.tr()),
                    ],
                  ),
                ],
              ),
            ),
      ),
      body: _isConciergeMode 
          ? _buildConciergeView(colors)
          : messagesAsync.when(
              data: (messages) {
                if (messages.isEmpty) return _buildEmptyState(colors);
                final filtered = messages
                    .where(
                      (m) =>
                          _searchQuery.isEmpty ||
                          (m.subject ?? '').toLowerCase().contains(
                            _searchQuery.toLowerCase(),
                          ) ||
                          m.body.toLowerCase().contains(_searchQuery.toLowerCase()),
                    )
                    .toList();
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMessageList(filtered, colors),
                    _buildMessageList(filtered.where((m) => m.isThreadStarter).toList(), colors),
                    _buildMessageList(filtered.where((m) => !m.isThreadStarter).toList(), colors),
                  ],
                );
              },
              loading: () => Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
              error: (e, _) => Center(
                child: Text(
                  '${'mobile.message.error'.tr()}$e',
                  style: TextStyle(color: colors.textSecondary),
                ),
              ),
            ),
    );
  }

  Widget _buildMessageList(List<Message> messages, ThemeAwareColors colors) {
    if (messages.isEmpty) return _buildEmptyState(colors);
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemCount: messages.length,
      separatorBuilder: (_, __) =>
          Divider(height: 1, color: colors.border, indent: 76),
      itemBuilder: (context, index) {
        final msg = messages[index];
        return _buildMessageTile(msg, colors, index);
      },
    );
  }

  Widget _buildMessageTile(Message msg, ThemeAwareColors colors, int index) {
    final isUnread = true; // Placeholder since no status field
    return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: Text(
              (msg.subject ?? 'M')[0].toUpperCase(),
              style: GoogleFonts.outfit(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          title: Text(
            msg.subject ?? 'mobile.message.noSubject'.tr(),
            style: GoogleFonts.outfit(
              fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500,
              color: colors.textPrimary,
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              msg.body,
              style: TextStyle(color: colors.textSecondary, fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(msg.createdAt),
                style: TextStyle(
                  color: isUnread ? AppColors.primary : colors.textSecondary,
                  fontSize: 11,
                  fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              if (isUnread) ...[
                SizedBox(height: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
          onTap: () => _showMessageDetail(context, msg, colors),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 50 * index))
        .slideX(begin: 0.05);
  }

  Widget _buildEmptyState(ThemeAwareColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 64,
            color: colors.textSecondary.withOpacity(0.3),
          ),
          SizedBox(height: 16),
          Text(
            'mobile.message.noMessages'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.textSecondary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'mobile.message.startConversation'.tr(),
            style: TextStyle(
              color: colors.textSecondary.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showMessageDetail(
    BuildContext context,
    Message msg,
    ThemeAwareColors colors,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) => Padding(
          padding: EdgeInsets.all(24),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                msg.subject ?? 'mobile.message.noSubject'.tr(),
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                _formatTime(msg.createdAt),
                style: TextStyle(color: colors.textSecondary, fontSize: 12),
              ),
              SizedBox(height: 20),
              Divider(color: colors.border),
              SizedBox(height: 16),
              FormattedMessageText(text: msg.body, colors: colors),
              if (RegExp(r'#\w+').hasMatch(msg.body)) ...[
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: RegExp(r'#\w+').allMatches(msg.body).map((m) => m.group(0)!).toSet().map((tag) => 
                    ActionChip(
                      label: Text(tag, style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600, fontSize: 12)),
                      backgroundColor: AppColors.gold.withValues(alpha: 0.1),
                      side: BorderSide.none,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Filtreleniyor: $tag'), behavior: SnackBarBehavior.floating));
                      },
                    )
                  ).toList(),
                ),
              ],
              SizedBox(height: 24),
              Text(
                'mobile.auto.quick_actions'.tr(),
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildQuickAction(context, Icons.description_rounded, 'mobile.auto.view_contract'.tr(), colors, onTap: () {}),
                    SizedBox(width: 8),
                    _buildQuickAction(context, Icons.check_circle_rounded, 'mobile.auto.approve_viewing'.tr(), colors, onTap: () {}),
                    SizedBox(width: 8),
                    _buildQuickAction(context, Icons.person_rounded, 'mobile.auto.view_profile'.tr(), colors, onTap: () {}),
                    SizedBox(width: 8),
                    _buildQuickAction(context, Icons.payment_rounded, 'mobile.auto.pending_payments'.tr(), colors, onTap: () {}),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showComposeSheet(
                          context, 
                          colors, 
                          replySubject: 'Re: ${msg.subject ?? ''}',
                        );
                      },
                      icon: Icon(Icons.reply_rounded),
                      label: Text('mobile.message.reply'.tr()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.card,
                        foregroundColor: colors.textPrimary,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: colors.border),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // Loading indicator
                        showDialog(
                          context: context, 
                          barrierDismissible: false,
                          barrierColor: Colors.black45,
                          builder: (c) => Center(
                            child: Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: colors.card,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(color: AppColors.primary),
                                  SizedBox(height: 16),
                                  Text(
                                    'mobile.auto.gemini_is_thinking'.tr(),
                                    style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        
                        String replyText = 'Taslak oluşturulamadı.';
                        try {
                          final dio = DioClient();
                          final response = await dio.post(
                            '/api/v1/ai/concierge',
                            data: {
                              'message': 'Lütfen bu mesaja profesyonel bir yanıt oluştur: ${msg.body}',
                              'chatHistory': [],
                            },
                          );
                          if (response.statusCode == 200 || response.statusCode == 201) {
                             replyText = response.data['reply'] ?? replyText;
                           }
                        } catch (e) {
                          replyText = 'Hata: $e';
                        }
                        if (!context.mounted) return;
                        Navigator.pop(context); // Close loading
                        Navigator.pop(context); // Close detail sheet
                        
                        _showComposeSheet(
                          context,
                          colors,
                          replySubject: 'Re: ${msg.subject ?? ''}',
                          initialBody: replyText,
                        );
                      },
                      icon: Icon(Icons.auto_awesome_rounded),
                      label: Text('mobile.auto.gemini_reply'.tr()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2563EB), 
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  void _pickHashtag(BuildContext context, ThemeAwareColors colors, TextEditingController controller) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.background,
      builder: (ctx) {
        return Consumer(builder: (ctx, ref, child) {
          final hashtagsAsync = ref.watch(hashtagListProvider);
          return hashtagsAsync.when(
            data: (hashtags) {
              return ListView.builder(
                itemCount: hashtags.length,
                itemBuilder: (ctx, i) {
                  final h = hashtags[i];
                  return ListTile(
                    leading: Icon(Icons.tag, color: AppColors.gold),
                    title: Text(h.name, style: TextStyle(color: colors.textPrimary)),
                    onTap: () {
                      Navigator.pop(ctx);
                      final text = controller.text;
                      final pos = controller.selection.baseOffset >= 0 ? controller.selection.baseOffset : text.length;
                      final newText = text.substring(0, pos) + '#' + h.name + ' ' + text.substring(pos);
                      controller.value = TextEditingValue(
                        text: newText,
                        selection: TextSelection.collapsed(offset: pos + h.name.length + 2),
                      );
                    },
                  );
                },
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error loading hashtags', style: TextStyle(color: colors.textPrimary))),
          );
        });
      }
    );
  }


  void _pickMention(BuildContext context, ThemeAwareColors colors, TextEditingController controller) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.background,
      builder: (ctx) {
        return Consumer(builder: (ctx, ref, child) {
          final mentionsAsync = ref.watch(mentionListProvider);
          return mentionsAsync.when(
            data: (mentions) {
              return ListView.builder(
                itemCount: mentions.length,
                itemBuilder: (ctx, i) {
                  final m = mentions[i];
                  return ListTile(
                    leading: Icon(Icons.alternate_email, color: Color(0xFF2563EB)),
                    title: Text(m.mentionedTo.name ?? '', style: TextStyle(color: colors.textPrimary)),
                    onTap: () {
                      Navigator.pop(ctx);
                      final text = controller.text;
                      final pos = controller.selection.baseOffset >= 0 ? controller.selection.baseOffset : text.length;
                      final newText = text.substring(0, pos) + '@' + (m.mentionedTo.name ?? '') + ' ' + text.substring(pos);
                      controller.value = TextEditingValue(
                        text: newText,
                        selection: TextSelection.collapsed(offset: pos + (m.mentionedTo.name?.length ?? 0) + 2),
                      );
                    },
                  );
                },
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error loading mentions', style: TextStyle(color: colors.textPrimary))),
          );
        });
      }
    );
  }

  void _showComposeSheet(BuildContext context, ThemeAwareColors colors, {String? replyTo, String? replySubject, String? initialBody}) {
    final bodyController = TextEditingController(text: initialBody);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'mobile.message.newMessage'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 20),
            Autocomplete<String>(
              initialValue: TextEditingValue(text: replyTo ?? ''),
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                final dummyContacts = [
                  'mobile.leftovers.alice_smith_alice_reservatior_com'.tr(),
                  'mobile.leftovers.bob_johnson_bob_reservatior_com'.tr(),
                  'mobile.leftovers.charlie_davis_charlie_reservatior_com'.tr(),
                  'mobile.leftovers.diana_prince_diana_reservatior_com'.tr(),
                  'mobile.leftovers.evan_wright_evan_reservatior_com'.tr(),
                ];
                return dummyContacts.where((String option) {
                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              },
              fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onEditingComplete: onEditingComplete,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'mobile.auto.mobile_message_to'.tr(),
                    labelStyle: TextStyle(color: colors.textSecondary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colors.border),
                    ),
                  ),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: colors.surface,
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 48,
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        itemCount: options.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return InkWell(
                            onTap: () => onSelected(option),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(option, style: TextStyle(color: colors.textPrimary)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: replySubject),
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                labelText: 'mobile.auto.mobile_message_subject'.tr(),
                labelStyle: TextStyle(color: colors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.border),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: bodyController,
              style: TextStyle(color: colors.textPrimary),
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'mobile.auto.mobile_message_messagelabel'.tr(),
                labelStyle: TextStyle(color: colors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.border),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                ActionChip(
                  avatar: Icon(Icons.alternate_email_rounded, size: 16, color: Color(0xFF2563EB)),
                  label: Text('Kişi Etiketle', style: TextStyle(color: Color(0xFF2563EB), fontSize: 12, fontWeight: FontWeight.bold)),
                  backgroundColor: Color(0xFF2563EB).withValues(alpha: 0.1),
                  side: BorderSide.none,
                  onPressed: () {
                    _pickMention(context, colors, bodyController);
                  },
                ),
                SizedBox(width: 8),
                ActionChip(
                  avatar: Icon(Icons.tag_rounded, size: 16, color: AppColors.gold),
                  label: Text('Konu Etiketle', style: TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.bold)),
                  backgroundColor: AppColors.gold.withValues(alpha: 0.1),
                  side: BorderSide.none,
                  onPressed: () {
                    _pickHashtag(context, colors, bodyController);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final dio = DioClient();
                    await dio.post('/api/v1/message', data: {
                      'subject': replySubject ?? 'No Subject',
                      'body': bodyController.text,
                      'isThreadStarter': replyTo == null,
                    });
                    if (context.mounted) {
                      Navigator.pop(context);
                      ref.invalidate(messageListProvider);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('mobile.auto.message_sent_successfully'.tr()),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                icon: Icon(Icons.send_rounded),
                label: Text('mobile.message.send'.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildConciergeView(ThemeAwareColors colors) {
    return Column(
      children: [
        // AI Greeting Text
        Padding(
          padding: EdgeInsets.all(24.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF2563EB),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text('mobile.auto.hello_i_am_your_personal_real_estate_concierge_how_can_i_help_you_manage_your_portfolio_today'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: colors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'mobile.auto.recent_actions'.tr(),
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildQuickAction(context, Icons.local_taxi_rounded, 'VIP Taksi Çağır', colors, onTap: () => _sendConciergeRequest('VIP Taksi Çağır', 'Lüks VIP Taksi gönderin.')),
                    SizedBox(width: 8),
                    _buildQuickAction(context, Icons.inventory_2_rounded, 'Eşyalarımı Taşı', colors, onTap: () => _sendConciergeRequest('Eşyalarımı Taşı', 'Yeni bir adrese taşınmam gerekiyor, nakliye ayarla.')),
                    SizedBox(width: 8),
                    _buildQuickAction(context, Icons.cleaning_services_rounded, 'Kuru Temizleme', colors, onTap: () => _sendConciergeRequest('Kuru Temizleme', 'Kuru temizleme hizmetine ihtiyacım var.')),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Active AI Tasks Tracker
        if (_isLoadingTriggers)
          Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary))
        else if (_activeTriggers.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome_motion_rounded, color: AppColors.primary, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Aktif AI İşlemleri',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: _activeTriggers.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final task = _activeTriggers[index];
                      final isCompleted = task['status'] == 'FULFILLED' || task['status'] == 'COMPLETED';
                      return Container(
                        width: 260,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colors.card,
                          border: Border.all(color: colors.border),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    task['title'] ?? 'Bilinmeyen İşlem',
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      color: colors.textPrimary,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  isCompleted ? Icons.check_circle_rounded : Icons.sync_rounded,
                                  color: isCompleted ? Colors.green : AppColors.primary,
                                  size: 16,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text(
                              task['description'] ?? '',
                              style: TextStyle(
                                fontSize: 11,
                                color: colors.textSecondary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            if (!isCompleted)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: LinearProgressIndicator(
                                  value: (task['progress'] ?? 50) / 100,
                                  backgroundColor: colors.border,
                                  color: AppColors.primary,
                                  minHeight: 4,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

        // Chat Area
        Expanded(
          child: _aiChatHistory.isEmpty
              ? SizedBox.shrink()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _aiChatHistory.length + (_aiIsTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _aiChatHistory.length && _aiIsTyping) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colors.card,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ),
                      );
                    }
                    final msg = _aiChatHistory[index];
                    final isUser = msg["role"] == "user";
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isUser ? Color(0xFF2563EB) : colors.card,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          msg["text"]!,
                          style: GoogleFonts.outfit(
                            color: isUser ? Colors.white : colors.textPrimary,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        
        // Input Field
        Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
          decoration: BoxDecoration(
            color: colors.background,
            border: Border(top: BorderSide(color: Colors.white12)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: colors.card,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: TextField(
                    controller: _aiTextController,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'mobile.auto.ask_anything'.tr(),
                      hintStyle: TextStyle(color: colors.textSecondary),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _handleAiSend(),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2563EB),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _handleAiSend,
                  icon: Icon(Icons.send_rounded, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'mobile.message.justNow'.tr();
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${dt.day}/${dt.month}';
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, ThemeAwareColors colors, {VoidCallback? onTap}) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: AppColors.primary),
      label: Text(label, style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
      backgroundColor: colors.card,
      side: BorderSide(color: colors.border),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      onPressed: onTap ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${label} tetiklendi.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }
}

class FormattedMessageText extends StatelessWidget {
  final String text;
  final ThemeAwareColors colors;
  const FormattedMessageText({super.key, required this.text, required this.colors});

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');
    List<TextSpan> spans = [];
    for (var word in words) {
      if (word.startsWith('@') && word.length > 1) {
        spans.add(TextSpan(text: '$word ', style: GoogleFonts.outfit(color: Color(0xFF2563EB), fontWeight: FontWeight.bold)));
      } else if (word.startsWith('#') && word.length > 1) {
        spans.add(TextSpan(text: '$word ', style: GoogleFonts.outfit(color: AppColors.gold, fontWeight: FontWeight.bold)));
      } else {
        spans.add(TextSpan(text: '$word ', style: TextStyle(color: colors.textPrimary, fontSize: 15, height: 1.6)));
      }
    }
    return RichText(text: TextSpan(children: spans));
  }
}
