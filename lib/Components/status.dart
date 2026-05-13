import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  final String status;
  const Status({super.key, required this.status});

  Color _getBackgroundColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color.fromARGB(141, 255, 214, 64);
      case 'approved':
      case 'accepted':
        return const Color.fromARGB(141, 100, 220, 100);
      case 'rejected':
        return const Color.fromARGB(141, 220, 100, 100);
      default:
        return const Color.fromARGB(141, 200, 200, 200);
    }
  }

  Color _getTextColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color.fromARGB(255, 123, 93, 2);
      case 'approved':
      case 'accepted':
        return const Color.fromARGB(255, 2, 100, 2);
      case 'rejected':
        return const Color.fromARGB(255, 150, 2, 2);
      default:
        return const Color.fromARGB(255, 100, 100, 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(5),
      child: Text(status, style: TextStyle(color: _getTextColor())),
    );
  }
}