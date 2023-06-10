import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/app_strings.dart';
import 'package:socialy/commons/ui_helpers.dart';
import 'package:socialy/components/reusable_button.dart';
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
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
               ),
               ReusableButton(
                title: 'Photo',
                height: 50.h,
                width: 60.w,
                circular: 10,
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
           Center(child: Text('Add Post',style: heading,)),
           verticalSpaceSmall,
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              ReusableButton(
                title: 'Create',
                height: 50.h,
                width: 60.w,
                circular: 10,
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