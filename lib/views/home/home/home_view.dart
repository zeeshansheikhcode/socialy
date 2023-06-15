import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/ui_helpers.dart';
import 'package:socialy/views/home/widgets/status_widget.dart';

import '../../../cubit/status_post/status_post_cubit.dart';
import '../widgets/post_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<StatusPostCubit>(context).getStoriePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<StatusPostCubit, StatusPostState>(
      builder: (context, state) {
        return  state is StatusPostLoadingState ?
                   const SizedBox(
                       
                       child: Center(child: CircularProgressIndicator.adaptive()))
                
        :
        Column(
          children: [
            verticalSpaceSmall,
            const Divider(
              color: Colors.purple,
              thickness: 3,
             ),
            
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: BlocProvider.of<StatusPostCubit>(context)
                        .uniqueEmail
                        .length,
                    itemBuilder: ((context, index) {
                      return StatusWidget(
                        allStories: BlocProvider.of<StatusPostCubit>(context)
                            .allStories[index],
                      );
                    }),
                  ),
                ),
            const Divider(
              color: Colors.purple,
              thickness: 3,
            ),
            verticalSpaceTiny,
                 Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: BlocProvider.of<StatusPostCubit>(context)
                          .posts
                          .length,
                      itemBuilder: (context, index) {
                        return PostWidget(
                          postModel: BlocProvider.of<StatusPostCubit>(context)
                              .posts[index],
                        );
                      },
                    ),
                  ),
                  )] 
               );
              }
          )   
        );    
      }
      
    
  }

