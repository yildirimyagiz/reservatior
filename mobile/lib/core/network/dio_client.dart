import 'package:dio/dio.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'api_endpoints.dart';
import 'network_info.dart';

class DioClient {
  static const _timeout = Duration(seconds: 30);

  final _storage = const FlutterSecureStorage();
  final _log = Logger();
  final NetworkInfo _networkInfo = NetworkInfoImpl(Connectivity());
  late final Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      headers: {'Accept': 'application/json', 'mobile.leftovers.content_type'.tr(): 'application/json'},
    ));

    _dio.interceptors.addAll([
      _AuthInterceptor(_storage),
      _RegionInterceptor(),
      _LoggingInterceptor(_log),
      _RetryInterceptor(_dio),
    ]);
  }

  Dio get dio => _dio;

  // HTTP Methods
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.patch<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.delete<T>(path, queryParameters: queryParameters, options: options);
  }
}

class _AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  _AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(key: 'access_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !err.requestOptions.path.contains('/auth/')) {
       // Only try refresh if NOT an auth endpoint to avoid loops
       // But wait, the server uses a single token (Elysia JWT). 
       // If it'mobile.leftovers.s_401_on_me_then_it'.tr()s expired.
       // Actually, the current server implementation doesn't seem to have a /refresh yet.
       // It just has /login and /register.
    }
    handler.next(err);
  }
}

class _LoggingInterceptor extends Interceptor {
  final Logger _log;
  _LoggingInterceptor(this._log);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log.d('→ ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log.d('← ${response.statusCode} ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log.e('✗ ${err.requestOptions.path}: ${err.message}');
    handler.next(err);
  }
}

class _RetryInterceptor extends Interceptor {
  final Dio _dio;
  static const _maxRetries = 3;
  _RetryInterceptor(this._dio);

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    final retries = (extra['retries'] as int?) ?? 0;

    if (_shouldRetry(err) && retries < _maxRetries) {
      await Future.delayed(Duration(seconds: retries + 1));
      err.requestOptions.extra['retries'] = retries + 1;
      try {
        final response = await _dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // Retry failed, continue to next handler
      }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException err) =>
    err.type == DioExceptionType.connectionTimeout ||
    err.type == DioExceptionType.receiveTimeout ||
    (err.response?.statusCode ?? 0) >= 500;
}

class _RegionInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final selectedRegion = prefs.getString('selected_region_code');
      if (selectedRegion != null && selectedRegion.isNotEmpty) {
        options.headers['X-Region'] = selectedRegion;
        print('🌍 RegionInterceptor: Attached X-Region header [$selectedRegion]');
      }
    } catch (e) {
      print('🌍 RegionInterceptor Error: $e');
    }
    handler.next(options);
  }
}

