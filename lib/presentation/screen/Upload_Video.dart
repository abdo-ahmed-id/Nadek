import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nadek/data/model/sports.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/GetLocation.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Upload_Video extends StatefulWidget {
  const Upload_Video({Key? key}) : super(key: key);

  @override
  State<Upload_Video> createState() => _Upload_VideoState();
}

class _Upload_VideoState extends State<Upload_Video> {
  String? token;
  File? _video;
  sports? s;
  String _SelectdType='اختر نوع الرياضة';
  int type_sportId=0;


  ImagePicker?_picker;
  bool isShowPlaying = false;
  late final ProgressDialog pr;
  final formKey=GlobalKey<FormState>();

  CachedVideoPlayerController? _videoPlayerController;
  var _title= TextEditingController();
  var _desc = TextEditingController();
  var _typeSport =TextEditingController();
  var _location  =TextEditingController();
  String? country;
  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    pr = ProgressDialog(context,type: ProgressDialogType.download, isDismissible: false, showLogs: true);
    BlocProvider.of<NadekCubit>(context).getSports();

    getToken();
    super.initState();
    PassLocation().then((value){
      setState(() {
        country =value.first.country;
        _location.text=country!;
      });
    });
    _picker = ImagePicker();
  }

  void getToken() async {
    await SharedPreferences.getInstance().then((value) {
      setState(() {
        token = value.getString("token");

      });
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorApp.black_400,
        centerTitle: true,
        title: Text('اضافة فيديو'),
      ),
      body: BlocConsumer<NadekCubit, NadekState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is LoadedDataSports ){
            setState((){

              s= state.s;

            });

          }

          if (state is SetUploadedVideo) {
            print(state.uploadVideo.msg);
            Fluttertoast.showToast(
              msg: '${state.uploadVideo.msg}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
            );
            Navigator.pop(context);

          }
        },
        builder: (context, state) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: ColorApp.black_400,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    if(_video != null)
                      _videoPlayerController!.value.isInitialized
                     ? InkWell(
                        onTap: () {
                          setState(() {
                            _videoPlayerController!.value.isPlaying
                                ? _videoPlayerController!.pause()
                                : _videoPlayerController!.play();
                          });
                        },
                        child: Container(
                            height: 200,
                            width: 200,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: AspectRatio(
                                      aspectRatio: _videoPlayerController!.value
                                          .aspectRatio,
                                      child: CachedVideoPlayer(_videoPlayerController!),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: isPlaying(),
                                )
                              ],
                            )
                        ),
                      )
                          : Container() else
                      Text("معاينة الفديو",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),),

                    SizedBox(height: 10,),

                    Component_App.InputText(
                        controller: _title,
                        hint: 'عنوان فيديو',
                        textInputType: TextInputType.text,
                        function: (value){
                          if (value.isEmpty||value ==null) {
                            return "ادخل عنوان فيديو";
                          }else {
                            return null;
                          }
                        }
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 60,
                      width: 322,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: ColorApp.back1

                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DropdownButton(
                            alignment: AlignmentDirectional.centerEnd,
                            menuMaxHeight: 300,
                            underline: Container(),
                            items: s?.data?.map((value) {

                              return DropdownMenuItem<int>(
                                value: value.id,
                                child: Text(value.title!),

                              );
                            }).toList(),
                            hint: Text(
                              _SelectdType,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),

                            onChanged: (int? value){
                              setState(() {
                                type_sportId =s!.data![value!.toInt() -1].id!.toInt();
                                //type_sportId =value!.toInt();

                                _SelectdType=s!.data![value.toInt()-1].title.toString();

                                print(type_sportId);
                              });
                            }
                        ),
                      ),

                    ),

                    SizedBox(height: 10,),

                    Component_App.InputText(
                        controller: _location,
                        hint: 'الموقع',
                        readOnly: true,
                        textInputType: TextInputType.text,
                        function: (value){
                          if (value.isEmpty||value ==null) {
                            return "ادخل  الموقع";
                          }else {
                            return null;
                          }
                        }
                    ),
                    SizedBox(height: 10,),

                    Component_App.Button(text: 'اختيار فيديو', function: () async {
                      _showDialog();
                    }),
                    SizedBox(height: 10,),

                    Component_App.Button(
                     text: 'رفع',
                     function: () {
                       final isValid=formKey.currentState!.validate();
                       if (isValid && _video?.path !=null) {
                         UploadVideo();
                       }


                     })

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  void UploadVideo()async{

    pr.style(
        message: 'انتظر من فضلك...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );

    await pr.show();

    BlocProvider.of<NadekCubit>(context).setUploadVideo(
        file:_video!.path,
        title:_title.text,
        location:_location.text,
        sport_id:type_sportId,
        token:token!,
        function: (int sent,int total)async{
          var time=(sent/total *100).round();
          if (time==100.0) {
            await pr.hide();

          }  
          pr.update(
            progress: time.toDouble(),
            message: "جاري رفع الفيديو...",
            progressWidget: Container(
                padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
            maxProgress: 100.0,
            progressTextStyle: TextStyle(
                color: Colors.black, fontSize: 13.0),
            messageTextStyle: TextStyle(
                color: Colors.black, fontSize: 13.0),
          );
        }
    );


  }
  Future getVideoFromGallery() async {
    XFile? video = await _picker!.pickVideo(source: ImageSource.gallery);
    setState((){
      _video = File(video!.path);

    });
    _videoPlayerController = CachedVideoPlayerController.file(File(video!.path))
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController!.play();
        });
      });
  }
  Future getVideoFromCamera() async {
    XFile? video = await _picker!.pickVideo(source: ImageSource.camera);
    setState((){
      _video = File(video!.path);

    });
    _videoPlayerController = CachedVideoPlayerController.file(File(video!.path))
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController!.play();
        });
      });
  }

  Future<bool> _showDialog() async {
    return (await showDialog(
      context: context,
      builder: (contex) => AlertDialog(
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                Navigator.of(contex).pop(true);
                getVideoFromGallery();
              },
              child: new Text('المعرض'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(contex).pop(true);
                getVideoFromCamera();
              } ,
              child: new Text('الكاميرا'),
            )],
        ),
      )
    )) ?? false;
  }

  Widget isPlaying() {
    return _videoPlayerController!.value.isPlaying && !isShowPlaying
        ? Container()
        : Icon(
      Icons.play_arrow, size: 80, color: Colors.white.withOpacity(0.5),);
  }

}
