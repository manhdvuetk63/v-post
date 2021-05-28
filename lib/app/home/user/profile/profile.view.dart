import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v_post/app/components/appbar/appbar.component.dart';
import 'package:v_post/config/config_screen.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget() : super();

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00B59C),
      appBar: staticAppbar(title: Text("Thông tin cá nhân")),
      body: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0)),
            ),
          ),
          _getBody()
        ],
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical),
          Container(
            child: Row(
              children: [
                Column(children: [
                  CircleAvatar(
                      minRadius: 60,
                      child: SizedBox(
                        height: 100,
                        child: Image.asset("assets/images/home/ic_section_user.png"),
                      ),
                      backgroundColor: Colors.white),
                ])
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          Text('Thông tin cá nhân', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          Card(
            elevation: 12,
            shadowColor: Color(0x3315608F),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical, horizontal: SizeConfig.safeBlockHorizontal * 4),
            child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.perm_identity, color: Colors.grey, size: 30),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                                Expanded(
                                  child: Text(
                                    "Đặng Văn Mạnh",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.safeBlockVertical * 2),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on_outlined, color: Colors.grey, size: 30),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                                Expanded(
                                  child: Text(
                                    "177 Trung Kính, Phường Yên Hòa, Quận Cầu Giấy, TP Hà Nội",
                                    style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.grey, size: 30),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                                Text(
                                  "0327348452",
                                  style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 2),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
