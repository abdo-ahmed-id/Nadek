class LiveModel {
  String? msg;
  String? token;
  String? channelName;

  LiveModel({this.msg, this.token, this.channelName});

  LiveModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    token = json['token'];
    channelName = json['channelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['token'] = this.token;
    data['channelName'] = this.channelName;
    return data;
  }
}