import 'package:flutter/material.dart';
import 'dart:math' as math;

class DiamondBottomNavigation extends StatelessWidget {
  final List<Widget> itemIcons;
  final Widget centerIcon;
  final int selectedIndex;
  final Function(int) onItemPressed;
  final double? height;
  final Color selectedColor;
  final Color bgColor;
  final Color selectedLightColor;
  final Color unselectedColor;
  const DiamondBottomNavigation({
    Key? key,
    required this.itemIcons,
    required this.centerIcon,
    required this.selectedIndex,
    required this.bgColor,
    required this.onItemPressed,
    this.height,
    this.selectedColor = const Color(0xff46BDFA),
    this.unselectedColor = const Color(0xffB5C8E7),
    this.selectedLightColor = const Color(0xff77E2FE),
  })  : assert(itemIcons.length == 4 || itemIcons.length == 2,
            "Item must equal 4 or 2"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.initSize(context);
    final height = this.height ?? getRelativeHeight(0.076);

    return SizedBox(
      height: height + getRelativeHeight(0.025),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: bgColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: itemIcons.length == 4
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(0);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: itemIcons[0],

                                // Container(
                                //   child: ,
                                //   color: selectedIndex == 0
                                //       ? selectedColor
                                //       : unselectedColor,
                                //   width: getRelativeWidth(0.07),
                                // ),
                              ),
                            ),
                          ),
                          if (itemIcons.length == 4)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                splashColor: selectedColor.withOpacity(0.5),
                                onTap: () {
                                  onItemPressed(1);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: itemIcons[1]

                                    //  Container(
                                    //   child: itemIcons[1],
                                    //   color: selectedIndex == 1
                                    //       ? selectedColor
                                    //       : unselectedColor,
                                    //   //  width: getRelativeWidth(0.07),
                                    // ),

                                    //  Icon(
                                    //   itemIcons[1],
                                    //   color: selectedIndex == 1
                                    //       ? selectedColor
                                    //       : unselectedColor,
                                    // ),
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: itemIcons.length == 4
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              splashColor: selectedColor.withOpacity(0.5),
                              onTap: () {
                                onItemPressed(itemIcons.length == 4 ? 3 : 2);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child:
                                      itemIcons[itemIcons.length == 4 ? 2 : 1]
                                  //  Container(
                                  //   child:
                                  //       itemIcons[itemIcons.length == 4 ? 2 : 1],
                                  //   color: selectedIndex ==
                                  //           (itemIcons.length == 4 ? 3 : 2)
                                  //       ? selectedColor
                                  //       : unselectedColor,
                                  //   //  width: getRelativeWidth(0.07),
                                  // ),

                                  //  Icon(
                                  //   itemIcons[itemIcons.length == 4 ? 2 : 1],
                                  //   color: selectedIndex ==
                                  //           (itemIcons.length == 4 ? 3 : 2)
                                  //       ? selectedColor
                                  //       : unselectedColor,
                                  // ),
                                  ),
                            ),
                          ),
                          if (itemIcons.length == 4)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                splashColor: selectedColor.withOpacity(0.5),
                                onTap: () {
                                  onItemPressed(4);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: itemIcons[3]

                                    // Container(
                                    //   child: itemIcons[3],
                                    //   color: selectedIndex == 4
                                    //       ? selectedColor
                                    //       : unselectedColor,
                                    //   //  width: getRelativeWidth(0.07),
                                    // ),

                                    //  Icon(
                                    //   itemIcons[3],
                                    //   color: selectedIndex == 4
                                    //       ? selectedColor
                                    //       : unselectedColor,
                                    // ),
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      onItemPressed(itemIcons.length == 4 ? 2 : 1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     blurRadius: 25,
                        //     offset: const Offset(0, 5),
                        //     //color: selectedColor.withOpacity(0.75),
                        //   )
                        // ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            selectedLightColor,
                            selectedColor,
                          ],
                        ),
                      ),
                      height: getRelativeWidth(0.135),
                      width: getRelativeWidth(0.135),
                      child: Center(
                          child: Transform.rotate(
                              angle: math.pi / 4, child: centerIcon)),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static initSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }
}

double getRelativeHeight(double percentage) {
  return percentage * SizeConfig.screenHeight;
}

double getRelativeWidth(double percentage) {
  return percentage * SizeConfig.screenWidth;
}
