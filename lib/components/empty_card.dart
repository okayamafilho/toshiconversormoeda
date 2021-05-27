import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  EmptyCard(this.text);

  String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.green,
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
