class GetCart {
  bool? status;
  dynamic errNum;
  dynamic msg;
  Data? data;

  GetCart({this.status, this.errNum, this.msg, this.data});

  GetCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }


}

class Data {
  List<CartItems>? cartItems;
  dynamic cart_total;
  Data({this.cartItems,this.cart_total});

  factory Data.fromJson(Map<String, dynamic> json) {
    final d =json['cart_items'] as List;
    return Data(
      cart_total: json['cart_total'],
      cartItems: d.map((e) => CartItems.fromJson(e)).toList()
    );
  }

}

class CartItems {
  int? id;
  dynamic cartId;
  dynamic productId;
  dynamic quantity;
  dynamic createdAt;
  dynamic updatedAt;
  Product? product;

  CartItems(
      {this.id,
        this.cartId,
        this.productId,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.product});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }


}

class Product {
  int? id;
  dynamic mainImage;
  dynamic title;
  dynamic description;
  dynamic price;
  dynamic categoryId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic imagePath;

  Product(
      {this.id,
        this.mainImage,
        this.title,
        this.description,
        this.price,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.imagePath});

  Product.fromJson(Map<String, dynamic> json) {
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