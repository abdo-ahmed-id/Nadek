import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/model/GetCart.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';
import 'package:nadek/sheard/component/component.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late List<dynamic> list;
  final formKey=GlobalKey<FormState>();
  bool wataing = true;
  GetCart? getCart;
  String? token;
  int price =0;
  Timer? timer;

  var textEditingController =TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    token =CacheHelper.getString('tokens');

    super.initState();

    BlocProvider.of<NadekCubit>(context).GetFromCart(
        token: token!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('السلة'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorApp.black_400,
      ),
      body: BlocConsumer<NadekCubit, NadekState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoadedPostMakeOrder) {
            setState(() {
              BlocProvider.of<NadekCubit>(context).GetCount(token: '$token');

              wataing =false;
              Navigator.pop(context);
              showSnackBarSuccess(context, title: '', message: '${state.order.msg}');
            });
          }
          if (state is RemoveCart) {

            BlocProvider.of<NadekCubit>(context).GetFromCart(
                token: token!);
            BlocProvider.of<NadekCubit>(context).ChangeCountBadget();

          }
          if (state is LoadedCart) {
            setState(() {
              wataing = false;

              getCart = state.data;
            });
          }
        },
        builder: (context, state) {
          return wataing ?
          Container(
            height: double.infinity,
            width: double.infinity,
            color: ColorApp.black_400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) : Container(

            height: double.infinity,
            width: double.infinity,
            color: ColorApp.black_400,
            child: getCart!.data!.cartItems!.length.toInt()>0?
            SingleChildScrollView(
              child:Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key:formKey,
                child:  Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getCart!.data!.cartItems!.length,
                        itemBuilder: (item, index) {

                          return Item(
                            id:     getCart!.data!.cartItems![index].product!.id ,
                            title: '${getCart?.data?.cartItems?[index].product
                                ?.title}',
                            desc: getCart?.data?.cartItems?[index].product
                                ?.description,
                            price: getCart!.data!.cartItems![index].product
                                !.price.toString(),
                            image: getCart?.data?.cartItems?[index].product
                                ?.imagePath,
                            total: int.parse(
                                getCart!.data!.cartItems![index].quantity
                                    .toString()),
                            function: () {
                              BlocProvider.of<NadekCubit>(context)
                                  .RemoveFromCart(
                                product_id: getCart!.data!.cartItems![index].product!.id!.toInt(),
                                quantity:-int.parse(
                                    getCart!.data!.cartItems![index].quantity
                                        .toString()),
                                token: token!,

                              );

                            },
                          );
                        }
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            width:double.infinity ,
                            height: 1,
                            child:ColoredBox(color: Colors.white) ,
                          ),
                          Row(
                            children: [
                              Text('${getCart!.data!.cart_total}',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    Component_App.InputText(
                      icon: Icons.map,
                        controller: textEditingController,
                        hint: 'عنوان التوصيل',
                        textInputType: TextInputType.text,
                        onClick: (){
                          _getLocation();

                        },
                        function: (value){
                          if (value.isEmpty||value ==null) {
                            return "عنوان التوصيل";
                          }else {
                            return null;
                          }
                        }
                    ),
                    SizedBox(height: 10,),
                    Component_App.Button(
                        text: 'تأكيد الطلب الان ',
                        function: (){
                          final isValde =formKey.currentState!.validate();
                          if(isValde){
                            make_order();

                          }
                        }
                    )
                  ],

                ),
              ),
            ):
            Container(
                  height: double.infinity,
                  width: double.infinity,
              color: ColorApp.black_400,
              child: Image(
                height: 50,
                width: 50,
                image: AssetImage('assets/icons/ic_cart.png'),
              ),
            )
          );
        },
      ),
    );
  }
  void make_order(){
    BlocProvider.of<NadekCubit>(context)
        .PostMakeOrder(location: textEditingController.text, token: token!);
  }
  _getLocation()async{
    await [Permission.location,Permission.locationAlways].request();
    Position position =await
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> address=await
    placemarkFromCoordinates(position.latitude, position.longitude);
    var firs =address.first;
    textEditingController.text=''
        '${firs.country} ${firs.administrativeArea} ${firs.locality}';
    print(" "
        "country ${firs.country}"
        " :name ${firs.name} "
        ":locality ${firs.locality} "
        ":subLocality ${firs.subLocality}"
        ":administrativeArea ${firs.administrativeArea}"
        ":subAdministrativeArea ${firs.subAdministrativeArea}"
        ":thoroughfare ${firs.thoroughfare}"
        ":subThoroughfare${firs.subThoroughfare}"
        ":street${firs.street}"
        ":${firs.isoCountryCode}");

  }
}
void showSnackBarSuccess(context, {required String title,required String message}){
  showTopSnackBar(
      context,
      CustomSnackBar.success(message: message)
  );
}
class Item extends StatefulWidget {
  String? title;
  String? desc;
  String? price;
  String? image;
  int ?   id;
  int total;
  Function() function;

  Item({Key? key,
    required this.title,
    required this.desc,
    required this.price,
    required this.image,
    required this.total,
    required this.function,
    required this.id
  }) :super(key: key);

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {


  String? token;

  @override
  void initState() {
    // TODO: implement initState
    token =CacheHelper.getString('tokens');

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NadekCubit, NadekState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(15),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(0),
                child: IconButton(
                    onPressed: widget.function,
                    icon: Icon(Icons.cancel, color: Colors.grey,)
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${widget.title}',
                          style: TextStyle(color: Colors.white, fontSize: 16),),
                        Text('${widget.desc} ',
                          style: TextStyle(color: Colors.white, fontSize: 10),),
                        Text('${widget.price} ',
                          style: TextStyle(color: Colors.white, fontSize: 10),),
                        SizedBox(height: 20,),
                        Container(
                          width: 109,
                          height: 34,
                          decoration: BoxDecoration(
                              color: ColorApp.back1,
                              borderRadius: BorderRadius.circular(31)
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    height: 33,
                                    width: 33,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        stops: [0.0, 100.0],
                                        colors: [
                                          ColorApp.blue,
                                          ColorApp.move,
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add, color: Colors.white,
                                          size: 15,),
                                        onPressed: () {
                                          setState(() {
                                            widget.total ++;
                                            BlocProvider.of<NadekCubit>(context)
                                                .RemoveFromCart(
                                                product_id: widget.id!.toInt(),
                                                quantity: 1,
                                                token: token!
                                            );
                                          });
                                        },
                                      ),
                                    )
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${widget.total.toInt()}', style: TextStyle(
                                    color: Colors.white, fontSize: 14),),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    height: 33,
                                    width: 33,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        stops: [0.0, 100.0],
                                        colors: [
                                          ColorApp.blue,
                                          ColorApp.move,
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.remove, color: Colors.white,
                                          size: 15,),
                                        onPressed: () {
                                          setState(() {
                                            widget.total --;
                                            BlocProvider.of<NadekCubit>(context)
                                                .RemoveFromCart(
                                                product_id: widget.id!.toInt(),
                                                quantity: -1,
                                                token: token!
                                            );
                                          });
                                        },
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 6,),
                    Container(
                      height: 133,
                      width: 111,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          stops: [0.0, 100.0],
                          colors: [
                            ColorApp.blue,
                            ColorApp.move,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                              height: 45,
                              width: 55,
                              image: NetworkImage('${widget.image}')
                          ),

                        ],
                      ),
                    ),
                  ],

                ),
              )
            ],
          ),
        );
      },
    );
  }

}

