import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/config/config_screen.dart';

class SwitchingWidget extends StatefulWidget {
  const SwitchingWidget({Key? key}) : super(key: key);

  @override
  _SwitchingWidgetState createState() => _SwitchingWidgetState();
}

class _SwitchingWidgetState extends State<SwitchingWidget> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: SizeConfig.safeBlockHorizontal * 80,
          child: IntrinsicHeight(
            child: Column(
              children: [
                FormBuilder(
                  key: _fbKey,
                  child: FormBuilderRadioGroup(
                    decoration: InputDecoration(border: InputBorder.none),
                    options: ["User", "Shipper", "Admin"]
                        .map(
                          (e) => FormBuilderFieldOption(value: e, child: Text("$e")),
                        )
                        .toList(),
                    name: 'role',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_fbKey.currentState!.saveAndValidate()) {
                      var val = _fbKey.currentState!.value["role"];
                      Modular.to.pushReplacementNamed("/$val".toLowerCase());
                    }
                  },
                  child: Text("Go", style: Theme.of(context).textTheme.bodyText1),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
