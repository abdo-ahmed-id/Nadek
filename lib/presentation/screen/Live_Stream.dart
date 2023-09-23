/*
import 'dart:async';
import 'dart:ui';

// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nadek/data/model/LiveModel.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/MessageLine.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/constante/string.dart';
import 'package:permission_handler/permission_handler.dart';

final _firestore = FirebaseFirestore.instance;

class Live_Stream extends StatefulWidget {
  const Live_Stream({Key? key}) : super(key: key);

  @override
  State<Live_Stream> createState() => _Live_StreamState();
}

class _Live_StreamState extends State<Live_Stream> {
  LiveModel? liveModel;
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  String? token;
  bool endLive = false;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    token = CacheHelper.getString('tokens');
    BlocProvider.of<NadekCubit>(context)
        .PlayStartAndEndLive(token: token!, map: {'channelName': token!});
    super.initState();
  }

  Future<void> initAgora(String channel) async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();
    await _initAgoraRtcEngine();

    _engine.registerEventHandler(
      RtcEngineEventHandler(
          joinChannelSuccess: (String channel, int uid, int elapsed) {
            print("local user $uid joined");
            setState(() {
              _localUserJoined = true;
            });
          },
          userJoined: (int uid, int elapsed) {
            print("remote user $uid joined");
            setState(() {
              _remoteUid = uid;
            });
          },
          userOffline: (int uid, UserOfflineReason reason) {
            print("remote user $uid left channel");

            setState(() {
              _remoteUid = null;
            });
          },
          leaveChannel: (RtcStats stats) {}),
    );

    await _engine.joinChannel(null, channel, null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    //_engine =  await RtcEngine.create(string_app.appId);
    _engine =
        await RtcEngine.createWithContext(RtcEngineContext(string_app.appId));
    await _engine.enableVideo();
    await _engine.enableAudio();

    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (true) {
      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    } else {
      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    }
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    if (!endLive) {
      BlocProvider.of<NadekCubit>(context).PlayStartAndEndLive(
          token: token!, map: {'channel_token': liveModel!.token});
      await _engine.leaveChannel();
      await _engine.destroy();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: BlocConsumer<NadekCubit, NadekState>(
          listener: (context, state) {
            if (state is LoadedStartAndEndLive) {
              Fluttertoast.showToast(
                msg: '${state.data.msg}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
              );
              setState(() {
                liveModel = state.data;
                if (state.data.token != null) {
                  initAgora(state.data.token!);
                }
                print('hhhhhhhhhh${state.data.msg}');
                loading = false;
              });
            }
          },
          builder: (context, state) {
            return loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : Stack(
                    children: [
                      Center(
                        child: _localUserJoined
                            ? RtcLocalView.SurfaceView()
                            : const CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(60),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Container(
                                  height: 42,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Live',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 100,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colors.white,
                                        size: 19,
                                      ),
                                      Text(
                                        '0',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35,
                            ),
                            GestureDetector(
                              onTap: () {
                                _onWillPop();
                              },
                              child: const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                    'assets/icons/ic_live_stream.png'),
                              ),
                            ),
                            IconButton(
                                onPressed: setSwitchCamera,
                                icon: Icon(
                                  Icons.cameraswitch,
                                  size: 35,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      _localUserJoined
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 70),
                                  child: Container(
                                    height: 300,
                                    child: StraemComments(),
                                  )),
                            )
                          : SizedBox()
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget StraemComments() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Live')
          .doc('Comments')
          .collection(liveModel!.token ?? 'non')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messagesWidgets = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        snapshot.data!.docs.reversed.forEach((message) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final messageImage = message.get('imageUrl');

          final messageWidget = MessageLine(
            text: messageText,
            sender: messageSender,
            imageUrl: messageImage,
          );
          messagesWidgets.add(messageWidget);
        });
        return ListView(
          reverse: true,
          padding: const EdgeInsets.all(20),
          children: messagesWidgets,
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (contex) => AlertDialog(
            title: new Text('هل انت متاكد؟'),
            content: new Text('من اغلاق البث؟؟'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(contex).pop(false),
                child: new Text('لا'),
              ),
              TextButton(
                onPressed: () async {
                  BlocProvider.of<NadekCubit>(context).PlayStartAndEndLive(
                      token: token!, map: {'channel_token': liveModel!.token});
                  endLive = true;
                  await _engine.leaveChannel();
                  await _engine.destroy();
                  print("Live........");
                  Navigator.of(contex).pop(true);
                  Navigator.pop(context);
                },
                child: new Text('نعم'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void setSwitchCamera() {
    _engine.switchCamera();
  }
}
*/
