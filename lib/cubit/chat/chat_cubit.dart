import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../views/calls/audio_call.dart';
import '../../views/calls/video_call.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  String? callId = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? imagefile;
  String? realchatRoomId ;
 

 

   Stream<QuerySnapshot> gettingStreams() async* {
   await for (QuerySnapshot snapshot in FirebaseFirestore.instance
      .collection('chatroom')
      .doc(realchatRoomId)
      .collection('chats')
      .orderBy("time", descending: false)
      .snapshots()) 
      {
        yield snapshot; 
      }
     }
 
 
 
  Future getImage() async
  {
       
        ImagePicker picker = ImagePicker();

         await picker.pickImage(source: ImageSource.gallery).then((xfile) 
       {
         if(xfile!=null)
        {
          imagefile =File(xfile.path);
          uploadimage();
         }
        }); 

    
  }
    
  void audioCallfunction(context)
  {
     
     Navigator.push(context,
     MaterialPageRoute(builder: (context) => AudioCallingPage(callingId: callId!))) ;
           
  }

   void videoCallfunction(context)
  {
    
     Navigator.push(context,
     MaterialPageRoute(builder: (context) => CallPage(callID: callId!))) ;
           
  }

  String generateChatRoomId(String user2email) {
  final currentuser1 =  FirebaseAuth.instance.currentUser!.email;
  final user1email   =  currentuser1;
  String username1 = user1email!.replaceAll('@gmail.com', '');
  String username2 = user2email.replaceAll('@gmail.com', '');
  List<String> usernames = [username1, username2]..sort();
  String combined = usernames.join('');
  List<int> bytes = utf8.encode(combined);
  Digest digest = sha256.convert(bytes);
  String hash = digest.toString();
  String chatRoomId = hash.substring(0, 12);
  String prefix = 'c';
  chatRoomId = prefix + chatRoomId.substring(1);
  realchatRoomId = chatRoomId;
  callId = chatRoomId;
  }
   
  Future uploadimage() async
  {
    String filename = const Uuid().v1();
    int status = 1;
    await _firestore
          .collection('chatroom')
          .doc(realchatRoomId)
          .collection('chats').doc(filename).set({
        "sendby": _auth.currentUser!.email,
        "message": "",
        "type" : "img",
        "time": FieldValue.serverTimestamp(),

          });

    var ref = FirebaseStorage.instance.ref().child('images').child("$filename.jpg");
    var uploadTask =  await ref.putFile(imagefile!).catchError((error) async
    { 
        await _firestore
          .collection('chatroom')
          .doc(realchatRoomId)
          .collection('chats')
          .doc(filename)
          .delete();
          status = 0;
    });
     if(status==1)
     {
       String imageUrl =  await uploadTask.ref.getDownloadURL();
        await _firestore
          .collection('chatroom')
          .doc(realchatRoomId)
          .collection('chats')
          .doc(filename).update({
            "message" : imageUrl
          });
     }
  
  }

  void onSendMessage(String message) async {

        Map<String, dynamic> usermessages = {
        "userId" : _auth.currentUser!.uid,
        "sendby": _auth.currentUser!.email,
        "message": message,
        "type" : "text",
        "time": DateTime.now(),
        "sent" : 1
        };
           
          await _firestore
          .collection('chatroom')
          .doc(realchatRoomId)
          .collection('chats')
          .add(usermessages);
     
    }

}
