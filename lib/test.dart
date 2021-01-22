import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: GestureDetector(
          child: Hero(
            tag: 'image',
            child: Icon(
              Icons.eighteen_mp,
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}
