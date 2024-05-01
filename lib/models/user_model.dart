class SignUpModel
{
  String? name;
  String? email;
  String? pass;
  String? phone;
  String? uId;

  SignUpModel({
    this.name,
    this.email,
    this.pass,
    this.phone,
    this.uId,
});
  SignUpModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    email = json['email'];
    pass = json['pass'];
    phone = json['confPass'];
    uId = json['uId'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'pass':pass,
      'confPass':phone,
      'uId':uId,
    };
  }
}