class Product{
  String name;
  double price;
  String category = "Umum";
  String image;
  String code;
  Product({this.name, this.price, this.category, this.code, this.image});
  factory Product.fromJson(Map<String, dynamic> data) {
    final _name = data["name"] as String;
    final _price = data["price"] as double;
    final _category = data["category"] as String;
    final _code = data["code"] as String;
    final _image = data["image"] as String;
    // return result passing all the arguments
    return Product(
      name: _name,
      price: _price,
      category: _category,
      code: _code,
      image: _image
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "price": this.price,
      "category": this.category,
      "code": this.code,
      "image": this.image
    };
  }
}

class Inventory{
  String id;
  String storeID;
  List<String> categories = [];
  List<Product> items = [];
  DateTime lastUpdated = DateTime.now();
  Inventory({
    this.id,
    this.storeID,
    this.categories,
    this.items,
    this.lastUpdated
  });

  void addItems(List<Product> newItems){
    this.items.addAll(newItems);
  }

  factory Inventory.fromJson(Map<String, dynamic> data) {
    final _id = data["id"] as String;
    final _storeID = data["storeID"] as String;
    final _categoriesData = data["categories"] as List<dynamic>;
    final _itemsData = data["items"] as List<dynamic>;
    final _lastUpdated = data["lastUpdated"] as String;
    final _items = _itemsData == null? <Product>[] :
      _itemsData.map((item)=>Product.fromJson(item)).toList();
    final _categories = _categoriesData == null ? <String>[]:
      _categoriesData.map((ctg) => "" + ctg).toList();
    // return result passing all the arguments
    return Inventory(
      id: _id,
      storeID: _storeID,
      categories: _categories,
      items: _items,
      lastUpdated: DateTime.parse(_lastUpdated)
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> _itms = this.items.map((it) => it.toJson()).toList();
    return {
      "storeID": this.storeID,
      "categories": this.categories,
      "items": _itms,
      "lastUpdated": this.lastUpdated.toIso8601String()
    };
  }
}