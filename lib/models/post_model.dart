
class PostModel 
{
  final String? userId;
  final String? useremail;
  final String? type;
  final String? photoUrl;
  PostModel({
   required this.userId,
   required this.useremail,
    this.photoUrl,
   required this.type,
    });

  Map<String, dynamic> toJson() {
    return {
      'userId'     : userId,
      'useremail'  : useremail,
      'type'       : type, 
      'photoUrl'   : photoUrl,
     };
  }

 static PostModel fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId      : json['userId'] ,
      useremail   : json['useremail'],
      type        : json['type'],
      photoUrl    : json['photoUrl'], 
    );
  }
}