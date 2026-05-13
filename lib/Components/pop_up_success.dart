import 'package:flutter/material.dart';

class PopUpSuccess extends StatelessWidget {
  final String message;
  const PopUpSuccess({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green[300], size: 80),
          SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.green[300]),
          ),
        ],
      ),
    );
  }
}