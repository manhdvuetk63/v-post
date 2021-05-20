import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:v_post/app/app.module.dart';
import 'package:v_post/app/home/home.cubit.dart';
import 'package:v_post/config/application.dart';
import 'package:v_post/config/config_screen.dart';
import 'package:v_post/themes/style.dart';

import 'home.module.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeCubit _cubit = Modular.get<HomeCubit>();
  ScrollController _scrollController = ScrollController();
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<Map<String, String>> _menuShortcut = [
    {"iconUrl": "ic_fnc_customer.png", "title": "Customer Management 2", "route": "HomeModule.customerManager"},
    {"iconUrl": "ic_fnc_schedule.png", "title": "To do List", "route": "HomeModule.customerManager"},
    {"iconUrl": "ic_fnc_stock_check.png", "title": "Stock check", "route": "HomeModule.customerManager"},
    {"iconUrl": "ic_fnc_dashboard.png", "title": "Dashboard", "route": "HomeModule.customerManager"},
    {"iconUrl": "ic_fnc_knowledge.png", "title": "Knowledge", "route": "HomeModule.customerManager"}
  ];
  @override
  void initState() {
    _scrollController.addListener(() => _cubit.scrollListener(_scrollController));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      backgroundColor: Color(0xFFD2F2FF),
      // drawer: buildDrawer(),
      // appBar: buildAppBar(),
    );
  }

  AppBar buildAppBar() => AppBar();

  Widget buildBody() => Stack(
        alignment: Alignment.topCenter,
        children: [
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.black,
                  expandedHeight: SizeConfig.safeBlockVertical * 20,
                  primary: true,
                  actions: [],
                  flexibleSpace: FlexibleSpaceBar(centerTitle: true, background: Image.asset('assets/images/login/img_main.png', fit: BoxFit.cover)),
                )
              ];
            },
            body: Container(
              color: Colors.black,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/login/bg_screen.png"), fit: BoxFit.fitWidth),
                  borderRadius: BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0)),
                  color: Colors.white,
                ),
                child: buildHome(),
              ),
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
              bloc: _cubit,
              builder: (context, state) {
                return AnimatedPositioned(
                  top: SizeConfig.safeBlockVertical * 22 * 0.85 - _cubit.scrollOffset,
                  duration: const Duration(milliseconds: 0),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 85,
                    height: SizeConfig.safeBlockVertical * 11,
                    child: Card(
                      elevation: 4,
                      shadowColor: Color(0x3315608F),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: SizeConfig.safeBlockHorizontal * 12,
                                  maxHeight: SizeConfig.safeBlockHorizontal * 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: Hero(
                                    tag: "avatar",
                                    child: CircleAvatar(
                                      radius: 90,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset("assets/images/home/male.png", width: SizeConfig.safeBlockHorizontal * 9),
                                    )),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                                ),
                                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                // padding: EdgeInsets.zero,
                                onPressed: () =>
                                    Modular.to.pushNamed(AppModule.home + HomeModule.profile, arguments: ""),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 3),
                                  width: SizeConfig.safeBlockHorizontal * 48,
                                  padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: AutoSizeText(
                                          "Đặng Văn Mạnh",
                                          style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 3, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text("Update profile", style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 2, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                splashRadius: SizeConfig.safeBlockVertical * 5,
                                icon: Image.asset("assets/images/home/ic_section_logout.png", height: SizeConfig.blockSizeVertical * 3),
                                onPressed: () {},
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
        ],
      );

  GridView buildHome() => GridView.builder(
        itemCount: _menuShortcut.length,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 8 / 9),
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Column(
              children: [
                Card(
                  elevation: 12,
                  shadowColor: Color(0x3315608F),
                  shape: CircleBorder(),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        // onPrimary: Colors.white,
                        onSurface: Colors.white),
                    onPressed: () {
                      // if (_menuShortcut[index]['route'] == HomeModule.dashboard) {
                      //   return Modular.to.pushNamed("${AppModule.home}${"${_menuShortcut[index]['route']}/${"test"}"}");
                      //   // } else if (_menuShortcut[index]['route'] == HomeModule.forumChat) {
                      //   //   Application.toast.showToastNotification("Tính năng đang trong quá trình phát triển!");
                      //   // } else if (_menuShortcut[index]['route'] == HomeModule.knowledge) {
                      //   //   Application.toast.showToastNotification("Tính năng đang trong quá trình phát triển!");
                      // } else {
                      //   return Modular.to.pushNamed("${AppModule.home}${"${_menuShortcut[index]['route']}"}");
                      // }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/images/home/circle_dot.png", width: SizeConfig.safeBlockHorizontal * 18, color: Colors.grey),
                        Image.asset("assets/images/home/${_menuShortcut[index]['iconUrl']}", width: SizeConfig.safeBlockHorizontal * 9)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical),
                Text("${_menuShortcut[index]['title']}", textAlign: TextAlign.center, style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 2)),
              ],
            ),
          );
        },
      );
}
