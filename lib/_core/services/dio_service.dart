import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_lista_compras_drift_dio/_core/data/local_data_handler.dart';
import 'package:flutter_lista_compras_drift_dio/listins/data/data_base.dart';

class DioService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://lista-compras-grift-default-rtdb.firebaseio.com/',
      // contentType: 'application/json; UTF-8',
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    ),
  );

  Future<void> saveLocalToServer(AppDatabase appdatabase) async {
    Map<String, dynamic> localData = await LocalDataHandler().localDataToMap(
      appdatabase: appdatabase,
    );

    await _dio.put('listins.json', data: json.encode(localData['listins']));
  }

  getDataFromServer(AppDatabase appdatabase) async {
    Response response = await _dio.get('listins.json');

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

  Future<void> clearServerData() async {
    await _dio.delete('listins.json');
  }
}
