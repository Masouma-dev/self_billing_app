/*import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// 🔹 Get ALL products (used to test Firebase connection)
  Future<List<Product>> getAllProducts() async {
    final snapshot = await _db.collection('products').get();

    return snapshot.docs
        .map((doc) => Product.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// 🔹 Get SINGLE product by document ID
  Future<Product?> getProductById(String id) async {
    final doc = await _db.collection('products').doc(id).get();

    if (!doc.exists) return null;

    return Product.fromMap(doc.id, doc.data()!);
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Product?> getProductById(String id) async {
    final doc = await _db.collection('products').doc(id).get();

    if (doc.exists) {
      return Product.fromFirestore(doc.id, doc.data()!);
    }
    return null;
  }
}
