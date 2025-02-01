import 'package:dio/dio.dart';
import 'package:tech_pay/core/constants/app_constants.dart';
import 'package:tech_pay/shared/services/auth_token_service.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseAPIUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
      },
    )
  );

  static Dio get instance => _dio;

  static void setupInterceptorsWrapper() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if(options.path.contains('/auth')) {
          return handler.next(options);
        }
        
        if(!options.headers.containsKey('tech-token')) {
          final token = await AuthTokenService.getToken();
          if(token != null) {
            options.headers['pp-token'] = token;
          }
        }

        return handler.next(options);
      },
      onError: (error, handler) async {
        if(error.response?.statusCode == 401) {
          await AuthTokenService.deleteToken();
        }

        return handler.next(error);
      }
    ));
  }
}