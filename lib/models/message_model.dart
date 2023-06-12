class MessageModel {
  final String userId;
  final String sendby;
  final String message;
  final String type;
  final DateTime dateTime;
  int sent;

  MessageModel( {
    required this.sendby,
    required this.message,
    required this.type,
    required this.dateTime,
    required  this.userId,
    this.sent = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'sendby'   : sendby,
      'message'  : message,
      'type'     : type,
      'dateTime' : dateTime.toIso8601String(),
      'sent'     : sent,
      'userId'    : userId,
    };
  }

 static MessageModel fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId :  json['userId'] ,
      sendby  : json['sendby'] ,
      type    : json['type'], 
      dateTime: DateTime.parse(json['dateTime']),  
      message : json['message'], 
      sent    : json['sent'] ?? 0,
    );
  }

}
