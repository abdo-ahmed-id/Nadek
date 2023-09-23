class CommentsModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  CommentsModel({this.status, this.errNum, this.msg, this.data});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? commentsCount;
  List<Comments>? comments;

  Data({this.commentsCount, this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    commentsCount = json['comments_count'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
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