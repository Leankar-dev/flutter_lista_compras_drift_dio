import 'package:dio/dio.dart';

class DioService {
  final Dio _dio;

  static const String baseUrl =
      'https://lista-compras-grift-default-rtdb.firebaseio.com/';

  DioService() : _dio = Dio(BaseOptions(baseUrl: baseUrl));
}
