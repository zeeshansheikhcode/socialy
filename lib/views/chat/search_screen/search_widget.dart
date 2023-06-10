import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubit/chat/chat_cubit.dart';
import '../../../utils/routes/routes_name.dart';

class SearchWidget extends StatelessWidget {
  final String img;
  final String email;
  const SearchWidget({super.key, required this.img, required this.email});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
         if(state is ChatLoadedState)
               {  
                 if(state.chatRoomId!=null)
             {
                Navigator.pushNamed(context, RoutesName.chatview);
              } 
          }
      },
      builder: (context, state) {
        return Container(
          height: 80.h,
          width: 250.w,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: Colors.blue,
                width: 2.0,
              )),
          child: ListTile(
            onTap: () async {
              BlocProvider.of<ChatCubit>(context).generateChatRoomId(email);
            },
            leading: const CircleAvatar(
              child: Text('A'),
            ),
            title: Text(email),
            subtitle: const Text('My Subtitle'),
            //trailing: Text('${DateTime.now().toIso8601String()}'),
          ),
        );
      },
    );
  }
}
