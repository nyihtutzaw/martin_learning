import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Dio getApiHandler(String token) {
    BaseOptions options = new BaseOptions(
      //baseUrl: "http://192.168.0.102:8000/api/v2/",
      baseUrl: "http://192.168.100.200:8000/api/v1/",
      // connectTimeout: 5000,
      // receiveTimeout: 3000,
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
