import 'package:flutter/material.dart';
import 'package:v_post/app/components/appbar/appbar.component.dart';

class PlacePicking extends StatefulWidget {
  const PlacePicking({Key? key}) : super(key: key);

  @override
  _PlacePickingState createState() => _PlacePickingState();
}

class _PlacePickingState extends State<PlacePicking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staticAppbar(
        leading: BackButtonWidget()
      ),
    );
  }
}
