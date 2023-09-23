import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/LiveUserNowModel.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/MessageLine.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/constante/string.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:permission_handler/permission_handler.dart';

final _firestore = FirebaseFirestore.instance;

class LiveUserNow extends StatefulWidget {
  const LiveUserNow({Key? key}) : super(key: key);

  @override
  State<LiveUserNow> createState() => _LiveUserNowState();
}

class _LiveUserNowState extends State<LiveUserNow> {
  LiveUserNowModel? model;
  bool isLoading = true;
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = CacheHelper.getString('tokens');
    BlocProvider.of<NadekCubit>(context).GetLiveUserNow(token: token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NadekCubit, NadekState>(
        listener: (context, state) {
          if (state is LoadedLiveUserNow) {
            setState(() {
              model = state.data;
              print(' noooooooooooooooo ${model!.msg}');
              isLoading = false;
            });
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          if (!isLoading) {
            return model!.data!.isEmpty
                ? const Center(
                    child: Text(
                    '....لا يوجد بث ',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                    textAlign: TextAlign.center,
                  ))
                : Layout(
                    model: model,
                    size: model!.data!.length,
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Layout extends StatefulWidget {
  LiveUserNowModel? model;
  int? size;
  Layout({Key? key, required this.model, required this.size}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool Loadeing = true;
  String? name;
  String? photo;

  @override
  void initState() {
    // TODO: implement initState
    name = CacheHelper.getString('username');
    photo = CacheHelper.getString('photo');
    _tabController = TabController(length: widget.size!, vsync: this);
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
    return getBody();
  }

  Widget getBody() {
    return RotatedBox(
      quarterTurns: 1,
      child: TabBarView(
        controller: _tabController,
        children: [
          for (int i = 0; i < widget.size!; i++)
            VideoPlayerItem(
              token: widget.model!.data![i].token,
              imageurl: photo,
              sender: name,
            ),
        ],
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  String? token;
  String? sender;
  String? imageurl;
  VideoPlayerItem(
      {Key? key,
      required this.token,
      required this.sender,
      required this.imageurl})
      : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  bool isShowPlaying = false;
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  String? messageText;
  TextEditingController messageTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('sssssssssssss  ${widget.token}');
    initAgora();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _engine.release();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();
    await _initAgoraRtcEngine();

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int uid) {
          print("local user $uid joined");

          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        onUserOffline:
            (RtcConnection connection, int uid, UserOfflineReasonType reason) {
          print("remote user $uid left channel");

          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(
      token: widget.token ?? '',
      channelId: widget.token ?? '',
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
      uid: _remoteUid ?? 0,
    );
  }

  Future<void> _initAgoraRtcEngine() async {
    // _engine =  await RtcEngine.create(string_app.appId);
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(appId: string_app.appId));
    await _engine.enableVideo();
    await _engine.enableAudio();

    await _engine
        .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: -1,
        child: Container(
          color: Colors.black,
          child: Center(
            child: _localUserJoined
                ? Center(
                    child: _remoteVideo(),
                  )
                : const CircularProgressIndicator(),
          ),
        ));
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return Stack(
        children: [
          AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: _engine,
              canvas: VideoCanvas(uid: _remoteUid),
              connection: RtcConnection(channelId: widget.token),
            ),
          ),
          // RtcRemoteView.TextureView(
          //   uid: _remoteUid!,
          //   channelId: widget.token!,
          // ),
          Padding(
            padding: const EdgeInsets.all(50),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Live',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 42,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                            size: 26,
                          ),
                          Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
                child: Container(
                  height: 300,
                  child: StraemComments(),
                )),
          )
        ],
      );
    } else {
      return const Text(
        '.....تم انتهاء البث',
        style: TextStyle(fontSize: 25, color: Colors.white),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget StraemComments() {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('Live')
              .doc('Comments')
              .collection(widget.token!)
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
            return Expanded(
              child: ListView(
                reverse: true,
                padding: const EdgeInsets.all(20),
                children: messagesWidgets,
              ),
            );
          },
        ),
        inputText(
            controller: messageTextController,
            hint: 'اضافة تعليق',
            textInputType: TextInputType.text,
            function: () {
              _firestore
                  .collection('Live')
                  .doc('Comments')
                  .collection(widget.token!)
                  .add({
                'text': messageText,
                'sender': widget.sender,
                'imageUrl': widget.imageurl,
                'time': FieldValue.serverTimestamp(),
              });
              messageTextController.clear();
            })
      ],
    );
  }

  Widget inputText(
      {int? index,
      required TextEditingController controller,
      required String hint,
      required TextInputType textInputType,
      required Function function,
      IconData? icon}) {
    return Container(
        height: 57,
        width: 322,
        decoration: BoxDecoration(
            color: ColorApp.input_text,
            borderRadius: BorderRadius.circular(31)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: TextFormField(
            controller: controller,
            onChanged: (value) {
              messageText = value;
            },
            textAlign: TextAlign.right,
            keyboardType: textInputType,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    _firestore
                        .collection('Live')
                        .doc('Comments')
                        .collection(widget.token!)
                        .add({
                      'text': messageText,
                      'sender': widget.sender,
                      'imageUrl': widget.imageurl,
                      'time': FieldValue.serverTimestamp(),
                    });
                    messageTextController.clear();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
                filled: true,
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.white)),
          ),
        ));
  }
}
