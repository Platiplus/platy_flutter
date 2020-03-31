import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalProgressIndicator extends StatefulWidget {
  final endAnimation;

  HorizontalProgressIndicator({ this.endAnimation });

  @override
  HorizontalProgressIndicatorState createState() => new HorizontalProgressIndicatorState();
}

class HorizontalProgressIndicatorState extends State<HorizontalProgressIndicator>
    with SingleTickerProviderStateMixin {

  AnimationController controller;

  Animation animation;

  double beginAnim = 0.0 ;

  @override
  void initState() {
    super.initState();
    controller = AnimationController( duration: const Duration(seconds: 1), vsync: this );
    animation = Tween(begin: beginAnim, end: widget.endAnimation).animate(controller)..addListener(() {
      setState(() {
        // Change here any Animation object value.
      });
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
        backgroundColor: Color(0xFFEEEEEE),
        valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xFF4A9CFF)
        ),
        value: animation.value
    );
  }
}