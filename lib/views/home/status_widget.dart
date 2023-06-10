import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: const CircleAvatar(
        backgroundColor: Colors.blue,
        maxRadius: 30,
        //foregroundImage: NetworkImage("enterImageUrl"),
        child: Text("A"),
      ),
    );
  }
}