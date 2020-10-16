import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final String suffixText;
  final int maxLength;
  final int minLines;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function onChanged;
  final Widget suffixIcon;
  final TextCapitalization textCapitalization;
  const CustomFormField(
      {this.title,
      this.maxLength,
      this.minLines,
      this.keyboardType,
      this.controller,
      this.onChanged,
      this.suffixIcon,
      this.suffixText,
      this.hintText,
      this.textCapitalization});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        autocorrect: false,
        textAlign: TextAlign.justify,
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType,
        maxLines: null,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        minLines: minLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.black45,
          labelText: title,
          hintText: hintText,
          suffixText: suffixText,
          suffixStyle: TextStyle(fontSize: 18, color: Colors.grey[400]),
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
