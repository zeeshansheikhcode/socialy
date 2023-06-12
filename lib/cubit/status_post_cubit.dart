import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_model.dart';
import '../models/story_model.dart';

part 'status_post_state.dart';

class StatusPostCubit extends Cubit<StatusPostState> {
  StatusPostCubit() : super(StatusPostInitial());
  
  final List<StoryModel> _stories = [];
  List<StoryModel>   get stories => _stories; 
  final List<PostModel> _posts = [];
  List<PostModel>   get posts => _posts; 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> allEmails =[];
  final List<List<StoryModel>> allStories = [];
  List<String> uniqueEmail =[];
  File? _imageFile;
  bool isLoading = false;

  final picker = ImagePicker();

  Future<void> pickImage({required isStatus}) async {
    emit(StatusPostLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
       try {
        final filePath = pickedFile.path;
        final lastIndex = filePath.lastIndexOf( RegExp(r'.jpg'));
        final splitted = filePath.substring(0, (lastIndex));
        final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
        var result1 = await FlutterImageCompress.compressAndGetFile(
        pickedFile.path, outPath,
         quality: 10,
       );
 
  //return result;
      // var result = await FlutterImageCompress.compressAndGetFile(
      //   pickedFile.path,
      //   pickedFile.path,
      //   quality: 5,
      // );
      _imageFile = File(result1!.path);
      isLoading = true;
      _uploadImage(isStatus);
    } catch (e) {
      // Handle the compression error
      print('Image compression error: ${e.toString()}');
      // Show an error message or perform other actions as needed
    }
    }
  }

  Future<void> _uploadImage(bool isStatus) async {
    if (_imageFile == null) return;
    try {
      if(isStatus)
      {
      final imageName = DateTime.now().microsecondsSinceEpoch.toString();
      final storageReference = FirebaseStorage.instance.ref().child('userstories/$imageName');
      await storageReference.putFile(_imageFile!);
      final downloadUrl = await storageReference.getDownloadURL();
      await _firestore.collection('stories')
          .doc()
          .set(
            {
              "userId"     : _auth.currentUser!.uid,
              "useremail"  : _auth.currentUser!.email,
              "type"       :  "photo",
              "statusText" :  "No Text",
              "photoUrl"   :  downloadUrl,
            }
          );
     isLoading = false;
     getStoriesPosts();
      }
    else 
    {
      final imageName = DateTime.now().microsecondsSinceEpoch.toString();
      final storageReference = FirebaseStorage.instance.ref().child('userspost/$imageName');
      await storageReference.putFile(_imageFile!);
      final downloadUrl = await storageReference.getDownloadURL();
      await _firestore.collection('posts')
          .doc()
          .set(
            {
              "userId"     : _auth.currentUser!.uid,
              "useremail"  : _auth.currentUser!.email,
              "type"       :  "photo",
              "photoUrl"   :  downloadUrl,
            }
          );
     isLoading = false;
     getStoriesPosts();
     }
    } catch (e) {
      emit(StatusPostErrorState(e.toString()));
    }
  }
 //Upload Status
  void uploadStatus(String statusText) async 
  {
     emit(StatusPostLoadingState());
    try 
    {
      await _firestore.collection('stories')
          .doc()
          .set(
            {
              "userId"     : _auth.currentUser!.uid,
              "useremail"  : _auth.currentUser!.email,
              "type"       :  "text",
              "statusText" :  statusText,
              "photoUrl"   :  "No Url",
            }
          );
     getStoriesPosts();
     
    }
    catch(e)
    {
      emit(StatusPostErrorState(e.toString()));
    }
  }
  

  // Getting Stories
  void getStoriesPosts() async
  {
    emit(StatusPostLoadingState());
     allStories.clear();
     allEmails.clear();
     uniqueEmail.clear();
     stories.clear();
    final  CollectionReference activeStories =  _firestore.collection('stories');
    QuerySnapshot querySnapshot = await activeStories.get();
    for (DocumentSnapshot doc in querySnapshot.docs) {
     _stories.add(
        StoryModel(
        userId: doc['userId'],
        useremail: doc['useremail'],
        type: doc['type'],
        statusText: doc['statusText'] ?? 'No Status title',
        photoUrl: doc['photoUrl'] ?? 'No Photo Url',
        ),
      );
      allEmails.add(doc['useremail']);
    }
    uniqueEmail = allEmails.toSet().toList();
   for(int i=0; i <uniqueEmail.length; i++)
    {   final List<StoryModel> userStories = [];
        for(int j=0 ;j < stories.length; j++)
       {
         if(uniqueEmail[i] == stories[j].useremail.toString())
         { 
            userStories.add(stories[j]);
            print('$userStories');
         }
       } 
       allStories.add(userStories);
     }
    final  CollectionReference activePosts =  _firestore.collection('posts');
    QuerySnapshot querySnapshotPost = await activePosts.get();
    for (DocumentSnapshot doc in querySnapshotPost.docs) {
     _posts.add(
        PostModel(
        userId: doc['userId'],
        useremail: doc['useremail'],
        type: doc['type'],
        photoUrl: doc['photoUrl'] ?? 'No Photo Url',
        ),
      );
    }
      emit(StatusPostLoadedState(allStories:allStories,allPost: _posts)); 
    }

  //  //Getting Posts
  //  void getPosts() async
  // {
    
  //   try
  //   { emit(StatusPostLoadingState());
  //   //   final  CollectionReference activeStories =  _firestore.collection('posts');
  //   // QuerySnapshot querySnapshot = await activeStories.get();
  //   // for (DocumentSnapshot doc in querySnapshot.docs) {
  //   //  _posts.add(
  //   //     PostModel(
  //   //     userId: doc['userId'],
  //   //     useremail: doc['useremail'],
  //   //     type: doc['type'],
  //   //     photoUrl: doc['photoUrl'] ?? 'No Photo Url',
  //   //     ),
  //   //   );
  //   // }
  //   print(_posts);
  //      emit(StatusPostLoadedState(allPost: _posts,allStories: allStories)); 
  //   }
  //   catch(e) 
  //   {
  //     emit(StatusPostErrorState(e.toString()));
  //   }
    
  //  }  
}

  


