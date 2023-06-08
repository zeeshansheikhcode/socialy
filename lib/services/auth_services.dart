import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationServices 
{
  final FirebaseAuth auth;
  AuthenticationServices({required this.auth});
  final _firestore = FirebaseFirestore.instance;
  String? message ;

     Future<dynamic> signInWithEmailAndPassword( String email, String password) async 
   {
    try 
    {    
        final user = await auth.signInWithEmailAndPassword(
         email: email,
         password: password,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final useremail   = await _firestore
                       .collection('Users')
                       .doc(user.user!.uid)
                       .get()
                       .then((value) {
                       return value.data()!['email'];
                       });
     //prefs.setString('UserName' , username);                 
     prefs.setString('Email'    , email);
     prefs.setString('Password' , password);
      return true;
      
    } 
    on FirebaseAuthException catch (e) 
    {

        switch(e.code)
     {
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
       message = 'Wrong password';
       break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
       message = 'No user found with this email.';
       break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
       message ='User disabled.';
       break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
       message = 'Error too many request';
       break;
      case "ERROR_OPERATION_NOT_ALLOWED":
       message = 'Server error, please try again later.';
       break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
       message = 'Email address is invalid.';
       break;
      default:
       message = 'Login failed. Please try again.';
        } 
        return message;     
    }
  }


  Future<dynamic> signInWithFacebook() async { 
     try {
       final LoginResult loginResult = await FacebookAuth.instance.login();
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
        final userCredential =await  FirebaseAuth.instance.signInWithCredential(facebookAuthCredential); 

         var user = userCredential.user;
         _firestore.collection('Users')
          .doc(user!.uid)
          .set(
            {
               "email"    : user.email,
               "password" : 'Facebook Account',
            

            }
          );
       SharedPreferences prefs = await SharedPreferences.getInstance();               
       prefs.setString('Email'    , user.email!);  
       return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return false;
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          return false;
          // handle the error here
        }
      } catch (e) {
        return false;
        // handle the error here
         }
  // Once signed in, return the UserCredential
         return true;
   }
 
   Future<dynamic> signInWithGoogle({required BuildContext context}) async {
   
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

          user = userCredential.user;
         _firestore.collection('Users')
          .doc(user!.uid)
          .set(
            {
               "email"    : user.email,
               "password" : 'Google Account',
            

            }
          );
       SharedPreferences prefs = await SharedPreferences.getInstance();               
       prefs.setString('Email'    , user.email!);  
       return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }   
  


  Future<dynamic> registerNewUser(String email,  String password,BuildContext context) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
       );
       _firestore.collection('Users')
        .doc(user.user!.uid)
        .set(
          {
             "email"    : email,
             "password" : password,
          }
        );
     SharedPreferences prefs = await SharedPreferences.getInstance();               
     prefs.setString('Email'    , email);
     prefs.setString('Password' , password);
     return true;
     
    } 
    on FirebaseAuthException catch (e)
     {
       switch(e.code)
        {
          case "ERROR_EMAIL_ALREADY_IN_USE":
          case "account-exists-with-different-credential":
          case "email-already-in-use":
          message ='Email already used. Go to login page.';
          break;
          case "ERROR_USER_DISABLED":
          case "user-disabled":
          message ='User disabled.';
          break;
          case "ERROR_TOO_MANY_REQUESTS":
          case "operation-not-allowed":
          message = 'Too many requests to log into this account.';
          break;
          case "ERROR_OPERATION_NOT_ALLOWED":
          message = 'Server error, please try again later.';
          break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
          message = 'Email address is invalid.';
          break;
          default:
          message = 'Sign Up Failed';
          break;
        }      
      return message;
    }
  }

   Future<dynamic> forgotPassword(String email) async {
    try {
      final result =  await  auth.sendPasswordResetEmail(
      email    : email,
      );
      return true;
    } catch (e) {
      return e.toString();
    }
  }
  Future<bool> logOut() async {
    try {

      await auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      return true;
    } catch (e) {
        e.toString();
        return false;
    }
  }
}