import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Dio getApiHandler(String token) {
    BaseOptions options = new BaseOptions(
      baseUrl: "http://54.255.18.148/marthin/public/api/v1/",
    );

    if (token != null) options.headers["Authorization"] = "Bearer " + token;

    options.headers["Accept"] = "application/json";

    Dio dio = new Dio(options);
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
