import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/BestUser.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';

class BestUsers extends StatefulWidget {
  const BestUsers({Key? key}) : super(key: key);

  @override
  State<BestUsers> createState() => _BestUsersState();
}

class _BestUsersState extends State<BestUsers> {
  bool waiting = false;
  BestUser? bestUser;
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    token =CacheHelper.getString('tokens');
    BlocProvider.of<NadekCubit>(context).GetBestUser(token: token!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorApp.black_400,
        title: Text('قائمة المتصدرين'),
        centerTitle: true,
      ),
      body: BlocConsumer<NadekCubit, NadekState>(
        listener: (context, state) {
          if (state is LoadedBestUser) {
              setState(() {
                bestUser =state.data;
                waiting =true;
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              Component_App.Item_group(
                                  file: '${bestUser!.data![index].photo}',
                                  name: '${bestUser!.data![index].name}',
                                  function: () {
                                    Navigator.pushNamed(
                                        context,
                                        '/ProfileOfUser',
                                      arguments: [
                                        bestUser!.data![index].id,
                                      ]

                                    );

                                  }
                              ),
                          separatorBuilder: (context, index) =>
                              Container(

                              ),
                          itemCount:bestUser!.data!.length
                      ),
                      SizedBox(height: 100,),


                    ],
                  ),
                ),
              ) :
              Container(
                height: double.infinity,
                width: double.infinity,
                color: ColorApp.black_400,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),


            ],
          );
        },
      ),
    );
  }
}
