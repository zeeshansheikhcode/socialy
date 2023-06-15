import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialy/views/add/add_screen.dart';
import 'package:socialy/views/chat/search_screen/search_view.dart';
import 'package:socialy/views/profile/user_profile.dart';

import '../../cubit/bottomavbar/bottomnvabar_cubit.dart';
import '../home/home/home_view.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomnvabarCubit, BottomnvabarState>(
      builder: (context, state) {
          if(state is BottomnvabarLoadingState)
          {
            return   BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index) => BlocProvider.of<BottomnvabarCubit>(context).selectView(index),
            items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 93, 6, 128)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Adds',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
        }
        if(state is BottomnvabarLoadedState)
          {
            return   BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index) => BlocProvider.of<BottomnvabarCubit>(context).selectView(index),
            items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 93, 6, 128)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Adds',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
        }
       return const SizedBox();
       },
       
    ), 
    body: BlocBuilder<BottomnvabarCubit, BottomnvabarState>(
        builder: (context, state) {
       if (state is BottomnvabarLoadingState) {
        switch (state.index) {
          case 0:
            return const HomeView();
          case 1:
            return const SearchView();
          case 2:
            return const AddScreen();
          case 3:
            return const UserProfile();
          default:
            return Container();
        }
      }
      if (state is BottomnvabarLoadedState) {
        switch (state.index) {
          case 0:
            return const HomeView();
          case 1:
            return const SearchView();
          case 2:
            return const AddScreen();
          case 3:
            return const UserProfile();
          default:
            return Container();
        }
      }
      return const SizedBox();
    }
     )
    );
  }
}
