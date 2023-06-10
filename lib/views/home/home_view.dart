import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialy/views/home/search_widget.dart';

import '../../cubit/chat/chat_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final searchController = TextEditingController();
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home View'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(children: [
          SizedBox(
            height: 50.h,
          ),
          Row(
            children: [
              Container(
                height: 50.h,
                width: 250.w,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 218, 209, 209),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search)),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: TextFormField(
                            controller: searchController,
                            onChanged: (query) {
                              BlocProvider.of<ChatCubit>(context)
                                  .searchFromFirebase(query);
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100.h,
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if(state is ChatLoadedState)
                {
                  return ListView.builder(
                    itemCount:BlocProvider.of<ChatCubit>(context).searchresult.length,
                    itemBuilder: (context, index) {
                      return SearchWidget(
                        email: BlocProvider.of<ChatCubit>(context).searchresult[index]['email'],
                        img: 'A',
                      );
                    });
                }
                return const SizedBox();
                    
              },
            ),
          )
        ]));
  }
}
