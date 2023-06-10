import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/app_strings.dart';
import 'package:socialy/commons/ui_helpers.dart';
class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: 
        [
          
          Center(
            child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: const CircleAvatar(
           backgroundColor: Colors.blue,
           maxRadius: 30,
            //foregroundImage: NetworkImage("enterImageUrl"),
           child: Text("A"),
             ),
            )
          ),
          verticalSpaceTiny,
          ElevatedButton(
          onPressed: (){},
          child: Text("Edit Pictures",style: heading,)
          ),
          verticalSpaceMedium,
          Center(
            child: Text('Zeeshan Sheikh',style: heading,),
          ),
          ElevatedButton(
          onPressed: (){},
          child: Text("Edit Name",style: heading,)
          ),
         
        ],
      ),
    );
  }
}