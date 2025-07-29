import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_lista_compras_drift_dio/_core/data/local_data_handler.dart';
import 'package:flutter_lista_compras_drift_dio/listins/data/data_base.dart';

class DioService {
  final Dio _dio = Dio();

  static const String baseUrl =
      'https://lista-compras-grift-default-rtdb.firebaseio.com/';

  Future<void> saveLocalToServer(AppDatabase appdatabase) async {
    Map<String, dynamic> localData = await LocalDataHandler().localDataToMap(
      appdatabase: appdatabase,
    );

    await _dio.put(
      '${baseUrl}listins.json',
      data: json.encode(localData['listins']),
      options: Options(contentType: 'application/json; UTF-8'),
    );
  }

  getDataFromServer(AppDatabase appdatabase) async {
    Response response = await _dio.get('${baseUrl}listins.json');

    if (response.data != null) {
      if ((response.data as List<dynamic>).isNotEmpty) {
        Map<String, dynamic> map = {};

        map['listins'] = response.data;

        await LocalDataHandler().mapToLocalData(
          map: map,
          appdatabase: appdatabase,
        );
      }
    }
  }
}
