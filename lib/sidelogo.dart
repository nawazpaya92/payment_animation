import 'package:flutter/material.dart';

class SideLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'image',
              transitionOnUserGestures: true,
              child: Icon(
            Icons.ac_unit,
            color: Colors.red,
                size: 36,
          ))
        ],
      ),
    );
  }
}
