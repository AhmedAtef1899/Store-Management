class StoreModel
{
  String? name;
  String? image;
  String? price;
  String? oldPrice;
  String? discount;
  String? description;
  bool? isFav;

  StoreModel({
    this.name,
    this.image,
    this.price,
    this.oldPrice,
    this.discount,
    this.description,
    this.isFav,

  });

  StoreModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    image = json['image'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    description = json['description'];
    isFav = json['isFav'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'image':image,
      'price':price,
      'oldPrice':oldPrice,
      'discount':discount,
      'description':description,
      'isFav':isFav,
    };

  }

}