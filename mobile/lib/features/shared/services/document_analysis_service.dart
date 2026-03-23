import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class DocumentAnalysisService {
  final DioClient _dioClient;
  DocumentAnalysisService(this._dioClient);

  // ── Get by ID ──
  Future<DocumentAnalysis> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/documentAnalysis/$id');
      return DocumentAnalysis.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<DocumentAnalysis>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/documentAnalysis', queryParameters: q);
      return (r.data['data'] as List).map((j) => DocumentAnalysis.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<DocumentAnalysis>> getWithFilters({
    String? extractedText,
    dynamic? metadata,
    dynamic? classification,
    double? confidence,
    int? processingTime,
  }) async {
    final filters = <String, dynamic>{};
    if (extractedText != null) filters['extractedText'] = extractedText;
    if (metadata != null) filters['metadata'] = metadata.toString();
    if (classification != null) filters['classification'] = classification.toString();
    if (confidence != null) filters['confidence'] = confidence.toString();
    if (processingTime != null) filters['processingTime'] = processingTime.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<DocumentAnalysis> create(DocumentAnalysis documentAnalysis) async {

    try {
      final r = await _dioClient.post('/documentAnalysis', data: documentAnalysis.toJson());
      return DocumentAnalysis.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<DocumentAnalysis> update(String id, DocumentAnalysis documentAnalysis) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/documentAnalysis/$id', data: documentAnalysis.toJson());
      return DocumentAnalysis.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/documentAnalysis/$id');
    } on DioException catch (e) { throw _err(e); }
  }

  Exception _err(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout. Check your internet connection.');
      case DioExceptionType.badResponse:
        final msg = e.response?.data?['message'] ?? 'Server error';
        return Exception('Server error: $msg');
      case DioExceptionType.connectionError:
        return Exception('Network error. Check your internet connection.');
      default:
        return Exception('Request failed: ${e.message}');
    }
  }
}