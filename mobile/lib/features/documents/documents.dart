// ── Documents Module Barrel Export
// Tüm document modülü için merkezi export

// Domain exports
export 'domain/entities/document.dart';
export 'domain/entities/document_analysis.dart';
export 'domain/entities/document_template.dart';
export 'domain/repositories/document_repository.dart';
export 'domain/services/document_service.dart';

// Data exports
export 'data/models/document_model.dart';
export 'data/models/document_analysis_model.dart';
export 'data/models/document_template_model.dart';
export 'data/datasources/document_datasource.dart';
export 'data/repositories/document_repository_impl.dart';

// Presentation exports
export 'presentation/providers/document_provider.dart';
export 'presentation/pages/document_list_page.dart';
export 'presentation/pages/document_detail_page.dart';
export 'presentation/pages/document_analysis_page.dart';
export 'presentation/pages/document_template_page.dart';
export 'presentation/widgets/document_card.dart';
export 'presentation/widgets/document_form.dart';
export 'presentation/widgets/document_analysis_widget.dart';

// Shared exports
export 'shared/stores/document_store.dart';
export 'shared/stores/document_analysis_store.dart';
export 'shared/stores/document_template_store.dart';
export 'shared/utils/document_utils.dart';
