

import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:nadek/data/model/ProfileModel.dart';
import 'package:nadek/data/model/ProfileOfUserModel.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/presentation/screen/repprt_screen.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfileOfUser extends StatefulWidget {
  int user_id;
   ProfileOfUser({Key? key,required this.user_id}) : super(key: key);

  @override
  State<ProfileOfUser> createState() => _ProfileOfUserState();
}

class _ProfileOfUserState extends State<ProfileOfUser> {
  late String token;
  bool loading= true;
  ProfileModel? user;
  ScrollController? _scrollController;
  ProfileOfUserModel? model;
  String add='متابعة';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();

    token =CacheHelper.getString('tokens')!;
    BlocProvider.of<NadekCubit>(context).GetProfileOfUser(user_id: widget.user_id, token: token);


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text('',),
        elevation: 0,
        backgroundColor: ColorApp.black_400,
        centerTitle: true,
      ),
      body: BlocConsumer<NadekCubit, NadekState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is LoadedAddFollow) {

            Fluttertoast.showToast(
              msg: '${state.data.msg}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
            );
            print('${state.data.msg}');
          }

          if (state is LoadedProfileOfUser) {
            setState(() {
              model =state.model;
              loading=false;
              model!.data!.myData!.user_follow==true?add='تم المتابعة':add='متابعة';

            });
          }

        },
        builder: (context, state) {
          return Container(
            color: ColorApp.black_400,
            height: double.infinity,
            width: double.infinity,
            child: loading?
            Container(
              height: double.infinity,
              width: double.infinity,
              color: ColorApp.black_400,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ):
            SingleChildScrollView(
              controller:  _scrollController,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ' ${model!.data!.myData!.name}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white
                              ),

                            ),
                            Row(
                              children: [
                                Text(
                                  '${model!.data!.myFollows!.length ?? 0}المتابَعون ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey
                                  ),

                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '${model!.data!.myFollowers!.length??0}المتابِعين ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey
                                  ),

                                ),

                              ],
                            )

                          ],
                        ),
                        SizedBox(width: 10,),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: ColorApp.black_400,
                          backgroundImage:NetworkImage(model!.data!.myData!.photo.toString()),

                        ),

                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 140,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorApp.back1
                        ),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              add=='متابعة'?add='تم المتابعة':add='متابعة';
                            });
                            BlocProvider.of<NadekCubit>(context).AddFollow(
                                token: token,
                                uid: model!.data!.myData!.id!.toInt()
                            );


                          },
                          child: Center(
                            child: Text(
                              add,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                              ),

                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      model!.data!.myData!.youtube!=null?
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: ColorApp.back1
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Uri _url = Uri.parse(model!.data!.myData!.youtube.toString());
                            _launchUrl(_url);
                          },
                          child:const Center(
                            child:  Image(
                              height: 35,
                              width: 35,
                              image: AssetImage('assets/icons/ic_youtube.png'),
                            ),
                          ),
                        ),
                      ):
                      const SizedBox(),
                      const SizedBox(width: 10,),
                      model!.data!.myData!.instagram!=null?
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: ColorApp.back1
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Uri _url = Uri.parse(model!.data!.myData!.instagram.toString());
                            _launchUrl(_url);
                          },
                          child:const Center(
                            child:  Image(
                              height: 35,
                              width: 35,
                              image: AssetImage('assets/icons/ic_insta.png'),
                            ),
                          ),
                        ),
                      ):
                      const SizedBox(),

                    ],
                  ),
                const SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,

                   children: [
                     Container(
                       width: 100,
                       height: 40,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: ColorApp.back1
                       ),
                       child: GestureDetector(
                         onTap: (){
                           Navigator.pop(context);
                           Fluttertoast.showToast(
                             msg: 'تم حظر المستخدم',
                             toastLength: Toast.LENGTH_LONG,
                             gravity: ToastGravity.BOTTOM,
                           );

                         },
                         child: Center(
                           child: Text(
                             'حظر المستخدم',
                             style: TextStyle(
                                 fontSize: 13,
                                 color: Colors.white
                             ),

                           ),
                         ),
                       ),
                     ),
                     const SizedBox(width: 5,),

                     Container(
                       width: 100,
                       height: 40,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: ColorApp.back1
                       ),
                       child: GestureDetector(
                         onTap: (){
                           Navigator.pop(context);
                           Navigator.push(context, MaterialPageRoute(
                               builder: (context)=>new repprt_screen(title: 'ابلاغ عن مستخدم')
                           ));

                         },
                         child: Center(
                           child: Text(
                             'ابلاغ',
                             style: TextStyle(
                                 fontSize: 13,
                                 color: Colors.white
                             ),

                           ),
                         ),
                       ),
                     ),


                   ],
                 ),

                 const SizedBox(height: 20,),

                  Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorApp.back1
                    ),
                    child: Center(
                      child: Text(
                        'مقاطع الفيديو',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                        ),

                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  model!.data!.myVideos!.isEmpty?  Container(
                    child:const Text('لا توجد فيديوهات',
                      style: TextStyle(color: Colors.white,fontSize: 25),),
                  ):
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: model!.data!.myVideos!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                          childAspectRatio: 0.6
                      ),
                      itemBuilder: (itemBuilder, index) {

                        return ItemVideoPlayer(
                          videoUrl:model!.data!.myVideos![index].path,
                          scrollController: _scrollController!,
                          function:(){

                          },
                        );
                      }
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Future<void> _launchUrl(Uri _url) async {
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    }else {
      throw 'Could not launch $_url';
    }

  }
}

class ItemVideoPlayer extends StatefulWidget {
  String? videoUrl;
  Function() function;
  ScrollController scrollController  ;

  ItemVideoPlayer({Key? key,required this.videoUrl,required this.function,required this.scrollController}) : super(key: key);

  @override
  State<ItemVideoPlayer> createState() => _VideoPlayerState();
}





class _VideoPlayerState extends State<ItemVideoPlayer> {

  late CachedVideoPlayerController _videoController;
  late String image;
  bool isShow = false;
  bool isShowPlaying = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.scrollController.addListener(() {
      _videoController.pause();
    });

    _videoController = CachedVideoPlayerController.network(widget.videoUrl!)
      ..initialize().then((value) {
        setState(() {
          isShow = true;
          isShowPlaying = false;

        });
      });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _videoController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return isShow?
    InkWell(
      onTap:(){
        setState(() {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
        });
      } ,
      child:Stack(
        children: [
          CachedVideoPlayer(_videoController),
          Center(
            child:isPlaying() ,
          )
        ],
      ),
    )
        :
    Center(
      child: CircularProgressIndicator(),
    );

  }
  Widget isPlaying() {
    return _videoController.value.isPlaying && !isShowPlaying
        ? Container()
        : Icon(
      Icons.play_arrow, size: 80, color: Colors.white.withOpacity(0.5),);
  }
}
