class StoreFavoriteModel
{
  String? name;
  String? image;
  String? price;
  String? oldPrice;
  String? discount;

  StoreFavoriteModel({
    this.name,
    this.image,
    this.price,
    this.oldPrice,
    this.discount,
  });

  StoreFavoriteModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    image = json['image'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'image':image,
      'price':price,
      'oldPrice':oldPrice,
      'discount':discount,
    };

  }

}