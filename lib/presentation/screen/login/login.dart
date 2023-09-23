import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/login_model.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/constante/string.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class login_user extends StatefulWidget {
  const login_user({Key? key}) : super(key: key);

  @override
  State<login_user> createState() => _login_userState();
}

class _login_userState extends State<login_user> {
  final _controller_phone = TextEditingController();
  final _controller_password = TextEditingController();
  final formKey=GlobalKey<FormState>();
  late login_model login;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: layout()
    );
  }

  Widget layout() {
    return BlocListener<NadekCubit, NadekState>(
      listener: (context, state) {
        // TODO: implement listener

        if (state is LoginLoadedDataState) {
          setState((){
            isLoading = false;
            if (state.model.status==false) {
              showSnackBarError(context, title: '',message:'${ state.model.msg}');

            }else{
              CacheHelper.setString('tokens',' ${state.model.data?.apiKey}');
              CacheHelper.setString('username',' ${state.model.data?.name}');
              CacheHelper.setString('photo',' ${state.model.data?.photo}');
              CacheHelper.setString('Id',  '${state.model.data?.iD}');
              SharedPreferences.getInstance().then((value) {
                setState(() {
                 // token =value.getString('token');
                  value.setString('token',' ${state.model.data?.apiKey}');
                  value.setString('username', '${state.model.data?.name}');
                  value.setString('photo', '${state.model.data?.photo}');

                  value.setString('berth_day', '${state.model.data?.berthDay}');
                  value.setString('gender', '${state.model.data?.gender}');
                  value.setString('phone', '${state.model.data?.phoneNumber}');
                  value.setString('youtube', '${state.model.data?.youtube}');
                  value.setString('instagram', '${state.model.data?.instagram}');

                });
              });
             showSnackBarSuccess(context, title: '',message:'${ state.model.msg}');
             Navigator.popAndPushNamed(context, '/Home_screen');

            }

          });

        }
      },
      child: Stack(
        children: [
          isLoading ?
          Container(
            height: double.infinity,
            width: double.infinity,
            color: ColorApp.black_400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) :
          Container(
              height: double.infinity,
              color: ColorApp.black_400,
              child: Center(
                child: Container(
                  height: double.infinity,
                  color: ColorApp.black_400,
                  child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                      child: Center(
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Padding(
                                padding: EdgeInsets.all(50),
                                child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,

                                      children: const [
                                        Text('${string_app.nadek}',
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.white
                                          ),
                                        ),
                                        Text('تسجيل الدخول',
                                          style: TextStyle(
                                              fontSize: 21,
                                              color: Colors.white
                                          ),
                                        ),

                                      ],
                                    )
                                ),
                              ),


                              const SizedBox(
                                height: 70,
                              ),

                              Component_App.InputText(
                                  controller: _controller_phone,
                                  hint: 'رقم الهاتف',
                                  textInputType: TextInputType.phone,
                                  icon: Icons.call,
                                function: (value){
                                    if (value.isEmpty||value ==null) {
                                      return "ادخل رقم الهاتف";
                                    }else {
                                      return null;
                                    }
                                }
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Component_App.InputText(
                                  controller: _controller_password,
                                  hint: 'كلمة السر',
                                  textInputType: TextInputType.visiblePassword,
                                  icon: Icons.lock,
                                  function: (value){
                                    if (value.isEmpty||value ==null) {
                                      return "ادخل كلمة السر";
                                    }else {
                                      return null;
                                    }
                                  }
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Component_App.Button(text: 'تسجيل الدخول',
                                  function: () {
                                    Login();
                                  }
                              ),
                              const SizedBox(
                                height: 43,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('القي نظرة علي سياسة الخوصوصيةوشروط الاستخدام ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(context, '/termsAndConditions');
                                        },
                                        child:const Text('Terms of use,\n',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(context, '/privacy_policy');
                                        },
                                        child:const Text('Privacy policy\n',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  GestureDetector(
                                    onTap: (){
                                      Navigator.popAndPushNamed(context, '/Create_Account');
                                    },
                                    child:const Text(' انشاء حساب مجانا',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue
                                      ),
                                    ),
                                  ),

                                  const Text('ليس لديك حساب ؟ ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 43,
                              ),

                            ],
                          ),
                        ),
                      )
                  ),
                ),
              )
          ),

        ],
      ),
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
  void Login() {
    final isValidForm=formKey.currentState!.validate();
    if (isValidForm) {
      setState((){
        isLoading = true;
        BlocProvider.of<NadekCubit>(context).login_user(
            phone: _controller_phone.text,
            password: _controller_password.text);
      });

    }

    //  print(login.msg);

    print('${_controller_password.text + '\n' + _controller_phone.text}');
  }

}


