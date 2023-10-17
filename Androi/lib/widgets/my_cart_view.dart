import 'package:flutter/material.dart';

class MyCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const MyCartButton({super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60, // Adjust the height as needed
        color: Colors.blue, // Adjust the background color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white, // Adjust the text color
                  fontSize: 16, // Adjust the font size
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward, // You can use a different icon here
              color: Colors.white, // Adjust the icon color
              size: 24, // Adjust the icon size
            ),
          ],
        ),
      ),
    );
  }
}
