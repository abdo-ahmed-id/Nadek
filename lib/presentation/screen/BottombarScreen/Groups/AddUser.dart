import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/AddUserRoom.dart';
import 'package:nadek/data/model/AllUser.dart';
import 'package:nadek/data/repository/repository.dart';
import 'package:nadek/data/webservices/WebServices.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Add_User extends StatefulWidget {
  int chat_id;

  Add_User({required this.chat_id, Key? key}) : super(key: key);

  @override
  State<Add_User> createState() => _Add_UserState();
}

class _Add_UserState extends State<Add_User> {
  String? token;

  late repository rpo = repository(Web_Services());
  late NadekCubit cubit = NadekCubit(rpo);
  bool waiting = false;
  AllUser? allUser;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token =CacheHelper.getString('tokens');
   // getToken();
    BlocProvider.of<NadekCubit>(context).getAllUser(room_id: widget.chat_id,token:token!);


  }


  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.black_400,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'إضافة أعضاء للمجموعة',
          style: TextStyle(
              fontSize: 16
          ),
        ),
      ),
      body: BlocConsumer<NadekCubit, NadekState>(
        listener: (context, state) {
          if (state is LoadedAddUserRoom) {
            BlocProvider.of<NadekCubit>(context).getAllUser(room_id: widget.chat_id,token:token!);

          }

          // TODO: implement listener
          if (state is LoadedAllUser) {
            setState(() {
              allUser = state.user;
              waiting = true;
            });
          }
        },
        builder: (context, state) {


          return Stack(
            children: [
              waiting ?
              Container(
                color: ColorApp.black_400,
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: allUser!.data!.length,
                    itemBuilder: (build, index) {
                      return ListItem(
                        token: token,
                        id: allUser!.data![index].id,
                        chat_id: widget.chat_id,
                        user_name: allUser!.data![index].name,
                        photo: allUser!.data![index].photo,
                        function: () {

                        },
                      );
                    }),
              ) :
              Container(
                height: double.infinity,
                width: double.infinity,
                color: ColorApp.black_400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          );
        },
      )
    );
  }

  void showSnackBarSuccess(context,
      {required String title, required String message}) {
    showTopSnackBar(
        context,
        CustomSnackBar.success(message: message)
    );
  }
}

class ListItem extends StatefulWidget {
  int? id;
  int chat_id;
  String? token;
  String? photo;
  String? user_name;
  Function() function;


  ListItem({Key? key,
    required this.id,
    required this.chat_id,
    required this.token,
    required this.user_name,
    required this.photo,
    required this.function
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  String title = 'اضافة';
  bool waiting= false;
  late repository rpo = repository(Web_Services());
  late NadekCubit cubit = NadekCubit(rpo);
  AddUserRoom? addUserRoom;


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NadekCubit, NadekState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoadedAddUserRoom) {
          setState(() {
            addUserRoom = state.room;
            waiting =false;
            title = 'اضافة';


          });
          print(addUserRoom!.msg);
        }
      },
      builder: (context, state) {
        return ListTile(
            leading:waiting? Container(
              width: 50,
              height: 50,
              child: Center(
                child: Container(
                  height: 20,
                  width: 30,
                  child: CircularProgressIndicator( ),
                ),
              ),
            ): Component_App.Button(
                width: 72,
                height: 26,
                text: title,
                function:(){
                  setState((){
                    BlocProvider.of<NadekCubit>(context).addRoomUser(widget.chat_id,widget.id!, '${widget.token}');
                    waiting =true;
                      title='تم';
                  });
                }
            ),
            onTap: () {

            },
            title: Component_App.Item_Alluser(
                name: '${widget.user_name}',
                file: '${widget.photo}',
                function: () {})
        );
      },
    );
  }

}

