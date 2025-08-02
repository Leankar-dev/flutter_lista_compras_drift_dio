import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioInterceptor extends Interceptor {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: false,
    ),
  );

  Map<String, dynamic> _buildErrorMap(DioException err) {
    return {
      'message': err.message,
      'type': err.type.toString(),
      'timestamp': DateTime.now().toIso8601String(),
      'request': {
        'url': err.requestOptions.uri.toString(),
        'method': err.requestOptions.method,
        'headers': err.requestOptions.headers,
        'data': err.requestOptions.data,
      },
      'response': err.response != null
          ? {
              'statusCode': err.response?.statusCode,
              'headers': err.response?.headers.map,
              'data': err.response?.data,
            }
          : null,
    };
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String log = "";
    log += "Request to: ${options.uri}\n";
    log += 'REQUISIÇÃO\n';
    log += 'Timestamp: ${DateTime.now()}\n';
    log += 'Método: ${options.method}\n';
    log += 'URL: ${options.uri}\n';
    log +=
        'Cabeçalho: ${JsonEncoder.withIndent('  ').convert(options.headers)}\n';

    if (options.data != null) {
      final body = options.data is String
          ? json.decode(options.data)
          : options.data;
      log += 'Corpo: ${JsonEncoder.withIndent('  ').convert(body)}\n';
    }
    // if (options.data != null) {
    //   log +=
    //       'Corpo: ${JsonEncoder.withIndent('  ').convert(json.decode(options.data))}\n';
    // }
    _logger.w(log);
    Dio().post(
      'https://lista-compras-grift-default-rtdb.firebaseio.com/logs.json',
      data: {'request': log},
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String log = "";
    log += "Response from: ${response.requestOptions.uri}\n";
    log += 'Timestamp: ${DateTime.now()}\n';
    log += 'Método: ${response.requestOptions.method}\n';
    log += 'URL: ${response.requestOptions.uri}\n';
    log +=
        'Cabeçalho: ${JsonEncoder.withIndent('  ').convert(response.headers.map)}\n';
    if (response.data != null) {
      log += 'Corpo: ${JsonEncoder.withIndent('  ').convert(response.data)}\n';
    }
    _logger.i(log);
    Dio().post(
      'https://lista-compras-grift-default-rtdb.firebaseio.com/logs.json',
      data: {'response': log},
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorMap = _buildErrorMap(err);
    final log = JsonEncoder.withIndent('  ').convert(errorMap);

    _logger.e(log);

    // Enviar log de erro para o Firebase
    Dio().post(
      'https://lista-compras-grift-default-rtdb.firebaseio.com/logs.json',
      data: {'error': log},
    );
    // String log = "";
    // log += "Error in request to: ${err.requestOptions.uri}\n";
    // log += 'Timestamp: ${DateTime.now()}\n';
    // log += 'Método: ${err.requestOptions.method}\n';
    // log += 'URL: ${err.requestOptions.uri}\n';
    // log +=
    //     'Cabeçalho: ${JsonEncoder.withIndent('  ').convert(err.requestOptions.headers)}\n';
    // if (err.response?.data != null) {
    //   log +=
    //       'Corpo: ${JsonEncoder.withIndent('  ').convert(err.response?.data)}\n';
    // }
    // _logger.e(log);
    // Dio().post(
    //   'https://lista-compras-grift-default-rtdb.firebaseio.com/logs.json',
    //   data: {'error': log},
    // );
    super.onError(err, handler);
  }
}
