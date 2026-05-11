import 'package:flutter/material.dart';

class PopUpFailed extends StatelessWidget {
  const PopUpFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Icon(Icons.error, color: Colors.red[300], size: 130),
    );
  }
}
