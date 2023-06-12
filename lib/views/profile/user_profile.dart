import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/app_strings.dart';
import 'package:socialy/commons/ui_helpers.dart';
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final nameController = TextEditingController();
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
          onPressed: ()
          {
             showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Enter Status', 
                      style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: Colors.black
                   ),
                     ),
                    content:  TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Edwards'),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          BlocProvider.of<StatusPostCubit>(context).uploadStatus(statusTextController.text);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
           },

          
          child: Text("Edit Name",style: heading,)
          ),
         
        ],
      ),
    );
  }
}