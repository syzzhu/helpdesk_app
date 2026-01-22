import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  final bool fixed;
  const LogoHeader({super.key, this.fixed = false});

  @override
  Widget build(BuildContext context) {
    final logo = Row(
      children: [
        Image.asset('assets/images/bernama_logo.webp', height: 40),
        const SizedBox(width: 8),
        const Text(
          'BERNAMA',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );

    if (fixed) {
      return Positioned(top: 10, left: 10, child: logo);
    } else {
      return Align(alignment: Alignment.centerLeft, child: logo);
    }
  }
}
