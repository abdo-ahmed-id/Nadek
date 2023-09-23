class GetCategories {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  GetCategories({this.status, this.errNum, this.msg, this.data});

 factory GetCategories.fromJson(Map<String, dynamic> json) {
   final f=json['data'] as List;
   return GetCategories(
       status : json['status'],
       errNum : json['errNum'],
       msg    : json['msg'],
       data: f.map((e) => Data.fromJson(e)).toList()
   );

  }

}

class Data {
  int? id;
  dynamic parentId;
  dynamic image;
  dynamic title;
  dynamic description;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic imagePath;
  List<Products>? products;

  Data(
      {this.id,
        this.parentId,
        this.image,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.imagePath,
        this.products});

  factory Data.fromJson(Map<String, dynamic> json) {
    final f=json['products'] as List;


    return Data(
        id : json['id'],
        parentId : json['parent_id'],
        image : json['image'],
        title : json['title'],
        description : json['description'],
        createdAt : json['created_at'],
        updatedAt : json['updated_at'],
        imagePath : json['image_path'],
        products  : f.map((e) =>Products.fromJson(e)).toList()
    );
  }

}
class Products {
  int? id;
  dynamic mainImage;
  dynamic title;
  dynamic description;
  dynamic price;
  dynamic categoryId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic imagePath;

  Products(
      {this.id,
        this.mainImage,
        this.title,
        this.description,
        this.price,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.imagePath});

  Products.fromJson(Map<String, dynamic> json) {
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