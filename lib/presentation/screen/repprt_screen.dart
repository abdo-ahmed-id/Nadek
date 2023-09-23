
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/style/ColorApp.dart';

class repprt_screen extends StatefulWidget {
  String? title;
   repprt_screen({Key? key,required this.title}) : super(key: key);

  @override
  State<repprt_screen> createState() => _repprt_screenState();
}

class _repprt_screenState extends State<repprt_screen> {
  TextEditingController textc=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorApp.black_400,
        title: Text('${widget.title}'),
        centerTitle: true,
      ),
      body: Container(
        color: ColorApp.black_400,
        width: double.infinity,
        height: double.infinity,
        child:SingleChildScrollView(
          child:  Column(
            children:  [
              const Text('ضع وصف لهذا البلاغ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),

              ),
               Padding(padding: const EdgeInsets.all(20),
                child: TextField(
                  controller:textc ,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 10,
                  style:const TextStyle(
                    color: Colors.white
                  ),

                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'الوصف',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                    ),
                  ),
                ),
              ),
              Component_App.Button(text: 'ابلاغ',
                  function: (){
                if (textc.text.isEmpty || textc.text.length <50) {
                  Fluttertoast.showToast(
                    msg: ' برجاءوصف المشكلة وان لايقل عن 50 حرف',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                  );
                }else{
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    msg: 'سوف يتم مراجعة البلاغ ',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
