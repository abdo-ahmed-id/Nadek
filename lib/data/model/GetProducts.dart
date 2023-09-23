class GetProducts {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  GetProducts({this.status, this.errNum, this.msg, this.data});

  factory GetProducts.fromJson(Map<String, dynamic> json) {
    final d =json['data'] as List;
    return GetProducts(
        status : json['status'],
        errNum : json['errNum'],
        msg    : json['msg'],
        data: d.map((e) =>Data.fromJson(e)).toList()
    );

  }

}

class Data {
  int? id;
  String? mainImage;
  String? title;
  String? description;
  String? price;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  String? imagePath;

  Data(
      {this.id,
        this.mainImage,
        this.title,
        this.description,
        this.price,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.imagePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainImage = json['main_image'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = json['image_path'];
  }

}