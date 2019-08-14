import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget {
  final double goalCompleted = 0.7;

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;

  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double progress = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController = AnimationController(
      vsync: this,
      duration: fillDuration,
    );
    _progressAnimation = Tween(
      begin: 0.0,
      end: 360.0,
    ).animate(CurvedAnimation(
      parent: _radialProgressAnimationController,
      curve: Curves.easeIn,
    ))
      ..addListener(() {
        setState(() {
          progress = widget.goalCompleted * _progressAnimation.value;
        });
      });
    _radialProgressAnimationController.forward();
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 200,
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 40.0),
        child: AnimatedOpacity(
          opacity: progress > 30 ? 1.0 : 0.0,
          duration: fadeInDuration,
          child: Column(
            children: <Widget>[
              Text(
                'Level',
                style: TextStyle(fontSize: 24.0, letterSpacing: 1.5),
              ),
              SizedBox(
                height: 4.0,
              ),
              Container(
                height: 5.0,
                width: 80.0,
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '130',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'UNITS',
                style: TextStyle(
                    fontSize: 14.0, color: Colors.blue, letterSpacing: 1.5),
              ),
            ],
          ),
        ),
      ),
      painter: RadialPainter(progress),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;

  RadialPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    Paint foundationPaint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;
    Offset offset = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(offset, size.width / 2, foundationPaint);

    Paint progressPaint = Paint()
      ..color = Colors.blue
      ..shader = LinearGradient(
        colors: [Colors.red, Colors.purple, Colors.purpleAccent],
      ).createShader(
        Rect.fromCircle(
          center: offset,
          radius: size.width / 2,
        ),
      )
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;
    canvas.drawArc(
        Rect.fromCircle(center: offset, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
