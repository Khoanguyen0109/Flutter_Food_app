import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_app/configs/colors.dart';

class CircleProgress extends CustomPainter {
  static const double STROKE_WIDTH = 12;
  static const double RADIUS = 100;

  double currentProgress;
  CircleProgress(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {
    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = STROKE_WIDTH
      ..color = lineColor
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = STROKE_WIDTH
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height/2);

    canvas.drawCircle(center, RADIUS, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress/100);

    canvas.drawArc(Rect.fromCircle(center: center,radius: RADIUS), -pi/2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class CircularProgressBar extends StatefulWidget {
  final double currentProgress;
  CircularProgressBar({this.currentProgress = 0.0});

  @override
  _CircularProgressBarState createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar> with SingleTickerProviderStateMixin {

  late AnimationController progressController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    animation = Tween(begin: widget.currentProgress, end: widget.currentProgress).animate(progressController)..addListener((){
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircleProgress(animation.value), // this will add custom painter after child
    );
  }
}
