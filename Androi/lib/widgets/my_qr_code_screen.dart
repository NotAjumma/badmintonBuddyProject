import 'package:flutter/material.dart';

class MyQRCodeScreen extends StatelessWidget {
  final String qrCodeImagePath;

  const MyQRCodeScreen({Key? key, required this.qrCodeImagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My QR Code'),
      ),
      body: Center(
        child: Image.asset(qrCodeImagePath),
      ),
    );
  }
}

