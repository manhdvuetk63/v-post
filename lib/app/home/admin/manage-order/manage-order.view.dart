import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:v_post/app/app.module.dart';
import 'package:v_post/app/components/app-title/app-title.component.dart';
import 'package:v_post/app/components/appbar/appbar.component.dart';
import 'package:v_post/app/components/expandable-fab/expandable-fab.component.dart';
import 'package:v_post/app/home/admin/manage-order/manage-order.cubit.dart';
import 'package:v_post/app/home/shared/shared.module.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/delivery/delivery.service.dart';
import 'package:v_post/themes/style.dart';

class ManageOrderWidget extends StatefulWidget {
  const ManageOrderWidget({Key? key}) : super(key: key);

  @override
  _ManageOrderWidgetState createState() => _ManageOrderWidgetState();
}

class _ManageOrderWidgetState extends State<ManageOrderWidget> {
  ManageOrderCubit _cubit = ManageOrderCubit(DeliveryService());

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
                        ..._cubit.orders!.orders!.map((e) => buildCardWidget(
                              data: e,
                              onPressed: () => Modular.to.pushNamed(AppModule.shared + SharedModule.detailDelivery, arguments: e.id),
                            ))
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
              await _cubit.getListOrderByStatus();
            },
            icon: const Icon(Icons.new_label),
          ),
          ActionButton(
            onPressed: () async {
              _cubit.status = 1;
              await _cubit.getListOrderByStatus();
            },
            icon: const Icon(Icons.history_toggle_off),
          ),
          ActionButton(
            onPressed: () async {
              _cubit.status = 2;
              await _cubit.getListOrderByStatus();
            },
            icon: const Icon(Icons.done_outline),
          ),
        ],
      ),
    );
  }

  Widget buildCardWidget({required Order data, required VoidCallback onPressed}) => Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(6),
            side: BorderSide(color: AppColor.accentColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: onPressed,
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
                              Text("Ngày tạo: ${data.orderedDate.toString().substring(0, 10)}",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                            ],
                          ),
                          (_cubit.status != 0)
                              ? Row(
                                  children: [
                                    Icon(Icons.date_range_rounded, color: Color(0xFF2196F3), size: 14),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal),
                                    Text("Ngày lấy hàng: ${data.orderedDate.toString().substring(0, 10)}",
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                                  ],
                                )
                              : Container(),
                          (_cubit.status == 2)
                              ? Row(
                                  children: [
                                    Icon(Icons.date_range_rounded, color: Color(0xFF2196F3), size: 14),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal),
                                    Text("Ngày nhận hàng: ${data.orderedDate.toString().substring(0, 10)}",
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                                  ],
                                )
                              : Container(),
                          Row(
                            children: [
                              Icon(Icons.person_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Họ tên khách hàng: ${data.user!.name ?? ""}",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.my_location, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Điểm đi: ${data.senderAddress}", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.place_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Điểm đến: ${data.receiverAddress}",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                            ],
                          ),
                          (_cubit.status != 0)
                              ? Row(
                                  children: [
                                    Icon(Icons.person, color: Color(0xFF2196F3), size: 14),
                                    SizedBox(width: SizeConfig.safeBlockHorizontal),
                                    Text("Shipper: ${data.account!.name}",
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
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
