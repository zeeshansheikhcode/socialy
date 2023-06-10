import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/cubit/chat/chat_cubit.dart';
import 'package:socialy/views/chat/widget/message_box.dart';

import '../calls/audio_call.dart';
import '../calls/video_call.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
       child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
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
                            if(state is ChatLoadedState)
                            {
                              String? chatRoomId = state.chatRoomId;
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AudioCallingPage(callingId: chatRoomId!))) ;
    
                            }
                          },
                          icon:const Icon(Icons.call)
                          ),
                        IconButton(
                          onPressed: (){
                            if(state is ChatLoadedState)
                            {
                              String? chatRoomId = state.chatRoomId;
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => CallPage(callID: chatRoomId!))) ;
                            }
                          },
                          icon:const Icon(Icons.video_call)
                          )
                      ],
                      automaticallyImplyLeading: false,
                    ),
                    Expanded(
                      child: 
                      Container(
                      decoration:const BoxDecoration(
                        color: Colors.white
                      ),
                    child:  StreamBuilder<QuerySnapshot>(
                        stream: BlocProvider.of<ChatCubit>(context).gettingStreams(BlocProvider.of<ChatCubit>(context).realchatRoomId!),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return const Text('Error');
                                      } else if (snapshot.hasData) {
                                        return ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            Map<String, dynamic>? map = snapshot.data!.docs[index].data() as Map<String, dynamic>?;
                                            return MessageBox(map: map!);
                                          },
                                        );
                                      } else {
                                        return const Text('Empty data');
                                      }
                                    }
                                 else {
                                      return Text('State: ${snapshot.connectionState}');
                                    }
             }))),
         
                    Container(
                      height: 70.h,
                      color: Colors.white,
                      child:Row(
                        children:  [
                           Expanded(
                             child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: messageController,
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
                             BlocProvider.of<ChatCubit>(context).getImage();
                          },
                          icon:const Icon(Icons.photo)),
                          IconButton
                          (
                          onPressed: ()
                          {
                             BlocProvider.of<ChatCubit>(context).onSendMessage(messageController.text);
                             messageController.clear();
                          },
                          icon:const Icon(Icons.send))
                        ],
                      ),
                    ),
                  ],
                );
          },
        ),
      ),
    );
  }
}