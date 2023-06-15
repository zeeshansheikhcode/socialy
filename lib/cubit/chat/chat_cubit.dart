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

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  String? callId = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List _searchResult = [];
  List  get searchresult => _searchResult;
  File? imagefile;
  String? realchatRoomId ;
 
  Stream<QuerySnapshot> gettingStreams(String roomId) async* {
   await for (QuerySnapshot snapshot in FirebaseFirestore.instance
      .collection('chatroom')
      .doc(roomId)
      .collection('chats')
      .orderBy("time", descending: false)
      .snapshots()) 
      { 
        yield snapshot; 
   
      }
       
     }
 
 
 
  Future getImage() async
  {
       emit(ChatLoadingState());
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
    
  // void audioCallfunction(String id)
  // {
     
  //    Navigator.push(context,
  //    MaterialPageRoute(builder: (context) => AudioCallingPage(callingId: callId!))) ;
           
  // }

  //  void videoCallfunction(String id)
  // {
    
  //    Navigator.push(context,
  //    MaterialPageRoute(builder: (context) => CallPage(callID: callId!))) ;
           
  // }

  void generateChatRoomId(String user2email) async{
   emit(ChatLoadingState());
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
  emit(ChatLoadedState(chatRoomId: chatRoomId,searchResult: const []));
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
     emit(ChatLoadedState(isSent: true));
  
  }

  void onSendMessage(String message) async {
         emit(ChatLoadingState());
         try{
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
          emit(ChatLoadedState(isSent: true));
         }
         catch(e)
         {
          emit(ChatErrorState(e.toString()));
         }
    }
   

  void searchFromFirebase(String query) async {
       
       try 
       {  emit(ChatLoadingState());
        final result = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: query)
        .get();
       _searchResult = result.docs.map((doc) {
        final data = doc.data();
        return {
        'email': data['email'],
        'username': data['username'],
        'profilePic': data['profilePic'],
         'userId': data['userId'],
        };
        }).toList();
         emit(ChatLoadedState(searchResult: _searchResult));
       }
       catch(e)
       {
         emit(ChatErrorState(e.toString()));
       }
        
  }

}
