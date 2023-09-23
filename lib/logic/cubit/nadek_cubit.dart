
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nadek/data/repository/repository.dart';
import 'package:nadek/logic/cubit/nadek_state.dart';



class NadekCubit extends Cubit<NadekState> {
  final repository rpo;


  NadekCubit(this.rpo) : super(NadekInitial());

  static NadekCubit get(context)=>BlocProvider.of(context);

  void login_user({required String phone,required String password}){
    rpo.login_user(phone: phone, password: password).then((value){

      emit(LoginLoadedDataState(model:value));

    });

  }
  void getSports(){
    rpo.getSports().then((value){
      emit(LoadedDataSports(value));
    });
   // return data;
  }

  void Register({
    required String name,
    required String date,
    required String sex,
    required String phone,
    required String password,
    required String fcm_token,
    required List list}){
    rpo.Register(name: name, date: date, sex: sex, phone: phone, password: password,list:list,fcm_token:fcm_token)
        .then((value){
          emit(LoadedResgister(value));
          print(value);
    }).onError((error, stackTrace) {
      print('${error.toString()}');
    });
  }

  void CreateGroup(String token,String name,String file){
    rpo.Create_group(token,name, file).then((value){
      emit(LoadedCreateGroup(value));
    });
  }
  void getAllRooms(String token){
    rpo.getAllRooms(token).then((value) {
      emit(LoadedAllRooms(value));
    });
  }
  void getPrivateVideo(String token){
    rpo.getPrivateVideo(token).then((value){
      emit(LoadedPrivateVideo(value));

    });
  }
  void getPublicVideo(String token){
    rpo.getPublicVideo(token).then((value){
      emit(LoadedPublicVideo(value));
    });
  }
  void getAllUser({required int room_id, required String token}){
    try{
      rpo.getAllUser(room_id: room_id,token: token).then((value) {
        emit(LoadedAllUser(value));
        print(value.msg);
      }).catchError((onError){
        emit(LoadedAllUserError());
      });
    }catch(e){

    }

  }
  void addRoomUser(int roomId,int user_id,String token){
    rpo.add_room_users(roomId, user_id, token).then((value){
      emit(LoadedAddUserRoom(value));
    });
    
    
  }
  void UpadtePhoto({required String file,required String token}){
    rpo.UpdatePhoto(file:file, token:token).then((value){
      emit(UpdatePhoto(value));
    }).onError((error, stackTrace){
      emit(UpdatePhotoError());
    });
  }
  void setAccount(
      String name,
      String berthDay,
      String gender,
      String phone,
      String password,
      String instagram,
      String youtube,
      String token
      ){
    rpo.setaccount_update(name, berthDay, gender, phone, password, instagram, youtube, token).then((value){
      emit(LoadedUpdateAccount(value));
    }).catchError((onError){
      print('fffffffffffffv ${onError.toString()}');
      emit(LoadedUpdateAccountError());
    });
    
  }

  void getCategories(String token){
    rpo.getCategories(token).then((value) {
      emit(LoadedCategories(value));
    }).catchError((onError){
      emit(LoadedCategoriesError());
    });
  }

  
  void setUploadVideo(
      {required Function(int sent, int total) function,
        required String file,
        required String title,
        required String location,
        required int sport_id,
        required String token}){
    rpo.setUploadVideo(function,file, title, location, sport_id, token).then((value){
      emit(SetUploadedVideo(value));
    });
  }

  void PostToCart({required int product_id,required int quantity,required String token}){
    
    rpo.PostToCart(product_id: product_id, quantity: quantity, token: token).then((value){
      emit(LoadedPostToCart(value));
    }).catchError((onError){
      emit(LoadedPostToCartError());
    });
  }
  void GetFromCart({required String token})async{
    rpo.GetFromCart(token: token).then((value){
      emit(LoadedCart(value));
      return value;
    });
  }

  void RemoveFromCart({required int product_id,required int quantity,required String token}){

    rpo.RemvoeCart(product_id: product_id, quantity: quantity, token: token).then((value){
      emit(RemoveCart(value));
    });
  }

  void PostMakeOrder({required String location,required String token})async{
    rpo.PostMakeOrder(location: location, token: token).then((value) {
      emit(LoadedPostMakeOrder(value));
    });
  }
  void GetCount({required String token})async{
    rpo.GetCount(token: token).then((value){
      emit(LoadedCountBadget(value));
    }).catchError((onError){
      print(onError.toString());
      emit(LoadedCountBadgetError());
    });
  }

  Future<int> PostAddComment({required String token,required int video_id,required String comment})async{
    await rpo.PostAddComment(token: token, video_id: video_id, comment: comment).then((value) {
      emit(LoadedAddComment());
    }).onError((error, stackTrace) {

    });
    return 1 ;
  }
  void GetProfile({required String token}){
    rpo.GetProfile(token: token).then((value){
      emit(LoadedProfile(value));
    }).onError((error, stackTrace){
      //emit(LoadedProfileError());
    });
  }
  void GetProfileOfUser({required int user_id,required String token}){
    rpo.GetProfileOfUser(user_id: user_id, token: token).then((value){
      emit(LoadedProfileOfUser(value));
    }).onError((error, stackTrace){
      print(error.toString());
      emit(LoadedProfileOfUseError());
    });
  }
  void GetFollowed({required String token}){
    rpo.GetFollowed(token: token).then((value){
      emit(LoadedFollowed(value));
    }).onError((error, stackTrace){
      print(error.toString());
      emit(LoadedFollowedError());
    });
  }
  void GetFollowers({required String token}){
    rpo.GetFollowers(token: token).then((value){
      emit(LoadedFollowers(value));
    }).onError((error, stackTrace){
      emit(LoadedFollowersError());
    });
  }

  void GetAllComments({required String token,required Map<String,dynamic> map}){
    rpo.GetAllComments(token: token, map: map).then((value) {
      emit(LoadedGetAllComments(value));
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(LoaLoadedGetAllCommentsError());
    });
  }
  void AddLike({required String token,required Map<String,dynamic> map}){
    rpo.AddLike(token: token, map: map).then((value){
      emit(LoadedAddLike(value));
    }).onError((error, stackTrace) {
      emit(LoadedAddLikeError());
    });
  }

  void  AddFollow({required String token,required int uid}){
    rpo.AddFollow(token: token, uid: uid).then((value){
      emit(LoadedAddFollow(value));
    }).catchError((onError){
      emit(LoadedAddFollowtError());

    });
  }

  void GetBestUser({required String token}){
    rpo.GetBestUser(token: token).then((value){
      emit(LoadedBestUser(value));
    }).onError((error, stackTrace){
      print(error.toString());
      emit(LoadedBestUserError());
    });
  }
  void GetAllocationUser({required String token}){
   rpo.GetAllocationUser(token: token).then((value){
     emit(LoadedGetAllocatonUser(value));
   }).onError((error, stackTrace){
     emit(LoadedGetAllocatonUserError());
   });
  }


  void PlayStartAndEndLive({required String token,required Map<String,dynamic> map}){
    rpo.StartAndEndLive(token: token, map: map).then((value) {
      emit(LoadedStartAndEndLive(value));

    }).onError((error, stackTrace){
      emit(LoadedStartAndEndLiveError());
    });
  }

  void GetLiveUserNow({required String token}){
    rpo.GetLiveUserNow(token: token).then((value) {
      emit(LoadedLiveUserNow(value));
    }).onError((error, stackTrace){
      print(error.toString());
      emit(LoadedLiveUserNowError());
    });
  }
  void UpdateLocationUser({
    required double lit,
    required double long,
    required String token}){
    rpo.UpdateLocation(lit: lit, long: long, token: token).then((value){
      emit(UpdateLocation(value));
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(UpdateLocationError());
    });
  }

  void GetSettings(){
    rpo.GetSettings().then((value){
      emit(LoadedSettings(value));
    }).onError((error, stackTrace) {
      emit(LoadedSettingsError());
    });
  }
  void DeleteUserFromRom({required String token,required String room_id,required String user_id}){
    rpo.DeleteUserFromRom(token: token, room_id: room_id, user_id: user_id).then((value) {
      emit(LoadedDeleteUserFromRoom());
    }).onError((error, stackTrace) {
      emit(LoadedDeleteUserFromRoomError());
    });
  }
  void DeleteRoom({required String token,required String room_id}){
    rpo.DeleteRoom(token: token, room_id: room_id).then((value) {
      emit(LoadedDeleteRoom(value));
    }).onError((error, stackTrace){
      emit(LoadedDeleteRoomError());
    });
  }
  /////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////

  void ChangeProfileUser(){
    emit(ChangeProfile());
  }
  void ChangeCountBadget(){

    emit(NewChangeCountBadget());
  }
  void ChangeItemListChat(){
    emit(ChangeItemChat());
  }
  void ChangePageView(){
    emit(ChangePage());
  }


}
