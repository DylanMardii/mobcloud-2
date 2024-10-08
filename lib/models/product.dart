class Product {
  String id;
  String name;
  String description;
  double price;
  String imageUrl;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        price: map['price'],
        imageUrl: map['imageUrl']);
  }
}
