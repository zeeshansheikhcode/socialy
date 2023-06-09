import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Column(
          children: [
            AppBar(
              backgroundColor: Colors.purple,
              title: const Text('Chat'),
              centerTitle: true,
              actions: 
              [
                IconButton(
                  onPressed: ()
                  {
                    audioCallfunction(context);
                  },
                  icon:const Icon(Icons.call)
                  ),
                IconButton(
                  onPressed: (){
                    videoCallfunction(context);
                  },
                  icon:const Icon(Icons.video_call)
                  )
              ],
              automaticallyImplyLeading: false,
            ),
            Expanded(child: Container(
              decoration:const BoxDecoration(
                color: Colors.white
              ),
              child:   
              StreamBuilder<QuerySnapshot>(
              stream:  gettingStreams(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot,) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child:  CircularProgressIndicator());
              }
             else if (snapshot.connectionState == ConnectionState.active  || snapshot.connectionState == ConnectionState.done) 
             {
                if (snapshot.hasError) 
                {
                  return const Text('Error');
                } 
                else if (snapshot.hasData) 
                {
                  return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index)
                  {
                    Map<String, dynamic>? map = snapshot.data!.docs[index].data() as Map<String, dynamic>?;
                    return MessageBox(map: map!);
                  });
                } 
                else {
                  return const Text('Empty data');
                }
              } 
              else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
             ),
           ),  
        ),
            Container(
              height: 70.h,
              color: Colors.white,
              child:Row(
                children:  [
                   Expanded(
                     child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: chatProvider.messageController,
                      decoration:const InputDecoration(
                        hintText: 'Type your message here',
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                     ),
                   ),
                   IconButton
                  (
                  onPressed: ()
                  {
                     chatProvider.getImage();
                  },
                  icon:const Icon(Icons.photo)),
                  IconButton
                  (
                  onPressed: ()
                  {
                     chatProvider.onSendMessage();
                  },
                  icon:const Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}