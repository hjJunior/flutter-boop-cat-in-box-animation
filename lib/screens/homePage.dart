import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  @override
  void initState() {
    super.initState();

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
      catController.reverse();
    } else if (catController.isDismissed) {
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
              _buildBox(),
              _buildCatAnimation(),
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
}
