import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_billing_app/screens/cart_screen.dart';
import 'package:self_billing_app/screens/scan_screen.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../services/product_services.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),

      /// 🔻 BOTTOM ACTION BAR
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),

          child: Row(
            children: [
              /// 🛒 ADD TO CART
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    for (int i = 0; i < quantity; i++) {
                      cartProvider.addToCart(widget.product);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Product added to cart')),
                    );
                  },

                  child: const Text('Add to Cart'),
                ),
              ),

              const SizedBox(width: 5),

              /// 🔁 SCAN OTHER PRODUCTS
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    /// OPEN SCANNER
                    final scannedId = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ScanScreen()),
                    );

                    /// IF USER CANCELLED SCAN
                    if (scannedId == null) return;

                    /// FETCH NEW PRODUCT
                    final productService = ProductService();

                    final Product? newProduct = await productService
                        .getProductById(scannedId);

                    /// SAFETY CHECK
                    if (!mounted) return;

                    /// OPEN NEW PRODUCT SCREEN
                    if (newProduct != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(product: newProduct),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Product not found')),
                      );
                    }
                  },

                  child: const Text('Scan Other Products'),
                ),
              ),
            ],
          ),
        ),
      ),

      /// 🔹 MAIN BODY
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// 🖼 PRODUCT IMAGE
            /// Uncomment if using Firebase Storage

            /*
            Center(
              child: Image.network(
                widget.product.imageUrl,
                height: 200,
              ),
            ),
            */
            Text(
              widget.product.name,

              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              '₹${widget.product.price}',

              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),

            const SizedBox(height: 30),

            const Text('Quantity', style: TextStyle(fontSize: 18)),

            const SizedBox(height: 10),

            /// ➕➖ QUANTITY CONTROLS
            Row(
              children: [
                /// ➖ DECREASE
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),

                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                ),

                Text(quantity.toString(), style: const TextStyle(fontSize: 18)),

                /// ➕ INCREASE
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),

                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
