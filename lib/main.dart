import 'package:first_flutter_app/bottomsheet1.dart';
import 'package:first_flutter_app/bottomsheet2.dart';
import 'package:first_flutter_app/initiatePayment.dart';
import 'package:first_flutter_app/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool _isBottomSheet1 = true;

  void changeView() {
    setState(() {
      _isBottomSheet1 = false;
      print('Value of IsBottom SHeet is $_isBottomSheet1');
      //_openBottomSheet()
    });
  }

  void _openBottomSheet(BuildContext context) {
    print('Open');

    /* Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Test();
    }));*/
    showModalBottomSheet(
      context: context,
      builder: (context) {
        //return _isBottomSheet1 ? BottomSheet1(changeView) : BottomSheet2();
        return InitiatePayment();
      },
    );
  }

  AnimationController _controller;
  AnimationController _controller1;
  Animation _animation;
  Animation _animation1;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _controller1 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = Tween(begin: 0.0, end: -150.0).animate(_controller);
    _animation1 = Tween(begin: 100.0, end: 50.0).animate(_controller1);

    _animation.addListener(() {
      setState(() {});
    });
    _animation.addStatusListener((status) {
      if (_animation.isCompleted) {
        //_controller.reverse();
        //_controller1.reverse();
      } else if (_animation.isDismissed) {
        _controller.forward();
        _controller1.forward();
      }
    });

    _controller.forward();
    _controller1.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('This is App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Open Bottom Sheet'),
              onPressed: () => _openBottomSheet(context),
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Transform.translate(
                      offset: Offset(_animation.value, _animation.value),
                      child: Container(
                        height: _animation1.value,
                        width: _animation1.value,
                        color: Colors.white,
                        child: Text(''),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
