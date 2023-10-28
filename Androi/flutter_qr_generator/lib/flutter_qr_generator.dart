// lib/flutter_qr_generator.dart
import 'package:flutter/services.dart';

class FlutterQRGenerator {
  static const MethodChannel _channel = MethodChannel('flutter_qr_generator');

  static Future<void> generateQRCode(String qrCodeData, int size, String filePath) async {
    try {
      await _channel.invokeMethod('generateQRCode', {
        'qrCodeData': qrCodeData,
        'size': size,
        'filePath': filePath,
      });
    } catch (e) {
      throw Exception('Error generating QR code: $e');
    }
  }
}
