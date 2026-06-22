import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_billing_app/screens/payment_screen.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cart.itemCount == 0
          ? const Center(child: Text('Cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: cart.items.values.map((item) {
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text('₹${item.product.price}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () =>
                                  cart.decrementQuantity(item.product.id),
                            ),
                            Text(item.quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  cart.incrementQuantity(item.product.id),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PaymentScreen()),
                    );
                  },
                  child: const Text('Proceed to Payment'),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Total: ₹${cart.totalAmount}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
    );
  }
}
