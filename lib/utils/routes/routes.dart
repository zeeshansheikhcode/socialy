import 'package:flutter/material.dart';
import 'package:socialy/utils/routes/routes_name.dart';

import '../../views/login/login_screen.dart';
import '../../views/signup/signup_screen.dart';
import '../../views/splash_screen.dart';
class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings)
  {

    switch(settings.name)
    {

      case RoutesName.splashview :
        return MaterialPageRoute(builder: (BuildContext context)  =>   const SplashScreen());
      case RoutesName.signupview :
        return MaterialPageRoute(builder: (BuildContext context)  =>   const SignupScreen());
     case RoutesName.loginview :
        return MaterialPageRoute(builder: (BuildContext context)  =>   const LoginScreen());
     //case RoutesName.homeView :
    //     return MaterialPageRoute(builder: (BuildContext context)  =>   const HomeScreen());
    //   case RoutesName.statusview :
    //     return MaterialPageRoute(builder: (BuildContext context)  =>   const StatusView());
    //   case RoutesName.chatview :
    //     return MaterialPageRoute(builder: (BuildContext context)  => const  ChatScreen());
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