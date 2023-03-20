import 'package:cofac_lv2/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // print(options.headers);

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }
    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({'Authorization': 'Bearer $refreshToken'});
    }

    return super.onRequest(options, handler);
  }
}
