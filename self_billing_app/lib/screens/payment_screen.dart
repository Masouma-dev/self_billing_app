import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_billing_app/screens/payment_success_screen.dart';
import '../providers/cart_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = 'UPI';
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            RadioGroup<String>(
              groupValue: selectedMethod,
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
              child: Column(
                children: const [
                  RadioListTile(title: Text('UPI'), value: 'UPI'),
                  RadioListTile(
                    title: Text('Debit / Credit Card'),
                    value: 'Card',
                  ),
                ],
              ),
            ),

            const Spacer(),

            Text(
              'Total Amount: ₹${cart.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isProcessing
                    ? null
                    : () async {
                        setState(() {
                          isProcessing = true;
                        });

                        // ⏳ Simulate payment processing
                        await Future.delayed(const Duration(seconds: 2));

                        if (!mounted) return;

                        cart.clearCart();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaymentSuccessScreen(),
                          ),
                          (route) => false,
                        );
                      },
                child: isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
