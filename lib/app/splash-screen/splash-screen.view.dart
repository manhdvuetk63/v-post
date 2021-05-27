import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/app.module.dart';
import 'package:v_post/app/components/loading-dots/loading-dots.component.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/config/config_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  Future<Timer> startTime() async => Timer(Duration(milliseconds: 1500), navigationPage);

  void navigationPage() => Application.sharePreference.hasKey('authToken') && Application.sharePreference.hasKey('userId')
      ? Modular.to.pushReplacementNamed(AppModule.home)
      : Modular.to.pushReplacementNamed(AppModule.home);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: LoadingDots(numberDots: 5),
      ),
    );
  }
}
