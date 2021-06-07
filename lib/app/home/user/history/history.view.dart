import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:v_post/app/app.module.dart';
import 'package:v_post/app/components/app-title/app-title.component.dart';
import 'package:v_post/app/components/appbar/appbar.component.dart';
import 'package:v_post/app/home/shared/shared.module.dart';
import 'package:v_post/app/home/user/history/history.cubit.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/delivery/delivery.service.dart';
import 'package:v_post/themes/style.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  HistoryCubit _cubit = HistoryCubit(DeliveryService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staticAppbar(title: AppTitle()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              Text(
                "Lịch sử",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700, fontSize: 30),
              ),
              BlocBuilder(
                bloc: _cubit,
                buildWhen: (previous, current) => current is OrdersLoading || current is OrdersLoaded,
                builder: (context, state) {
                  return (state is OrdersLoaded)
                      ? (_cubit.orders!.orders == null)
                          ? Container()
                          : Column(children: [
                              ..._cubit.orders!.orders!.map((e) => buildCardWidget(
                                    data: e,
                                    onPressed: () => Modular.to.pushNamed(AppModule.shared + SharedModule.detailDelivery, arguments: e.id),
                                  ))
                            ])
                      : Center(child: CupertinoActivityIndicator(radius: 20));
                },
              )
            ],
          ),
        ),
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
                  Text(data.fee ?? "", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700)),
                  SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mã đơn : ${data.orderNo}", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700)),
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
                          Row(
                            children: [
                              Icon(Icons.my_location, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Điểm đi", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Expanded(child: Text("${data.senderAddress}", overflow: TextOverflow.ellipsis,maxLines: 1,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040))))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.place_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Điểm đến", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Expanded(child: Text("${data.receiverAddress}",overflow: TextOverflow.ellipsis,maxLines: 1 ,style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040))))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.loop_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Trạng thái", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text(
                                  "${data.status == 0 ? "Chưa có shipper" : data.status == 1 ? "Đã có shipper" : "Đã giao"}",
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)))
                            ],
                          ),
                          (data.account != null)
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
