import 'dart:async';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/CommentsModel.dart';
import 'package:nadek/data/model/ProfileOfUserModel.dart';
import 'package:nadek/data/model/private_video.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/presentation/screen/ProfileOfUser.dart';
import 'package:nadek/presentation/screen/repprt_screen.dart';
import 'package:nadek/sheard/component/column_social_icon.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
class PublicAllVideo extends StatefulWidget {
  private_video? p;
  String? videoUrl;


  PublicAllVideo({Key? key, required this.p}) : super(key: key);

  @override
  State<PublicAllVideo> createState() => _LayoutState();
}

class _LayoutState extends State<PublicAllVideo> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  var _textComment =TextEditingController();
  String? token;
  bool Loadeing =true;
  int CommentCount=0;
  int LikesCount=0;
  CommentsModel? commentsModel;

  ScrollController _myController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: widget.p!.data!.length, vsync: this);
    token =CacheHelper.getString('tokens');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: getBody(context),
    );
  }

  Widget getBody(widgetContext) {
    var size = MediaQuery
        .of(widgetContext)
        .size;

    return BlocConsumer<NadekCubit,NadekState>(

      listener:  (context,state){


        if (state is LoadedAddLike) {

          if (state.likeModel.errNum == 'dislike') {
            setState(() {
              LikesCount --;
            });
          }else{
            setState(() {
              LikesCount ++;
            });
          }


        }
      },
      builder: (context,state){
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child:  RotatedBox(
            quarterTurns: 1,
            child: TabBarView(
              controller: _tabController,
              children: [
                for(int i =0;i<widget.p!.data!.length;i++)
                  VideoPlayerItem(
                    videoUrl: '${widget.p!.data![i].path}',
                    size: size,
                    name: '',
                    caption: '',
                    songName: widget.p!.data![i].owner!.name.toString(),
                    profileImg: widget.p!.data![i].owner!.photo.toString() ,
                    likes: '${int.parse(widget.p!.data![i].likes_count!) + LikesCount}',
                    user_like: widget.p!.data![i].user_like ,
                    comments: '${widget.p!.data![i].comments!.length +CommentCount}',
                    repprt: 'ابلاغ',
                    albumImg: '',
                    title: '${widget.p!.data![i].title}',
                    subtitle: '${widget.p!.data![i].description}',
                    location: '${widget.p!.data![i].location}',
                    addLike: (){
                      addLike(i);
                    },
                    addComment: (){
                      addComment(i);
                    },
                    addrepprt: (){
                      BlocProvider.of<NadekCubit>(context).ChangePageView();

                      Navigator.of(widgetContext).push( MaterialPageRoute(builder: (context)=>repprt_screen(title: 'ابلاغ عن محتوي',)));

                    },
                    addFollow: (){
                      addFollow(i);
                    },
                    profileClick: (){
                      BlocProvider.of<NadekCubit>(context).ChangePageView();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c)=>ProfileOfUser(
                              user_id: widget.p!.data![i].owner!.id!.toInt()
                          )
                      ));
                    },
                  )

              ],
            ),
          ),
        );
      },
    );
  }
  void addFollow(int i){
    BlocProvider.of<NadekCubit>(context).AddFollow(
        token: token!,
        uid: widget.p!.data![i].owner!.id!.toInt()
    );
  }
  void addLike(int itemIndex){
    if (widget.p!.data![itemIndex].user_like==false) {
      setState(() {
        widget.p!.data![itemIndex].user_like=true;

      });
    }else{
      setState(() {
        widget.p!.data![itemIndex].user_like=false;

      });
    }
    BlocProvider.of<NadekCubit>(context).AddLike(
        token: token!,
        map: {'video_id':widget.p!.data![itemIndex].id}
    );

  }
  void addComment(int itemIndex){
    BlocProvider.of<NadekCubit>(context).GetAllComments(
        token: token!,
        map: {'video_id':widget.p!.data![itemIndex].id}
    );
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder:(context){

          return BlocConsumer<NadekCubit, NadekState>(
            listener: (context,state){
              if (state is LoadedGetAllComments) {
                setState(() {
                  commentsModel=state.commentsModel;
                  Loadeing =false;
                });
              }
            },

            builder: (context,state) => Container(
                color: ColorApp.black_400,
                width: double.infinity,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        flex: 1,
                        child:Center(
                          child: Text(
                            '${widget.p!.data![itemIndex].comments!.length +CommentCount} تعليق',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    ),
                    Expanded(
                      flex: 6,
                      child:Loadeing?
                      Center(
                        child: CircularProgressIndicator(),
                      ):
                      ListView.builder(
                        controller: _myController,
                        itemCount:  commentsModel?.data?.comments?.length??0,
                        itemBuilder: (context,index){

                          return  ListTile(
                            title: Text(
                              commentsModel?.data?.comments?[index].user?.name??'non user',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle:Text(
                                commentsModel?.data?.comments?[index].comment??'non comment',
                                style: TextStyle(color: Colors.white)
                            ) ,
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage('${ commentsModel?.data?.comments?[index].user?.photo}'),

                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: inputText(
                          index: itemIndex,
                          controller:_textComment ,
                          hint: 'اضافة تعليق',
                          textInputType: TextInputType.text,
                        )
                    )
                  ],
                )
            ),

          );
        }
    );

  }

  Widget inputText({required int index,required TextEditingController controller,required String hint,required TextInputType textInputType, IconData? icon}){
    return Container(
        height: 57,
        width: 322,

        decoration: BoxDecoration(
            color: ColorApp.input_text,
            borderRadius: BorderRadius.circular(31)
        ),
        child:  Padding(
          padding:const EdgeInsets.fromLTRB(20, 5, 20, 0),
          child:  TextFormField(
            controller: controller,

            textAlign: TextAlign.right,
            keyboardType: textInputType,
            style: const TextStyle(
                color: Colors.white
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
                suffixIcon:IconButton(
                  onPressed: (){
                    if (_textComment.text.isEmpty) {
                      print('isEmpty');
                      return;
                    }
                    BlocProvider.of<NadekCubit>(context).PostAddComment(
                        token: token!,
                        video_id: widget.p!.data![index].id!.toInt(),
                        comment: _textComment.text
                    ).then((value) {
                      setState(() {
                        CommentCount ++;
                      });
                      BlocProvider.of<NadekCubit>(context).GetAllComments(
                          token: token!,
                          map: {'video_id':widget.p!.data![index].id}
                      );
                    });
                    _textComment.clear();


                  },
                  icon: Icon(Icons.send,color: Colors.white,),
                ),
                filled: true,
                icon:Icon(
                  icon,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                hintText: hint,
                hintStyle:const TextStyle(
                    color: Colors.white
                )

            ),
          ),
        )
    );
  }

}


class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String name;
  final String caption;
  final String songName;
  final String profileImg;
  final String likes;
  final String comments;
  final String repprt;
  final String albumImg;
  final String title;
  final String subtitle;
  final String location;
  final bool user_like;
  final Function() addLike;
  final Function() addComment;
  final Function() addrepprt;
  final Function() addFollow;
  final Function() profileClick;


  VideoPlayerItem({Key? key,
    required this.size,
    required this.name,
    required this.caption,
    required this.songName,
    required this.profileImg,
    required this.likes,
    required this.comments,
    required this.repprt,
    required this.albumImg,
    required this.videoUrl,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.user_like,
    required this.addLike,
    required this.addComment,
    required this.addrepprt,
    required this.addFollow,
    required this.profileClick
  })
      : super(key: key);

  final Size size;

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerController _videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        _videoController.play();
        _videoController.setLooping(true);
        setState(() {
          isShowPlaying = false;
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController.dispose();
  }

  Widget isPlaying() {
    return _videoController.value.isPlaying && !isShowPlaying
        ? Container()
        : Icon(
      Icons.play_arrow, size: 80, color: Colors.white.withOpacity(0.5),);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NadekCubit, NadekState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ChangePage) {
          _videoController.pause();
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            setState(() {
              _videoController.value.isPlaying
                  ? _videoController.pause()
                  : _videoController.play();
            });
          },
          child: RotatedBox(
              quarterTurns: -1,
              child: Stack(
                children: [
                  buildVideo(),

                  Center(
                    child: Container(
                      child: isPlaying(),
                    ),
                  ),
                  Container(
                    height: widget.size.height,
                    width: widget.size.width,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 15, top: 20, bottom: 10, right: 10),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                child: Row(
                                  children: <Widget>[
                                    LeftPanel(
                                      size: widget.size,
                                      title: widget.title,
                                      subtitle: widget.subtitle,
                                      location: widget.location,
                                    ),
                                    RightPanel(
                                      size: widget.size,
                                      likes: "${widget.likes}",
                                      comments: "${widget.comments}",
                                      repprt: "${widget.repprt}",
                                      profileImg: "${widget.profileImg}",
                                      albumImg: "${widget.albumImg}",
                                      colorIcon: widget.user_like,
                                      addComment: widget.addComment,
                                      addLike: widget.addLike,
                                      addrepprt: widget.addrepprt,
                                      addFollow:widget.addFollow ,
                                      profileClick: widget.profileClick,
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        );
      },
    );
  }

  Widget buildVideo() =>
      Stack(
        fit: StackFit.expand,
        children: [
          buildVideoPlayer()
        ],
      );

  Widget buildVideoPlayer() {
    return buildFullScreen(
        child: AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: CachedVideoPlayer(_videoController),
        )
    );
  }

  Widget buildFullScreen({required Widget child}) {
    final size = _videoController.value.size;
    final width = size.width;
    final height = size.height;
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(height: height, width: width, child: child,),
    );
  }
}


class LeftPanel extends StatelessWidget {
  final Size size;
  String? title;
  String? subtitle;
  String? location;

  LeftPanel({
    Key? key,
    required this.size,
    required this.title,
    required this.subtitle,
    required this.location
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child:Text(
                title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),

              ),

            ),
            // Flexible(
            //   child: Text(
            //     subtitle!,
            //     overflow: TextOverflow.ellipsis,
            //     maxLines: 2,
            //     style: TextStyle(
            //       color: Colors.white,
            //
            //     ),
            //
            //   ),
            // ),

            Flexible(
              child: Text(
              location!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
              ),

            ),
            )
          ],
        ),
      )
    );
  }
}


class RightPanel extends StatelessWidget {
  final String likes;
  final String comments;
  final String repprt;
  final String profileImg;
  final String albumImg;
  final bool   colorIcon;
  final Function() addLike;
  final Function() addComment;
  final Function() addrepprt;
  final Function() addFollow;
  final Function() profileClick;

  const RightPanel({
    Key? key,
    required this.size,
    required this.likes,
    required this.comments,
    required this.repprt,
    required this.profileImg,
    required this.albumImg,
    required this.addLike,
    required this.addComment,
    required this.addrepprt,
    required this.colorIcon,
    required this.addFollow,
    required this.profileClick
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              getProfile(
                  profileImg,
                  function:addFollow,
                  profileClick:profileClick
              ),
              getIconsLike(
                  icon:Icon(
                    Icons.favorite,
                    color: colorIcon?Colors.red:Colors.white,
                    size: 35,
                  ),
                  count:likes,
                  size:35.0,
                  function: addLike
              ),
              getIcons('assets/icons/ic_comment.png', comments, 35.0,addComment),
              getIcons('assets/icons/ic_repprt.png', repprt, 25.0,addrepprt),
            ],
          )
      ),
    );
  }
}