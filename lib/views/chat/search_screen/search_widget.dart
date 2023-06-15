import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/cubit/user/user_cubit.dart';
import 'package:socialy/utils/utils.dart';

import '../../../cubit/chat/chat_cubit.dart';
import '../../../utils/routes/routes_name.dart';

class SearchWidget extends StatelessWidget {
  final String img;
  final String email;
  final String username;
  final String userId;
  const SearchWidget({super.key, required this.username,required this.img,required this.userId, required this.email});
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
              color:  Colors.purple,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              )),
          child: ListTile(
            onTap: () async {
              BlocProvider.of<ChatCubit>(context).generateChatRoomId(email);
            },
            leading:  CircleAvatar(
              maxRadius: 30,
             foregroundImage: NetworkImage(img),
            ),
            title: Text(email),
            subtitle:  Text(username),
            trailing: TextButton(onPressed: ()
            {
              BlocProvider.of<UserCubit>(context).addFollowers(email);
              Utils.showSnackBar('Following', context);
              
            },
            child: const Text('Follow',
            style: TextStyle(color: Colors.white),),),
          ),
        );
      },
    );
  }
}
