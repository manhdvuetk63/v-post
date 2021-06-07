import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_post/app/components/app-title/app-title.component.dart';
import 'package:v_post/app/components/appbar/appbar.component.dart';
import 'package:v_post/app/home/admin/shipper-list/shipper-list.cubit.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/model/user/order/order.dart';
import 'package:v_post/service/account/account.service.dart';
import 'package:v_post/themes/style.dart';

class ShipperListWidget extends StatefulWidget {
  const ShipperListWidget({Key? key}) : super(key: key);

  @override
  _ShipperListWidgetState createState() => _ShipperListWidgetState();
}

class _ShipperListWidgetState extends State<ShipperListWidget> {
  ShipperListCubit _cubit = ShipperListCubit(AccountService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: staticAppbar(title: AppTitle()),
        body: BlocBuilder(
          bloc: _cubit,
          buildWhen: (previous, current) => current is ShipperLoading || current is ShipperLoaded,
          builder: (context, state) {
            return (state is ShipperLoaded)
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: SizeConfig.safeBlockVertical * 2),
                          Text(
                            "Danh sách tài xế",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w700, fontSize: 30),
                          ),
                          ..._cubit.accounts!.accounts!.map((e) => buildCardWidget(
                                data: e,
                                onPressed: () => null,
                              ))
                        ],
                      ),
                    ),
                  )
                : Center(child: CupertinoActivityIndicator(radius: 20));
          },
        ));
  }

  Widget buildCardWidget({required Account data, required VoidCallback onPressed}) => Container(
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
              Icon(Icons.person_outlined, color: AppColor.accentColor, size: 60),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text.rich(TextSpan(
                                text: "",
                                children: [
                                  TextSpan(
                                    text: "Họ tên ",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(text: ": ", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600)),
                                  TextSpan(
                                    text: data.name,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)),
                                  ),
                                ],
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.call_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text.rich(TextSpan(
                                text: "",
                                children: [
                                  TextSpan(
                                    text: "Số điện thoại",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(text: ": ", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600)),
                                  TextSpan(
                                    text: data.phone,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)),
                                  ),
                                ],
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.email_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text.rich(TextSpan(
                                text: "",
                                children: [
                                  TextSpan(
                                    text: "Email",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(text: ": ", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600)),
                                  TextSpan(
                                    text: data.email,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)),
                                  ),
                                ],
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.thumb_up_outlined, color: Color(0xFF2196F3), size: 14),
                              SizedBox(width: SizeConfig.safeBlockHorizontal),
                              Text.rich(TextSpan(
                                text: "",
                                children: [
                                  TextSpan(
                                    text: "Đánh giá",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(text: ": ", style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600)),
                                  TextSpan(
                                    text: data.rate.toString(),
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFF404040)),
                                  ),
                                  WidgetSpan(child: Icon(Icons.star_outlined, color: Colors.yellowAccent), alignment: PlaceholderAlignment.middle)
                                ],
                              )),
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
