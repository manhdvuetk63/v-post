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
import 'package:v_post/app/home/shipper/shipping-order/shipping-order.cubit.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/delivery/delivery.service.dart';
import 'package:v_post/themes/style.dart';

class ShippingOrderWidget extends StatefulWidget {
  const ShippingOrderWidget({Key? key}) : super(key: key);

  @override
  _ShippingOrderWidgetState createState() => _ShippingOrderWidgetState();
}

class _ShippingOrderWidgetState extends State<ShippingOrderWidget> {
  ShippingOrderCubit _cubit = ShippingOrderCubit(DeliveryService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: staticAppbar(title: AppTitle()),
        body: BlocBuilder(
          bloc: _cubit,
          buildWhen: (previous, current) => current is Loading || current is Loaded,
          builder: (context, state) {
            return (state is Loaded)
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: SizeConfig.safeBlockVertical * 2),
                          Text(
                            "Quản lý đơn hàng",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700, fontSize: 30),
                          ),
                          ..._cubit.orders!.orders!.map((e) => buildCardWidget(
                                data: e,
                                onPressed: () => Modular.to.pushNamed(AppModule.shared + SharedModule.detailDelivery),
                              ))
                        ],
                      ),
                    ),
                  )
                : Center(child: CupertinoActivityIndicator(radius: 20));
          },
        ));
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
                        Text("Mã đơn : ID${data.orderNo}", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700)),
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
                              Icon(Icons.person_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text("Họ tên khách hàng: ${data.user!.name}",
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
