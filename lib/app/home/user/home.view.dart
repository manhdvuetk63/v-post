import 'package:flutter/material.dart';
import 'package:v_post/app/home/user/delivery/delivery.module.dart';
import 'package:v_post/app/home/user/home.module.dart';

class UserHomeWidget extends StatefulWidget {
  const UserHomeWidget({Key? key}) : super(key: key);

  @override
  _UserHomeWidgetState createState() => _UserHomeWidgetState();
}

class _UserHomeWidgetState extends State<UserHomeWidget> {
  List<Map<String, dynamic>> _mainModules = [
    {'icon': Icon(Icons.local_shipping_outlined), 'label': 'Giao hàng', 'widget': DeliveryModule(), 'route': UserHomeModule.delivery},
    {'icon': Icon(Icons.bar_chart_outlined), 'label': 'Lịch sử', 'widget': Container(), 'route': ""},
    {'icon': Icon(Icons.person_outlined), 'label': 'Cá nhân', 'widget': Container(), 'route': UserHomeModule.profile},
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
