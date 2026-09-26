import 'package:flutter/material.dart';

import 'package:laptix/Core/Constants/app_colors.dart';

class CodeSlashIcon extends StatelessWidget {
  const CodeSlashIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final color = IconTheme.of(context).color ?? AppColors.primaryColor;
    return CustomPaint(
      size: const Size(56, 56),
      painter: _CodeSlashPainter(color),
    );
  }
}

class BusinessChartIcon extends StatelessWidget {
  const BusinessChartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final color = IconTheme.of(context).color ?? AppColors.primaryColor;
    return CustomPaint(
      size: const Size(56, 56),
      painter: _BusinessChartPainter(color),
    );
  }
}

class DesignNodesIcon extends StatelessWidget {
  const DesignNodesIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final color = IconTheme.of(context).color ?? AppColors.primaryColor;
    return CustomPaint(
      size: const Size(56, 56),
      painter: _DesignNodesPainter(color),
    );
  }
}

class _CodeSlashPainter extends CustomPainter {
  final Color color;

  _CodeSlashPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final left = Path()
      ..moveTo(19.75, 21.25)
      ..lineTo(14.25, 26.75)
      ..lineTo(19.75, 32.25);
    canvas.drawPath(left, paint);

    final slash = Path()
      ..moveTo(24.75, 37.25)
      ..lineTo(31.25, 16.25);
    canvas.drawPath(slash, paint);

    final right = Path()
      ..moveTo(36.25, 21.25)
      ..lineTo(41.75, 26.75)
      ..lineTo(36.25, 32.25);
    canvas.drawPath(right, paint);
  }

  @override
  bool shouldRepaint(_CodeSlashPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _BusinessChartPainter extends CustomPainter {
  final Color color;

  _BusinessChartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final axes = Path()
      ..moveTo(17.5, 18)
      ..lineTo(17.5, 35.5)
      ..lineTo(38.5, 35.5);
    canvas.drawPath(axes, paint);

    final trend = Path()
      ..moveTo(22, 28.3)
      ..lineTo(27.5, 23.5)
      ..lineTo(31, 26)
      ..lineTo(37.3, 21.5);
    canvas.drawPath(trend, paint);
  }

  @override
  bool shouldRepaint(_BusinessChartPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _DesignNodesPainter extends CustomPainter {
  final Color color;

  _DesignNodesPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()..color = color;

    final arch = Path()
      ..moveTo(18.25, 30.5)
      ..cubicTo(18.25, 25, 19.5, 22.5, 21.75, 22.5)
      ..lineTo(34.25, 22.5)
      ..cubicTo(36.5, 22.5, 37.75, 25, 37.75, 30.5);
    canvas.drawPath(arch, stroke);

    final bar = Path()
      ..moveTo(15.75, 20)
      ..lineTo(40.25, 20);
    canvas.drawPath(bar, stroke);

    canvas.drawCircle(const Offset(15.75, 20), 2.75, fill);
    canvas.drawCircle(const Offset(40.25, 20), 2.75, fill);

    final centerSquare = RRect.fromRectAndRadius(
      const Rect.fromLTWH(25.75, 17.75, 4.5, 4.5),
      const Radius.circular(0.5),
    );
    canvas.drawRRect(centerSquare, stroke);

    final leftFoot = RRect.fromRectAndRadius(
      const Rect.fromLTWH(15.75, 31.75, 5, 3.5),
      const Radius.circular(0.5),
    );
    final rightFoot = RRect.fromRectAndRadius(
      const Rect.fromLTWH(35.25, 31.75, 5, 3.5),
      const Radius.circular(0.5),
    );
    canvas.drawRRect(leftFoot, stroke);
    canvas.drawRRect(rightFoot, stroke);
  }

  @override
  bool shouldRepaint(_DesignNodesPainter oldDelegate) =>
      oldDelegate.color != color;
}
