
import 'package:nadek/data/model/AddUserRoom.dart';
import 'package:nadek/data/model/AllRooms.dart';
import 'package:nadek/data/model/AllUser.dart';
import 'package:nadek/data/model/ApiData.dart';
import 'package:nadek/data/model/BestUser.dart';
import 'package:nadek/data/model/CommentsModel.dart';
import 'package:nadek/data/model/FollowedModel.dart';
import 'package:nadek/data/model/FollowersModel.dart';
import 'package:nadek/data/model/GetCart.dart';
import 'package:nadek/data/model/GetCategories.dart';
import 'package:nadek/data/model/GetProducts.dart';
import 'package:nadek/data/model/LikeModel.dart';
import 'package:nadek/data/model/LiveModel.dart';
import 'package:nadek/data/model/LiveUserNowModel.dart';
import 'package:nadek/data/model/LocationUserModel.dart';
import 'package:nadek/data/model/MakeOrder.dart';
import 'package:nadek/data/model/ProfileOfUserModel.dart';
import 'package:nadek/data/model/SettingsModel.dart';
import 'package:nadek/data/model/UploadVideo.dart';
import 'package:nadek/data/model/account_update.dart';
import 'package:nadek/data/model/create_group_model.dart';
import 'package:nadek/data/model/login_model.dart';
import 'package:nadek/data/model/private_video.dart';
import 'package:nadek/data/model/public_video.dart';
import 'package:nadek/data/model/register_model.dart';

import 'package:nadek/data/model/sports.dart';
import 'package:nadek/data/webservices/WebServices.dart';

class repository{
   final Web_Services _web;

  repository(this._web);

  Future<login_model> login_user ({required String phone,required String password})async{
    final data= await _web.getData(phone: phone, password: password);

    return data;
  }
   Future<sports> getSports()async{
     final data= await _web.getSports();


     return data;
   }
   Future<register_model> Register({
     required String name,
     required String date,
     required String sex,
     required String phone,
     required String password,
     required String fcm_token,
     required List list})async{
    final data =await _web.Register(
        name: name,
        date: date,
        sex: sex,
        phone: phone,
        password: password,
        fcm_token :fcm_token,
        list: list
    );

     return data;
   }
   Future<create_group_model> Create_group(String token,String name,String file)async{
    final data = await _web.Create_group(token,name, file);

    return data;
  }
   Future<AllRooms> getAllRooms(String token)async{
     final data =await _web.getAllRooms(token);

     return data;
   }
   Future<private_video> getPrivateVideo(String token)async{
     final data = await _web.getPrivateVideo(token);
     return data;
   }
   Future<public_video> getPublicVideo(String token)async{
     final data = await _web.getPublicVideo(token);

     return data;
   }
   Future<AllUser> getAllUser({required int room_id, required String token})async{
     final data = await _web.getAllUser(room_id: room_id,token: token);

     return data;
   }
   Future<AddUserRoom> add_room_users(int room_id,int user_id,String token)async{
     final data =await _web.add_room_users(room_id,user_id,token);

     return data;
   }

   Future<account_update> UpdateLocation({required double lit,
     required double long,
     required String token})async{
    final data=await _web.UpdateLocation(lit: lit, long: long, token: token);

    return data;
   }

   Future<account_update> UpdatePhoto({required String file,required String token})async{
     final data=await _web.UpdatePhoto(file, token);

     return data;
   }

   Future<account_update> setaccount_update(
       String name,
       String berth_day,
       String gender,
       String phone,
       String password,
       String instagram,
       String youtube,
       String token)async{
    final data =await _web.setaccount_update(
        name,
        berth_day,
        gender,
        phone,
        password,
        instagram,
        youtube,
        token);

     return data;
   }
   Future<GetCategories> getCategories(String token)async{
     final data =await _web.getCategories(token);
     print(data);
     return data;
   }

   Future<UploadVideo> setUploadVideo(Function(int sent,int total) function,String file,String title,String location,int sport_id,String token)async{
    final data =await _web.setUploadVideo(function,file, title, location, sport_id, token);

    return data;

   }
   Future<ApiData> PostToCart({required int product_id,required int quantity,required String token})async{
    final data =await _web.PostToCart(product_id: product_id, quantity: quantity, token: token);
     return data;
   }
   Future<GetCart> GetFromCart({required String token})async{
    final data =await _web.GetFromCart(token: token);
     return data;
   }
   Future<ApiData> RemvoeCart({required int product_id,required int quantity,required String token})async{
     final data =await _web.RemoveFromCart(product_id: product_id, quantity: quantity, token: token);
     return data;
   }

   Future<MakeOrder> PostMakeOrder({required String location,required String token})async{
    final data =await _web.PostMakeOrder(location: location, token: token);
     return data;
   }

   Future<ApiData> GetCount({required String token})async{
    final data =await _web.GetCount(token: token);
     return data;
   }
   Future<int> PostAddComment({required String token,required int video_id,required String comment})async{
    final data =await _web.PostAddComment(token: token, video_id: video_id, comment: comment);
    return data;
   }

   Future<dynamic> GetProfile({required String token})async{
    final data =await _web.GetProfile(token: token);
    return data;
   }
   Future<ProfileOfUserModel> GetProfileOfUser({required int user_id,required String token})async{
     final data =await _web.GetProfileOfUser(user_id: user_id, token: token);
     return data;
   }
   Future<FollowedModel> GetFollowed({required String token})async{
     final data =await _web.GetFollowed(token: token);

     return data;
   }
   Future<FollowersModel> GetFollowers({required String token})async{
     final data =await _web.GetFollowers(token: token);


     return data;
   }

   Future<CommentsModel> GetAllComments({required String token,required Map<String,dynamic> map})async{

    final data =await _web.GetAllComments(token: token, map: map);
     return data;
   }

   Future<LikeModel> AddLike({required String token,required Map<String,dynamic> map})async{
    final data =await _web.AddLike(token: token, map: map);
    return data;
   }

   Future<ApiData> AddFollow({required String token,required int uid})async{
     final data =await _web.AddFollow(token: token, uid: uid);
     return data;
   }
   Future<BestUser> GetBestUser({required String token})async{
    final data=await _web.GetBestUser(token: token);
     return data;

   }

   Future<LocationUserModel> GetAllocationUser({required String token})async{
     final data=await _web.GetAllocationUser(token: token);

     return data;
   }
   Future<LiveModel> StartAndEndLive({required String token,required Map<String,dynamic> map})async{
     final data =await _web.StartAndEndLive(token: token, map: map);
     return data;
   }
   Future<LiveUserNowModel> GetLiveUserNow({required String token})async{
     final data =await _web.GetLiveUserNow(token: token,);
     return data;
   }
   Future<SettingsModel> GetSettings()async{
     final data =await _web.GetSettings();
     return data;
   }

   Future<dynamic> DeleteUserFromRom({required String token,required String room_id,required String user_id})async{
     final data =await _web.DeleteUserFromRom(token: token, room_id: room_id, user_id: user_id);

     return data;
   }
   Future<ApiData> DeleteRoom({required String token,required String room_id})async{
    final data =await _web.DeleteRoom(token: token, room_id: room_id);
     return data;
   }
}