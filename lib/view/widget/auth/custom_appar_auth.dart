import 'package:flutter/material.dart';

class CustomApparAuth extends StatelessWidget {
  const CustomApparAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C3C78),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.handshake_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  );
  }
}