class Product {
  final String id;
  final String name;
  final double price;
  //final String description;
  Product({
    required this.id,
    required this.name,
    required this.price,
    //required this.description,
  });
  /*factory Product.fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['Name'] ?? '',
      price: (data['Price'] as num?)?.toDouble() ?? 0.0,
    );
  }*/

  factory Product.fromFirestore(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['Name'] ?? '',
      price: (data['Price'] as num?)?.toDouble() ?? 0.0,
      //description: data['description'] ?? '',
    );
  }
}
