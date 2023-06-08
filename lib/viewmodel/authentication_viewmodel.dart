import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../services/services_locator.dart';

class AuthenticationViewModel with ChangeNotifier
{  
   dynamic result;
   final emailController    = TextEditingController();
   final passwordController = TextEditingController();
   final FirebaseAuth auth  = FirebaseAuth.instance;
   final AuthenticationServices _authenticationService = locator<AuthenticationServices>();
  

   Future<dynamic> googlecreateAccount(BuildContext context) async
   {    
       
    try
     {      
        final res = await _authenticationService.signInWithGoogle(context: context);
        if(res is bool != false)
        {
          emailController.dispose();
          passwordController.dispose();
          result   = true;
          notifyListeners();
          // Utils.showSnackBar('Successfully Register', context);
          // Navigator.pushNamed(context, RoutesName.searchview);
        
        }
          
     } 
      catch(e)
     { print('error $e');
        e.toString();    
     }
  }
  
  Future<dynamic> facebokkCreateAccount(BuildContext context) async
   {    
       
    try
     {      
        final res = await _authenticationService.signInWithFacebook();
        if(res is bool != false)
        {
          emailController.dispose();
          passwordController.dispose();
          result   = true;
          notifyListeners();
          // Utils.showSnackBar('Successfully Register', context);
          // Navigator.pushNamed(context, RoutesName.searchview);
        
        }
          
     } 
      catch(e)
     { print('error $e');
        e.toString();    
     }
  }


    Future<dynamic> createAccount(BuildContext context) async
   {    
       if(emailController.text.isEmpty && passwordController.text.isEmpty )
        {
          result = 'Enter Credentials';
         // Utils.showSnackBar(result, context);
          return result;
          
        }
    try
     {  
       
        final res = await _authenticationService.registerNewUser(emailController.text,  passwordController.text,context);
        if(res is bool != false)
        {
          
          emailController.clear();
          passwordController.clear();
          result   = true;
          notifyListeners();
         // Utils.showSnackBar('Successfully Register', context);
        //  Navigator.pushNamed(context, RoutesName.homeView);
           return result;
        }
        else 
        { 
          result = res ;
          notifyListeners();
      //    Utils.showSnackBar(result, context);
          return result;
        }
     } 
      catch(e)
     { print('errrorrrrr $e');
        e.toString();    
     }
  }

  Future<dynamic> logIn(BuildContext context) async
  { 
     if(emailController.text.isEmpty && passwordController.text.isEmpty )
        {
          result ='Enter Credentials';
        //  Utils.showSnackBar(result, context);
          return result;
        }
  
   try
   {  
         final res = await _authenticationService.signInWithEmailAndPassword(emailController.text, 
          passwordController.text,);
          print('res is $res');
           if(res is bool != false)
           {
            emailController.clear();
            passwordController.clear();
            result = true;
            notifyListeners();
            // Utils.showSnackBar('Successfully login', context);
            // Navigator.pushNamed(context, RoutesName.homeView);
            return result;
           }
           else {
             result = res;
             notifyListeners();
            // Utils.showSnackBar(result, context);
             //return res;
           }
          
   } 
   catch(e)
    {
      e.toString();
      // return false;
        
    }
  }

  Future<dynamic> forgotPassword(BuildContext context) async
  {
     
     if(emailController.text==null)
     {
       result = 'Enter Credentials';
       return result;
     }
     try
     {
       final res = await _authenticationService.forgotPassword(emailController.text);
       notifyListeners();
     }
     catch(e)
     {
      e.toString();
     }   
  }

  void loggingOut(context) async
  {
    final res =  await _authenticationService.logOut();
    notifyListeners();
    print(res);
    if(res==true)
    {
     // Navigator.pushNamed(context, RoutesName.loginview);
    }
  }
}
