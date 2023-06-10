import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/ui_helpers.dart';
import 'package:socialy/views/home/widgets/post_widget.dart';
import 'package:socialy/views/home/widgets/status_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(       
        body: 
        Column(
        children: [
         verticalSpaceMedium,
         SizedBox(
          height: 80.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: ((context, index) 
            {
             return const StatusWidget();
            })),
         ),
         verticalSpaceRegular,
         Expanded(
          child: SizedBox(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index)
              {
                return  const PostWidget();
              }),
          ))

        ])
      );
  }
}
