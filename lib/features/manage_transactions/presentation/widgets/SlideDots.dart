import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12: 8,
      width: isActive ? 12: 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF7644ad) : Color(0xFF797f94),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}
