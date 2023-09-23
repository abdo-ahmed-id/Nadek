import 'dart:convert';

import 'package:nadek/data/model/data_of_cart.dart';

class DataOfCart{
  late int id;
  late String title;
  late String suptitle;
  late String price;
  late String total;

  DataOfCart({
    required this.id,
    required this.title,
    required this.suptitle,
    required this.price,
    required this.total
  });
  factory DataOfCart.fromJson(Map<String,dynamic> json){
    return DataOfCart(
        id: json['id'],
        title: json['title'],
        suptitle: json['suptitle'],
        price: json['price'],
        total: json['total']
    );
  }
  static Map<String,dynamic> toMap(DataOfCart cart)=>{
    'id': cart.id,
    'title': cart.title,
    'suptitle': cart.suptitle,
    'price': cart.price,
    'total': cart.total
  };
  static String encode(List<DataOfCart> cart)=>json.encode(
    cart.map<Map<String,dynamic>>((e) => DataOfCart.toMap(e)).toList(),
  );

  static List<DataOfCart> decode(String cart)=>
      (json.decode(cart) as List<dynamic>)
          .map<DataOfCart>((e) => DataOfCart.fromJson(e)).toList();

}