class AllUser {
  bool? status;
  dynamic errNum;
  dynamic msg;
  List<Data>? data;

  AllUser({this.status, this.errNum, this.msg, this.data});

  factory AllUser.fromJson(Map<String, dynamic> json) {
    final d =json['data'] as List<dynamic>;
    return AllUser(
        status : json['status'],
        errNum : json['errNum'],
        msg : json['msg'],
      data: d.map((e) =>Data.fromJson(e)).toList()
    );
  }


}

class Data {
  int? id;
  dynamic name;
  dynamic fcmToken;
  dynamic phone;
  dynamic berthDay;
  dynamic gender;
  dynamic facebook;
  dynamic twitter;
  dynamic instagram;
  dynamic youtube;
  dynamic snapchat;
  dynamic telegram;
  dynamic whatsapp;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic photo;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fcmToken = json['fcm_token'];
    phone = json['phone'];
    berthDay = json['berth_day'];
    gender = json['gender'];
    facebook = json['facebook']??'';
    twitter = json['twitter']??'';
    instagram = json['instagram']??'';
    youtube = json['youtube']??'';
    snapchat = json['snapchat']??'';
    telegram = json['telegram']??'';
    whatsapp = json['whatsapp']??'';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
  }


}