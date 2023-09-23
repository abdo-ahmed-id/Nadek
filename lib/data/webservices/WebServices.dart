import 'package:dio/dio.dart';
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
import 'package:nadek/data/model/LikeModel.dart';
import 'package:nadek/data/model/LiveModel.dart';
import 'package:nadek/data/model/LiveUserNowModel.dart';
import 'package:nadek/data/model/LocationUserModel.dart';
import 'package:nadek/data/model/MakeOrder.dart';
import 'package:nadek/data/model/ProfileModel.dart';
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

class Web_Services {
  late Dio dio;
  //https://nadekapp.online

  Web_Services() {
    dio = Dio(BaseOptions(
      baseUrl:
          //"https://nadekapp.online/public/",
          'https://nadekapp.online/api/',
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ));
  }

  Future<login_model> getData(
      {required String phone, required String password}) async {
    login_model? login;
    try {
      Response response =
          await dio.post('login', data: {'phone': phone, 'password': password});
      login = login_model.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio Error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error send request!');
        print(e.message);
      }
    }
    return login!;
  }

  Future<sports> getSports() async {
    sports? s;

    try {
      Response response = await dio.get('sports');
      print(response.data);

      s = sports.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio Error! $e');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error send request!');
        print(e.message);
      }
    }
    return s!;
  }

  Future<register_model> Register(
      {required String name,
      required String date,
      required String sex,
      required String phone,
      required String password,
      required String fcm_token,
      required List list}) async {
    register_model? register;

    try {
      Response response = await dio.post('register', data: {
        'name': name,
        'berth_day': date,
        'gender': sex,
        'phone': phone,
        'password': password,
        'fcm_token': fcm_token,
        'sports': list
      });
      register = register_model.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio Error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error send request!');
        print(e.message);
      }
    }

    return register!;
  }

  Future<dynamic> Create_group(String token, String name, String file) async {
    dio.options.headers['Authorization'] = ' Bearer $token';

    String fileName = file.split('/').last;

    FormData data = FormData.fromMap({
      'photo': await MultipartFile.fromFile(file, filename: fileName),
      'name': name
    });
    Response response = await dio.post('create_room', data: data);
    return create_group_model.fromJson(response.data);
  }

  Future<dynamic> getAllRooms(String token) async {
    dio.options.headers['Authorization'] = ' Bearer $token';

    Response response = await dio.get('rooms');

    return AllRooms.fromJson(response.data);
  }

  Future<dynamic> getPrivateVideo(String token) async {
    dio.options.headers['Authorization'] = ' Bearer $token';

    Response response = await dio.get('videos');

    print(response.data);

    return private_video.fromJson(response.data);
  }

  Future<dynamic> getPublicVideo(String token) async {
    dio.options.headers['Authorization'] = ' Bearer $token';

    Response response = await dio.get('home');
    return public_video.fromJson(response.data);
  }

  Future<dynamic> getAllUser(
      {required int room_id, required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';

    Response response =
        await dio.get('users', queryParameters: {'room_id': room_id});
    print(response.data);
    return AllUser.fromJson(response.data);
  }

  Future<dynamic> add_room_users(int room_id, int user_id, String token) async {
    dio.options.headers['Authorization'] = ' Bearer $token';

    Response response = await dio
        .post('add_room_users', data: {'room_id': room_id, 'user_id': user_id});
    return AddUserRoom.fromJson(response.data);
  }

  Future<dynamic> UpdatePhoto(String file, String token) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    String fileName = file.split('/').last;

    FormData data = FormData.fromMap({
      'photo': await MultipartFile.fromFile(file, filename: fileName),
    });
    Response response = await dio.post('account_update', data: data);
    return account_update.fromJson(response.data);
  }

  Future<dynamic> UpdateLocation(
      {required double lit,
      required double long,
      required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';

    Response response =
        await dio.post('account_update', data: {'lat': lit, 'long': long});
    print(response.data);
    return account_update.fromJson(response.data);
  }

  Future<dynamic> setaccount_update(
      String name,
      String berth_day,
      String gender,
      String phone,
      String password,
      String instagram,
      String youtube,
      String token) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    FormData formData = FormData.fromMap({
      'name': name,
      'berth_day': berth_day,
      'gender': gender,
      'phone': phone,
      'instagram': instagram ?? '',
      'youtube': youtube ?? '',
      'password': password
    });
    Response response = await dio.post('account_update', data: formData);
    print(response.data);
    return account_update.fromJson(response.data);
  }

  Future<dynamic> getCategories(String token) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('categories');

    return GetCategories.fromJson(response.data);
  }

  Future<dynamic> setUploadVideo(
      Function(int sent, int total) function,
      String file,
      String title,
      String location,
      int sport_id,
      String token) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    String fileName = file.split('/').last;

    FormData data = FormData.fromMap({
      'title': title,
      'location': location,
      'sport_id': sport_id,
      'video': await MultipartFile.fromFile(file, filename: fileName)
    });
    Response response = await dio.post('upload_video',
        data: data,
        onSendProgress: (int sent, int total) => function(sent, total));
    print(response.data);
    return UploadVideo.fromJson(response.data);
  }

  Future<dynamic> PostToCart(
      {required int product_id,
      required int quantity,
      required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.post('add_to_cart',
        data: {'product_id': product_id, 'quantity': quantity});
    return ApiData.fromJson(response.data);
  }

  Future<dynamic> GetFromCart({required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('cart');
    print(response.data);
    return GetCart.fromJson(response.data);
  }

  Future<dynamic> RemoveFromCart(
      {required int product_id,
      required int quantity,
      required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.post('add_to_cart',
        data: {'product_id': product_id, 'quantity': quantity});
    return ApiData.fromJson(response.data);
  }

  Future<dynamic> PostMakeOrder(
      {required String location, required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response =
        await dio.post('make_order', data: {'location': location});
    return MakeOrder.fromJson(response.data);
  }

  Future<dynamic> GetCount({required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('cart_count');
    return ApiData.fromJson(response.data);
  }

  Future<dynamic> PostAddComment(
      {required String token,
      required int video_id,
      required String comment}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.post('add_comment', data: {
      'video_id': video_id,
      'comment': comment,
    });
    return response.statusCode;
  }

  Future<dynamic> GetProfile({required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('profile');
    return ProfileModel.fromJson(response.data);
  }

  Future<dynamic> GetProfileOfUser(
      {required int user_id, required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response =
        await dio.get('profile', queryParameters: {'user_id': user_id});
    print(response.data);
    return ProfileOfUserModel.fromJson(response.data);
  }

  Future<dynamic> GetFollowed({required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('followed');
    print(response.data);
    return FollowedModel.fromJson(response.data);
  }

  Future<dynamic> GetFollowers({required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('followers');
    return FollowersModel.fromJson(response.data);
  }

  Future<dynamic> GetAllComments(
      {required String token, required Map<String, dynamic> map}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('comments', queryParameters: map);
    print(response.data);

    return CommentsModel.fromJson(response.data);
  }

  Future<dynamic> AddLike(
      {required String token, required Map<String, dynamic> map}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.post('add_like', queryParameters: map);
    return LikeModel.fromJson(response.data);
  }

  Future<dynamic> AddFollow({required String token, required int uid}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.post('make_follow', data: {'user_id': uid});
    // print(response.data);
    return ApiData.fromJson(response.data);
  }

  Future<dynamic> GetBestUser({required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('best_users');
    return BestUser.fromJson(response.data);
  }

  Future<dynamic> GetAllocationUser({required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('users_near');
    print(response.data);
    return LocationUserModel.fromJson(response.data);
  }

  Future<dynamic> StartAndEndLive(
      {required String token, required Map<String, dynamic> map}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('agora_token', queryParameters: map);
    return LiveModel.fromJson(response.data);
  }

  Future<dynamic> GetLiveUserNow({required String token}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.get('users_live');
    return LiveUserNowModel.fromJson(response.data);
  }

  Future<dynamic> GetSettings() async {
    Response response = await dio.get('settings');
    print(response.data);
    return SettingsModel.fromJson(response.data);
  }

  Future<dynamic> DeleteUserFromRom(
      {required String token,
      required String room_id,
      required String user_id}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.post('delete_room_user',
        data: {'room_id': room_id, 'user_id': user_id});
    print(response.data);
    return response.data;
  }

  Future<dynamic> DeleteRoom(
      {required String token, required String room_id}) async {
    dio.options.headers['Authorization'] = ' Bearer $token';
    Response response = await dio.post('delete_room', data: {
      'room_id': room_id,
    });
    print(response.data);
    return ApiData.fromJson(response.data);
  }
}
