import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    boxController.forward();
  }

  void _setupAnimations() {
    _setupBoxAnimation();
    _setupCatAnimation();
  }

  void _setupBoxAnimation() {
    boxController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800)
    );

    boxAnimation = Tween(begin: pi * .6, end: pi * .65).animate(
        CurvedAnimation(
            curve: Curves.easeInOut,
            parent: boxController
        )
    );

    boxAnimation.addListener(() {
      if (boxAnimation.status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (boxAnimation.status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
  }

  void _setupCatAnimation() {
    catController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200)
    );

    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
        CurvedAnimation(
            parent: catController,
            curve: Curves.easeIn
        )
    );
  }

  void _startAnimation() {
    if (catController.isCompleted) {
      boxController.forward();
      catController.reverse();
    } else if (catController.isDismissed) {
      boxController.stop();
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!'),
      ),
      body: GestureDetector(
        onTap: _startAnimation,
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              _buildCatAnimation(),
              _buildBox(),
              _buildLeftFlap(),
              _buildRightFlap(),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildBox() => Container(
    height: 200.0,
    width: 200.0,
    color: Colors.brown,
  );

  Widget _buildCatAnimation() => AnimatedBuilder(
    animation: catAnimation,
    builder: (context, child) => Positioned(
      child: child,
      top: catAnimation.value,
      right: 0,
      left: 0,
    ),
    child: Cat(),
  );

  Widget _buildLeftFlap() => Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) => Transform.rotate(
          angle: boxAnimation.value,
          alignment: Alignment.topLeft,
          child: child,
        ),
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
      )
  );



  Widget _buildRightFlap() => Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) => Transform.rotate(
          angle: -boxAnimation.value,
          alignment: Alignment.topRight,
          child: child,
        ),
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
      )
  );
}
