import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/app.module.dart';
import 'package:v_post/app/components/common-button/common-button.component.dart';
import 'package:v_post/app/components/text-field/text-field.component.dart';
import 'package:v_post/app/login/login.cubit.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/themes/style.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final LoginCubit _cubit = LoginCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Container(
        margin: EdgeInsets.all(15),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Align(
              child: TextButton(
                child: Text("Close", style: TextStyle(fontSize: 16, color: Color(0xFf0294E7), fontWeight: FontWeight.w500)),
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
              alignment: Alignment.topRight,
            ),
            Spacer(flex: 2),
            Align(
              child: Text("V Post", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: AppColor.accentColor)),
              alignment: Alignment.center,
            ),
            SizedBox(
              child: buildLoginWidget(),
              width: SizeConfig.safeBlockHorizontal * 80,
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  Widget buildLoginWidget() {
    return FormBuilder(
      key: _fbKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          TextFieldView(
            name: "user_name",
            hintText: "User name or email",
            validator: FormBuilderValidators.required(context),
            initialValue: Application.sharePreference.getStringList("credentialData")?.elementAt(0),
            type: 'text_field',
          ),
          SizedBox(height: SizeConfig.safeBlockVertical),
          TextFieldView(
            name: 'password',
            hintText: "Password",
            initialValue: Application.sharePreference.getStringList("credentialData")?.elementAt(1),
            validator: FormBuilderValidators.required(context),
            type: 'password',
          ),
          SizedBox(height: SizeConfig.safeBlockVertical),
          ButtonTheme(
            minWidth: SizeConfig.safeBlockHorizontal * 55,
            height: 45.0,
            child: BlocBuilder<LoginCubit, LoginState>(
              bloc: _cubit,
              builder: (context, state) {
                return AbsorbPointer(
                  absorbing: state is Signing,
                  child: CommonButton(
                      onPressed: () async {
                        _fbKey.currentState!.saveAndValidate()
                            ? await _cubit.login(_fbKey.currentState!.value)
                                ? Modular.to.pushReplacementNamed(AppModule.home)
                                : Application.toast.showToastNotification("Wrong User Name or Password")
                            : Application.toast.showToastNotification("Invalid Value");
                      },
                      backgroundColor: AppColor.accentColor,
                      child: Container(
                        alignment: Alignment.center,
                        width: SizeConfig.safeBlockHorizontal * 80,
                        child: state is! Signing
                            ? Text("Login".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500))
                            : Theme(
                                data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
                                child: CupertinoActivityIndicator(),
                              ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
