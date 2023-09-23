class ProfileModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  ProfileModel({this.status, this.errNum, this.msg, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<MyVideos>? myVideos;
  User? myData;

  Data({this.myVideos, this.myData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['my_videos'] != null) {
      myVideos = <MyVideos>[];
      json['my_videos'].forEach((v) {
        myVideos!.add(new MyVideos.fromJson(v));
      });
    }
    myData =
    json['my_data'] != null ? new User.fromJson(json['my_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myVideos != null) {
      data['my_videos'] = this.myVideos!.map((v) => v.toJson()).toList();
    }
    if (this.myData != null) {
      data['my_data'] = this.myData!.toJson();
    }
    return data;
  }
}

class MyVideos {
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
  List<Comments>? comments;

  MyVideos(
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
        this.comments});

  MyVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    path = json['path'];
    location = json['location'];
    userId = json['user_id'];
    sportId = json['sport_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['path'] = this.path;
    data['location'] = this.location;
    data['user_id'] = this.userId;
    data['sport_id'] = this.sportId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['video_id'] = this.videoId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fcm_token'] = this.fcmToken;
    data['phone'] = this.phone;
    data['berth_day'] = this.berthDay;
    data['gender'] = this.gender;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['snapchat'] = this.snapchat;
    data['telegram'] = this.telegram;
    data['whatsapp'] = this.whatsapp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo'] = this.photo;
    return data;
  }
}