import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'api_constants.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio provideDio(SharedPreferences prefs, FlutterSecureStorage storage) {
    final dio = Dio();

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      baseUrl: ApiConstants.baseUrl,
    );

    dio.interceptors.add(
      PrettyDioLogger(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final selectedLanguageCode = prefs.getString(
            Constants.selectedLanguageCode,
          );
          final token = await storage.read(key: Constants.token);
          if (token != null) {
            options.headers[Constants.authorization] =
                "${Constants.bearer}$token";
            options.headers[Constants.token] = "${Constants.bearer}$token";
          }
          options.headers[Constants.acceptLanguage] = selectedLanguageCode;
          handler.next(options);
        },
      ),
    );

    return dio;
  }
}
