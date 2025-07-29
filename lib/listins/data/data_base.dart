import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_lista_compras_drift_dio/listins/models/listin.dart';
import 'package:flutter_lista_compras_drift_dio/products/model/product.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'data_base.g.dart';

class ListinTable extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get name => text().named('name').withLength(min: 4, max: 30)();
  TextColumn get obs => text().named('obs')();
  DateTimeColumn get dateCreate => dateTime().named('dateCreate')();
  DateTimeColumn get dateUpdate => dateTime().named('dateUpdate')();
}

class ProductTable extends Table {
  TextColumn get id => text().named('id')();
  TextColumn get name => text().named('name')();
  TextColumn get obs => text().named('obs')();
  TextColumn get category => text().named('category')();
  BoolColumn get isKilograms => boolean().named('isKilograms')();
  RealColumn get price => real().named('price').nullable()();
  RealColumn get amount => real().named('amount').nullable()();
  BoolColumn get isPurchased => boolean().named('isPurchased')();
  TextColumn get listinId => text().named('listinId')();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [ListinTable, ProductTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_oppenConnection());

  @override
  int get schemaVersion => 1;

  // metodo para inserir dados no banco
  Future<int> insertListin(Listin listin) async {
    ListinTableCompanion newRow = ListinTableCompanion(
      name: Value(listin.name),
      obs: Value(listin.obs),
      dateCreate: Value(listin.dateCreate),
      dateUpdate: Value(listin.dateUpdate),
    );
    return await into(listinTable).insert(newRow);
  }

  // método para gerar buscas ordenadas por nome e data de criação
  Future<List<Listin>> getListinsOrderedByName() async {
    List<ListinTableData> listData =
        await (select(listinTable)..orderBy([
              (t) => OrderingTerm(expression: t.name),
              (t) => OrderingTerm(
                expression: t.dateCreate,
                mode: OrderingMode.desc,
              ),
            ]))
            .get();

    return listData.map((row) {
      return Listin(
        id: row.id.toString(),
        name: row.name,
        obs: row.obs,
        dateCreate: row.dateCreate,
        dateUpdate: row.dateUpdate,
      );
    }).toList();
  }

  Future<List<Listin>> getListins() async {
    List<Listin> temp = [];

    List<ListinTableData> listData = await select(listinTable).get();

    for (ListinTableData row in listData) {
      temp.add(
        Listin(
          id: row.id.toString(),
          name: row.name,
          obs: row.obs,
          dateCreate: row.dateCreate,
          dateUpdate: row.dateUpdate,
        ),
      );
    }
    return temp;
  }

  // médoto updateListin para atualizar os dados de um Listin
  Future<bool> updateListin(Listin listin) async {
    ListinTableCompanion newRow = ListinTableCompanion(
      id: Value(int.parse(listin.id)),
      name: Value(listin.name),
      obs: Value(listin.obs),
      dateCreate: Value(listin.dateCreate),
      dateUpdate: Value(listin.dateUpdate),
    );
    return await update(listinTable).replace(newRow);
  }

  // método para remover um Listin
  Future<int> deleteListin(int id) async {
    return await (delete(listinTable)..where((t) => t.id.equals(id))).go();
  }

  // método para pesquisar Listins por nome
  Future<List<Listin>> searchListinsByName(String searchTerm) async {
    List<ListinTableData> listData =
        await (select(listinTable)
              ..where((t) => t.name.like('%$searchTerm%'))
              ..orderBy([
                (t) => OrderingTerm(expression: t.name),
                (t) => OrderingTerm(
                  expression: t.dateCreate,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();

    return listData.map((row) {
      return Listin(
        id: row.id.toString(),
        name: row.name,
        obs: row.obs,
        dateCreate: row.dateCreate,
        dateUpdate: row.dateUpdate,
      );
    }).toList();
  }

  // MÉTODOS CRUD PARA PRODUTOS

  // Inserir produto

  Future<int> insertProduct(Product product) async {
    final newRow = ProductTableCompanion(
      id: Value(product.id),
      name: Value(product.name),
      obs: Value(product.obs),
      category: Value(product.category),
      isKilograms: Value(product.isKilograms),
      price: Value(product.price),
      amount: Value(product.amount),
      isPurchased: Value(product.isPurchased),
      listinId: Value(product.listinId),
    );

    return await into(productTable).insertOnConflictUpdate(newRow);
  }

  // Buscar produtos por listin
  Future<List<Product>> getProductsByListin(String listinId) async {
    List<ProductTableData> listData = await (select(
      productTable,
    )..where((t) => t.listinId.equals(listinId))).get();

    return listData.map((row) {
      return Product(
        id: row.id,
        name: row.name,
        obs: row.obs,
        category: row.category,
        isKilograms: row.isKilograms,
        price: row.price,
        amount: row.amount,
        isPurchased: row.isPurchased,
        listinId: row.listinId,
      );
    }).toList();
  }

  // Atualizar produto
  Future<bool> updateProduct(Product product) async {
    ProductTableCompanion newRow = ProductTableCompanion(
      id: Value(product.id),
      name: Value(product.name),
      obs: Value(product.obs),
      category: Value(product.category),
      isKilograms: Value(product.isKilograms),
      price: Value(product.price),
      amount: Value(product.amount),
      isPurchased: Value(product.isPurchased),
      listinId: Value(product.listinId),
    );
    return await update(productTable).replace(newRow);
  }

  // Remover produto
  Future<int> deleteProduct(String productId) async {
    return await (delete(
      productTable,
    )..where((t) => t.id.equals(productId))).go();
  }

  // Remover todos os produtos de um listin
  Future<int> deleteProductsByListin(String listinId) async {
    return await (delete(
      productTable,
    )..where((t) => t.listinId.equals(listinId))).go();
  }
}

LazyDatabase _oppenConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbPath = path.join(dbFolder.path, 'db.sqlite');
    final file = File(dbPath);

    // // DURANTE DESENVOLVIMENTO: Apaga o banco antigo para recriar tudo
    // if (await file.exists()) {
    //   await file.delete();
    // }

    return NativeDatabase.createInBackground(file);
  });
}
