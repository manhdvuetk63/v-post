import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:v_post/app/components/app-title/app-title.component.dart';
import 'package:v_post/app/components/common-button/common-button.component.dart';
import 'package:v_post/app/components/text-field/text-field.component.dart';
import 'package:v_post/app/signup/signup.cubit.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/themes/style.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  SignupCubit _cubit = SignupCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.safeBlockVertical * 3),
              AppTitle(),
              SizedBox(height: SizeConfig.safeBlockVertical * 3),
              Text(
                "Tạo tài khoản",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical),
              SizedBox(child: buildLoginWidget(), width: SizeConfig.safeBlockHorizontal * 85),
              SizedBox(height: SizeConfig.safeBlockVertical),
              SizedBox(child: buildOtherMethodWidget(), width: SizeConfig.safeBlockHorizontal * 80),
              SizedBox(height: SizeConfig.safeBlockVertical * 3),
            ],
          ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text("Tên", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700)),
          TextFieldView(
            name: "user_name",
            hintText: "Bắt buộc",
            validator: FormBuilderValidators.required(context),
            type: 'text_field',
          ),
          Text("Số điện thoại", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700)),
          TextFieldView(
            name: "phone",
            hintText: "Bắt buộc",
            validator: FormBuilderValidators.required(context),
            type: 'text_field',
          ),
          SizedBox(height: SizeConfig.safeBlockVertical),
          Text("Mật khẩu", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700)),
          TextFieldView(
            name: 'password',
            hintText: "Bắt buộc",
            validator: FormBuilderValidators.required(context),
            type: 'password',
          ),
          Text("Xác nhận mật khẩu", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700)),
          TextFieldView(
            name: 'password',
            hintText: "Bắt buộc",
            validator: FormBuilderValidators.required(context),
            type: 'password',
          ),
          SizedBox(height: SizeConfig.safeBlockVertical),
          ButtonTheme(
            minWidth: SizeConfig.safeBlockHorizontal * 55,
            height: 45.0,
            child: BlocBuilder<SignupCubit, SignupState>(
              bloc: _cubit,
              builder: (context, state) {
                return AbsorbPointer(
                  absorbing: state is Signing,
                  child: CommonButton(
                      onPressed: () async {},
                      backgroundColor: AppColor.accentColor,
                      child: Container(
                        alignment: Alignment.center,
                        width: SizeConfig.safeBlockHorizontal * 80,
                        child: state is! Signing
                            ? Text(
                                "Đăng nhập",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                              )
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

  Widget buildOtherMethodWidget() => Column(
        children: [
          SizedBox(height: SizeConfig.safeBlockVertical),
          Text(
            "Hoặc",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Color(0xFFFF0000).withOpacity(0.89),
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Image.asset("assets/images/login/facebook.png", height: 50),
                onTap: () => print("aaa"),
              ),
              GestureDetector(
                child: Image.asset("assets/images/login/gmail.png", height: 50),
                onTap: () => print("aaa"),
              ),
              GestureDetector(
                child: Image.asset("assets/images/login/zalo.png", height: 50),
                onTap: () => print("aaa"),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          Text(
            "Bạn chưa có tài khoản",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: Navigator.of(context).pop,
            child: Text(
              "Đăng nhập",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, color: Color(0xFFDB3E00)),
            ),
          ),
        ],
      );
}
