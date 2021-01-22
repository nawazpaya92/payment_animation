import 'package:flutter/material.dart';

class BottomSheet2 extends StatefulWidget {
  @override
  _BottomSheet2State createState() => _BottomSheet2State();
}

class _BottomSheet2State extends State<BottomSheet2> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Center(
        child: GestureDetector(
          child: Icon(
            Icons.ac_unit,
            color: Colors.purple,
            size: 48,
          ),
        ),
      ),
    );
  }
}
