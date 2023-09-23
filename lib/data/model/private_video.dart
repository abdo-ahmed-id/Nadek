class private_video {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  private_video({this.status, this.errNum, this.msg, this.data});

  factory private_video.fromJson(Map<String, dynamic>? json) {
    final d =json!['data'] as List<dynamic>;
    return private_video(
        status : json['status'],
        errNum : json['errNum'],
        msg : json['msg'],
        data:d.map((e) =>Data.fromJson(e)).toList()
    );

  }

}

class Data {
  int? id;
  String? title;
  String? description;
  String? path;
  String? location;
  String? userId;
  String? sportId;
  String? status;
  String? createdAt;
  String? updatedAt;
  bool   user_like;
  String? likes_count;
  Owner? owner;
  List<Comments>? comments;

  Data(
      {this.id,
        this.title,
        this.description,
        this.path,
        this.location,
        this.userId,
        this.sportId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.comments,
        this.owner,
        required this.user_like,
        required this.likes_count});

  factory Data.fromJson(Map<String, dynamic> json) {
    final d =json['comments'] as List<dynamic>;
    return Data(
        id : json['id'],
        title : json['title'],
        description : json['description'],
        path : json['path'],
        location : json['location'],
        userId : json['user_id'],
        sportId : json['sport_id'],
        status : json['status'],
        createdAt : json['created_at'],
        updatedAt : json['updated_at'],
        likes_count: json['likes_count'],
        owner : json['owner'] != null ? new Owner.fromJson(json['owner']) : null,
        user_like: json['user_like'],
        comments: d.map((e) => Comments.fromJson(e)).toList()
    );

  }

}
class Owner {
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

  Owner(
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

  Owner.fromJson(Map<String, dynamic> json) {
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

class Comments {
  int? id;
  String? comment;
  String? userId;
  String? videoId;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comments(
      {this.id,
        this.comment,
        this.userId,
        this.videoId,
        this.createdAt,
        this.updatedAt,
        this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    userId = json['user_id'];
    videoId = json['video_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }


}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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