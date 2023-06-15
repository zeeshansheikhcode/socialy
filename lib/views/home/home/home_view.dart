import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/ui_helpers.dart';
import 'package:socialy/views/home/widgets/status_widget.dart';

import '../../../cubit/status_post_cubit.dart';
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
    // BlocProvider.of<StatusPostCubit>(context).getPosts();
    // BlocProvider.of<StatusPostCubit>(context).getStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        verticalSpaceSmall,

        BlocBuilder<StatusPostCubit, StatusPostState>(
          builder: (context, state) {
            if (state is StatusPostLoadingState) {
              return const CircularProgressIndicator.adaptive();
            }
            return SizedBox(
              height: 120.h,
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
            );
          },
        ),
        verticalSpaceTiny,
        BlocBuilder<StatusPostCubit, StatusPostState>(
          builder: (context, state) {
            if (state is StatusPostLoadingState) {
              return const CircularProgressIndicator.adaptive();
            }
            return Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount:
                      BlocProvider.of<StatusPostCubit>(context).posts.length,
                  itemBuilder: (context, index) {
                    return PostWidget(
                      postModel: BlocProvider.of<StatusPostCubit>(context)
                          .posts[index],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    ));
  }
}
