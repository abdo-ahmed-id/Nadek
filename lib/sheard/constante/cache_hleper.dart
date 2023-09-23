
import 'package:nadek/data/model/GetProducts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
 static late SharedPreferences sharedPreferences;
 static init()async{
   sharedPreferences =await SharedPreferences.getInstance();
 }

 static Future<bool> setString(String key,String value){
   return sharedPreferences.setString(key, value);
 }
 static String? getString(String key){
   return sharedPreferences.getString(key);
 }

 static Future<bool> Remove(String key){
   return sharedPreferences.remove(key);
 }

}