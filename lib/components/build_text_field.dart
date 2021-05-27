import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField(
      {this.label, this.prefix, this.textEditingController, this.function});

  String label;
  String prefix;
  TextEditingController textEditingController;
  Function function;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green[800]),
        border: OutlineInputBorder(),
        prefixText: prefix,
        isDense: true,
      ),
      style: TextStyle(
        color: Colors.grey[700],
      ),
      onChanged: function,
    );
  }
}
