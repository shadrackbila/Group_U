import 'package:flutter/material.dart';

class PopUpSuccess extends StatelessWidget {
  const PopUpSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Icon(Icons.check_circle, color: Colors.green[300], size: 130),
    );
  }
}
