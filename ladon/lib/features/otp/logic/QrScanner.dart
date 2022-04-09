import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrScanner {
  static Future<String> scan() async {
    return await FlutterBarcodeScanner.scanBarcode(
        "#bfff00", "Cancle", true, ScanMode.QR);
  }
}
