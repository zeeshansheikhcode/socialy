
class StoryModel 
{
  final String? userId;
  final String? useremail;
  final String? statusText;
  final String? type;
  final String? photoUrl;
  StoryModel({
   required this.userId,
   required this.useremail,
    this.statusText,
    this.photoUrl,
   required this.type,
    });

  Map<String, dynamic> toJson() {
    return {
      'userId'     : userId,
      'useremail'  : useremail,
      'type'       : type, 
      'statusText' : statusText,
      'photoUrl'   : photoUrl,
     };
  }

 static StoryModel fromJson(Map<String, dynamic> json) {
    return StoryModel(
      userId      : json['userId'] ,
      useremail   : json['useremail'],
      type        : json['type'],
      statusText  : json['statusText'],
      photoUrl    : json['photoUrl'], 
    );
  }
}