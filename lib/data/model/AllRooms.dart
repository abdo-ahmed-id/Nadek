class AllRooms {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  AllRooms({this.status, this.errNum, this.msg, this.data});

  factory AllRooms.fromJson(Map<String, dynamic> json) {
    final d =json['data'] as List<dynamic>;
    return AllRooms(
        status : json['status'],
        errNum : json['errNum'],
        msg : json['msg'],
        data:d.map((e) =>Data.fromJson(e)).toList()
    );
  }


}

class Data {
  int? id;
  dynamic name;
  dynamic status;
  dynamic photo;
  dynamic userId;
  dynamic createdAt;
  dynamic updatedAt;
  List<Users>? users;
  List<Admins>? admins;
  Users? owner;

  Data(
      {this.id,
        this.name,
        this.status,
        this.photo,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.users,
        this.admins,
        this.owner});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    photo = json['photo'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    if (json['admins'] != null) {
      admins = <Admins>[];
      json['admins'].forEach((v) {
        admins!.add(new Admins.fromJson(v));
      });
    }
    owner = json['owner'] != null ? new Users.fromJson(json['owner']) : null;
  }

}

class Users {
  int? id;
  String? name;
  String? fcmToken;
  String? phone;
  String? berthDay;
  String? gender;
  String? facebook;
  String? twitter;
  String? instagram;
  String? youtube;
  String? snapchat;
  String? telegram;
  String? whatsapp;
  String? createdAt;
  String? updatedAt;
  String? photo;

  Users(
      {this.id,
        this.name,
        this.fcmToken,
        this.phone,
        this.berthDay,
        this.gender,
        this.facebook,
        this.twitter,
        this.instagram,
        this.youtube,
        this.snapchat,
        this.telegram,
        this.whatsapp,
        this.createdAt,
        this.updatedAt,
        this.photo});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fcmToken = json['fcm_token'];
    phone = json['phone'];
    berthDay = json['berth_day'];
    gender = json['gender'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    snapchat = json['snapchat'];
    telegram = json['telegram'];
    whatsapp = json['whatsapp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
  }



}
class Admins {
  int? id;
  String? name;
  String? fcmToken;
  String? phone;
  String? berthDay;
  String? gender;
  String? facebook;
  String? twitter;
  String? instagram;
  String? youtube;
  String? snapchat;
  String? telegram;
  String? whatsapp;
  String? createdAt;
  String? updatedAt;
  String? photo;

  Admins(
      {this.id,
        this.name,
        this.fcmToken,
        this.phone,
        this.berthDay,
        this.gender,
        this.facebook,
        this.twitter,
        this.instagram,
        this.youtube,
        this.snapchat,
        this.telegram,
        this.whatsapp,
        this.createdAt,
        this.updatedAt,
        this.photo});

  Admins.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fcmToken = json['fcm_token'];
    phone = json['phone'];
    berthDay = json['berth_day'];
    gender = json['gender'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    snapchat = json['snapchat'];
    telegram = json['telegram'];
    whatsapp = json['whatsapp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
  }


}