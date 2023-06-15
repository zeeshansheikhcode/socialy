import 'package:flutter/material.dart';
import 'package:socialy/utils/routes/routes_name.dart';
import 'package:socialy/views/add/add_screen.dart';
import 'package:socialy/views/bottombar/bottom_bar.dart';
import 'package:socialy/views/chat/search_screen/search_view.dart';
import 'package:socialy/views/profile/user_profile.dart';

import '../../views/auth/login/login_screen.dart';
import '../../views/auth/signup/signup_screen.dart';
import '../../views/chat/chat_screen/chat_screen.dart';
import '../../views/home/home/home_view.dart';
import '../../views/splash_screen.dart';
class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings)
  {

    switch(settings.name)
    {

      case RoutesName.splashview :
        return MaterialPageRoute(builder: (BuildContext context)  =>   const SplashScreen());
      case RoutesName.signupview :
        return MaterialPageRoute(builder: (BuildContext context)  =>    const SignupScreen());
     case RoutesName.loginview :
        return MaterialPageRoute(builder: (BuildContext context)  =>    const LoginScreen());
     case RoutesName.homeView :
        return MaterialPageRoute(builder: (BuildContext context)  =>    const HomeView());
      case RoutesName.searchview :
        return MaterialPageRoute(builder: (BuildContext context)  =>   const SearchView());
      case RoutesName.chatview :
        return MaterialPageRoute(builder: (BuildContext context)  => const  ChatScreen());
     case RoutesName.profileview :
        return MaterialPageRoute(builder: (BuildContext context)  => const  UserProfile());
    case RoutesName.addview :
        return MaterialPageRoute(builder: (BuildContext context)  => const  AddScreen());
    case RoutesName.bottombarview :
        return MaterialPageRoute(builder: (BuildContext context)  => const  BottomNavBar());
   
    //  case RoutesName.chatpagesqlite :
    //     return MaterialPageRoute(builder: (BuildContext context)  =>   const ChatPage());
   
     default:

        return MaterialPageRoute(builder: (_)
        {
          return const Scaffold(
            body: Center(
              child: Text('No routes Defined'),
            ),
          );
        });
    }
  }
}