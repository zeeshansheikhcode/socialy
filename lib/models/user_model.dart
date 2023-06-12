class UserModel 
{
  final String? userId;
  final String? useremail;
  final String? name;
  final String? photoUrl;
  UserModel({
   required this.userId,
   required this.useremail,
   required this.name,
   required this.photoUrl,
    });

  Map<String, dynamic> toJson() {
    return {
      'userId'     : userId,
      'useremail'  : useremail,
      'name'       : name, 
      'photoUrl'   : photoUrl,
     };
  }

 static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId      : json['userId'] ,
      useremail   : json['useremail'],
      name        : json['name'],
      photoUrl    : json['photoUrl'], 
    );
  }
}