class UploadVideo {
  bool? status;
  String? errNum;
  String? msg;

  UploadVideo({this.status, this.errNum, this.msg});

  UploadVideo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
  }


}