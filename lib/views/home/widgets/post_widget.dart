import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/app_strings.dart';
import 'package:socialy/commons/ui_helpers.dart';
import 'package:socialy/models/post_model.dart';

import '../../../cubit/status_post_cubit.dart';

class PostWidget extends StatelessWidget {
  final PostModel postModel;
  const PostWidget({super.key, required this.postModel,});

  @override
  Widget build(BuildContext context) {
    print(postModel.photoUrl);
    return BlocConsumer<StatusPostCubit,StatusPostState>(
      listener: (context, state) {
      
      },
      builder: (context, state) {
        if(state is StatusPostLoadingState)
        {
           return const Center(child: CircularProgressIndicator(),);
        }
       if(state is StatusPostLoadedState)
       {
        return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        height: 300.h,
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 200.h,
                 width: 1.sw,
                child: Image(
                  image: NetworkImage(
                    postModel.photoUrl!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border_outlined)),
                horizontalSpaceSmall,
                IconButton(onPressed: () {}, icon: const Icon(Icons.comment))
              ],
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'View all Comments',
                  style: heading3,
                ))
          ],
        ),
              );
       }
          return const SizedBox();
          
        }
        
    );
  }
}
