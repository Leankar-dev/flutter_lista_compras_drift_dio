import 'package:drift/drift.dart';
import 'package:flutter_lista_compras_drift_dio/listins/data/data_base.dart';
import 'package:flutter_lista_compras_drift_dio/products/data/products_drift_handler.dart';
import '../../listins/models/listin.dart';
import '../../products/model/product.dart';

class LocalDataHandler {
  Future<Map<String, dynamic>> localDataToMap({
    required AppDatabase appdatabase,
  }) async {
    List<Listin> listListins = await appdatabase.getListins();

    List<Map<String, dynamic>> listMappedListins = listListins
        .map((listin) => listin.toMap())
        .toList();

    for (var mappedListin in listMappedListins) {
      ProductsDriftHandler pdh = ProductsDriftHandler();
      await pdh.initialize(mappedListin["id"], appdatabase);

      List<Product> listProducts = await pdh.getProducts();
      List<Map<String, dynamic>> listMappedProducts = listProducts
          .map((product) => product.toMap())
          .toList();

      mappedListin["products"] = listMappedProducts;
    }

    Map<String, dynamic> finalMap = {};
    finalMap["listins"] = listMappedListins;

    return finalMap;
  }

  Future<void> mapToLocalData({
    required Map<String, dynamic> map,
    required AppDatabase appdatabase,
  }) async {
    await appdatabase.listinTable.deleteAll();

    for (Map<String, dynamic> mappedListin in map["listins"]) {
      Listin listin = Listin.fromMap(mappedListin);
      int id = await appdatabase.insertListin(listin);

      ProductsDriftHandler productsDriftHandler = ProductsDriftHandler();
      await productsDriftHandler.initialize(id.toString(), appdatabase);

      if (mappedListin["products"] != null) {
        for (Map<String, dynamic> mappedProduct in mappedListin["products"]) {
          Product product = Product.fromMap(mappedProduct);
          await productsDriftHandler.insertProduct(product);
        }
      }
    }
  }
}
