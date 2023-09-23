import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/GetCategories.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';

class shop_page extends StatefulWidget {
  const shop_page({Key? key}) : super(key: key);

  @override
  State<shop_page> createState() => _shop_pageState();
}

class _shop_pageState extends State<shop_page> {
  String? token;
  bool waiting = true;
  int count = 0;
  Timer? timer;

  GetCategories? categories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = CacheHelper.getString('tokens');
    BlocProvider.of<NadekCubit>(context).GetCount(token: '$token');

    BlocProvider.of<NadekCubit>(context).getCategories(token!);
    // getCartRET();
  }

  void getCartRET() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      BlocProvider.of<NadekCubit>(context).GetCount(token: '$token');
      print('timer ${timer.tick}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NadekCubit, NadekState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is NewChangeCountBadget) {
          BlocProvider.of<NadekCubit>(context).GetCount(token: '$token');
        }
        if (state is LoadedCountBadget) {
          setState(() {
            count = state.data.count!.toInt();
          });
        }

        if (state is LoadedCategories) {
          setState(() {
            categories = state.categories;
            waiting = false;
          });
        }
      },
      builder: (context, state) {
        return waiting
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: ColorApp.black_400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : shopoing(
                categories: categories,
                tokens: token,
                count: count,
              );
      },
    );
  }
}

class shopoing extends StatefulWidget {
  GetCategories? categories;
  String? tokens;
  int? count;

  shopoing(
      {Key? key,
      required this.categories,
      required this.tokens,
      required this.count})
      : super(key: key);

  @override
  State<shopoing> createState() => _shopoingState();
}

class _shopoingState extends State<shopoing> with TickerProviderStateMixin {
  TabController? _tabController;
  int isChange = 0;
  NadekCubit? nadekCubit;
  @override
  void initState() {
    // TODO: implement initState
    _tabController =
        TabController(length: widget.categories!.data!.length, vsync: this);

    nadekCubit = NadekCubit.get(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.categories!.data!.length,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: ColorApp.black_400,
                elevation: 0,
                centerTitle: true,
                title: Text('المتجر'),
                leading: badge.Badge(
                  position: badge.BadgePosition.topEnd(top: 5, end: 5),
                  badgeColor: ColorApp.blue,
                  badgeContent: Text(
                    '${widget.count}',
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
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: ColorApp.black_400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'الأقسام ',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        onTap: (index) {
                          setState(() {
                            isChange = index;
                            print(_tabController!.index);
                          });
                        },
                        tabs: List.generate(widget.categories!.data!.length,
                            (index) {
                          return ItemCategory(
                              color: ColorApp.back1,
                              file: widget.categories!.data![index].imagePath,
                              title: widget.categories!.data![index].title);
                        }),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'المنتجات',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Flexible(
                      child: TabBarView(
                          controller: _tabController,
                          children: List.generate(
                              widget.categories!.data!.length, (index) {
                            return GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: widget
                                    .categories!.data![index].products!.length,
                                itemBuilder: (context, index1) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/Show_Item',
                                          arguments: [
                                            widget.categories!.data![index]
                                                .products![index1].id, //id
                                            widget
                                                .categories!
                                                .data![index]
                                                .products![index1]
                                                .imagePath, //url
                                            widget
                                                .categories!
                                                .data![index]
                                                .products![index1]
                                                .title, //title
                                            widget
                                                .categories!
                                                .data![index]
                                                .products![index1]
                                                .description, //descr
                                            widget.categories!.data![index]
                                                .products![index1].price //price
                                          ]);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Component_App.Item_Shoping(
                                          file:
                                              '${widget.categories!.data![index].products![index1].imagePath}',
                                          title:
                                              '${widget.categories!.data![index].products![index1].title}'),
                                    ),
                                  );
                                });
                          })))
                ],
              ),
            )));
  }
}

class ItemCategory extends StatefulWidget {
  String? file;
  String? title;
  Color? color;
  ItemCategory(
      {Key? key, required this.file, required this.color, required this.title})
      : super(key: key);

  @override
  State<ItemCategory> createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 94,
      child: Container(
        height: 94,
        width: 94,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(height: 45, width: 55, image: NetworkImage('${widget.file}')),
            Text(
              '${widget.title}',
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
