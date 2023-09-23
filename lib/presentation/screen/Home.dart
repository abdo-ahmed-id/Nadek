import 'package:connection_notifier/connection_notifier.dart';
// import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:location/location.dart';
import 'package:nadek/data/repository/repository.dart';
import 'package:nadek/data/webservices/WebServices.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Groups/Groups_Page.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Home_Page.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Make_Video_Page.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Profile_Page.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Shopping/Shop_Page.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_screens/custom_bottom_nav.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _State();
}

class _State extends State<Home_Screen> {
  late repository rpo = repository(Web_Services());
  late NadekCubit cubit = NadekCubit(rpo);
  int index = 4;
  String? token;
  List<Widget> page = const [
    profile_page(),
    groups_page(),
    make_video_page(),
    shop_page(),
    home_page(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = CacheHelper.getString('tokens');
    _getLocation();
  }

  void ShowSocial() {
    String? s = CacheHelper.getString('isFirstOpen');
    if (s != null) {
      print('$s');
    } else {
      Navigator.pushNamed(context, '/FollowMe');
      CacheHelper.setString('isFirstOpen', 'yes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorApp.black_400,
        body: ConnectionNotifierToggler(
          onConnectionStatusChanged: (connected) {
            /// that means it is still in the initialization phase.
            if (connected == null) return;
            print(connected);
          },
          connected: LazyLoadIndexedStack(index: index, children: page),
          disconnected: const Center(
            child: Image(
              height: 100,
              width: 100,
              image: AssetImage('assets/images/no-wifi.png'),
            ),
          ),
        ),
        bottomNavigationBar: DiamondBottomNavigation(
          height: 70,
          bgColor: Color(0xff272727),
          itemIcons: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/video_v3.svg",
                  height: 30,
                  width: 30,
                  // color: index == 0 ? Color(0xffAE2A2A) : Colors.white,
                ),
                const Text(
                  "فديوهات",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/diamond_v2.svg",
                  height: 35,
                  width: 35,
                  // color: index == 1 ? Color(0xffAE2A2A) : Colors.white,
                ),
                const Text(
                  "صرح النادي",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/comp_v2.svg",
                  height: 30,
                  width: 30,
                  // color: index == 3 ? Color(0xffAE2A2A) : Colors.white,
                ),
                const Text(
                  "البطولات",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/shop_v2.svg",
                  height: 30,
                  width: 30,
                  //   color: index == 4 ? Color(0xffAE2A2A) : Colors.white,
                ),
                const Text(
                  "المتجر",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ],
          selectedColor: Color(0xffAE2A2A),
          selectedLightColor: Color(0xffAE2A2A),
          centerIcon: SvgPicture.asset(
            "assets/icons/home_v2.svg",
            color: Colors.white,
          ),
          selectedIndex: index,
          onItemPressed: (index) {
            BlocProvider.of<NadekCubit>(context).ChangePageView();
            ShowSocial();
            setState(() {
              this.index = index;
            });
          },
        ));
  }

  _getLocation() async {
    if (await Permission.location.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      print('isDenied');
    } else {
      [
        Permission.location,
        Permission.locationAlways,
        Permission.locationWhenInUse
      ].request();

      if (await Permission.location.isDenied) {
        //   Navigator.pop(context);
      } else {
        if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
          var location = Location();
          LocationData locationData = await location.getLocation();
          setState(() {
            BlocProvider.of<NadekCubit>(context).UpdateLocationUser(
                lit: locationData.latitude!,
                long: locationData.longitude!,
                token: token!);
            print('${locationData.latitude} \n ${locationData.longitude}');
          });
        }
      }
    }
  }
}
