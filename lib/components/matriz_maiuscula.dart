import 'package:flutter/material.dart';

class MatrizMaiuscula extends StatelessWidget {
  const MatrizMaiuscula({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.circle_outlined, size: 50),
              ),
            ),
            SizedBox(width: 50),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.circle, size: 50),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.circle_outlined, size: 50),
              ),
            ),
            SizedBox(width: 50),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.circle_outlined, size: 50),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.circle_outlined, size: 50),
              ),
            ),
            SizedBox(width: 50),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.circle, size: 50),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
