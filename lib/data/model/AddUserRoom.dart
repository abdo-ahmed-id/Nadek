class AddUserRoom {
  bool? status;
  dynamic? errNum;
  dynamic? msg;

  AddUserRoom({this.status, this.errNum, this.msg});

  AddUserRoom.fromJson(Map<String, dynamic> json) {
    status = json['status']as bool;
    errNum = json['errNum']as String;
    msg = json['msg']as String;
  }

}