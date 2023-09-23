class register_model {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  register_model({this.status, this.errNum, this.msg, this.data});

  register_model.fromJson(Map<String, dynamic> json) {
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
  int? iD;
  String? name;
  String? berthDay;
  String? gender;
  String? phoneNumber;
  String? firebaseToken;
  String? facebook;
  String? twitter;
  String? instagram;
  String? youtube;
  String? snapchat;
  String? telegram;
  String? whatsapp;
  String? apiKey;

  Data(
      {this.iD,
        this.name,
        this.berthDay,
        this.gender,
        this.phoneNumber,
        this.firebaseToken,
        this.facebook,
        this.twitter,
        this.instagram,
        this.youtube,
        this.snapchat,
        this.telegram,
        this.whatsapp,
        this.apiKey});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    berthDay = json['BerthDay'];
    gender = json['Gender'];
    phoneNumber = json['PhoneNumber'];
    firebaseToken = json['FirebaseToken'];
    facebook = json['Facebook'];
    twitter = json['Twitter'];
    instagram = json['Instagram'];
    youtube = json['Youtube'];
    snapchat = json['Snapchat'];
    telegram = json['Telegram'];
    whatsapp = json['Whatsapp'];
    apiKey = json['ApiKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['BerthDay'] = this.berthDay;
    data['Gender'] = this.gender;
    data['PhoneNumber'] = this.phoneNumber;
    data['FirebaseToken'] = this.firebaseToken;
    data['Facebook'] = this.facebook;
    data['Twitter'] = this.twitter;
    data['Instagram'] = this.instagram;
    data['Youtube'] = this.youtube;
    data['Snapchat'] = this.snapchat;
    data['Telegram'] = this.telegram;
    data['Whatsapp'] = this.whatsapp;
    data['ApiKey'] = this.apiKey;
    return data;
  }
}