import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubit/status_post_cubit.dart';
import '../../../models/story_model.dart';
import '../status/show_status_view.dart';

class StatusWidget extends StatelessWidget {
  final List<StoryModel> allStories;
  const StatusWidget({super.key, required this.allStories});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatusPostCubit, StatusPostState>(
      listener: (context, state) {
     
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if(state is StatusPostLoadedState)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowStatus(
                          showstories: allStories,
                        )));

            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: const CircleAvatar(
              backgroundColor: Colors.blue,
              maxRadius: 30,
              //foregroundImage: NetworkImage("enterImageUrl"),
              child: Text("A"),
            ),
          ),
        );
      },
    );
  }
}
