class StoreTableModel
{
  String? text1;
  String? text2;
  String? text3;
  String? text4;
  String? text5;
  String? text6;
  String? text7;
  String? text8;
  String? text9;
  String? text10;
  String? text11;
  String? text12;

  StoreTableModel({
    this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.text5,
    this.text6,
    this.text7,
    this.text8,
    this.text9,
    this.text10,
    this.text11,
    this.text12,
  });

  StoreTableModel.fromJson(Map<String,dynamic>json)
  {
    text1 = json['text1'];
    text2 = json['text2'];
    text3 = json['text3'];
    text4 = json['text4'];
    text5 = json['text5'];
    text6 = json['text6'];
    text7 = json['text7'];
    text8 = json['text8'];
    text9 = json['text9'];
    text10 = json['text10'];
    text11 = json['text11'];
    text12 = json['text12'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'text1':text1,
      'text2':text2,
      'text3':text3,
      'text4':text4,
      'text5':text5,
      'text6':text6,
      'text7':text7,
      'text8':text8,
      'text9':text9,
      'text10':text10,
      'text11':text11,
      'text12':text12,
    };

  }

}