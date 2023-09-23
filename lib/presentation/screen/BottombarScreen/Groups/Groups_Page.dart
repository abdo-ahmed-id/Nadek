import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/AllRooms.dart';
import 'package:nadek/data/repository/repository.dart';
import 'package:nadek/data/webservices/WebServices.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class groups_page extends StatefulWidget {
  const groups_page({Key? key}) : super(key: key);

  @override
  State<groups_page> createState() => _groups_pageState();
}

class _groups_pageState extends State<groups_page> {
  AllRooms? rooms;
  bool waiting = false;
  late String token;
  Timer? timer;
  String? id;
  String? username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = CacheHelper.getString('tokens')!;
    id = CacheHelper.getString('Id')!;
    username = CacheHelper.getString('username');
    print('iddddd $id');
    BlocProvider.of<NadekCubit>(context).getAllRooms(token);

    //getRoomRET();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorApp.black_400,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Image(
              height: 20,
              width: 20,
              image: AssetImage('assets/icons/ic_search_1.png'),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/Maps');
            },
          ),
          title: const Text('المجموعات'),
        ),
        body: BlocConsumer<NadekCubit, NadekState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is ChangeItemChat) {
              BlocProvider.of<NadekCubit>(context).getAllRooms(token);
            }
            if (state is LoadedAllRooms) {
              setState(() {
                waiting = true;
                rooms = state.rooms;
              });
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                waiting
                    ? Container(
                        color: ColorApp.black_400,
                        height: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      Component_App.Item_group(
                                          file: '${rooms!.data![index].photo}',
                                          name: '${rooms!.data![index].name}',
                                          function: () {
                                            Navigator.pushNamed(
                                                context, '/Chats',
                                                arguments: [
                                                  rooms!
                                                      .data![index].name, //name
                                                  rooms!.data![index]
                                                      .id, //chat id
                                                  username, // user name
                                                  id,
                                                  rooms!.data![index].owner?.id!
                                                      .toInt(), //chat id
                                                ]);
                                          }),
                                  separatorBuilder: (context, index) =>
                                      Container(),
                                  itemCount: rooms!.data!.length),
                              SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: ColorApp.black_400,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Component_App.Button(
                      text: 'انشاء مجموعة',
                      function: () {
                        Navigator.pushNamed(context, '/Create_Group');
                      }),
                ),
              ],
            );
          },
        ));
  }
}
