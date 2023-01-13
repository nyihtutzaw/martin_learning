import 'package:dio/dio.dart';
import 'package:optimize/constants/chat_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ChatApiService {
  static Dio getApiHandler(String token, {bool isFormData = false}) {
    BaseOptions options = BaseOptions(
      baseUrl: '$path/api/',
    );

    options.headers["Authorization"] = "Bearer $token";

    options.headers["Accept"] = "application/json";
    isFormData ? options.headers['Content-Type'] = 'multipart/form-data' : null;

    Dio dio = Dio(options);
    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      )
    ]);

    return dio;
  }
}
