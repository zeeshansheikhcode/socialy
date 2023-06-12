import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/app_strings.dart';
import 'package:socialy/commons/ui_helpers.dart';
import 'package:socialy/components/reusable_button.dart';
import 'package:socialy/cubit/status_post_cubit.dart';
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final statusTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: 
        [
           
           Center(child: Text('Add Status',style: heading,)),
           verticalSpaceSmall,
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              ReusableButton(
                title: 'Text',
                height: 50.h,
                width: 60.w,
                circular: 10,
                ontap: ()
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
                      controller: statusTextController,
                      decoration: const InputDecoration(hintText: 'Happy'),
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
                
               ),
               
               ReusableButton(
                title: 'Photo',
                height: 50.h,
                width: 60.w,
                circular: 10,
                ontap: () {
                BlocProvider.of<StatusPostCubit>(context).pickImage(isStatus: true);
                },
               ),
               ReusableButton(
                title: 'Video',
                height: 50.h,
                width: 60.w,
                circular: 10,
               ),
            ],
           ),
           verticalSpaceSmall,
           Center(child: Text('Post',style: heading,)),
           verticalSpaceSmall,
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              ReusableButton(
                title: 'Add',
                height: 50.h,
                width: 60.w,
                circular: 10,
                ontap: ()
                {
                   BlocProvider.of<StatusPostCubit>(context).pickImage(isStatus: false);
               
                },
               ),
               
               ReusableButton(
                title: 'Delete',
                height: 50.h,
                width: 60.w,
                circular: 10,
               ),
            ],
           ),
           verticalSpaceSmall,
        ],
      ),
    );
  }
}