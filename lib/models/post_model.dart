
class PostModel 
{
  final String? userId;
  final String? useremail;
  final String? type;
  final String? photoUrl;
  final String? postId;
  PostModel({
   required this.userId,
   required this.useremail,
   required this.photoUrl,
   required this.type,
   required this.postId
    });

  Map<String, dynamic> toJson() {
    return {
      'userId'     : userId,
      'useremail'  : useremail,
      'type'       : type, 
      'photoUrl'   : photoUrl,
      'postId'     : postId
     };
  }

 static PostModel fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId      : json['userId'] ,
      useremail   : json['useremail'],
      type        : json['type'],
      photoUrl    : json['photoUrl'], 
      postId      : json['postId']   
    );
  }
}