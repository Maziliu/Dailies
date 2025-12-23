import 'package:flutter/material.dart';

class SuccessSnackbarContent extends StatelessWidget {
  final String message;

  const SuccessSnackbarContent({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}
