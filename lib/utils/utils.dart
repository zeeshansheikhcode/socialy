
import 'package:flutter/material.dart';

class Utils
{
   static int appId =  478672287; // enter your id
   static String appSignin = "8c0c20e92d1d38b7ab50812c8bb4a152d0acdc09d4f92bc054b4d70554ca4edd" ;
   static  showSnackBar(String message,BuildContext context)
   {
     return ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
           backgroundColor: Colors.green,
           content: Text(message)),
     );
   }
}