import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socialy/commons/app_strings.dart';

import '../services/splash_services.dart';
import '../utils/routes/routes_name.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3),
     () async
     {  SplashService splashService = SplashService();
        dynamic auth = await splashService.checkingAuthentication();
       
       if(auth == true) 
        {  
           Navigator.pushNamed(context  , RoutesName.homeView);
        }
        else 
        {
           Navigator.pushNamed(context   , RoutesName.loginview);
        }
     });
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Text('Soialy Club',
      style: heading
      )
     ),
    );
  }
}