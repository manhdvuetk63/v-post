import 'package:flutter/material.dart';
import 'package:v_post/app/home/delivery/delivery.module.dart';
import 'package:v_post/app/home/home.module.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<Map<String, dynamic>> _mainModules = [
    {'icon': Icon(Icons.local_shipping_outlined), 'label': 'Giao hàng', 'widget': DeliveryModule(), 'route': HomeModule.delivery},
    {'icon': Icon(Icons.bar_chart_outlined), 'label': 'Lịch sử', 'widget': Container(), 'route': ""},
    {'icon': Icon(Icons.person_outlined), 'label': 'Cá nhân', 'widget': Container(), 'route': HomeModule.profile},
  ];

  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainModules[_selectIndex]['widget'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
          onTap: (index) => setState(() => _selectIndex = index),
          currentIndex: _selectIndex,
          items: _mainModules
              .map((e) => BottomNavigationBarItem(
                    icon: e["icon"] as Icon,
                    label: e["label"] as String,
                  ))
              .toList()),
    );
  }
}
