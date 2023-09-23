
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/SettingsModel.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/constante/string.dart';
import 'package:nadek/sheard/style/ColorApp.dart';

class privacy_policy extends StatefulWidget {
  const privacy_policy({Key? key}) : super(key: key);

  @override
  State<privacy_policy> createState() => _privacy_policyState();
}

class _privacy_policyState extends State<privacy_policy> {

  SettingsModel? settingsModel;
  bool loading =true;
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token =CacheHelper.getString('tokens');
    BlocProvider.of<NadekCubit>(context).GetSettings();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorApp.black_400,
        centerTitle: true,
        title: Text('سياسة الخصوصية'),
      ),
      body: BlocConsumer<NadekCubit,NadekState>(
          listener:  (context,state){
            if (state is LoadedSettings) {
              setState(() {
                settingsModel =state.data;
                loading =false;
              });
            }
          },
          builder: (context,state){
            return loading?
            Container(
              color: ColorApp.black_400,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ):Container(
              color:  ColorApp.black_400,
              height: double.infinity,
              width: double.infinity,
              child:Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: Text(
                      '${settingsModel!.data!.privacyPolicy}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                      textDirection: TextDirection.ltr,
                    )
                ),
              ) ,
            );
          }

      ),
    );
  }
}
