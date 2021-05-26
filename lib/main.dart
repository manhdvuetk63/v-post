// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/app.module.dart';
import 'package:v_post/app/app.view.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/themes/style.dart';
import 'package:v_post/utils/shared_preferences.dart';
import 'package:wemapgl/wemapgl.dart' as we_map;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: AppColor.white,
    ),
  );
  await Future.wait([
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]),
  ]);
  Application.sharePreference = await SpUtil.getInstance();
  we_map.Configuration.setWeMapKey('GqfwrZUEfxbwbnQUhtBMFivEysYIxelQ');
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
