import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/app_strings.dart';
import 'package:socialy/commons/ui_helpers.dart';
class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      height: 250.h,
      width: 0.8.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
          Center(
            child: SizedBox(
              height: 150.h,
             // width: 0.75.sw,
              child:const Image(
                image: AssetImage('assets/images/sitting.png',
                ),
              ),
             ),
          ),
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [
              IconButton(
                onPressed: (){},
                icon:const Icon(Icons.favorite_border_outlined)
              ),
              horizontalSpaceSmall,
              IconButton(onPressed: (){},
              icon: const Icon(Icons.comment))
            ],
          ),
          TextButton(onPressed: (){}, child: Text('View all Comments',style: heading3,))
        ],

      ),

    );
  }
}