import 'package:control_escolar/const/const.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _bgMain(),
        Container(
          height: _size.height,
          width: _size.width,
          color: Colors.transparent,
          child: CustomPaint(
            painter: _Curve1(),
          ),
        ),
        Container(
          height: _size.height,
          width: _size.width,
          color: Colors.transparent,
          child: CustomPaint(
            painter: _Curve2(),
          ),
        ),
      ],
    );
  }

  Widget _bgMain() {
    return Container(
      height: _size.height,
      decoration: BoxDecoration(
        color: kBlueColor,
      ),
    );
  }
}

class _Curve1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    paint.color = kGreenColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;
    final path = new Path();
    path.moveTo(0, size.height * 0.46);

    //Wave
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.43,
        size.width * 0.6, size.height * 0.35);
    path.quadraticBezierTo(
        size.width * .80, size.height * 0.23, size.width, size.height * 0.23);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _Curve2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromCircle(
        center: Offset(size.width, size.height), radius: 3000);

    final gradiants = new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF3C9D9B),
          Colors.white,
        ],
        stops: [
          0.01,
          1.0,
        ]);

    final paint = new Paint()..shader = gradiants.createShader(rect);
    paint.color = kGreenColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;
    final path = new Path();
    double dy = 15.0;
    path.moveTo(0, size.height * 0.46 + dy);
    //Wave
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.43 + dy,
        size.width * 0.6, size.height * 0.35 + dy);
    path.quadraticBezierTo(size.width * .80, size.height * 0.23 + dy,
        size.width, size.height * 0.23 + dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.46);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
