import 'dart:async';

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Show_Item extends StatefulWidget {
  int? PID;
  String? url;
  String? title;
  String? description;
  String? price;

  Show_Item(
      {Key? key,
      required this.PID,
      required this.url,
      required this.title,
      required this.description,
      required this.price});

  @override
  State<Show_Item> createState() => _Show_ItemState();
}

class _Show_ItemState extends State<Show_Item> {
  int count = 0;
  int total = 1;
  String? token;
  bool waiting = false;
  Timer? timer;

  late NadekCubit nadekCubit;

  @override
  void initState() {
    // TODO: implement initState
    token = CacheHelper.getString('tokens');

    nadekCubit = NadekCubit.get(context);
    nadekCubit.GetCount(token: '$token');

    super.initState();
    // getCartRET();
  }

  void getCartRET() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      nadekCubit.GetCount(token: '$token');

      print('timer ${timer.tick}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // timer?.cancel();
    super.dispose();
  }

  void showSnackBarSuccess(context,
      {required String title, required String message}) {
    showTopSnackBar(context, CustomSnackBar.success(message: message));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NadekCubit, NadekState>(
      listener: (context, state) {
        // TODO: implement listener

        if (state is NewChangeCountBadget) {
          nadekCubit.GetCount(token: '$token');
        }

        if (state is LoadedPostToCart) {
          setState(() {
            waiting = false;
            showSnackBarSuccess(context,
                title: '', message: '${state.data.msg}');
            nadekCubit.ChangeCountBadget();
          });
        }

        if (state is LoadedCountBadget) {
          setState(() {
            count = state.data.count!.toInt();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: ColorApp.black_400,
              elevation: 0,
              centerTitle: true,
              title: Text('المتجر'),
              leading: badge.Badge(
                position: badge.BadgePosition.topEnd(top: 5, end: 5),
                badgeColor: ColorApp.blue,
                badgeContent: Text(
                  '$count',
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('assets/icons/ic_cart.png'),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Cart');
                  },
                ),
              )),
          body: waiting
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: ColorApp.black_400,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: ColorApp.black_400,
                  child: Column(
                    children: [
                      Component_App.Item_ShopingViewItem(
                          height: 342,
                          width: 336,
                          file: '${widget.url}',
                          title: '${widget.title}'),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                  height: 77,
                                  width: 77,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(77),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      stops: [0.0, 100.0],
                                      colors: [
                                        ColorApp.blue,
                                        ColorApp.move,
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${widget.price}',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${widget.description}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 142,
                            height: 44,
                            decoration: BoxDecoration(
                                color: ColorApp.back1,
                                borderRadius: BorderRadius.circular(31)),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      height: 44,
                                      width: 44,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(44),
                                        gradient: const LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                          stops: [0.0, 100.0],
                                          colors: [
                                            ColorApp.blue,
                                            ColorApp.move,
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              total++;
                                            });
                                          },
                                        ),
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$total',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                      height: 44,
                                      width: 44,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(44),
                                        gradient: const LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                          stops: [0.0, 100.0],
                                          colors: [
                                            ColorApp.blue,
                                            ColorApp.move,
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (total > 1) {
                                                total--;
                                              }
                                            });
                                          },
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Component_App.Button(
                              height: 44,
                              width: 168,
                              text: 'إضافة الى السلة',
                              function: () {
                                addCart();
                              })
                        ],
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }

  void addCart() {
    nadekCubit.PostToCart(
        product_id: widget.PID!.toInt(), quantity: total, token: '$token');
    setState(() {
      waiting = true;
    });
    BlocProvider.of<NadekCubit>(context).GetCount(token: '$token');
  }
}
