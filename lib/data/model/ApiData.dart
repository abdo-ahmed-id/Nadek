class ApiData{
  bool? status;
  String? errNum;
  String? msg;
  int?   count;

  ApiData({this.status, this.errNum, this.msg,this.count});

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
        status :json['status'],
        errNum : json['errNum'],
        msg : json['msg'],
        count: json['data']??0
    );
  }
}