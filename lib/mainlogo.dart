import 'package:flutter/material.dart';

class MainLogo extends StatefulWidget {
  final Function updateView;

  MainLogo(this.updateView);

  @override
  _MainLogoState createState() => _MainLogoState();
}

class _MainLogoState extends State<MainLogo> with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;
  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    _animation = Tween(begin: 20.0, end: 100.0).animate(_controller);

    _animation.addListener(() {
    //  setState(() {});
    });

    _animation.addStatusListener((status) {
      if (_animation.isCompleted) {
        _controller.reverse();
      } else if (_animation.isDismissed) {
        _controller.forward();
      }
    });

   // _controller.forward();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0, end: 50).animate(_positionController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Tap'),
              onPressed: () {
                _positionController.forward();
              },
            ),
            Container(
                height: _animation.value,
                width: _animation.value,
                child: FlutterLogo()),
            Stack(
              children: [

                   Container(
                    height: 150,
                    width: 150,
                    color: Colors.blue,
                  ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
