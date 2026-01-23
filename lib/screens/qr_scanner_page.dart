import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool hasScanned = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: MobileScanner(
        // Logic bila kamera jumpa QR
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            debugPrint('QR Terjumpa: ${barcode.rawValue}');

            // Bila jumpa, tutup scanner dan hantar data balik
            Navigator.pop(context, barcode.rawValue);
          }
        },
      ),
    );
  }
}
