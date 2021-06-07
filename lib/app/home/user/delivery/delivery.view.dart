import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/app.module.dart';
import 'package:v_post/app/components/app-title/app-title.component.dart';
import 'package:v_post/app/components/appbar/appbar.component.dart';
import 'package:v_post/app/components/common-button/common-button.component.dart';
import 'package:v_post/app/components/text-field/text-field.component.dart';
import 'package:v_post/app/home/user/delivery/delivery.cubit.dart';
import 'package:v_post/app/home/user/delivery/delivery.module.dart';
import 'package:v_post/app/home/user/home.module.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/service/delivery/delivery.service.dart';
import 'package:v_post/themes/style.dart';
import 'package:wemapgl/wemapgl.dart';

class _NestedData {
  String hintText;
  Icon icon;
  String name;
  int? typeAddress;
  FormFieldValidator<String>? validator;

  _NestedData({required this.name, required this.hintText, required this.icon, this.typeAddress, this.validator});
}

class DeliveryWidget extends StatefulWidget {
  const DeliveryWidget({Key? key}) : super(key: key);

  @override
  _DeliveryWidgetState createState() => _DeliveryWidgetState();
}

class _DeliveryWidgetState extends State<DeliveryWidget> {
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  late List<MapEntry<String, List<_NestedData>>> _allForm;

  DeliveryCubit _cubit = DeliveryCubit(DeliveryService());

  @override
  void initState() {
    // TODO: implement initState
    _allForm = [
      MapEntry(
        "Người gửi",
        [
          _NestedData(name: "sender_name", hintText: "Họ và tên", icon: Icon(Icons.person_outlined)),
          _NestedData(name: "sender_phone", hintText: "Số điện thoại", icon: Icon(Icons.call_outlined)),
          _NestedData(name: "sender_address", hintText: "Địa chỉ", icon: Icon(Icons.place_outlined), typeAddress: 1),
        ],
      ),
      MapEntry(
        "Người nhận",
        [
          _NestedData(name: "receiver_name", hintText: "Họ và tên", icon: Icon(Icons.person_outlined)),
          _NestedData(name: "receiver_phone", hintText: "Số điện thoại", icon: Icon(Icons.call_outlined)),
          _NestedData(name: "receiver_address", hintText: "Địa chỉ", icon: Icon(Icons.place_outlined), typeAddress: 2),
        ],
      ),
      MapEntry(
        "Hàng hoá",
        [
          _NestedData(name: "package_name", hintText: "Tên hàng hóa", icon: Icon(Icons.all_inbox_outlined)),
          _NestedData(
              name: "package_price", hintText: "Giá trị", icon: Icon(Icons.attach_money_outlined), validator: FormBuilderValidators.integer(context)),
          _NestedData(
              name: "package_weight",
              hintText: "Khối lượng (kg)",
              icon: Icon(Icons.line_weight_outlined),
              validator: FormBuilderValidators.integer(context)),
          _NestedData(name: "package_description", hintText: "Mô tả", icon: Icon(Icons.description_outlined)),
        ],
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Do Phong nên mới để vào đây

    return Scaffold(
      appBar: staticAppbar(
        title: AppTitle(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: FormBuilder(
            key: _fbKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.safeBlockVertical * 2),
                Text(
                  "Giao hàng",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700, fontSize: 30),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 2),
                ..._allForm.map((e) => buildGroupTextField(title: e.key, data: e.value)),
                SizedBox(height: SizeConfig.safeBlockVertical * 5),
                Align(
                  alignment: Alignment.center,
                  child: CommonButton(
                    onPressed: () async {
                      if (_fbKey.currentState!.saveAndValidate()) {
                        _cubit.order = await _cubit.confirmOrder(_fbKey.currentState!.value);
                        Modular.to
                            .pushNamed(AppModule.user + UserHomeModule.delivery + DeliveryModule.deliveryConfirmation, arguments: _cubit.order)
                            .whenComplete(() => _fbKey.currentState!.reset());
                      } else {
                        print('aaa');
                      }
                    },
                    child: Text(
                      "Tiếp theo",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: AppColor.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    backgroundColor: AppColor.accentColor,
                  ),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGroupTextField({required String title, required List<_NestedData> data}) => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColor.accentColor, fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            ...data.map(
              (e) => e.hintText != "Địa chỉ"
                  ? TextFieldView(
                      name: e.name,
                      type: 'text_field',
                      hintText: e.hintText,
                      prefixIcon: e.icon,
                      validator: e.validator,
                    )
                  : buildCustomAddressForm(e, e.typeAddress),
            ),
          ],
        ),
      );

  Widget buildCustomAddressForm(_NestedData e, int? type) => Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical),
        child: GestureDetector(
          onTap: () => Modular.to.pushNamed<WeMapPlace?>(AppModule.user + UserHomeModule.delivery + DeliveryModule.placePicking).then((value) {
            setState(() {
              type == 1 ? _cubit.placeSender = value : _cubit.placeReceiver = value;
            });
          }),
          child: FormBuilderTextField(
            enabled: false,
            name: e.name,
            maxLines: 1,
            style: const TextStyle(fontSize: 18),
            initialValue: type == 1 ? _cubit.placeSender?.placeName ?? "" : _cubit.placeReceiver?.placeName ?? "",
            key: Key(type == 1 ? _cubit.placeSender?.placeName ?? "" : _cubit.placeReceiver?.placeName ?? ""),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintText: e.hintText,
              hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF7A7A7A)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.accentColor, width: 1.25, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(13),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.accentColor, width: 1.25, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(13),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.errorColor, width: 1.25, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(13),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.errorColor, width: 1.25, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(13),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.accentColor, width: 1.25, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(13),
              ),
              prefixIcon: e.icon,
            ),
            // Todo: uncomment to navigate to place picking.
            keyboardType: TextInputType.text,
            validator: FormBuilderValidators.required(context),
          ),
        ),
      );
}
