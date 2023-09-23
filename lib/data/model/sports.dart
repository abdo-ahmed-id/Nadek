class sports {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  sports({this.status, this.errNum, this.msg, this.data});

  factory sports.fromJson(Map<String, dynamic> json) {
    final data =json['data'] as List<dynamic>;
    return sports(
        status : json['status'],
        errNum : json['errNum'],
        msg : json['msg'],
        data: data.map((e) => Data.fromJson(e)).toList()

    );
  }


}

class Data {
  int? id;
  String? title;
  String? photo;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.title, this.photo, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}