class PostModel{
  String? text;
  String? image;
  String? uId;

  PostModel({this.text,this.image,this.uId});

  PostModel.fromJson(Map<String,dynamic> json){
    text = json['text'];
    image = json['image'];
    uId = json['uId'];
  }

  Map<String,dynamic> toMap(){
    return{
      'text' : text,
      'image' : image,
      'uId' : uId,
    };
  }
}