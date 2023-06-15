import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/app_strings.dart';
import 'package:socialy/commons/ui_helpers.dart';
import 'package:socialy/models/post_model.dart';
import 'package:socialy/utils/utils.dart';
import 'package:socialy/views/home/comments/comments_view.dart';

import '../../../cubit/status_post/status_post_cubit.dart';

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
      
        return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        height: 300.h,
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceTiny,
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  postModel.useremail!,
                  style: heading2
                ),
              ),
              verticalSpaceTiny,
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
                    onPressed: () {
                      BlocProvider.of<StatusPostCubit>(context).likeAdded(postModel);
                      Utils.showSnackBar('Like Added', context);
                    },
                    icon: const Icon(Icons.favorite_border_outlined)

                    
                     ),
                horizontalSpaceSmall,
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentsView(
                    postModel: postModel,
                  )));
                }, icon: const Icon(Icons.comment))
              ],
            ),
           Text( 
                  'Likes ${ postModel.likes!.length} ',
                  style: heading3,
                )
          ],
        ),
              );
       
        //  return const SizedBox();
          
        }
        
    );
  }
}
