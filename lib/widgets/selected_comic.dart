import 'package:flutter/material.dart';

class SelectComic extends StatelessWidget {
  final bool isSelected;
  final Function onTap;
  final String text;
  SelectComic({this.text, this.isSelected, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: (isSelected) ? Colors.red : Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        margin: EdgeInsets.only(top: 5, right: 5),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
