import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/features/client/payment/presentation/screens/smart_checkout_screen.dart';

class FeatureGroup {
  final String nameTr;
  final String nameEn;
  final String category;
  final IconData icon;
  final List<Map<String, String>> subModules;

  const FeatureGroup({
    required this.nameTr,
    required this.nameEn,
    required this.icon,
    required this.category,
    required this.subModules,
  });

  String getLocalizedName(BuildContext context) {
    return context.locale.languageCode == 'tr' ? nameTr : nameEn;
  }
}

class FeatureHelper {
  static IconData getIconForModule(String route) {
    final lower = route.toLowerCase();
    
    // AI
    if (lower.contains('chat')) return Icons.chat_bubble_outline;
    if (lower.contains('fraud')) return Icons.security_outlined;
    if (lower.contains('image') || lower.contains('photo')) return Icons.image_outlined;
    if (lower.contains('predict')) return Icons.online_prediction;
    if (lower.contains('sentiment')) return Icons.mood_outlined;
    if (lower.contains('model') || lower.contains('ai')) return Icons.auto_awesome;
    
    // Financial
    if (lower.contains('escrow')) return Icons.shield_outlined;
    if (lower.contains('budget') || lower.contains('ledger')) return Icons.account_balance_wallet_outlined;
    if (lower.contains('tax')) return Icons.receipt_long_outlined;
    if (lower.contains('discount')) return Icons.discount_outlined;
    if (lower.contains('payment') || lower.contains('financ') || lower.contains('earning')) return Icons.payments_outlined;
    if (lower.contains('currency') || lower.contains('exchange')) return Icons.currency_exchange_outlined;
    if (lower.contains('price') || lower.contains('pricing') || lower.contains('quote') || lower.contains('offer')) return Icons.local_offer_outlined;
    
    // Property
    if (lower.contains('floor') || lower.contains('plan')) return Icons.architecture_outlined;
    if (lower.contains('amenity') || lower.contains('facility')) return Icons.pool_outlined;
    if (lower.contains('maintenance')) return Icons.handyman_outlined;
    if (lower.contains('inventory')) return Icons.inventory_2_outlined;
    if (lower.contains('mortgage')) return Icons.real_estate_agent_outlined;
    if (lower.contains('tour') || lower.contains('viewing')) return Icons.visibility_outlined;
    if (lower.contains('home') || lower.contains('property')) return Icons.home_work_outlined;
    if (lower.contains('listing')) return Icons.list_alt_outlined;
    
    // CRM
    if (lower.contains('message') || lower.contains('communicat')) return Icons.message_outlined;
    if (lower.contains('contact') || lower.contains('lead') || lower.contains('client')) return Icons.contact_phone_outlined;
    if (lower.contains('agent') || lower.contains('user') || lower.contains('guest') || lower.contains('tenant')) return Icons.person_outline;
    if (lower.contains('team')) return Icons.group_outlined;
    if (lower.contains('review') || lower.contains('feedback')) return Icons.star_outline;
    if (lower.contains('ambassador')) return Icons.campaign_outlined;
    if (lower.contains('social')) return Icons.share_outlined;
    if (lower.contains('ticket') || lower.contains('support')) return Icons.support_agent_outlined;
    if (lower.contains('reservation') || lower.contains('booking')) return Icons.book_online_outlined;
    if (lower.contains('event') || lower.contains('calendar')) return Icons.calendar_month_outlined;
    if (lower.contains('deal') || lower.contains('pipeline')) return Icons.view_kanban_outlined;
    
    // Legal & Doc
    if (lower.contains('contract') || lower.contains('signature')) return Icons.draw_outlined;
    if (lower.contains('compliance') || lower.contains('legal') || lower.contains('attorney')) return Icons.gavel_outlined;
    if (lower.contains('document') || lower.contains('file')) return Icons.description_outlined;
    if (lower.contains('audit') || lower.contains('log') || lower.contains('record')) return Icons.history_outlined;
    if (lower.contains('report') || lower.contains('analytic') || lower.contains('metric')) return Icons.bar_chart_outlined;
    if (lower.contains('performance')) return Icons.timeline_outlined;
    
    // Other / Systems
    if (lower.contains('map') || lower.contains('location') || lower.contains('route') || lower.contains('neighborhood')) return Icons.map_outlined;
    if (lower.contains('notification') || lower.contains('alert')) return Icons.notifications_outlined;
    if (lower.contains('api') || lower.contains('webhook') || lower.contains('integrat')) return Icons.webhook_outlined;
    if (lower.contains('role') || lower.contains('permission')) return Icons.admin_panel_settings_outlined;
    if (lower.contains('tag') || lower.contains('hashtag')) return Icons.tag_outlined;
    if (lower.contains('queue') || lower.contains('job') || lower.contains('task')) return Icons.checklist_rtl_outlined;
    if (lower.contains('sync') || lower.contains('export')) return Icons.sync_outlined;
    if (lower.contains('setting') || lower.contains('config') || lower.contains('preference') || lower.contains('device')) return Icons.settings_outlined;
    
    return Icons.widgets_outlined;
  }

  static List<FeatureGroup> getFeatureGroups() {
    return [
      // ==================== AI & ML ====================
      FeatureGroup(
        nameTr: 'AI Sohbet Robotu Merkezi',
        nameEn: 'AI Chatbot Hub',
        icon: Icons.chat_bubble_outline,
        category: 'AI & ML',
        subModules: [
          {'name': 'mobile.modules.ai_chat_handoff'.tr(), 'route': '/admin/ai_chat_handoff'},
          {'name': 'mobile.modules.ai_chat_message'.tr(), 'route': '/admin/ai_chat_message'},
          {'name': 'mobile.modules.ai_chatbot_session'.tr(), 'route': '/admin/ai_chatbot_session'},
        ],
      ),
      FeatureGroup(
        nameTr: 'AI & ML Model Yönetimi',
        nameEn: 'AI & ML Model Manager',
        icon: Icons.auto_awesome,
        category: 'AI & ML',
        subModules: [
          {'name': 'mobile.modules.ai_model'.tr(), 'route': '/admin/ai_model'},
          {'name': 'mobile.modules.ml_configuration'.tr(), 'route': '/admin/ml_configuration'},
          {'name': 'mobile.modules.ml_model'.tr(), 'route': '/admin/ml_model'},
          {'name': 'mobile.modules.predictive_model'.tr(), 'route': '/admin/predictive_model'},
          {'name': 'mobile.modules.analysis_job'.tr(), 'route': '/admin/analysis_job'},
        ],
      ),
      FeatureGroup(
        nameTr: 'AI Analiz & Öneriler',
        nameEn: 'AI Recommendations & Analysis',
        icon: Icons.online_prediction,
        category: 'AI & ML',
        subModules: [
          {'name': 'mobile.modules.ai_recommendations'.tr(), 'route': '/ai-recommendations'},
          {'name': 'mobile.modules.ai_recommendation'.tr(), 'route': '/admin/ai_recommendation'},
          {'name': 'mobile.modules.recommendation_result'.tr(), 'route': '/ai-recommendations'},
          {'name': 'mobile.modules.document_analysis'.tr(), 'route': '/admin/document_analysis'},
          {'name': 'mobile.modules.property_valuation'.tr(), 'route': '/admin/property_valuation'},
        ],
      ),
      FeatureGroup(
        nameTr: 'AI Stüdyosu',
        nameEn: 'AI Studio',
        icon: Icons.psychology,
        category: 'AI & ML',
        subModules: [
          {'name': 'mobile.modules.ai_studio'.tr(), 'route': '/ai-studio'},
        ],
      ),

      // ==================== FINANCIAL ====================
      FeatureGroup(
        nameTr: 'Ödeme & Hakediş Operasyonları',
        nameEn: 'Payment & Payout Operations',
        icon: Icons.payments_outlined,
        category: 'Financial',
        subModules: [
          {'name': 'mobile.modules.payment'.tr(), 'route': '/admin/payment'},
          {'name': 'mobile.modules.payment_installment'.tr(), 'route': '/admin/payment_installment'},
          {'name': 'mobile.modules.payment_negotiation'.tr(), 'route': '/admin/payment_negotiation'},
          {'name': 'mobile.modules.payout'.tr(), 'route': '/admin/payout'},
          {'name': 'mobile.modules.commission'.tr(), 'route': '/admin/commission'},
          {'name': 'mobile.modules.commission_rule'.tr(), 'route': '/admin/commission_rule'},
          {'name': 'mobile.modules.discount'.tr(), 'route': '/admin/discount'},
          {'name': 'mobile.modules.extra_charge'.tr(), 'route': '/admin/extra_charge'},
          {'name': 'mobile.modules.gift_card'.tr(), 'route': '/admin/gift_card'},
          {'name': 'mobile.modules.loyalty_account'.tr(), 'route': '/admin/loyalty_account'},
          {'name': 'mobile.modules.negotiation_offer'.tr(), 'route': '/admin/negotiation_offer'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Güvence & Emanet Hesapları',
        nameEn: 'Escrow & Deposit Trust',
        icon: Icons.shield_outlined,
        category: 'Financial',
        subModules: [
          {'name': 'mobile.modules.escrow_account'.tr(), 'route': '/admin/escrow_account'},
          {'name': 'mobile.modules.escrow_dispute'.tr(), 'route': '/admin/escrow_dispute'},
          {'name': 'mobile.modules.escrow_release'.tr(), 'route': '/admin/escrow_release'},
          {'name': 'mobile.modules.escrow_status_history'.tr(), 'route': '/admin/escrow_status_history'},
          {'name': 'mobile.modules.deposit_protection'.tr(), 'route': '/admin/deposit_protection'},
          {'name': 'mobile.modules.security_deposit_protection'.tr(), 'route': '/admin/security_deposit_protection'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Vergi & Muhasebe Merkezi',
        nameEn: 'Tax & Accounting Center',
        icon: Icons.receipt_long_outlined,
        category: 'Financial',
        subModules: [
          {'name': 'mobile.modules.tax1099_form'.tr(), 'route': '/admin/tax1099_form'},
          {'name': 'mobile.modules.tax_depreciation'.tr(), 'route': '/admin/tax_depreciation'},
          {'name': 'mobile.modules.tax_record'.tr(), 'route': '/admin/tax_record'},
          {'name': 'mobile.modules.budget'.tr(), 'route': '/admin/budget'},
          {'name': 'mobile.modules.earning'.tr(), 'route': '/admin/earning'},
          {'name': 'mobile.modules.expense'.tr(), 'route': '/admin/expense'},
          {'name': 'mobile.modules.financial_record'.tr(), 'route': '/admin/financial_record'},
          {'name': 'mobile.modules.ledger_entry'.tr(), 'route': '/admin/ledger_entry'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Fiyatlandırma & Döviz Kuralları',
        nameEn: 'Pricing & Exchange Rules',
        icon: Icons.local_offer_outlined,
        category: 'Financial',
        subModules: [
          {'name': 'mobile.modules.pricing'.tr(), 'route': '/pricing'},
          {'name': 'mobile.modules.pricing_rule'.tr(), 'route': '/pricing'},
          {'name': 'mobile.modules.currency'.tr(), 'route': '/admin/currency'},
          {'name': 'mobile.modules.exchange_rate'.tr(), 'route': '/admin/exchange_rate'},
          {'name': 'mobile.modules.quote'.tr(), 'route': '/admin/quote'},
          {'name': 'mobile.modules.offer'.tr(), 'route': '/admin/offer'},
          {'name': 'mobile.modules.increase'.tr(), 'route': '/admin/increase'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Finansal Panel',
        nameEn: 'Financial Dashboard',
        icon: Icons.account_balance_outlined,
        category: 'Financial',
        subModules: [
          {'name': 'mobile.modules.financial_dashboard'.tr(), 'route': '/financial'},
        ],
      ),

      // ==================== PROPERTY ====================
      FeatureGroup(
        nameTr: 'Mülk Portföy Yöneticisi',
        nameEn: 'Property Portfolio Manager',
        icon: Icons.home_work_outlined,
        category: 'Property',
        subModules: [
          {'name': 'mobile.auto.eco_dynamic_lease'.tr(), 'route': '/checkout'},
          {'name': 'mobile.modules.property'.tr(), 'route': '/admin/property'},
          {'name': 'mobile.modules.property_amenity'.tr(), 'route': '/admin/property_amenity'},
          {'name': 'mobile.modules.property_compliance'.tr(), 'route': '/admin/property_compliance'},
          {'name': 'mobile.modules.property_disclosure'.tr(), 'route': '/admin/property_disclosure'},
          {'name': 'mobile.modules.property_document'.tr(), 'route': '/admin/property_document'},
          {'name': 'mobile.modules.property_inventory'.tr(), 'route': '/admin/property_inventory'},
          {'name': 'mobile.modules.property_offer'.tr(), 'route': '/admin/property_offer'},
          {'name': 'mobile.modules.property_photo'.tr(), 'route': '/admin/property_photo'},
          {'name': 'mobile.modules.property_viewing'.tr(), 'route': '/admin/property_viewing'},
          {'name': 'mobile.modules.virtual_tour'.tr(), 'route': '/admin/virtual_tour'},
          {'name': 'mobile.modules.home_information_pack'.tr(), 'route': '/admin/home_information_pack'},
          {'name': 'mobile.modules.investor_portfolio'.tr(), 'route': '/admin/investor_portfolio'},
          {'name': 'mobile.modules.investor_property'.tr(), 'route': '/admin/investor_property'},
          {'name': 'mobile.modules.project'.tr(), 'route': '/admin/project'},
          {'name': 'mobile.modules.project_alert'.tr(), 'route': '/admin/project_alert'},
          {'name': 'mobile.modules.key_management'.tr(), 'route': '/admin/key_management'},
        ],
      ),
      FeatureGroup(
        nameTr: 'İlan & Kanal Dağıtım Merkezi',
        nameEn: 'Listings & Channels Hub',
        icon: Icons.list_alt_outlined,
        category: 'Property',
        subModules: [
          {'name': 'mobile.modules.listing'.tr(), 'route': '/listings'},
          {'name': 'mobile.modules.listing_channel'.tr(), 'route': '/admin/listing_channel'},
          {'name': 'mobile.modules.listing_status_history'.tr(), 'route': '/admin/listing_status_history'},
          {'name': 'mobile.modules.listing_tag'.tr(), 'route': '/admin/listing_tag'},
          {'name': 'mobile.modules.listing_doping'.tr(), 'route': '/listing-promotion'},
          {'name': 'mobile.modules.channel_distribution'.tr(), 'route': '/channels'},
          {'name': 'mobile.modules.property_promotion'.tr(), 'route': '/listing-promotion'},
          {'name': 'mobile.modules.external_rental_listing'.tr(), 'route': '/admin/external_rental_listing'},
          {'name': 'mobile.modules.vacation_rental'.tr(), 'route': '/admin/vacation_rental'},
          {'name': 'mobile.modules.vacation_rental_platform'.tr(), 'route': '/admin/vacation_rental_platform'},
          {'name': 'mobile.modules.mls_connection'.tr(), 'route': '/admin/mls_connection'},
          {'name': 'mobile.modules.mls_data_mapping'.tr(), 'route': '/admin/mls_data_mapping'},
          {'name': 'mobile.modules.mls_external_listing'.tr(), 'route': '/admin/mls_external_listing'},
          {'name': 'mobile.modules.mls_listing_enhancement'.tr(), 'route': '/admin/mls_listing_enhancement'},
          {'name': 'mobile.modules.mls_sync_job'.tr(), 'route': '/admin/mls_sync_job'},
          {'name': 'mobile.modules.rental_sync_job'.tr(), 'route': '/admin/rental_sync_job'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Rezervasyon & Randevu Ofisi',
        nameEn: 'Booking & Reservation Desk',
        icon: Icons.book_online_outlined,
        category: 'Property',
        subModules: [
          {'name': 'mobile.modules.booking'.tr(), 'route': '/admin/booking'},
          {'name': 'mobile.modules.reservation'.tr(), 'route': '/admin/reservation'},
          {'name': 'mobile.modules.appointment'.tr(), 'route': '/admin/appointment'},
          {'name': 'mobile.modules.availability'.tr(), 'route': '/admin/availability'},
          {'name': 'mobile.modules.event'.tr(), 'route': '/events'},
          {'name': 'mobile.modules.event_attendee'.tr(), 'route': '/admin/event_attendee'},
          {'name': 'mobile.modules.calendar_event'.tr(), 'route': '/admin/calendar_event'},
          {'name': 'mobile.modules.events'.tr(), 'route': '/events'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Bakım & Tesis Yönetimi',
        nameEn: 'Maintenance & Facilities',
        icon: Icons.handyman_outlined,
        category: 'Property',
        subModules: [
          {'name': 'mobile.modules.maintenance_block'.tr(), 'route': '/admin/maintenance_block'},
          {'name': 'mobile.modules.maintenance_work_order'.tr(), 'route': '/admin/maintenance_work_order'},
          {'name': 'mobile.modules.facility'.tr(), 'route': '/admin/facility'},
          {'name': 'mobile.modules.facility_block'.tr(), 'route': '/admin/facility_block'},
          {'name': 'mobile.modules.floor_plan'.tr(), 'route': '/admin/floor_plan'},
          {'name': 'mobile.modules.amenity'.tr(), 'route': '/admin/amenity'},
          {'name': 'mobile.modules.shared_amenity'.tr(), 'route': '/admin/shared_amenity'},
          {'name': 'mobile.modules.included_service'.tr(), 'route': '/admin/included_service'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Mortgage & Finansman Kredisi',
        nameEn: 'Mortgage & Financing Hub',
        icon: Icons.real_estate_agent_outlined,
        category: 'Property',
        subModules: [
          {'name': 'mobile.modules.mortgage'.tr(), 'route': '/admin/mortgage'},
          {'name': 'mobile.modules.mortgage_offer'.tr(), 'route': '/admin/mortgage_offer'},
          {'name': 'mobile.modules.mortgage_pre_approval'.tr(), 'route': '/admin/mortgage_pre_approval'},
        ],
      ),

      // ==================== CRM & USERS ====================
      FeatureGroup(
        nameTr: 'İletişim & Mesajlaşma',
        nameEn: 'Communications & Messages',
        icon: Icons.message_outlined,
        category: 'CRM & Users',
        subModules: [
          {'name': 'mobile.modules.message'.tr(), 'route': '/messages'},
          {'name': 'mobile.modules.messages'.tr(), 'route': '/messages'},
          {'name': 'mobile.modules.communication_center'.tr(), 'route': '/communications'},
          {'name': 'mobile.modules.communication_log'.tr(), 'route': '/admin/communication_log'},
          {'name': 'mobile.modules.communication_template'.tr(), 'route': '/admin/communication_template'},
          {'name': 'mobile.modules.contact'.tr(), 'route': '/contact'},
          {'name': 'mobile.modules.ticket'.tr(), 'route': '/support'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Acente & Temsilci Yönetimi',
        nameEn: 'Agent & Agency Operations',
        icon: Icons.group_outlined,
        category: 'CRM & Users',
        subModules: [
          {'name': 'mobile.modules.agent'.tr(), 'route': '/admin/agent'},
          {'name': 'mobile.modules.agent_assignment'.tr(), 'route': '/admin/agent_assignment'},
          {'name': 'mobile.modules.agent_performance'.tr(), 'route': '/admin/agent_performance'},
          {'name': 'mobile.modules.agent_team'.tr(), 'route': '/admin/agent_team'},
          {'name': 'mobile.modules.agent_team_member'.tr(), 'route': '/admin/agent_team_member'},
          {'name': 'mobile.modules.agency'.tr(), 'route': '/admin/agency'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Kiracı & Kiralama İlişkileri',
        nameEn: 'Tenant & Rental Relations',
        icon: Icons.person_outline,
        category: 'CRM & Users',
        subModules: [
          {'name': 'mobile.modules.tenant'.tr(), 'route': '/admin/tenant'},
          {'name': 'mobile.modules.tenant_application'.tr(), 'route': '/admin/tenant_application'},
          {'name': 'mobile.modules.rent_arrears'.tr(), 'route': '/admin/rent_arrears'},
          {'name': 'mobile.modules.rent_schedule'.tr(), 'route': '/admin/rent_schedule'},
          {'name': 'mobile.modules.lease'.tr(), 'route': '/admin/lease'},
          {'name': 'mobile.modules.lease_renewal'.tr(), 'route': '/admin/lease_renewal'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Misafir & Ev Sahibi İlişkileri',
        nameEn: 'Guest & Host Relations',
        icon: Icons.people_alt_outlined,
        category: 'CRM & Users',
        subModules: [
          {'name': 'mobile.modules.guest'.tr(), 'route': '/admin/guest'},
          {'name': 'mobile.modules.guest_profile'.tr(), 'route': '/admin/guest_profile'},
          {'name': 'mobile.modules.guest_review'.tr(), 'route': '/admin/guest_review'},
          {'name': 'mobile.modules.review'.tr(), 'route': '/admin/review'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Profil & Tercih Yönetimi',
        nameEn: 'User Profiles & Configuration',
        icon: Icons.manage_accounts_outlined,
        category: 'CRM & Users',
        subModules: [
          {'name': 'mobile.modules.user'.tr(), 'route': '/admin/user'},
          {'name': 'mobile.modules.user_activity_log'.tr(), 'route': '/activity'},
          {'name': 'mobile.modules.user_preference'.tr(), 'route': '/admin/user_preference'},
          {'name': 'mobile.modules.user_financial_profile'.tr(), 'route': '/admin/user_financial_profile'},
          {'name': 'mobile.modules.account'.tr(), 'route': '/admin/account'},
          {'name': 'mobile.modules.achievement'.tr(), 'route': '/admin/achievement'},
          {'name': 'mobile.modules.vendor_profile'.tr(), 'route': '/admin/vendor_profile'},
          {'name': 'mobile.modules.subscription'.tr(), 'route': '/admin/subscription'},
          {'name': 'mobile.modules.org_subscription'.tr(), 'route': '/admin/org_subscription'},
          {'name': 'mobile.modules.home'.tr(), 'route': '/dashboard'},
          {'name': 'mobile.modules.activity_tracking'.tr(), 'route': '/activity'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Müşteri & Potansiyel İlişkileri',
        nameEn: 'Leads & Relationship Hub',
        icon: Icons.view_kanban_outlined,
        category: 'CRM & Users',
        subModules: [
          {'name': 'mobile.modules.lead'.tr(), 'route': '/leads'},
          {'name': 'mobile.modules.lead_source'.tr(), 'route': '/admin/lead_source'},
          {'name': 'mobile.modules.client_relationship'.tr(), 'route': '/admin/client_relationship'},
          {'name': 'mobile.modules.referral'.tr(), 'route': '/admin/referral'},
          {'name': 'mobile.modules.favorite'.tr(), 'route': '/admin/favorite'},
          {'name': 'mobile.modules.deals_pipeline'.tr(), 'route': '/deals'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Marka Elçileri & Sosyal Medya',
        nameEn: 'Brand Ambassadors & Social',
        icon: Icons.campaign_outlined,
        category: 'CRM & Users',
        subModules: [
          {'name': 'mobile.modules.brand_ambassador'.tr(), 'route': '/admin/brand_ambassador'},
          {'name': 'mobile.modules.ambassador_campaign'.tr(), 'route': '/admin/ambassador_campaign'},
          {'name': 'mobile.modules.ambassador_contract'.tr(), 'route': '/admin/ambassador_contract'},
          {'name': 'mobile.modules.post'.tr(), 'route': '/admin/post'},
          {'name': 'mobile.modules.mention'.tr(), 'route': '/admin/mention'},
          {'name': 'mobile.modules.social_impact_counter'.tr(), 'route': '/admin/social_impact_counter'},
          {'name': 'mobile.modules.social_impact_record'.tr(), 'route': '/admin/social_impact_record'},
          {'name': 'mobile.modules.marketing_campaign'.tr(), 'route': '/admin/marketing_campaign'},
        ],
      ),

      // ==================== LEGAL ====================
      FeatureGroup(
        nameTr: 'Sözleşmeler & E-İmza',
        nameEn: 'Contracts & e-Signatures',
        icon: Icons.draw_outlined,
        category: 'Legal',
        subModules: [
          {'name': 'mobile.modules.contract'.tr(), 'route': '/admin/contract'},
          {'name': 'mobile.modules.contract_version'.tr(), 'route': '/admin/contract_version'},
          {'name': 'mobile.modules.signature_request'.tr(), 'route': '/admin/signature_request'},
          {'name': 'mobile.modules.signature_signer'.tr(), 'route': '/admin/signature_signer'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Hukuk Danışmanlığı & Avukatlar',
        nameEn: 'Legal Advisory & Lawyers',
        icon: Icons.gavel_outlined,
        category: 'Legal',
        subModules: [
          {'name': 'mobile.modules.attorney_management'.tr(), 'route': '/admin/attorney_management'},
          {'name': 'mobile.modules.solicitor_management'.tr(), 'route': '/admin/solicitor_management'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Uyum & Geçmiş Kontrolleri',
        nameEn: 'Compliance & Checks',
        icon: Icons.fact_check_outlined,
        category: 'Legal',
        subModules: [
          {'name': 'mobile.modules.compliance_record'.tr(), 'route': '/admin/compliance_record'},
          {'name': 'mobile.modules.right_to_rent_check'.tr(), 'route': '/admin/right_to_rent_check'},
          {'name': 'mobile.modules.immigration_status_check'.tr(), 'route': '/admin/immigration_status_check'},
        ],
      ),

      // ==================== SYSTEMS ====================
      FeatureGroup(
        nameTr: 'API & Webhook Yönetimi',
        nameEn: 'API & Webhooks',
        icon: Icons.webhook_outlined,
        category: 'Systems',
        subModules: [
          {'name': 'mobile.modules.api_integration'.tr(), 'route': '/admin/api_integration'},
          {'name': 'mobile.modules.api_key'.tr(), 'route': '/admin/api_key'},
          {'name': 'mobile.modules.api_token'.tr(), 'route': '/admin/api_token'},
          {'name': 'mobile.modules.webhook'.tr(), 'route': '/admin/webhook'},
          {'name': 'mobile.modules.webhook_delivery'.tr(), 'route': '/admin/webhook_delivery'},
          {'name': 'mobile.modules.integrations'.tr(), 'route': '/integrations'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Otomasyon & İş Akışları',
        nameEn: 'Automation & Workflows',
        icon: Icons.autorenew_outlined,
        category: 'Systems',
        subModules: [
          {'name': 'mobile.modules.automation_execution'.tr(), 'route': '/admin/automation_execution'},
          {'name': 'mobile.modules.automation_rule'.tr(), 'route': '/admin/automation_rule'},
          {'name': 'mobile.modules.automation_task'.tr(), 'route': '/admin/automation_task'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Sistem İzleme & Teşhis',
        nameEn: 'System Monitoring & Diagnostics',
        icon: Icons.analytics_outlined,
        category: 'Systems',
        subModules: [
          {'name': 'mobile.modules.audit_log'.tr(), 'route': '/admin/audit_log'},
          {'name': 'mobile.modules.system_metrics'.tr(), 'route': '/admin/system_metrics'},
          {'name': 'mobile.modules.health_check'.tr(), 'route': '/admin/health_check'},
          {'name': 'mobile.modules.analytics'.tr(), 'route': '/admin/analytics'},
          {'name': 'mobile.modules.performance_alert'.tr(), 'route': '/admin/performance_alert'},
          {'name': 'mobile.modules.project_analytics'.tr(), 'route': '/admin/project_analytics'},
          {'name': 'mobile.modules.project_report'.tr(), 'route': '/admin/project_report'},
          {'name': 'mobile.modules.report'.tr(), 'route': '/analytics'},
          {'name': 'mobile.modules.report_execution'.tr(), 'route': '/admin/report_execution'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Kuyruk & Arka Plan İşleri',
        nameEn: 'Queue & Background Jobs',
        icon: Icons.checklist_rtl_outlined,
        category: 'Systems',
        subModules: [
          {'name': 'mobile.modules.job'.tr(), 'route': '/admin/job'},
          {'name': 'mobile.modules.queue_configuration'.tr(), 'route': '/admin/queue_configuration'},
          {'name': 'mobile.modules.queue_message'.tr(), 'route': '/admin/queue_message'},
          {'name': 'mobile.modules.offline_sync_queue'.tr(), 'route': '/admin/offline_sync_queue'},
          {'name': 'mobile.modules.task'.tr(), 'route': '/admin/task'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Roller & Güvenlik Yetkileri',
        nameEn: 'Roles, Permissions & Security',
        icon: Icons.admin_panel_settings_outlined,
        category: 'Systems',
        subModules: [
          {'name': 'mobile.modules.role'.tr(), 'route': '/admin/role'},
          {'name': 'mobile.modules.role_permission'.tr(), 'route': '/admin/role_permission'},
          {'name': 'mobile.modules.permission'.tr(), 'route': '/admin/permission'},
          {'name': 'mobile.modules.verification'.tr(), 'route': '/admin/verification'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Lokasyon & Harita Verileri',
        nameEn: 'Locations & Maps',
        icon: Icons.map_outlined,
        category: 'Systems',
        subModules: [
          {'name': 'mobile.modules.location'.tr(), 'route': '/admin/location'},
          {'name': 'mobile.modules.map_data'.tr(), 'route': '/admin/map_data'},
          {'name': 'mobile.modules.map_layer'.tr(), 'route': '/admin/map_layer'},
          {'name': 'mobile.modules.neighborhood'.tr(), 'route': '/admin/neighborhood'},
          {'name': 'mobile.modules.route'.tr(), 'route': '/admin/route'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Dosya & Belge Yönetimi',
        nameEn: 'Document Management & Files',
        icon: Icons.description_outlined,
        category: 'Systems',
        subModules: [
          {'name': 'mobile.modules.document'.tr(), 'route': '/admin/document'},
          {'name': 'mobile.modules.document_template'.tr(), 'route': '/admin/document_template'},
          {'name': 'mobile.modules.attachment'.tr(), 'route': '/admin/attachment'},
          {'name': 'mobile.modules.export_file'.tr(), 'route': '/files'},
          {'name': 'mobile.modules.video_content'.tr(), 'route': '/admin/video_content'},
          {'name': 'mobile.modules.photo'.tr(), 'route': '/admin/photo'},
          {'name': 'mobile.modules.file_management'.tr(), 'route': '/files'},
        ],
      ),
      FeatureGroup(
        nameTr: 'Sistem Yardımcı Araçları',
        nameEn: 'System Utilities & Config',
        icon: Icons.settings_outlined,
        category: 'Systems',
        subModules: [
          {'name': 'mobile.modules.tag'.tr(), 'route': '/admin/tag'},
          {'name': 'mobile.modules.hashtag'.tr(), 'route': '/admin/hashtag'},
          {'name': 'mobile.modules.session'.tr(), 'route': '/admin/session'},
          {'name': 'mobile.modules.mobile_device'.tr(), 'route': '/admin/mobile_device'},
          {'name': 'mobile.modules.export_job'.tr(), 'route': '/admin/export_job'},
          {'name': 'mobile.modules.scraping_job'.tr(), 'route': '/admin/scraping_job'},
          {'name': 'mobile.modules.language'.tr(), 'route': '/admin/language'},
          {'name': 'mobile.modules.integration_log'.tr(), 'route': '/admin/integration_log'},
          {'name': 'mobile.modules.government_integration'.tr(), 'route': '/admin/government_integration'},
          {'name': 'mobile.modules.reference_source'.tr(), 'route': '/admin/reference_source'},
          {'name': 'mobile.modules.plan'.tr(), 'route': '/admin/plan'},
          {'name': 'mobile.modules.organization'.tr(), 'route': '/organization'},
          {'name': 'mobile.modules.dashboard_configuration'.tr(), 'route': '/admin/dashboard_configuration'},
          {'name': 'mobile.modules.dashboard_widget'.tr(), 'route': '/dashboard-widgets'},
        ],
      ),
    ];
  }

  static void showSubModulesBottomSheet({
    required BuildContext context,
    required FeatureGroup group,
    required Color lightColor,
    required Color primaryColor,
    required Color darkBgColor,
    String searchQuery = '',
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6),
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0B0F19).withOpacity(0.85),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
                border: Border.all(
                  color: lightColor.withOpacity(0.25),
                  width: 1.5,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 48,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: lightColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: lightColor.withOpacity(0.3)),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Icon(group.icon, color: lightColor, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  group.getLocalizedName(context),
                                  style: GoogleFonts.outfit(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${group.category.toUpperCase()} • ${group.subModules.length} ${context.locale.languageCode == 'tr' ? 'ALT MODÜL' : 'SUB-MODULES'}',
                                  style: GoogleFonts.outfit(
                                    color: lightColor.withOpacity(0.8),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Flexible(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.5,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: group.subModules.length,
                            itemBuilder: (context, index) {
                              final sub = group.subModules[index];
                              final subName = sub['name']!;
                              final subRoute = sub['route']!;
                              
                              final matchesSearch = searchQuery.isNotEmpty &&
                                  subName.toLowerCase().contains(searchQuery.toLowerCase());
                              
                              String cleanTitle = subName;
                              if (cleanTitle.startsWith('mobile.modules.')) {
                                cleanTitle = cleanTitle.replaceAll('mobile.modules.', '').replaceAll('.tr()', '').replaceAll('_', ' ');
                                cleanTitle = cleanTitle.split(' ').map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '').join(' ');
                              }
                              
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    if (subRoute == '/checkout' || subRoute == 'checkout') {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SmartCheckoutScreen()));
                                    } else {
                                      context.push(subRoute);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: matchesSearch
                                          ? lightColor.withOpacity(0.18)
                                          : Colors.white.withOpacity(0.03),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: matchesSearch
                                            ? lightColor
                                            : Colors.white.withOpacity(0.08),
                                        width: matchesSearch ? 1.5 : 1.0,
                                      ),
                                      boxShadow: matchesSearch
                                          ? [
                                              BoxShadow(
                                                color: lightColor.withOpacity(0.25),
                                                blurRadius: 12,
                                                spreadRadius: 1,
                                              )
                                            ]
                                          : [],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: matchesSearch
                                                ? lightColor.withOpacity(0.2)
                                                : Colors.white.withOpacity(0.05),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            getIconForModule(subRoute),
                                            color: matchesSearch ? lightColor : Colors.white60,
                                            size: 18,
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Text(
                                            cleanTitle,
                                            style: GoogleFonts.outfit(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: matchesSearch
                                                  ? FontWeight.w800
                                                  : FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        if (matchesSearch) ...[
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: lightColor,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              context.locale.languageCode == 'tr' ? 'EŞLEŞTİ' : 'MATCHED',
                                              style: GoogleFonts.outfit(
                                                color: Colors.black,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: matchesSearch ? lightColor : Colors.white30,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showCategoryBottomSheet({
    required BuildContext context,
    required String category,
    required String title,
    required Color lightColor,
    required Color primaryColor,
    required Color darkBgColor,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6),
      isScrollControlled: true,
      builder: (context) {
        return _CategoryBottomSheetContent(
          category: category,
          title: title,
          lightColor: lightColor,
          primaryColor: primaryColor,
          darkBgColor: darkBgColor,
        );
      },
    );
  }
}

class _CategoryBottomSheetContent extends StatefulWidget {
  final String category;
  final String title;
  final Color lightColor;
  final Color primaryColor;
  final Color darkBgColor;

  const _CategoryBottomSheetContent({
    required this.category,
    required this.title,
    required this.lightColor,
    required this.primaryColor,
    required this.darkBgColor,
  });

  @override
  State<_CategoryBottomSheetContent> createState() => _CategoryBottomSheetContentState();
}

class _CategoryBottomSheetContentState extends State<_CategoryBottomSheetContent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allGroups = FeatureHelper.getFeatureGroups().where((g) => g.category == widget.category).toList();
    
    final filteredGroups = allGroups.where((g) {
      if (_searchQuery.isEmpty) return true;
      final matchesGroupName = g.getLocalizedName(context).toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesSubModule = g.subModules.any((sub) => sub['name']!.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesGroupName || matchesSubModule;
    }).toList();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0B0F19).withOpacity(0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
            border: Border.all(
              color: widget.lightColor.withOpacity(0.25),
              width: 1.5,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Category Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: widget.lightColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: widget.lightColor.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: widget.primaryColor.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Icon(
                          widget.category == 'AI & ML' ? Icons.auto_awesome : 
                          widget.category == 'Financial' ? Icons.payments_outlined :
                          widget.category == 'Property' ? Icons.business_outlined :
                          widget.category == 'CRM & Users' ? Icons.people_alt_outlined :
                          widget.category == 'Legal' ? Icons.gavel_outlined :
                          Icons.settings_suggest_outlined, 
                          color: widget.lightColor, 
                          size: 28
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.category.toUpperCase()} • ${allGroups.length} HUBS',
                              style: GoogleFonts.outfit(
                                color: widget.lightColor.withOpacity(0.8),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Local Search bar inside bottom sheet
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
                      onChanged: (val) => setState(() => _searchQuery = val),
                      decoration: InputDecoration(
                        hintText: 'Search modules in this category...',
                        hintStyle: GoogleFonts.outfit(color: Colors.white.withOpacity(0.4), fontSize: 14),
                        prefixIcon: Icon(Icons.search_rounded, color: widget.lightColor, size: 20),
                        suffixIcon: _searchQuery.isNotEmpty 
                            ? IconButton(
                                icon: const Icon(Icons.clear, color: Colors.white54, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Groups & Modules List
                  Flexible(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      child: filteredGroups.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 40),
                                child: Text(
                                  'No matching modules found',
                                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 14),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: filteredGroups.length,
                              itemBuilder: (context, gIndex) {
                                final group = filteredGroups[gIndex];
                                
                                // Filter submodules of this group
                                final matchingSubModules = group.subModules.where((sub) {
                                  if (_searchQuery.isEmpty) return true;
                                  return sub['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
                                }).toList();

                                if (matchingSubModules.isEmpty) return const SizedBox.shrink();

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.02),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Group Header inside Category Sheet
                                      Row(
                                        children: [
                                          Icon(group.icon, color: widget.lightColor.withOpacity(0.7), size: 18),
                                          const SizedBox(width: 8),
                                          Text(
                                            group.getLocalizedName(context),
                                            style: GoogleFonts.outfit(
                                              color: Colors.white.withOpacity(0.9),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '${matchingSubModules.length} ${context.locale.languageCode == 'tr' ? 'MODÜL' : 'MODULES'}',
                                            style: GoogleFonts.outfit(
                                              color: widget.lightColor.withOpacity(0.6),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      
                                      // Submodules list
                                      ...matchingSubModules.map((sub) {
                                        final subName = sub['name']!;
                                        final subRoute = sub['route']!;
                                        
                                        final isHighlighted = _searchQuery.isNotEmpty &&
                                            subName.toLowerCase().contains(_searchQuery.toLowerCase());

                                        String cleanTitle = subName;
                                        if (cleanTitle.startsWith('mobile.modules.')) {
                                          cleanTitle = cleanTitle.replaceAll('mobile.modules.', '').replaceAll('.tr()', '').replaceAll('_', ' ');
                                          cleanTitle = cleanTitle.split(' ').map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '').join(' ');
                                        }

                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              if (subRoute == '/checkout' || subRoute == 'checkout') {
                                                Navigator.push(context, MaterialPageRoute(builder: (_) => const SmartCheckoutScreen()));
                                              } else {
                                                context.push(subRoute);
                                              }
                                            },
                                            borderRadius: BorderRadius.circular(16),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              decoration: BoxDecoration(
                                                color: isHighlighted
                                                    ? widget.lightColor.withOpacity(0.12)
                                                    : Colors.white.withOpacity(0.02),
                                                borderRadius: BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: isHighlighted
                                                      ? widget.lightColor
                                                      : Colors.white.withOpacity(0.05),
                                                  width: isHighlighted ? 1.5 : 1.0,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    FeatureHelper.getIconForModule(subRoute),
                                                    color: isHighlighted ? widget.lightColor : Colors.white54,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      cleanTitle,
                                                      style: GoogleFonts.outfit(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: isHighlighted ? FontWeight.w800 : FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios_rounded,
                                                    color: isHighlighted ? widget.lightColor : Colors.white24,
                                                    size: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
