import 'package:flutter/material.dart';
import 'package:flutter_form_builder/localization/form_builder_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/config/locale.dart';
import 'package:v_post/themes/style.dart';
import 'package:v_post/utils/api.dart';
import 'package:v_post/utils/custom_toast.dart';

class AppWidget extends StatefulWidget {
  AppWidget() {
    Application.api = API();
    Application.toast = Toastify();
    Application.sharePreference.putString('locale', "vi_vn");
    Intl.defaultLocale = Application.sharePreference.getString('locale');
  }

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // FormBuilderLocalizations.delegate,
      ],
      supportedLocales: AppLocale.locales.values.toList(),
      locale: AppLocale.locales[Application.sharePreference.getString('locale')],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.white,
        accentColor: AppColor.accentColor,
        fontFamily: "Quicksand",
      ),
      debugShowCheckedModeBanner: false,
    ).modular();
  }
}
