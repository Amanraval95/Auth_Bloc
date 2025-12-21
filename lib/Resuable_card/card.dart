import 'package:flutter/material.dart';

class CustomizeCard extends StatelessWidget {
  const CustomizeCard({
    super.key,
    required this.email,
    required this.password,
    required this.button,
  });
  final String email;
  final String password;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return const Card(child: Column());
  }
}
