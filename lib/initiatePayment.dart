import 'package:first_flutter_app/Animations/FadeAnimation.dart';
import 'package:flutter/material.dart';

class InitiatePayment extends StatefulWidget {
  @override
  _InitiatePaymentState createState() => _InitiatePaymentState();
}

class _InitiatePaymentState extends State<InitiatePayment>
    with TickerProviderStateMixin {
  Animation _sizeAnimation,
      _translateAnimation,
      _widthAnimation,
      _btnAnimation,
      _scale2Animation;
  AnimationController _sizeAnimationContoller,
      _scale2Controller,
      _btnController,
      _translateController,
      _widthController;
  bool isBackground, isWhite, isToShowText;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.infinity;
  bool _isPressed = false;
  bool _hideIcon = false;
  int _state = 0;

  @override
  void initState() {
    _sizeAnimationContoller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _widthAnimation =
        Tween<double>(begin: 50.0, end: 400.0).animate(_widthController);

    _translateController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _sizeAnimation =
        Tween<double>(begin: 0.0, end: -160).animate(_sizeAnimationContoller);
    _translateAnimation =
        Tween<double>(begin: 80, end: 40).animate(_translateController);

    _widthController.addStatusListener((status) {
      if (_widthAnimation.isCompleted) {
        setState(() {
          isToShowText = true;
        });
      }
    });
    _sizeAnimationContoller.addStatusListener((status) {
      if (_sizeAnimation.isCompleted) {
        setState(() {
          isWhite = false;

          _widthController.forward();
        });
      }
    });

    isBackground = true;
    isWhite = true;
    isToShowText = false;

    Future.delayed(Duration(milliseconds: 2000), () {
      initiateAnimation();
    });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _scale2Animation = Tween<double>(begin: 1.0, end: 25.0)
        .animate(_scale2Controller)
          ..addStatusListener((status) {});

    super.initState();
  }

  void initiateAnimation() {
    setState(() {
      isBackground = false;
    });
    _sizeAnimationContoller.forward();
    _translateController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _state == 3
        ? Center(
            child: Container(
              width: double.infinity,
              color: Colors.green,
              child: FadeAnimation(
                  1,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 64,
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          'Payment Done ! Thank you ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      )
                    ],
                  )),
            ),
          )
        : Container(
            color: isBackground ? Colors.deepPurpleAccent : Colors.white,
            child: isWhite
                ? Center(
                    child: AnimatedBuilder(
                      animation: _sizeAnimationContoller,
                      builder: (context, child) => Transform.translate(
                        offset:
                            Offset(_sizeAnimation.value, _sizeAnimation.value),
                        child: Container(
                          height: _translateAnimation.value,
                          width: _translateAnimation.value,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/gpy.png')),
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/gpy.png')),
                              ),
                            ),
                            Text(
                              'Pay',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            FlatButton(onPressed: null, child: Text('Cancel')),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        SizedBox(
                            height: 120,
                            child: Center(
                                child: Text(
                              'Here comes the item lists',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ))),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: AnimatedBuilder(
                            animation: _widthController,
                            builder: (context, child) => Container(
                              width: _widthAnimation.value,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: isToShowText
                                  ? Text(
                                      'Submit',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  : Text(''),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: PhysicalModel(
                            color: _state == 2 ? Colors.green : Colors.blue,
                            elevation: _isPressed ? 8 : 4,
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              key: _globalKey,
                              height: 48,
                              width: _width,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                padding: EdgeInsets.all(0.0),
                                color: _state == 2 ? Colors.green : Colors.blue,
                                child: btnChild(),
                                onPressed: () {},
                                onHighlightChanged: (isPressed) {
                                  setState(() {
                                    _isPressed = isPressed;
                                    if (_state == 0) {
                                      animateButton();
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _btnController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _btnAnimation = Tween(begin: 0.0, end: 1.0).animate(_btnController)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48.0) * _btnAnimation.value);
        });
      });

    _btnController.addStatusListener((status) {
      if (_btnAnimation.isCompleted) {
        setState(() {
          _state = 1;
        });
      }
    });
    _btnController.forward();

    Future.delayed(Duration(milliseconds: 2500), () {
      setState(() {
        _state = 2;
        Future.delayed(Duration(milliseconds: 1000), () {
          _scale2Controller.forward();
          _hideIcon = true;
        });
      });
    });

    _scale2Controller.addStatusListener((status) {
      if (_scale2Animation.isCompleted) {
        setState(() {
          _state = 3;
        });
      }
    });
  }

  Widget btnChild() {
    if (_state == 0) {
      return Text(
        'Submit',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      );
    } else if (_state == 1) {
      return SizedBox(
        width: 36.0,
        height: 36.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return AnimatedBuilder(
          animation: _scale2Controller,
          builder: (context, child) => Transform.scale(
              scale: _scale2Animation.value,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green,
                  ),
                  child: _hideIcon
                      ? Icon(Icons.check, color: Colors.green)
                      : Icon(Icons.check, color: Colors.white))));
    }
  }
}
