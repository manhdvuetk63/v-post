import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:v_post/app/components/app-title/app-title.component.dart';
import 'package:v_post/app/components/appbar/appbar.component.dart';
import 'package:v_post/app/components/common-button/common-button.component.dart';
import 'package:v_post/app/components/text-field/text-field.component.dart';
import 'package:v_post/app/home/user/delivery/delivery.cubit.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/delivery/delivery.service.dart';
import 'package:v_post/themes/style.dart';

class _NestedData {
  String hintText;
  Icon icon;
  String name;

  _NestedData({required this.name, required this.hintText, required this.icon});
}

class DeliveryConfirmationWidget extends StatefulWidget {
  final Order? order;

  const DeliveryConfirmationWidget({Key? key, this.order}) : super(key: key);

  @override
  _DeliveryConfirmationWidgetState createState() => _DeliveryConfirmationWidgetState();
}

class _DeliveryConfirmationWidgetState extends State<DeliveryConfirmationWidget> {
  @override
  void initState() {
    print(widget.order!.toJson());
    super.initState();
  }

  DeliveryCubit _cubit = DeliveryCubit(DeliveryService());
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  List<MapEntry<String, List<_NestedData>>> _allForm = [
    MapEntry(
      "Người gửi",
      [
        _NestedData(name: "sender_name", hintText: "Họ và tên", icon: Icon(Icons.person_outlined)),
        _NestedData(name: "sender_phone", hintText: "Số điện thoại", icon: Icon(Icons.call_outlined)),
        _NestedData(name: "sender_address", hintText: "Địa chỉ", icon: Icon(Icons.place_outlined)),
      ],
    ),
    MapEntry(
      "Người nhận",
      [
        _NestedData(name: "receiver_name", hintText: "Họ và tên", icon: Icon(Icons.person_outlined)),
        _NestedData(name: "receiver_phone", hintText: "Số điện thoại", icon: Icon(Icons.call_outlined)),
        _NestedData(name: "receiver_address", hintText: "Địa chỉ", icon: Icon(Icons.place_outlined)),
      ],
    ),
    MapEntry(
      "Thông tin",
      [
        _NestedData(name: "package_name", hintText: "Tên hàng hóa", icon: Icon(Icons.all_inbox_outlined)),
        _NestedData(name: "package_price", hintText: "Giá trị", icon: Icon(Icons.attach_money_outlined)),
        _NestedData(name: "package_weight", hintText: "Khối lượng (kg) ", icon: Icon(Icons.line_weight_outlined)),
        _NestedData(name: "package_description", hintText: "Mô tả ", icon: Icon(Icons.description_outlined)),
        _NestedData(name: "picking_date", hintText: "Ngày lấy hàng dự kiến ", icon: Icon(Icons.calendar_today_outlined)),
        _NestedData(name: "receive_date", hintText: "Ngày nhận dự kiến ", icon: Icon(Icons.calendar_today_outlined)),
        _NestedData(name: "distance", hintText: "Khoảng cách ", icon: Icon(Icons.social_distance_outlined)),
        _NestedData(name: "fee", hintText: "Giá vận chuyển ", icon: Icon(Icons.attach_money_outlined)),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staticAppbar(
        title: AppTitle(),
        leading: BackButtonWidget(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5),
          child: FormBuilder(
            key: _fbKey,
            enabled: false,
            initialValue: {
              "sender_name": widget.order!.senderName,
              "sender_phone": widget.order!.senderPhone,
              "sender_address": widget.order!.senderAddress,
              "receiver_name": widget.order!.receiverName,
              "receiver_phone": widget.order!.receiverPhone,
              "receiver_address": widget.order!.receiverAddress,
              "package_name": widget.order!.item,
              "package_price": widget.order!.value.toString(),
              "package_weight": widget.order!.weight.toString(),
              "package_description": widget.order!.description,
              "picking_date": DateFormat('yyyy-MM-dd').format(widget.order!.orderedDate!.add(const Duration(days: 1))).toString(),
              "receive_date": DateFormat('yyyy-MM-dd').format(widget.order!.orderedDate!.add(const Duration(days: 3))).toString(),
              "distance": widget.order!.distance,
              "fee": widget.order!.fee,
            },
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
                  child: BlocConsumer(
                    listener: (context, state) {
                      (state is CreateFalse) ? Application.toast.showToastFailed("Thất bại") : Application.toast.showToastSuccess("Thành công");
                    },
                    bloc: _cubit,
                    buildWhen: (previous, current) => current is Create || current is Created || current is CreateFalse,
                    builder: (BuildContext context, state) {
                      return (state is Create)
                          ? Center(child: CupertinoActivityIndicator(radius: 20))
                          : CommonButton(
                              onPressed: () async {
                                if (_fbKey.currentState!.saveAndValidate()) {
                                  await _cubit.createOrder(_fbKey.currentState!.value);
                                  Modular.to.pushReplacementNamed("/user");
                                  // Navigator.pop(context);
                                }
                              },
                              child: Text(
                                "Gửi yêu cầu",
                                style:
                                    Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColor.white, fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              backgroundColor: AppColor.accentColor,
                            );
                    },
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
            ...title != "Thông tin"
                ? data.map((e) => TextFieldView(
                      name: e.name,
                      type: 'text_field',
                      hintText: e.hintText,
                      prefixIcon: e.icon,
                    ))
                : data.map((e) => buildCustomInformationForm(e)),
          ],
        ),
      );

  Widget buildCustomInformationForm(_NestedData e) => Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical),
        child: FormBuilderTextField(
          name: e.name,
          maxLines: 1,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              prefixText: "${e.hintText}:",
              prefixStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w700,
                  )),
          keyboardType: TextInputType.text,
          validator: FormBuilderValidators.required(context),
        ),
      );
}
