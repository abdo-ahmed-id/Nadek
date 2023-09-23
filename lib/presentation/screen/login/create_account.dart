
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/string.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
class Create_Account extends StatefulWidget {
  const Create_Account({Key? key}) : super(key: key);

  @override
  State<Create_Account> createState() => _Create_AccountState();
}

class _Create_AccountState extends State<Create_Account> {
  final _controller_name = TextEditingController();
  final _controller_date= TextEditingController();
  final _controller_gender = TextEditingController();
  final _controller_phone = TextEditingController();
  final _controller_password = TextEditingController();
  DateTime selectedDate = DateTime.now();

  final formKey =GlobalKey<FormState>();

  String _sex = 'male';
  String? _date ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            color: ColorApp.black_400,
            child: Center(
              child: Container(
                height: double.infinity,
                color: ColorApp.black_400,
                child:  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child:Center(
                      child: Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: formKey,
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 30, 30) ,
                              child:SizedBox(
                                  width: double.infinity,
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                    children: const [
                                      Text(string_app.nadek,
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.white
                                        ),
                                      ),
                                      Text('انشاء حساب جديد',
                                        style: TextStyle(
                                            fontSize: 21,
                                            color: Colors.white
                                        ),
                                      ),

                                    ],
                                  )
                              ) ,
                            ),
                            Component_App.InputText2(
                              controller: _controller_name,
                              hint: 'اسم الكريم',
                              textInputType: TextInputType.text,
                              function: (value){
                                  if (value.isEmpty||value ==null) {
                                    return "ادخل رقم الهاتف";
                                  }else {
                                    return null;
                                  }
                                }

                            ),
                            const SizedBox(
                              height: 9,
                            ),


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

                            const SizedBox(
                              height: 9,
                            ),
                            ////////////Sex
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                GestureDetector(
                                  onTap: (){
                                    print(_sex);

                                    setState((){
                                      _sex ='male';
                                    });
                                  },
                                  child:Container(
                                    height: 57,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(31),
                                      color:_sex=='male'?ColorApp.blue:ColorApp.back1,
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
                                  onTap: (){
                                    print(_sex);
                                    setState((){
                                      _sex ='female';
                                    });
                                  },
                                  child: Container(
                                    height: 57,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(31),
                                      color: _sex=='female'?ColorApp.move:ColorApp.back1,


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
                            const SizedBox(
                              height: 21,
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
                              height: 16,
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
                              height: 19,
                            ),
                            Component_App.Button(text: 'متابعة التسجيل',
                                function: (){
                                  final isValde =formKey.currentState!.validate();
                                  if (isValde) {
                                    Navigator.pushNamed(
                                        context,
                                        '/Sports_Selection',
                                        arguments: [
                                          _controller_name.text,
                                          _date,
                                          _sex,
                                          _controller_phone.text,
                                          _controller_password.text
                                        ]
                                    );
                                  }

                                }
                            ),
                            const SizedBox(
                              height: 43,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('عند متابعة  التسجيل فأنت توافق علي الاحكام والشروط ',
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
                                    Navigator.popAndPushNamed(context, '/login_user');
                                  },
                                  child:const Text('تسجيل الدخول',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue
                                    ),
                                  ),
                                ),
                                const Text(' لديك حساب ؟ ',
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
        )
    );
  }
  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:selectedDate ,
        firstDate: DateTime(1900, 8),
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

