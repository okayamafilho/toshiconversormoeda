import 'package:flutter/material.dart';

class TextVariation extends StatelessWidget {
  TextVariation({this.valueVariation});

  double valueVariation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(16),
        color: (valueVariation) < 0 ? Colors.red : Colors.green,
        child: Text(
          "$valueVariation %",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
