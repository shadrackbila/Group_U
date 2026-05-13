import 'package:flutter/material.dart';

class PopUpFailed extends StatelessWidget {
  final String errorMessage;
  const PopUpFailed({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.red[300], size: 80),
          SizedBox(height: 10),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.red[300]),
          ),
        ],
      ),
    );
  }
}
