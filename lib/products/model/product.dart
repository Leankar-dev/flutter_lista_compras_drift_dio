class Product {
  String id;
  String name;
  String obs;
  String category;
  bool isKilograms;
  double? price;
  double? amount;
  bool isPurchased;
  String listinId;

  Product({
    required this.id,
    required this.name,
    required this.obs,
    required this.category,
    required this.isKilograms,
    required this.isPurchased,
    required this.listinId,
    this.price,
    this.amount,
  });

  Product.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      name = map["name"],
      obs = map["obs"],
      category = map["category"],
      isKilograms = map["isKilograms"],
      isPurchased = map["isPurchased"],
      listinId = map["listinId"],
      price = map["price"],
      amount = map["amount"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "obs": obs,
      "category": category,
      "isKilograms": isKilograms,
      "isPurchased": isPurchased,
      "listinId": listinId,
      "price": price,
      "amount": amount,
    };
  }
}
