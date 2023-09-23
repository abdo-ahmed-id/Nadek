import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nadek/data/model/account_update.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Update_Account extends StatefulWidget {
  const Update_Account({Key? key}) : super(key: key);

  @override
  State<Update_Account> createState() => _Update_AccountState();
}

class _Update_AccountState extends State<Update_Account> {
  var _cname = TextEditingController();
  var _berth_day = TextEditingController();
  var _cgender = TextEditingController();
  var _cphone = TextEditingController();
  var _cyoutube = TextEditingController();
  var _cinstagram = TextEditingController();
  var _cpassword = TextEditingController();
  final formKey =GlobalKey<FormState>();




  String? token;
  String? photo;
  String? _sex;
  ImagePicker? _picker;
  File? image;
   String? path;
   String? _date;
  account_update? account;
  account_update? photo_update;
  bool imageLoaded=false;
  DateTime selectedDate = DateTime.now();




  @override
  void initState() {
    // TODO: implement initState
    _picker = ImagePicker();
    _date='${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
    getData();
    super.initState();
  }

  void getData() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        // token =value.getString('token');
        token = value.getString('token');
        photo = value.getString('photo');
        _cname.text = value.getString('username')!;
        _berth_day.text = value.getString('berth_day')!;
        _sex = value.getString('gender')!;
        _cphone.text = value.getString('phone')!;
        _cyoutube.text = value.getString('youtube')!;
        _cinstagram.text = value.getString('instagram')!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorApp.black_400,
      ),
      body: BlocConsumer<NadekCubit, NadekState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is UpdatePhoto) {


            setState((){
              photo_update=state.account;
              print(photo_update!.msg);
              BlocProvider.of<NadekCubit>(context).ChangeProfileUser();


            });

          }

          if (state is LoadedUpdateAccount) {


            setState((){
              account =state.account;
              print(account!.msg);
              BlocProvider.of<NadekCubit>(context).ChangeProfileUser();

              Fluttertoast.showToast(
                msg: '${account!.msg}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
              );

            });

          }
        },
        builder: (context, state) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: ColorApp.black_400,
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: ()async{
                        image = await _picker?.pickImage(source: ImageSource.gallery).then((value){

                          setState((){
                            path=value!.path;

                          });
                        });
                      },
                      child: CircleAvatar(
                        radius: 90,
                        backgroundColor: ColorApp.black_400,
                        backgroundImage:path == null?AssetImage('assets/images/upload.png'):FileImage(File(path!))as ImageProvider,

                      ),
                    ),


                    SizedBox(height: 30,),
                    Component_App.InputText(
                        controller: _cname,
                        hint: 'name',
                        textInputType: TextInputType.text,
                        function: (value){
                          if (value.isEmpty||value ==null) {
                            return "ادخل  الاسم";
                          }else {
                            return null;
                          }
                        }
                    ),
                    SizedBox(height: 30,),
                    GestureDetector(
                      child: Container(
                        width: 322,
                        height: 60,
                        decoration: BoxDecoration(
                          color: ColorApp.input_text,
                          borderRadius: BorderRadius.circular(31),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0,15,10,0),
                          child: Text(
                            '${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white),

                          ),
                        ),
                      ),
                      onTap: (){
                        _selectDate(context);
                      },
                    ),
                    SizedBox(height: 30,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        GestureDetector(
                          onTap: () {
                            print(_sex);

                            setState(() {
                              _sex = 'male';
                            });
                          },
                          child: Container(
                            height: 57,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(31),
                              color: _sex == 'male' ? ColorApp.blue : ColorApp
                                  .back1,
                            ),
                            child: const Center(
                              child: Text(
                                'ذكر',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20

                                ),
                              ),
                            ),
                          ),

                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        GestureDetector(
                          onTap: () {
                            print(_sex);
                            setState(() {
                              _sex = 'female';
                            });
                          },
                          child: Container(
                            height: 57,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(31),
                              color: _sex == 'female' ? ColorApp.move : ColorApp
                                  .back1,


                            ),
                            child: const Center(
                              child: Text(
                                'انثى',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Component_App.InputText(
                        controller: _cphone,
                        hint: 'phone',
                        textInputType: TextInputType.text,
                        function: (value){
                          if (value.isEmpty||value ==null) {
                            return "ادخل  رقم الهاتف";
                          }else {
                            return null;
                          }
                        }
                    ),

                    SizedBox(height: 30,),
                    Component_App.InputText(
                        controller: _cyoutube,
                        hint: 'youtube',
                        textInputType: TextInputType.text,
                        function: (value){

                        }
                    ),
                    SizedBox(height: 30,),
                    Component_App.InputText(
                        controller: _cinstagram,
                        hint: 'instagram',
                        textInputType: TextInputType.text,
                        function: (value){
                          return null;
                        }
                    ),
                    SizedBox(height: 30,),
                    Component_App.InputText(
                        controller:_cpassword,
                        hint: 'password',
                        textInputType: TextInputType.visiblePassword,
                        function: (value){
                          return  null;
                        }
                    ),
                    SizedBox(height: 30,),

                    Component_App.Button(
                        text: 'حفظ التغيرات',
                        function: () {
                          final isValde =formKey.currentState!.validate();
                          if (isValde) {
                            SharedPreferences.getInstance().then((value) {
                              setState(() {
                                // token =value.getString('token');
                                value.setString('username', _cname.text);
                                if (path !=null) {
                                  value.setString('photo', path!);

                                }

                                value.setString('berth_day',_date!);
                                value.setString('gender', _sex!);
                                value.setString('phone', _cphone.text);
                                value.setString('youtube', _cyoutube.text);
                                value.setString('instagram',_cinstagram.text);

                              });
                            });


                            BlocProvider.of<NadekCubit>(context).setAccount(
                                _cname.text,
                                _date!,
                                _sex!,
                                _cphone.text,
                                _cpassword.text,
                                _cinstagram.text,
                                _cyoutube.text,
                                token!
                            );


                            if (path !=null) {
                              BlocProvider.of<NadekCubit>(context).UpadtePhoto(file:path!, token:token!);

                            }
                          }

                        }



                    ),
                    SizedBox(height: 30,),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:selectedDate ,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime.now()
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _date='${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
        print(_date);
      });
    }
  }
}
