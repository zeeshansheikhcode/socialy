import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/commons/ui_helpers.dart';
import 'package:socialy/views/home/widgets/post_widget.dart';
import 'package:socialy/views/home/widgets/status_widget.dart';

import '../../../commons/app_strings.dart';
import '../../../cubit/status_post_cubit.dart';

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
    BlocProvider.of<StatusPostCubit>(context).getStoriesPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<StatusPostCubit, StatusPostState>(
      listener: (context, state) {
     
      },
      builder: (context, state) {
        return Column(children: [
          verticalSpaceMedium,
          SizedBox(
            height: 80.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: BlocProvider.of<StatusPostCubit>(context).uniqueEmail.length,
                itemBuilder: ((context, index) {
                  if (state is StatusPostLoadingState)
                   {
                    return const Center(
                      child: SizedBox(
                        child: Text('No Status'),
                      ),
                    );
                  }
                  return StatusWidget(
                    allStories: BlocProvider.of<StatusPostCubit>(context)
                        .allStories[index],
                  );
                })),
          ),
          verticalSpaceSmall,
          Expanded(
              child: SizedBox(
            child: ListView.builder(
                itemCount:
                    BlocProvider.of<StatusPostCubit>(context).posts.length,
                itemBuilder: (context, index) {
                  if (state is StatusPostLoadingState) {
                    return  Center(
                      child: SizedBox(
                        child: Text('No Posts',style: heading),
                      ),
                    );
                  }
                  return PostWidget(
                    postModel:
                        BlocProvider.of<StatusPostCubit>(context).posts[index],
                  );
                }),
          ))
        ]);
      },
    ));
  }
}
