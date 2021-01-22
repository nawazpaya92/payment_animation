import 'package:first_flutter_app/mainlogo.dart';
import 'package:first_flutter_app/sidelogo.dart';
import 'package:flutter/material.dart';

class BottomSheet1 extends StatefulWidget {
  //final Function changeView;

  //BottomSheet1(this.changeView);

  @override
  _BottomSheet1State createState() => _BottomSheet1State();
}

class _BottomSheet1State extends State<BottomSheet1> {
  bool isBottomSheet1 = true;

  HeroController heroController;


  void updateView() {
    print('Update View Called');
    setState(() {
      if (!isBottomSheet1) {
        isBottomSheet1 = true;
      } else {
        isBottomSheet1 = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isBottomSheet1) {
      return MainLogo(updateView);
    } else {
      return SideLogo();
    }
  }

  @override
  void initState() {
   // heroController=HeroController(createRectTween: _createRectTween);
    super.initState();

  }

}
