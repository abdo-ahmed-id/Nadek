
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:ndialog/ndialog.dart';


final _firestore = FirebaseFirestore.instance;


class Chats extends StatefulWidget {
  String chat_name;
  int chat_id;
  String sender;
  String id;
  int? owner;

  Chats({Key? key , required String this.sender ,required this.chat_name,  required this.chat_id,required this.id,required this.owner}):super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats>  {

  String? messageText;
  final messageTextController = TextEditingController();
  late String token;
  bool loding=false;



  @override
  void initState() {
    super.initState();
    token =CacheHelper.getString('tokens')!;

    //getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorApp.black_400,
        title:  Text('${widget.chat_name}' , style: const TextStyle(color: Colors.white),),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/AddUser',
                    arguments: [
                      widget.chat_id //chat_id
                    ]
                );
              },
              icon: Image(
                height: 25,
                width: 25,
                image: AssetImage('assets/icons/ic_add-user.png'),
              )
          ),
          IconButton(
              onPressed: (){
                print('object');

                showDialog(context);
              },
              icon: Image(
                height: 25,
                width: 25,
                image: AssetImage('assets/icons/ic_logout.png'),
              )
          )
        ],
      ),
      body: BlocConsumer<NadekCubit,NadekState>(

       listener:  (context,state){
         if (state is LoadedDeleteUserFromRoom) {
           BlocProvider.of<NadekCubit>(context).ChangeItemListChat();
           Navigator.pop(context);
           Navigator.pop(context);
         }
         if (state is LoadedDeleteRoom) {
           BlocProvider.of<NadekCubit>(context).ChangeItemListChat();

           Navigator.pop(context);
           Navigator.pop(context);
         }
       },
        builder: (context,state){
         return Container(
           color: ColorApp.black_400,
           child:  Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               MessageStreamBuilder(
                 chat_id: widget.chat_id.toString(),
                 sender: widget.sender.toString(),
                 id: widget.id,
               ),
               Container(
                 width: double.infinity,
                 child: inPutMSG(),
               ),
             ],
           ),
         );
        },
      )
    );
  }


  Widget inPutMSG(){
    return Padding(
        padding: EdgeInsets.all(20),
      child:  Container(
        width: 368,
        height: 57,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(31)
        ),
        child: Row(
          children: [
            Expanded(child: Container(
              decoration: const BoxDecoration(
                  color: ColorApp.move,

                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(31),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  bottomLeft: Radius.circular(31)
                )
              ),
              child: Center(
                child: IconButton(
                    onPressed: (){
                      _firestore.collection('chat')
                          .doc('message')
                          .collection(widget.chat_id.toString()).add({
                        'text' : messageText,
                        'sender' : widget.sender,
                        'ID':widget.id,
                        'time' : FieldValue.serverTimestamp(),
                      });
                      messageTextController.clear();
                    },
                    icon: Image(
                      image: AssetImage('assets/icons/ic_send.png'),
                    )
                ),
              ),
            )),
            Expanded(
              flex: 3,
              child:TextField(
                controller: messageTextController,
                onChanged: (value){
                  messageText = value;
                },
                textAlign: TextAlign.right,

                keyboardType: TextInputType.text,
                style: const TextStyle(
                    color: ColorApp.black_400
                ),
                cursorColor: ColorApp.black_400,
                decoration: const InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: "ادخل نص رسالتك ",
                    hintStyle:const TextStyle(
                        color: ColorApp.black_400
                    )

                ),
              ),
            )
          ],
        )
      ),
    );
  }

  void showDialog(context){
    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      content: Container(
        height: 335,
        width: 375,
        child: Center(
          child: Text(
            identical(widget.owner, int.parse(widget.id))?
            "سيتم حذف كافة الأعضاء والرسائل  من هذه المجموعة  هل انت متاكد من اغلاق المجموعة؟":
            "هل انت متاكد الخروج من هذه المجموعة؟",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
      actions: <Widget>[
       Container(

         child: Center(
           child:  Column(
             children: [
               identical(widget.owner, int.parse(widget.id))?
                   Column(
                     children: [
                       Component_App.Button(
                           text: 'اغلاق المجموعة',
                           function: (){

                             BlocProvider.of<NadekCubit>(context).DeleteRoom(
                                 token: token,
                                 room_id: widget.chat_id.toString()
                             );
                           }),
                       SizedBox(height: 10,),
                     ],
                   ):
                   Column(
                     children: [
                       Component_App.Button(
                           text: 'خروج من المجموعة',
                           function: (){
                             BlocProvider.of<NadekCubit>(context).DeleteUserFromRom(
                                 token: token,
                                 room_id:  widget.chat_id.toString(),
                                 user_id: widget.id
                             );

                           }),
                       SizedBox(height: 10,),
                     ],
                   )

             ],
           )
         ),
       )
       // TextButton(child: Text("Close"), onPressed: () => Navigator.pop(context)),
      ],
    ).show(context);
  }


}
class MessageStreamBuilder extends StatelessWidget {
  String chat_id;
  String sender;
  String id;
   MessageStreamBuilder({Key? key,required this.chat_id,required  this.sender,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('chat')
          .doc('message').collection(chat_id)
          .orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messagesWidgets = [];
        if(!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );

        }
        snapshot.data!.docs.reversed.forEach((message) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final userID =message.get('ID');
          final currentUser = id;

          final messageWidget = MessageLine(
            text: messageText,
            sender: messageSender,
            isMe: currentUser == userID? true : false,);
          messagesWidgets.add(messageWidget);
        });
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.all(20),
            children: messagesWidgets,
          ),
        );

      },);
  }
}
class MessageLine extends StatelessWidget {
  const MessageLine({Key? key, this.sender, this.text, required this.isMe}) : super(key: key);
  final String? sender;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender! ,style: TextStyle(fontSize: 12 , color: Colors.white) ,),
          Material(
            elevation: 5,
            borderRadius: isMe? const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ) :  const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isMe ? ColorApp.move : Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 20),
              child: Text(text! , style: TextStyle(fontSize: 15 , color: isMe ? Colors.white : Colors.black),),
            ),
          ),
        ],
      ),
    );
  }
}
