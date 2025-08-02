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
    Response response = await _dio.get(
      'listins.json',
      queryParameters: {
        'orderBy': '"name"',
        "startAt": '"0"',
        'limitToFirst': 100,
      },
    );

    if (response.data != null) {
      Map<String, dynamic> map = {};

      if (response.data.runtimeType == List) {
        if ((response.data as List<dynamic>).isNotEmpty) {
          map['listins'] = response.data;
        }
      } else {
        List<Map<String, dynamic>> tempList = [];

        for (var mapResponse in (response.data as Map).values) {
          tempList.add(mapResponse as Map<String, dynamic>);
        }
        map['listins'] = tempList;
      }
      await LocalDataHandler().mapToLocalData(
        map: map,
        appdatabase: appdatabase,
      );
    }
  }

  Future<void> clearServerData() async {
    await _dio.delete('listins.json');
  }
}
