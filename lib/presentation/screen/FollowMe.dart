import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/SettingsModel.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:url_launcher/url_launcher.dart';


class FollowMe extends StatefulWidget {
  const FollowMe({Key? key}) : super(key: key);

  @override
  State<FollowMe> createState() => _FollowMeState();
}

class _FollowMeState extends State<FollowMe> {
  bool waiting=true;
  String? token;
  SettingsModel? settingsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = CacheHelper.getString('tokens');

    BlocProvider.of<NadekCubit>(context).GetSettings();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ColorApp.black_400,
        title: const Text('تابعنا'),
      ),
      body: BlocConsumer<NadekCubit, NadekState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoadedSettings) {
            setState(() {
              settingsModel =state.data;
              waiting =false;
            });

          }  
        },
        builder: (context, state) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: ColorApp.black_400,
            
            child: waiting ?const Center(
              child: CircularProgressIndicator(),
              
            ):Center(
              child: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const  Text('تابع حسابتنا الخاصة عبر وسائل التواصل الاجتماعي لفرصة نشر فيديوهاتك عليها',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,


                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,

                    ),
                    const SizedBox(height: 30,),
                    settingsModel!.data!.youtubeLink!=null?
                    Component_App.ButtonStyle(
                        function: (){
                          Uri _url = Uri.parse(settingsModel!.data!.youtubeLink.toString());
                          _launchUrl(_url);
                        },
                        text: 'يوتيوب',
                        color: Colors.red
                    ) :const SizedBox(),
                    const SizedBox(height: 10,),

                    settingsModel!.data!.facebookLink!=null?
                    Component_App.ButtonStyle(
                        function: (){
                          Uri _url = Uri.parse(settingsModel!.data!.facebookLink.toString());
                          _launchUrl(_url);
                        },
                        text: 'فيسبوك',
                        color: Colors.blueAccent
                    ) :const SizedBox(),

                    const SizedBox(height: 10,),

                    settingsModel!.data!.twitterLink!=null?
                    Component_App.ButtonStyle(
                        function: (){
                          Uri _url = Uri.parse(settingsModel!.data!.twitterLink.toString());
                          _launchUrl(_url);
                        },
                        text: 'تويتر',
                        color: Colors.blue
                    ) :const SizedBox(),

                    const SizedBox(height: 10,),
                    settingsModel!.data!.instagramLink!=null?
                    Component_App.ButtonStyle(
                        function: (){
                          Uri _url = Uri.parse(settingsModel!.data!.instagramLink.toString());
                          _launchUrl(_url);
                        },
                        text: 'انستجرام',
                        color: Colors.pinkAccent
                    ) :const SizedBox()
                  ],
                ),
              ),
            )
          );
        },
      ),

    );
  }
  Future<void> _launchUrl(Uri _url) async {
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url,mode: LaunchMode.externalApplication);
    }else {
      throw 'Could not launch $_url';
    }

  }
}
