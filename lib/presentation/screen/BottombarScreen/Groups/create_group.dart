

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class create_group extends StatefulWidget {
  const create_group({Key? key}) : super(key: key);

  @override
  State<create_group> createState() => _create_groupState();
}

class _create_groupState extends State<create_group> {
  final formKey =GlobalKey<FormState>();
   ImagePicker? _picker;
   File? image;
   bool loaded=false;
   String? path;
   bool isLoaded=false;
   late TextEditingController _name_controller =TextEditingController();
   String? token;


   void getToken() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     setState((){
       token= prefs.getString("token");

     });
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
     _picker = ImagePicker();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ColorApp.black_400,
        title: Text('إضافة أعضاء للمجموعة'),
      ),
      body:BlocListener<NadekCubit, NadekState>(
       listener: (context, state) {
         if (state is LoadedCreateGroup) {
           showSnackBarSuccess(context, title: '', message:'${state.group.msg}');
           BlocProvider.of<NadekCubit>(context).ChangeItemListChat();

           Navigator.pop(context);
         }
      },
       child: Stack(
        children: [
          isLoaded?
          Container(
            height: double.infinity,
            width: double.infinity,
            color: ColorApp.black_400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) :ColoredBox(
            color: ColorApp.black_400,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child:SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child:  Column(
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        height: 207,
                        width: 207,
                        child:  GestureDetector(
                            onTap: ()async{
                              image = await _picker?.pickImage(source: ImageSource.gallery).then((value){
                                setState((){
                                  path=value!.path;
                                  loaded=true;
                                });
                              });
                              // Pick an image

                            },
                            child:ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(207)),
                              child: !loaded?Image.asset('assets/icons/ic_create_group.png',fit: BoxFit.cover,): Image.file(File(path!),fit: BoxFit.cover),
                            )
                        ),
                      ),
                      SizedBox(height: 30,),

                      Component_App.InputText(
                          controller: _name_controller,
                          hint: 'اسم المجموعة',
                          textInputType: TextInputType.text,
                          function: (value){
                            if (value.isEmpty||value ==null) {
                              return "ادخل  اسم المجموعة";
                            }else {
                              return null;
                            }
                          }
                      ),
                      SizedBox(height: 30,),

                      Component_App.Button(
                          text: 'حفظ المجموعة ',
                          function: (){
                            final isValde =formKey.currentState!.validate();
                            if (path == null) {
                              Fluttertoast.showToast(
                                msg: "اضف صورة",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                              );
                            }
                            if(isValde && path != null){
                              setState((){
                                isLoaded=true;
                              });
                              BlocProvider.of<NadekCubit>(context).CreateGroup(token!,_name_controller.text, path!);
                            }

                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ) ,
    );
  }

   void showSnackBarError(context, {required String title,required String message}){
     showTopSnackBar(
         context,
         CustomSnackBar.error(message: message)
     );
   }
   void showSnackBarSuccess(context, {required String title,required String message}){
     showTopSnackBar(
         context,
         CustomSnackBar.success(message: message)
     );
   }
}
