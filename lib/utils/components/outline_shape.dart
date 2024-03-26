import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  final Color strokeColor;

  RPSCustomPainter({super.repaint, required this.strokeColor});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8888889, size.height * 0.009569378);
    path_0.lineTo(size.width * 0.1049383, size.height * 0.009569378);
    path_0.cubicTo(
        size.width * 0.05039167,
        size.height * 0.009569378,
        size.width * 0.006172840,
        size.height * 0.07811914,
        size.width * 0.006172840,
        size.height * 0.1626794);
    path_0.lineTo(size.width * 0.006172840, size.height * 0.2009569);
    path_0.lineTo(size.width * 0.006172840, size.height * 0.8492823);
    path_0.lineTo(size.width * 0.006172840, size.height * 0.8851675);
    path_0.cubicTo(
        size.width * 0.006172840,
        size.height * 0.9446220,
        size.width * 0.03726420,
        size.height * 0.9928230,
        size.width * 0.07561728,
        size.height * 0.9928230);
    path_0.lineTo(size.width * 0.1049383, size.height * 0.9928230);
    path_0.lineTo(size.width * 0.2685185, size.height * 0.9928230);
    path_0.cubicTo(
        size.width * 0.3136914,
        size.height * 0.9928230,
        size.width * 0.3503086,
        size.height * 0.9360574,
        size.width * 0.3503086,
        size.height * 0.8660287);
    path_0.lineTo(size.width * 0.3503086, size.height * 0.8492823);
    path_0.lineTo(size.width * 0.3503086, size.height * 0.7368421);
    path_0.lineTo(size.width * 0.3503086, size.height * 0.7344498);
    path_0.cubicTo(
        size.width * 0.3503086,
        size.height * 0.6882057,
        size.width * 0.3744907,
        size.height * 0.6507177,
        size.width * 0.4043210,
        size.height * 0.6507177);
    path_0.lineTo(size.width * 0.6033951, size.height * 0.6507177);
    path_0.cubicTo(
        size.width * 0.6323735,
        size.height * 0.6507177,
        size.width * 0.6558642,
        size.height * 0.6871340,
        size.width * 0.6558642,
        size.height * 0.7320574);
    path_0.lineTo(size.width * 0.6558642, size.height * 0.7368421);
    path_0.lineTo(size.width * 0.6558642, size.height * 0.8492823);
    path_0.lineTo(size.width * 0.6558642, size.height * 0.8540670);
    path_0.cubicTo(
        size.width * 0.6558642,
        size.height * 0.9306986,
        size.width * 0.6959383,
        size.height * 0.9928230,
        size.width * 0.7453704,
        size.height * 0.9928230);
    path_0.lineTo(size.width * 0.9305556, size.height * 0.9928230);
    path_0.cubicTo(
        size.width * 0.9663519,
        size.height * 0.9928230,
        size.width * 0.9953704,
        size.height * 0.9478373,
        size.width * 0.9953704,
        size.height * 0.8923445);
    path_0.lineTo(size.width * 0.9953704, size.height * 0.8492823);
    path_0.lineTo(size.width * 0.9953704, size.height * 0.2009569);
    path_0.lineTo(size.width * 0.9953704, size.height * 0.1746411);
    path_0.cubicTo(
        size.width * 0.9953704,
        size.height * 0.08347464,
        size.width * 0.9476975,
        size.height * 0.009569378,
        size.width * 0.8888889,
        size.height * 0.009569378);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.018259259;
    paint0Stroke.color = strokeColor;
    // paint0Stroke.color = Colors.black.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);

    // Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    // paint0Fill.color = const Color(0xff000000).withOpacity(1.0);
    // canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8888889, size.height * 0.009569378);
    path_0.lineTo(size.width * 0.1049383, size.height * 0.009569378);
    path_0.cubicTo(
        size.width * 0.05039167,
        size.height * 0.009569378,
        size.width * 0.006172840,
        size.height * 0.07811914,
        size.width * 0.006172840,
        size.height * 0.1626794);
    path_0.lineTo(size.width * 0.006172840, size.height * 0.2009569);
    path_0.lineTo(size.width * 0.006172840, size.height * 0.8492823);
    path_0.lineTo(size.width * 0.006172840, size.height * 0.8851675);
    path_0.cubicTo(
        size.width * 0.006172840,
        size.height * 0.9446220,
        size.width * 0.03726420,
        size.height * 0.9928230,
        size.width * 0.07561728,
        size.height * 0.9928230);
    path_0.lineTo(size.width * 0.1049383, size.height * 0.9928230);
    path_0.lineTo(size.width * 0.2685185, size.height * 0.9928230);
    path_0.cubicTo(
        size.width * 0.3136914,
        size.height * 0.9928230,
        size.width * 0.3503086,
        size.height * 0.9360574,
        size.width * 0.3503086,
        size.height * 0.8660287);
    path_0.lineTo(size.width * 0.3503086, size.height * 0.8492823);
    path_0.lineTo(size.width * 0.3503086, size.height * 0.7368421);
    path_0.lineTo(size.width * 0.3503086, size.height * 0.7344498);
    path_0.cubicTo(
        size.width * 0.3503086,
        size.height * 0.6882057,
        size.width * 0.3744907,
        size.height * 0.6507177,
        size.width * 0.4043210,
        size.height * 0.6507177);
    path_0.lineTo(size.width * 0.6033951, size.height * 0.6507177);
    path_0.cubicTo(
        size.width * 0.6323735,
        size.height * 0.6507177,
        size.width * 0.6558642,
        size.height * 0.6871340,
        size.width * 0.6558642,
        size.height * 0.7320574);
    path_0.lineTo(size.width * 0.6558642, size.height * 0.7368421);
    path_0.lineTo(size.width * 0.6558642, size.height * 0.8492823);
    path_0.lineTo(size.width * 0.6558642, size.height * 0.8540670);
    path_0.cubicTo(
        size.width * 0.6558642,
        size.height * 0.9306986,
        size.width * 0.6959383,
        size.height * 0.9928230,
        size.width * 0.7453704,
        size.height * 0.9928230);
    path_0.lineTo(size.width * 0.9305556, size.height * 0.9928230);
    path_0.cubicTo(
        size.width * 0.9663519,
        size.height * 0.9928230,
        size.width * 0.9953704,
        size.height * 0.9478373,
        size.width * 0.9953704,
        size.height * 0.8923445);
    path_0.lineTo(size.width * 0.9953704, size.height * 0.8492823);
    path_0.lineTo(size.width * 0.9953704, size.height * 0.2009569);
    path_0.lineTo(size.width * 0.9953704, size.height * 0.1746411);
    path_0.cubicTo(
        size.width * 0.9953704,
        size.height * 0.08347464,
        size.width * 0.9476975,
        size.height * 0.009569378,
        size.width * 0.8888889,
        size.height * 0.009569378);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Define a custom path to create a stylish clipped shape
    var path = Path();
    path.moveTo(0, size.height * 0.5);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(size.width * 0.8, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
