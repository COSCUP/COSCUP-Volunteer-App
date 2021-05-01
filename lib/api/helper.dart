import 'package:dio/dio.dart';

class Helper {
  static const String host = '';

  static Helper _instance;

  static Helper get instance {
    if (_instance == null) {
      _instance = Helper();
    }
    return _instance;
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
