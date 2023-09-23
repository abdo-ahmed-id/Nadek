import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nadek/sheard/style/ColorApp.dart';

class make_video_page extends StatefulWidget {
  const make_video_page({Key? key}) : super(key: key);

  @override
  State<make_video_page> createState() => _make_video_pageState();
}

class _make_video_pageState extends State<make_video_page> {
  ImagePicker? _picker;
  File? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              //color: Colors.amber,
              width: 50,
              // height: 130,
              child: Center(
                child: ClipPolygon(
                  sides: 6,
                  borderRadius: 5.0, // Default 0.0 degrees
                  rotate: 90.0,
                  // Default 0.0 degrees
                  boxShadows: [
                    PolygonBoxShadow(color: Colors.black, elevation: 1.0),
                    PolygonBoxShadow(color: Colors.grey, elevation: 5.0)
                  ],
                  child: Container(
                    child: Image.asset(
                      "assets/icons/profile.webp",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
                width: 70,
                child: Text(
                  "Montaser Hamad",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.0,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              "assets/icons/notification.svg",
              height: 30,
              width: 30,
              // color: index == 0 ? Color(0xffAE2A2A) : Colors.white,
            ),
          ),
        ],
        // leading: const Text(""),
        // centerTitle: true,
        elevation: 0,
        backgroundColor: ColorApp.black_400,
      ),
      body: Container(
        color: ColorApp.black_400,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8), // Image border
                    child: SizedBox.fromSize(
                      size: const Size(double.infinity, 130), // Image radius
                      child: Image.network(
                          'https://images.pexels.com/photos/3148452/pexels-photo-3148452.jpeg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: const Center(
                        child: Text(
                          "حجز الملاعب",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                      child: buildRoWItem(ColorApp.card1,
                          "assets/icons/player_rating.svg", "تقييم اللاعب")),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: buildRoWItem(ColorApp.card2,
                          "assets/icons/search_play.svg", "البحث")),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: buildRoWItem(ColorApp.card3,
                          "assets/icons/show_player.svg", "عرض اللاعبين")),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: buildRoWItem2(ColorApp.limonCrd,
                          "assets/icons/map_user.svg", "خريطة اللاعبين ")),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: buildRoWItem2(ColorApp.greenCard,
                          "assets/icons/sports_shoes.svg", "أنواع الرياضات")),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Container(
                    height: 155,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorApp.redCard),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 57,
                                  child: ClipPolygon(
                                    sides: 6,
                                    borderRadius: 5.0, // Default 0.0 degrees
                                    rotate: 90.0,
                                    // Default 0.0 degrees
                                    boxShadows: [
                                      PolygonBoxShadow(
                                          color: Colors.black, elevation: 1.0),
                                      PolygonBoxShadow(
                                          color: Colors.grey, elevation: 5.0)
                                    ],
                                    child: Container(
                                      child: Image.asset(
                                        "assets/icons/profile.webp",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 0,
                                ),
                                const Text(
                                  "Khaled Ahmad",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 68,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      SizedBox(
                                        height: 60,
                                        child: ClipPolygon(
                                          sides: 6,
                                          borderRadius:
                                              5.0, // Default 0.0 degrees
                                          rotate: 90.0,
                                          // Default 0.0 degrees
                                          boxShadows: [
                                            PolygonBoxShadow(
                                                color: Colors.black,
                                                elevation: 1.0),
                                            PolygonBoxShadow(
                                                color: Colors.grey,
                                                elevation: 5.0)
                                          ],
                                          child: Container(
                                            child: Image.asset(
                                              "assets/icons/profile.webp",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: -3,
                                          // right: 20,
                                          // left: 20,
                                          child: SvgPicture.asset(
                                            "assets/icons/winner.svg",
                                            height: 18,
                                            width: 60,
                                          ))
                                    ],
                                  ),
                                ),
                                const Text(
                                  "Khaled Ahmad",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 57,
                                  child: ClipPolygon(
                                    sides: 6,
                                    borderRadius: 5.0, // Default 0.0 degrees
                                    rotate: 90.0,
                                    // Default 0.0 degrees
                                    boxShadows: [
                                      PolygonBoxShadow(
                                          color: Colors.black, elevation: 1.0),
                                      PolygonBoxShadow(
                                          color: Colors.grey, elevation: 5.0)
                                    ],
                                    child: Container(
                                      child: Image.asset(
                                        "assets/icons/profile.webp",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Khaled Ahmad",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xff171717).withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: const Center(
                        child: Text(
                          "قائمة المتصدرين",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )

            // const Padding(
            //   padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
            //   child: Text(
            //     'قم بانشاء الفيديو الخاص بك او البث المباشر ليظهر الان على التطبيق وتحصل على المتابعين ',
            //     textDirection: TextDirection.rtl,
            //     style: TextStyle(fontSize: 14, color: Colors.white),
            //   ),
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Component_App.Item_Make_Video(
            //         file: 'assets/icons/ic_live.png',
            //         title: 'اضافة بث مباشر',
            //         function: () {
            //           Navigator.pushNamed(context, '/Live_Stream');
            //         }),
            //     SizedBox(
            //       width: 19,
            //     ),
            //     Component_App.Item_Make_Video(
            //       file: 'assets/icons/ic_gallery.png',
            //       title: 'اضافة فيديو',
            //       function: () async {
            //         Navigator.pushNamed(context, '/Upload_Video');
            //       },
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  buildRoWItem(Color bgColor, String image, String text) {
    return Container(
      height: 100,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: bgColor),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(image),
        const SizedBox(
          height: 5,
        ),
        Text(text)
      ]),
    );
  }

  buildRoWItem2(Color bgColor, String image, String text) {
    return Container(
      height: 100,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: bgColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SvgPicture.asset(image),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 56,
            child: Text(
              text,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
