class UserModel{
  String? email;
  String? fName;
  String? lName;
  String? uId;

  UserModel({this.uId, this.lName, this.fName, this.email});

  UserModel.fromJson(Map<String,dynamic> json){
    email = json['email'];
    fName = json['fName'];
    lName = json['lName'];
    uId = json['uId'];
  }

  Map<String,dynamic> toMap(){
    return{
      'email' : email,
      'fName' : fName,
      'lName' : lName,
      'uId' : uId,
    };
  }
}