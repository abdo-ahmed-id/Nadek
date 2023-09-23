

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


abstract class NadekState {}

class NadekInitial extends NadekState {}

class LoginLoadedDataState extends NadekState{
  final login_model model;
  LoginLoadedDataState({required this.model});
}
class ErrorLogin extends NadekState{}

class LoadedDataSports extends NadekState{
  final sports s;
  LoadedDataSports(this.s);


}
class LoadedDataSportsErroe extends NadekState{

}


class LoadedResgister extends NadekState{
  final register_model r;

  LoadedResgister(this.r);
}

class LoadedCreateGroup extends NadekState{
  final create_group_model group;

  LoadedCreateGroup(this.group);

}


class LoadedAllRooms extends NadekState{
  final AllRooms rooms;

  LoadedAllRooms(this.rooms);
}
class LoadedAllRoomsError extends NadekState{

}



class LoadedPrivateVideo extends NadekState{
  final private_video video;

  LoadedPrivateVideo(this.video);
}
class LoadedPrivateVideoError extends NadekState{

}

class LoadedPublicVideo extends NadekState{
  final public_video video;

  LoadedPublicVideo(this.video);
}
class LoadedPublicVideoError extends NadekState{

}

class LoadedAllUser extends NadekState{
  final AllUser user;

  LoadedAllUser(this.user);
}
class LoadedAllUserError extends NadekState{

}

class LoadedAddUserRoom extends NadekState{
  final AddUserRoom room;

  LoadedAddUserRoom(this.room);
}
class LoadedAddUserRoomError extends NadekState{

}

class LoadedUpdateAccount extends NadekState{
  final account_update account;

  LoadedUpdateAccount(this.account);

}
class LoadedUpdateAccountError extends NadekState{

}


class UpdateLocation extends NadekState{
  final account_update account;

  UpdateLocation(this.account);

}

class UpdateLocationError extends NadekState{

}

class UpdatePhoto extends NadekState{
  final account_update account;

  UpdatePhoto(this.account);

}

class UpdatePhotoError extends NadekState{

}


class LoadedCategories extends NadekState{
  final GetCategories categories;

  LoadedCategories(this.categories);


}
class LoadedCategoriesError extends NadekState{

}


class SetUploadedVideo extends NadekState{

  final UploadVideo uploadVideo;

  SetUploadedVideo(this.uploadVideo);


}
class SetUploadedVideoError extends NadekState{

}

class LoadedPostToCart extends NadekState{
  final ApiData data;

  LoadedPostToCart(this.data);
}
class LoadedPostToCartError extends NadekState{

}

class LoadedCart extends NadekState{
  final GetCart data;

  LoadedCart(this.data);
}
class LoadedCartError extends NadekState{

}
class RemoveCart extends NadekState{
  final ApiData data;

  RemoveCart(this.data);
}
class RemoveCartError extends NadekState{

}

class LoadedPostMakeOrder extends NadekState{
  final MakeOrder order;

  LoadedPostMakeOrder(this.order);

}
class LoadedPostMakeOrderError extends NadekState{

}


class LoadedCountBadget extends NadekState{
  final ApiData data;

  LoadedCountBadget(this.data);
}
class LoadedCountBadgetError extends NadekState{

}


class LoadedAddComment extends NadekState{

}
class LoadedAddCommentError extends NadekState{

}


class LoadedProfile extends NadekState{
  final ProfileModel profileModel;

  LoadedProfile(this.profileModel);
}
class LoadedProfileError extends NadekState{

}

class LoadedProfileOfUser extends NadekState{
  final ProfileOfUserModel model;

  LoadedProfileOfUser(this.model);


}
class LoadedProfileOfUseError extends NadekState{

}


class LoadedFollowed extends NadekState{
  final FollowedModel followedModel;

  LoadedFollowed(this.followedModel);
}
class LoadedFollowedError extends NadekState{

}


class LoadedFollowers extends NadekState{
  final FollowersModel followersModel;

  LoadedFollowers(this.followersModel);
}
class LoadedFollowersError extends NadekState{

}
class LoadedGetAllComments extends NadekState{
  final CommentsModel  commentsModel;

  LoadedGetAllComments(this.commentsModel);

}
class LoaLoadedGetAllCommentsError extends NadekState{

}

class LoadedAddLike extends NadekState{
  final LikeModel likeModel;

  LoadedAddLike(this.likeModel);
}
class LoadedAddLikeError extends NadekState{

}


class LoadedAddFollow extends NadekState{
  final ApiData data;

  LoadedAddFollow(this.data);
}
class LoadedAddFollowtError extends NadekState{

}
class LoadedBestUser extends NadekState{
  final BestUser data;

  LoadedBestUser(this.data);
}
class LoadedBestUserError extends NadekState{

}

class LoadedGetAllocatonUser extends NadekState{
  final LocationUserModel data;

  LoadedGetAllocatonUser(this.data);
}
class LoadedGetAllocatonUserError extends NadekState{

}
class LoadedStartAndEndLive extends NadekState{
  final LiveModel data;

  LoadedStartAndEndLive(this.data);
}
class LoadedStartAndEndLiveError extends NadekState{

}

class LoadedLiveUserNow extends NadekState{
  final LiveUserNowModel data;

  LoadedLiveUserNow(this.data);
}
class LoadedLiveUserNowError extends NadekState{

}

class LoadedSettings extends NadekState{
  final SettingsModel data;

  LoadedSettings(this.data);
}
class LoadedSettingsError extends NadekState{

}


class LoadedDeleteUserFromRoom extends NadekState{

}
class LoadedDeleteUserFromRoomError extends NadekState{

}

class LoadedDeleteRoom extends NadekState{
  final ApiData apiData;

  LoadedDeleteRoom(this.apiData);
}
class LoadedDeleteRoomError extends NadekState{

}

class ChangePage extends NadekState {}
class NewChangeCountBadget extends NadekState{}

////////////////////
class ChangeItemChat extends NadekState{
}

class ChangeProfile extends NadekState{
}



///////////////////////////
/////////////////////////
class AppCreateDatabase extends NadekState{}
class AppInsertDatabase extends NadekState{}

class AppDeleteDatabase extends NadekState{}