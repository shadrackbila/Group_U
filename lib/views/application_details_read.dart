import 'package:flutter/material.dart';

class ApplicationDetailsRead extends StatelessWidget {
  const ApplicationDetailsRead({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
      ),
      body: const Center(
        child: Text('Application Details Screen'),
      ),
    );
  }
}