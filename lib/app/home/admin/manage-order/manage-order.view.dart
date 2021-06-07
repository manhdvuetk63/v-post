import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:v_post/app/app.module.dart';
import 'package:v_post/app/components/app-title/app-title.component.dart';
import 'package:v_post/app/components/appbar/appbar.component.dart';
import 'package:v_post/app/components/expandable-fab/expandable-fab.component.dart';
import 'package:v_post/app/home/admin/manage-order/manage-order.cubit.dart';
import 'package:v_post/app/home/shared/shared.module.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/account/account.service.dart';
import 'package:v_post/service/delivery/delivery.service.dart';
import 'package:v_post/themes/style.dart';

class ManageOrderWidget extends StatefulWidget {
  const ManageOrderWidget({Key? key}) : super(key: key);

  @override
  _ManageOrderWidgetState createState() => _ManageOrderWidgetState();
}

class _ManageOrderWidgetState extends State<ManageOrderWidget> {
  ManageOrderCubit _cubit = ManageOrderCubit(DeliveryService(), AccountService());
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staticAppbar(title: AppTitle()),
      body: BlocBuilder(
        bloc: _cubit,
        buildWhen: (previous, current) => current is OrdersLoaded || current is OrdersLoading,
        builder: (context, state) {
          return (state is OrdersLoaded)
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.safeBlockVertical * 2),
                        Text(
                          "Đơn hàng ${_cubit.status == 0 ? "chưa có shipper" : _cubit.status == 1 ? "đã có shipper" : "đã hoàn thành"}",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                        ..._cubit.orders!.orders!.map(
                          (e) => buildCardWidget(
                            data: e,
                            onPressed: () => Modular.to.pushNamed(AppModule.shared + SharedModule.detailDelivery, arguments: e.id),
                            onLongPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        title: Center(child: Text("Chuyển tiếp", style: TextStyle(fontWeight: FontWeight.bold))),
                                        content: (state is OrdersLoaded)
                                            ? SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    FormBuilder(
                                                        key: _fbKey,
                                                        autovalidateMode: AutovalidateMode.disabled,
                                                        child: Column(
                                                          children: [
                                                            FormBuilderDropdown(
                                                              validator: FormBuilderValidators.required(context),
                                                              decoration: InputDecoration(
                                                                contentPadding: EdgeInsets.only(top: 20, left: 15),
                                                                hintText: "Shipper",
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                                hintStyle: const TextStyle(fontWeight: FontWeight.w500),
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(20),
                                                                ),
                                                              ),
                                                              name: 'shipper',
                                                              items: _cubit.listShipper!.accounts!
                                                                  .map(
                                                                    (e) => DropdownMenuItem(child: Text("${e.name}-${e.phone}"), value: e.id),
                                                                  )
                                                                  .toList(),
                                                            ),
                                                            FormBuilderTextField(
                                                              name: "note",
                                                              keyboardAppearance: Brightness.light,
                                                              decoration: InputDecoration(labelText: 'Hãy chọn shipper hợp lý'),
                                                              enabled: false,
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              )
                                            : CupertinoActivityIndicator(radius: 20),
                                        actions: [
                                          Container(
                                            width: SizeConfig.blockSizeHorizontal * 100,
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    if (_fbKey.currentState!.saveAndValidate()) {
                                                      var status = await _cubit.forwardOrder(_fbKey.currentState!.value["shipper"], e.id);
                                                      if (status) {
                                                        Application.toast.showToastSuccess("Thành công");
                                                        await _cubit.getScreen();
                                                        Modular.to.pop();
                                                      } else {
                                                        Application.toast.showToastFailed("Thất bại");
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig.safeBlockHorizontal * 22,
                                                    height: SizeConfig.safeBlockVertical * 5,
                                                    child: Text(
                                                      'Save',
                                                      style: TextStyle(color: Colors.white, fontSize: SizeConfig.safeBlockVertical * 1.8),
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(AppColor.accentColor),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: AppColor.accentColor)),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Modular.to.pop();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: SizeConfig.safeBlockHorizontal * 22,
                                                    height: SizeConfig.safeBlockVertical * 5,
                                                    child: Text(
                                                      'Close',
                                                      style: TextStyle(color: Colors.red, fontSize: SizeConfig.safeBlockVertical * 1.8),
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.red)),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(child: CupertinoActivityIndicator(radius: 20));
        },
      ),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () async {
              _cubit.status = 0;
              await _cubit.getScreen();
            },
            icon: const Icon(Icons.new_label),
          ),
          ActionButton(
            onPressed: () async {
              _cubit.status = 1;
              await _cubit.getScreen();
            },
            icon: const Icon(Icons.history_toggle_off),
          ),
          ActionButton(
            onPressed: () async {
              _cubit.status = 2;
              await _cubit.getScreen();
            },
            icon: const Icon(Icons.done_outline),
          ),
        ],
      ),
    );
  }

  Widget buildCardWidget({required Order data, required VoidCallback onPressed, required VoidCallback onLongPressed}) => Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(6),
            side: BorderSide(color: AppColor.accentColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: onPressed,
          onLongPress: onLongPressed,
          child: Row(
            children: [
              Column(
                children: [
                  SvgPicture.asset('assets/images/home/gift.svg'),
                  SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                  Text(
                    data.fee ?? "",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mã đơn : ${data.orderNo}",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text("Chi tiết",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700, color: Color(0xFF2196F3)))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range_rounded, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Ngày tạo", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("${data.orderedDate.toString().substring(0, 10)}",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                            ],
                          ),
                          (_cubit.status != 0)
                              ? Row(
                                  children: [
                                    Icon(Icons.date_range_rounded, color: Color(0xFF2196F3), size: 14),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal),
                                    Text("Ngày lấy hàng", style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal),
                                    Expanded(
                                      child: Text("${data.orderedDate.toString().substring(0, 10)}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040))),
                                    )
                                  ],
                                )
                              : Container(),
                          (_cubit.status == 2)
                              ? Row(
                                  children: [
                                    Icon(Icons.date_range_rounded, color: Color(0xFF2196F3), size: 14),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal),
                                    Text("Ngày nhận hàng", style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal),
                                    Expanded(
                                      child: Text("${data.orderedDate.toString().substring(0, 10)}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040))),
                                    )
                                  ],
                                )
                              : Container(),
                          Row(
                            children: [
                              Icon(Icons.person_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Tên KH", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("${data.user!.name ?? ""}", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.my_location, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Điểm đi", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Expanded(
                                  child: Text("${data.senderAddress}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040))))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.place_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Điểm đến", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Expanded(
                                  child: Text("${data.receiverAddress}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040))))
                            ],
                          ),
                          (_cubit.status != 0)
                              ? Row(
                                  children: [
                                    Icon(Icons.person, color: Color(0xFF2196F3), size: 14),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal),
                                    Text("Shipper", style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal),
                                    Text("${data.account!.name}", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
