import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget {
  final double highestOfToday;

  RadialProgress({Key key, this.highestOfToday}) : super(key: key);

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  final double maximumLimit = 500;
  Tween<double> _valueTween;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 1);

  double progress = 0;

  @override
  void initState() {
    _radialProgressAnimationController = AnimationController(
      vsync: this,
      duration: fillDuration,
    );
    _valueTween = Tween(
      begin: 0.0,
      end: 360.0,
    );
    _progressAnimation = _valueTween.animate(CurvedAnimation(
      parent: _radialProgressAnimationController,
      curve: Curves.easeIn,
    ))
      ..addListener(() {
        setState(() {
          progress =
              (widget.highestOfToday / maximumLimit) * _progressAnimation.value;
        });
      });
    _radialProgressAnimationController.forward();
    super.initState();
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
          opacity: progress > 30 ? 1.0 : 0.5,
          duration: fadeInDuration,
          child: Column(
            children: <Widget>[
              Text(
                'Top',
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
                widget.highestOfToday.toString(),
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'mg/dL',
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

  @override
  void didUpdateWidget(RadialProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (this.widget.highestOfToday != oldWidget.highestOfToday) {
      // Try to start with the previous tween's end value. This ensures that we
      // have a smooth transition from where the previous animation reached.
      double beginValue =
          this._valueTween?.evaluate(this._radialProgressAnimationController) ??
              oldWidget?.highestOfToday ??
              0;

      // Update the value tween.
      this._valueTween = Tween<double>(
        begin: beginValue,
        end: this.widget.highestOfToday ?? 1,
      );

      this._radialProgressAnimationController
        ..value = 0
        ..forward();
    }
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
        colors: [Colors.red, Colors.purple, Colors.blueAccent],
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
