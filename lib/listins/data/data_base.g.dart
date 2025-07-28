// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_base.dart';

// ignore_for_file: type=lint
class $ListinTableTable extends ListinTable
    with TableInfo<$ListinTableTable, ListinTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListinTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _obsMeta = const VerificationMeta('obs');
  @override
  late final GeneratedColumn<String> obs = GeneratedColumn<String>(
    'obs',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateCreateMeta = const VerificationMeta(
    'dateCreate',
  );
  @override
  late final GeneratedColumn<DateTime> dateCreate = GeneratedColumn<DateTime>(
    'dateCreate',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateUpdateMeta = const VerificationMeta(
    'dateUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> dateUpdate = GeneratedColumn<DateTime>(
    'dateUpdate',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, obs, dateCreate, dateUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'listin_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ListinTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('obs')) {
      context.handle(
        _obsMeta,
        obs.isAcceptableOrUnknown(data['obs']!, _obsMeta),
      );
    } else if (isInserting) {
      context.missing(_obsMeta);
    }
    if (data.containsKey('dateCreate')) {
      context.handle(
        _dateCreateMeta,
        dateCreate.isAcceptableOrUnknown(data['dateCreate']!, _dateCreateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateCreateMeta);
    }
    if (data.containsKey('dateUpdate')) {
      context.handle(
        _dateUpdateMeta,
        dateUpdate.isAcceptableOrUnknown(data['dateUpdate']!, _dateUpdateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ListinTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ListinTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      obs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}obs'],
      )!,
      dateCreate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dateCreate'],
      )!,
      dateUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dateUpdate'],
      )!,
    );
  }

  @override
  $ListinTableTable createAlias(String alias) {
    return $ListinTableTable(attachedDatabase, alias);
  }
}

class ListinTableData extends DataClass implements Insertable<ListinTableData> {
  final int id;
  final String name;
  final String obs;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  const ListinTableData({
    required this.id,
    required this.name,
    required this.obs,
    required this.dateCreate,
    required this.dateUpdate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['obs'] = Variable<String>(obs);
    map['dateCreate'] = Variable<DateTime>(dateCreate);
    map['dateUpdate'] = Variable<DateTime>(dateUpdate);
    return map;
  }

  ListinTableCompanion toCompanion(bool nullToAbsent) {
    return ListinTableCompanion(
      id: Value(id),
      name: Value(name),
      obs: Value(obs),
      dateCreate: Value(dateCreate),
      dateUpdate: Value(dateUpdate),
    );
  }

  factory ListinTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ListinTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      obs: serializer.fromJson<String>(json['obs']),
      dateCreate: serializer.fromJson<DateTime>(json['dateCreate']),
      dateUpdate: serializer.fromJson<DateTime>(json['dateUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'obs': serializer.toJson<String>(obs),
      'dateCreate': serializer.toJson<DateTime>(dateCreate),
      'dateUpdate': serializer.toJson<DateTime>(dateUpdate),
    };
  }

  ListinTableData copyWith({
    int? id,
    String? name,
    String? obs,
    DateTime? dateCreate,
    DateTime? dateUpdate,
  }) => ListinTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    obs: obs ?? this.obs,
    dateCreate: dateCreate ?? this.dateCreate,
    dateUpdate: dateUpdate ?? this.dateUpdate,
  );
  ListinTableData copyWithCompanion(ListinTableCompanion data) {
    return ListinTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      obs: data.obs.present ? data.obs.value : this.obs,
      dateCreate: data.dateCreate.present
          ? data.dateCreate.value
          : this.dateCreate,
      dateUpdate: data.dateUpdate.present
          ? data.dateUpdate.value
          : this.dateUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ListinTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('obs: $obs, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateUpdate: $dateUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, obs, dateCreate, dateUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListinTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.obs == this.obs &&
          other.dateCreate == this.dateCreate &&
          other.dateUpdate == this.dateUpdate);
}

class ListinTableCompanion extends UpdateCompanion<ListinTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> obs;
  final Value<DateTime> dateCreate;
  final Value<DateTime> dateUpdate;
  const ListinTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.obs = const Value.absent(),
    this.dateCreate = const Value.absent(),
    this.dateUpdate = const Value.absent(),
  });
  ListinTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String obs,
    required DateTime dateCreate,
    required DateTime dateUpdate,
  }) : name = Value(name),
       obs = Value(obs),
       dateCreate = Value(dateCreate),
       dateUpdate = Value(dateUpdate);
  static Insertable<ListinTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? obs,
    Expression<DateTime>? dateCreate,
    Expression<DateTime>? dateUpdate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (obs != null) 'obs': obs,
      if (dateCreate != null) 'dateCreate': dateCreate,
      if (dateUpdate != null) 'dateUpdate': dateUpdate,
    });
  }

  ListinTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? obs,
    Value<DateTime>? dateCreate,
    Value<DateTime>? dateUpdate,
  }) {
    return ListinTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      obs: obs ?? this.obs,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (obs.present) {
      map['obs'] = Variable<String>(obs.value);
    }
    if (dateCreate.present) {
      map['dateCreate'] = Variable<DateTime>(dateCreate.value);
    }
    if (dateUpdate.present) {
      map['dateUpdate'] = Variable<DateTime>(dateUpdate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListinTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('obs: $obs, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateUpdate: $dateUpdate')
          ..write(')'))
        .toString();
  }
}

class $ProductTableTable extends ProductTable
    with TableInfo<$ProductTableTable, ProductTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _obsMeta = const VerificationMeta('obs');
  @override
  late final GeneratedColumn<String> obs = GeneratedColumn<String>(
    'obs',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isKilogramsMeta = const VerificationMeta(
    'isKilograms',
  );
  @override
  late final GeneratedColumn<bool> isKilograms = GeneratedColumn<bool>(
    'isKilograms',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("isKilograms" IN (0, 1))',
    ),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPurchasedMeta = const VerificationMeta(
    'isPurchased',
  );
  @override
  late final GeneratedColumn<bool> isPurchased = GeneratedColumn<bool>(
    'isPurchased',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("isPurchased" IN (0, 1))',
    ),
  );
  static const VerificationMeta _listinIdMeta = const VerificationMeta(
    'listinId',
  );
  @override
  late final GeneratedColumn<String> listinId = GeneratedColumn<String>(
    'listinId',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    obs,
    category,
    isKilograms,
    price,
    amount,
    isPurchased,
    listinId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('obs')) {
      context.handle(
        _obsMeta,
        obs.isAcceptableOrUnknown(data['obs']!, _obsMeta),
      );
    } else if (isInserting) {
      context.missing(_obsMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('isKilograms')) {
      context.handle(
        _isKilogramsMeta,
        isKilograms.isAcceptableOrUnknown(
          data['isKilograms']!,
          _isKilogramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isKilogramsMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('isPurchased')) {
      context.handle(
        _isPurchasedMeta,
        isPurchased.isAcceptableOrUnknown(
          data['isPurchased']!,
          _isPurchasedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isPurchasedMeta);
    }
    if (data.containsKey('listinId')) {
      context.handle(
        _listinIdMeta,
        listinId.isAcceptableOrUnknown(data['listinId']!, _listinIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listinIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      obs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}obs'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isKilograms: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}isKilograms'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
      isPurchased: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}isPurchased'],
      )!,
      listinId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}listinId'],
      )!,
    );
  }

  @override
  $ProductTableTable createAlias(String alias) {
    return $ProductTableTable(attachedDatabase, alias);
  }
}

class ProductTableData extends DataClass
    implements Insertable<ProductTableData> {
  final String id;
  final String name;
  final String obs;
  final String category;
  final bool isKilograms;
  final double? price;
  final double? amount;
  final bool isPurchased;
  final String listinId;
  const ProductTableData({
    required this.id,
    required this.name,
    required this.obs,
    required this.category,
    required this.isKilograms,
    this.price,
    this.amount,
    required this.isPurchased,
    required this.listinId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['obs'] = Variable<String>(obs);
    map['category'] = Variable<String>(category);
    map['isKilograms'] = Variable<bool>(isKilograms);
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    map['isPurchased'] = Variable<bool>(isPurchased);
    map['listinId'] = Variable<String>(listinId);
    return map;
  }

  ProductTableCompanion toCompanion(bool nullToAbsent) {
    return ProductTableCompanion(
      id: Value(id),
      name: Value(name),
      obs: Value(obs),
      category: Value(category),
      isKilograms: Value(isKilograms),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      isPurchased: Value(isPurchased),
      listinId: Value(listinId),
    );
  }

  factory ProductTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      obs: serializer.fromJson<String>(json['obs']),
      category: serializer.fromJson<String>(json['category']),
      isKilograms: serializer.fromJson<bool>(json['isKilograms']),
      price: serializer.fromJson<double?>(json['price']),
      amount: serializer.fromJson<double?>(json['amount']),
      isPurchased: serializer.fromJson<bool>(json['isPurchased']),
      listinId: serializer.fromJson<String>(json['listinId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'obs': serializer.toJson<String>(obs),
      'category': serializer.toJson<String>(category),
      'isKilograms': serializer.toJson<bool>(isKilograms),
      'price': serializer.toJson<double?>(price),
      'amount': serializer.toJson<double?>(amount),
      'isPurchased': serializer.toJson<bool>(isPurchased),
      'listinId': serializer.toJson<String>(listinId),
    };
  }

  ProductTableData copyWith({
    String? id,
    String? name,
    String? obs,
    String? category,
    bool? isKilograms,
    Value<double?> price = const Value.absent(),
    Value<double?> amount = const Value.absent(),
    bool? isPurchased,
    String? listinId,
  }) => ProductTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    obs: obs ?? this.obs,
    category: category ?? this.category,
    isKilograms: isKilograms ?? this.isKilograms,
    price: price.present ? price.value : this.price,
    amount: amount.present ? amount.value : this.amount,
    isPurchased: isPurchased ?? this.isPurchased,
    listinId: listinId ?? this.listinId,
  );
  ProductTableData copyWithCompanion(ProductTableCompanion data) {
    return ProductTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      obs: data.obs.present ? data.obs.value : this.obs,
      category: data.category.present ? data.category.value : this.category,
      isKilograms: data.isKilograms.present
          ? data.isKilograms.value
          : this.isKilograms,
      price: data.price.present ? data.price.value : this.price,
      amount: data.amount.present ? data.amount.value : this.amount,
      isPurchased: data.isPurchased.present
          ? data.isPurchased.value
          : this.isPurchased,
      listinId: data.listinId.present ? data.listinId.value : this.listinId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('obs: $obs, ')
          ..write('category: $category, ')
          ..write('isKilograms: $isKilograms, ')
          ..write('price: $price, ')
          ..write('amount: $amount, ')
          ..write('isPurchased: $isPurchased, ')
          ..write('listinId: $listinId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    obs,
    category,
    isKilograms,
    price,
    amount,
    isPurchased,
    listinId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.obs == this.obs &&
          other.category == this.category &&
          other.isKilograms == this.isKilograms &&
          other.price == this.price &&
          other.amount == this.amount &&
          other.isPurchased == this.isPurchased &&
          other.listinId == this.listinId);
}

class ProductTableCompanion extends UpdateCompanion<ProductTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> obs;
  final Value<String> category;
  final Value<bool> isKilograms;
  final Value<double?> price;
  final Value<double?> amount;
  final Value<bool> isPurchased;
  final Value<String> listinId;
  final Value<int> rowid;
  const ProductTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.obs = const Value.absent(),
    this.category = const Value.absent(),
    this.isKilograms = const Value.absent(),
    this.price = const Value.absent(),
    this.amount = const Value.absent(),
    this.isPurchased = const Value.absent(),
    this.listinId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductTableCompanion.insert({
    required String id,
    required String name,
    required String obs,
    required String category,
    required bool isKilograms,
    this.price = const Value.absent(),
    this.amount = const Value.absent(),
    required bool isPurchased,
    required String listinId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       obs = Value(obs),
       category = Value(category),
       isKilograms = Value(isKilograms),
       isPurchased = Value(isPurchased),
       listinId = Value(listinId);
  static Insertable<ProductTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? obs,
    Expression<String>? category,
    Expression<bool>? isKilograms,
    Expression<double>? price,
    Expression<double>? amount,
    Expression<bool>? isPurchased,
    Expression<String>? listinId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (obs != null) 'obs': obs,
      if (category != null) 'category': category,
      if (isKilograms != null) 'isKilograms': isKilograms,
      if (price != null) 'price': price,
      if (amount != null) 'amount': amount,
      if (isPurchased != null) 'isPurchased': isPurchased,
      if (listinId != null) 'listinId': listinId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? obs,
    Value<String>? category,
    Value<bool>? isKilograms,
    Value<double?>? price,
    Value<double?>? amount,
    Value<bool>? isPurchased,
    Value<String>? listinId,
    Value<int>? rowid,
  }) {
    return ProductTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      obs: obs ?? this.obs,
      category: category ?? this.category,
      isKilograms: isKilograms ?? this.isKilograms,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      isPurchased: isPurchased ?? this.isPurchased,
      listinId: listinId ?? this.listinId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (obs.present) {
      map['obs'] = Variable<String>(obs.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isKilograms.present) {
      map['isKilograms'] = Variable<bool>(isKilograms.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (isPurchased.present) {
      map['isPurchased'] = Variable<bool>(isPurchased.value);
    }
    if (listinId.present) {
      map['listinId'] = Variable<String>(listinId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('obs: $obs, ')
          ..write('category: $category, ')
          ..write('isKilograms: $isKilograms, ')
          ..write('price: $price, ')
          ..write('amount: $amount, ')
          ..write('isPurchased: $isPurchased, ')
          ..write('listinId: $listinId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ListinTableTable listinTable = $ListinTableTable(this);
  late final $ProductTableTable productTable = $ProductTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    listinTable,
    productTable,
  ];
}

typedef $$ListinTableTableCreateCompanionBuilder =
    ListinTableCompanion Function({
      Value<int> id,
      required String name,
      required String obs,
      required DateTime dateCreate,
      required DateTime dateUpdate,
    });
typedef $$ListinTableTableUpdateCompanionBuilder =
    ListinTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> obs,
      Value<DateTime> dateCreate,
      Value<DateTime> dateUpdate,
    });

class $$ListinTableTableFilterComposer
    extends Composer<_$AppDatabase, $ListinTableTable> {
  $$ListinTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get obs => $composableBuilder(
    column: $table.obs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateCreate => $composableBuilder(
    column: $table.dateCreate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateUpdate => $composableBuilder(
    column: $table.dateUpdate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ListinTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ListinTableTable> {
  $$ListinTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get obs => $composableBuilder(
    column: $table.obs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateCreate => $composableBuilder(
    column: $table.dateCreate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateUpdate => $composableBuilder(
    column: $table.dateUpdate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ListinTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListinTableTable> {
  $$ListinTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get obs =>
      $composableBuilder(column: $table.obs, builder: (column) => column);

  GeneratedColumn<DateTime> get dateCreate => $composableBuilder(
    column: $table.dateCreate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateUpdate => $composableBuilder(
    column: $table.dateUpdate,
    builder: (column) => column,
  );
}

class $$ListinTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ListinTableTable,
          ListinTableData,
          $$ListinTableTableFilterComposer,
          $$ListinTableTableOrderingComposer,
          $$ListinTableTableAnnotationComposer,
          $$ListinTableTableCreateCompanionBuilder,
          $$ListinTableTableUpdateCompanionBuilder,
          (
            ListinTableData,
            BaseReferences<_$AppDatabase, $ListinTableTable, ListinTableData>,
          ),
          ListinTableData,
          PrefetchHooks Function()
        > {
  $$ListinTableTableTableManager(_$AppDatabase db, $ListinTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListinTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListinTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ListinTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> obs = const Value.absent(),
                Value<DateTime> dateCreate = const Value.absent(),
                Value<DateTime> dateUpdate = const Value.absent(),
              }) => ListinTableCompanion(
                id: id,
                name: name,
                obs: obs,
                dateCreate: dateCreate,
                dateUpdate: dateUpdate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String obs,
                required DateTime dateCreate,
                required DateTime dateUpdate,
              }) => ListinTableCompanion.insert(
                id: id,
                name: name,
                obs: obs,
                dateCreate: dateCreate,
                dateUpdate: dateUpdate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ListinTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ListinTableTable,
      ListinTableData,
      $$ListinTableTableFilterComposer,
      $$ListinTableTableOrderingComposer,
      $$ListinTableTableAnnotationComposer,
      $$ListinTableTableCreateCompanionBuilder,
      $$ListinTableTableUpdateCompanionBuilder,
      (
        ListinTableData,
        BaseReferences<_$AppDatabase, $ListinTableTable, ListinTableData>,
      ),
      ListinTableData,
      PrefetchHooks Function()
    >;
typedef $$ProductTableTableCreateCompanionBuilder =
    ProductTableCompanion Function({
      required String id,
      required String name,
      required String obs,
      required String category,
      required bool isKilograms,
      Value<double?> price,
      Value<double?> amount,
      required bool isPurchased,
      required String listinId,
      Value<int> rowid,
    });
typedef $$ProductTableTableUpdateCompanionBuilder =
    ProductTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> obs,
      Value<String> category,
      Value<bool> isKilograms,
      Value<double?> price,
      Value<double?> amount,
      Value<bool> isPurchased,
      Value<String> listinId,
      Value<int> rowid,
    });

class $$ProductTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductTableTable> {
  $$ProductTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get obs => $composableBuilder(
    column: $table.obs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isKilograms => $composableBuilder(
    column: $table.isKilograms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPurchased => $composableBuilder(
    column: $table.isPurchased,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get listinId => $composableBuilder(
    column: $table.listinId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductTableTable> {
  $$ProductTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get obs => $composableBuilder(
    column: $table.obs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isKilograms => $composableBuilder(
    column: $table.isKilograms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPurchased => $composableBuilder(
    column: $table.isPurchased,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get listinId => $composableBuilder(
    column: $table.listinId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductTableTable> {
  $$ProductTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get obs =>
      $composableBuilder(column: $table.obs, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isKilograms => $composableBuilder(
    column: $table.isKilograms,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<bool> get isPurchased => $composableBuilder(
    column: $table.isPurchased,
    builder: (column) => column,
  );

  GeneratedColumn<String> get listinId =>
      $composableBuilder(column: $table.listinId, builder: (column) => column);
}

class $$ProductTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductTableTable,
          ProductTableData,
          $$ProductTableTableFilterComposer,
          $$ProductTableTableOrderingComposer,
          $$ProductTableTableAnnotationComposer,
          $$ProductTableTableCreateCompanionBuilder,
          $$ProductTableTableUpdateCompanionBuilder,
          (
            ProductTableData,
            BaseReferences<_$AppDatabase, $ProductTableTable, ProductTableData>,
          ),
          ProductTableData,
          PrefetchHooks Function()
        > {
  $$ProductTableTableTableManager(_$AppDatabase db, $ProductTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> obs = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isKilograms = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<bool> isPurchased = const Value.absent(),
                Value<String> listinId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductTableCompanion(
                id: id,
                name: name,
                obs: obs,
                category: category,
                isKilograms: isKilograms,
                price: price,
                amount: amount,
                isPurchased: isPurchased,
                listinId: listinId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String obs,
                required String category,
                required bool isKilograms,
                Value<double?> price = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                required bool isPurchased,
                required String listinId,
                Value<int> rowid = const Value.absent(),
              }) => ProductTableCompanion.insert(
                id: id,
                name: name,
                obs: obs,
                category: category,
                isKilograms: isKilograms,
                price: price,
                amount: amount,
                isPurchased: isPurchased,
                listinId: listinId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductTableTable,
      ProductTableData,
      $$ProductTableTableFilterComposer,
      $$ProductTableTableOrderingComposer,
      $$ProductTableTableAnnotationComposer,
      $$ProductTableTableCreateCompanionBuilder,
      $$ProductTableTableUpdateCompanionBuilder,
      (
        ProductTableData,
        BaseReferences<_$AppDatabase, $ProductTableTable, ProductTableData>,
      ),
      ProductTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ListinTableTableTableManager get listinTable =>
      $$ListinTableTableTableManager(_db, _db.listinTable);
  $$ProductTableTableTableManager get productTable =>
      $$ProductTableTableTableManager(_db, _db.productTable);
}
