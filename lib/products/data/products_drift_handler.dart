import 'package:flutter_lista_compras_drift_hive/listins/data/data_base.dart';
import 'package:flutter_lista_compras_drift_hive/products/model/product.dart';

class ProductsDriftHandler {
  late AppDatabase _database;
  late String _listinId;

  Future<void> initialize(String listinId, AppDatabase database) async {
    _listinId = listinId;
    _database = database;
  }

  Future<int> insertProduct(Product product) async {
    product.listinId = _listinId;
    return await _database.insertProduct(product);
  }

  Future<List<Product>> getProducts() async {
    return await _database.getProductsByListin(_listinId);
  }

  Future<bool> updateProduct(Product product) async {
    product.listinId = _listinId;
    return await _database.updateProduct(product);
  }

  Future<int> deleteProduct(String productId) async {
    return await _database.deleteProduct(productId);
  }

  Future<int> removeProduct(Product product) async {
    return await _database.deleteProduct(product.id);
  }

  Future<int> deleteAllProducts() async {
    return await _database.deleteProductsByListin(_listinId);
  }
}
