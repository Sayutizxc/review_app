import 'package:flutter/material.dart';

class SelectTag extends StatelessWidget {
  final bool isSelected;
  final Function onTap;
  final Function onDelete;
  final String text;
  SelectTag({this.text, this.isSelected, this.onTap, this.onDelete});
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
          color: (isSelected) ? Colors.purple : Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        margin: EdgeInsets.only(top: 5, right: 5),
        child: Wrap(
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
