import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:i18n_extension/i18n_widget.dart';
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
    print(I18n.localeStr);
    Application.sharePreference.putString("locale", I18n.localeStr);
    startTime();
  }

  Future<Timer> startTime() async => Timer(Duration(milliseconds: 1500), navigationPage);

  void navigationPage() => Application.sharePreference.hasKey('authToken') && Application.sharePreference.hasKey('userId')
      ? Modular.to.pushReplacementNamed(AppModule.home)
      : Modular.to.pushReplacementNamed(AppModule.login);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: LoadingDots(numberDots: 5),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
