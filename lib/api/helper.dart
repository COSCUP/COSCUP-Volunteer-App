import 'package:dio/dio.dart';

class Helper {
  static const String host = '';

  static Helper _instance;

  // ignore: prefer_constructors_over_static_methods
  static Helper get instance {
    return _instance ??= Helper();
  }

  Helper() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://$host',
        connectTimeout: 10000,
        receiveTimeout: 10000,
      ),
    );
  }

  Dio dio;
}
