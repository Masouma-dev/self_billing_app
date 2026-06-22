import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isScanned = false;

  final MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Product')),
      body: MobileScanner(
        controller: controller,

        onDetect: (capture) async {
          if (isScanned) return;

          final barcode = capture.barcodes.first;

          final String? code = barcode.rawValue;

          if (code != null) {
            isScanned = true;

            await controller.stop();

            if (!mounted) return;

            Navigator.pop(context, code);
          }
        },
      ),
    );
  }
}
