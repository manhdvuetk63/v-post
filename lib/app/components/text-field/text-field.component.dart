import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:v_post/app/components/text-field/text-field.cubit.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/themes/style.dart';

class TextFieldView extends StatefulWidget {
  final String name;
  final String type;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final String? initialValue;

  const TextFieldView({
    required this.name,
    required this.type,
    this.hintText,
    this.validator,
    this.initialValue,
  });

  @override
  State<StatefulWidget> createState() => TextFieldState();
}

class TextFieldState extends State<TextFieldView> {
  TextFieldCubit _cubit = TextFieldCubit();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical),
      child: Builder(
        builder: (context) {
          switch (widget.type) {
            case "password":
              return BlocBuilder<TextFieldCubit, bool>(
                bloc: _cubit,
                builder: (context, hasShowPassword) {
                  return FormBuilderTextField(
                    maxLines: 1,
                    name: widget.name,
                    initialValue: widget.initialValue,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF7A7A7A)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.accentColor, width: 1.25, style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.accentColor, width: 1.25, style: BorderStyle.solid)),
                      suffixIcon: IconButton(
                        icon: hasShowPassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                        onPressed: _cubit.toggleIconPassword,
                      ),
                    ),
                    obscureText: !hasShowPassword,
                    keyboardType: TextInputType.text,
                    validator: widget.validator,
                  );
                },
              );
            case "text_field":
              return FormBuilderTextField(
                maxLines: 1,
                initialValue: widget.initialValue,
                name: widget.name,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF7A7A7A)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.accentColor, width: 1.25, style: BorderStyle.solid)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.accentColor, width: 1.25, style: BorderStyle.solid)),
                ),
                keyboardType: TextInputType.text,
                validator: widget.validator,
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
