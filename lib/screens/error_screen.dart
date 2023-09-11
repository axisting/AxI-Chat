import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? errorMessage;
  const ErrorScreen({super.key, this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: Center(
        child: errorMessage == null
            ? const Text("Error!")
            : Text(errorMessage.toString()),
      ),
    );
  }
}
