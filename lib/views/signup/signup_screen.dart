import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/reusable_button.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: 
        [
           SizedBox(height: 30.h,),
           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 10.h),
             child: Align(
              alignment: Alignment.topLeft,
               child: CircleAvatar(
                backgroundColor: Colors.white,
                 child: IconButton(onPressed: ()
                 {
                  if(context.locale == const Locale('en', 'US'))
                    {
                      context.locale = const Locale('ur', 'PK');
                    }
                   else 
                   {
                     context.locale = const Locale('en', 'US');
                   }
                 },
                 icon:const Icon(Icons.arrow_back_rounded,color: Colors.black,)),
               ),
             ),
           ),
           SizedBox(height: 10.h,),
           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 10.h),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Text('Hello_Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,color: Colors.black),
                    ).tr(),
                    SizedBox(height: 5.h,),
                    Text('Happy_signup',
                    textAlign: TextAlign.left, 
                    maxLines: 2, 
                    overflow: TextOverflow.ellipsis,
                     style: TextStyle(fontSize: 15.sp,color: Colors.black),
                    ).tr(),
                  ],
                ),
                SizedBox(
                   height: 140.h,
                   width: 80.w,
                   child:  context.locale == const Locale('ur', 'PK')
                    ?
                    Transform(
                    alignment: Alignment.center,
                     transform: Matrix4.rotationY(math.pi),
                    child:const Image(image: AssetImage('assets/images/sitting.png')))
                    : 
                    const Image(image: AssetImage('assets/images/sitting.png')
                  ),
                 )
              ],
             ),
           ),
             SizedBox(height: 10.h,),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 20.w),
               child: Text('Email', 
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,color: Colors.black),).tr(),
             ),
             SizedBox(height: 10.h,),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 10.w),
               child: TextFormField(
                style:const TextStyle(
                color: Colors.black,
                 ),
                //controller: authProvider.emailController,
                decoration: InputDecoration(

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                       borderSide: const BorderSide(width: 5)
                  ),
                  
                )
               ),
             ),
              SizedBox(height: 10.h,),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 20.w),
               child: Text('Password', 
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,color: Colors.black),).tr(),
             ),
             SizedBox(height: 10.h,),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 10.w),
               child: TextFormField(
                style:const TextStyle(
                color: Colors.black, // set the color of the entered text
                 ),
               // controller: authProvider.passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:const BorderSide(width: 5)
                  ),
                  
                )
               ),
             ),
             SizedBox(height: 20.h,),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 10.h),
               child: Align(      
                alignment: Alignment.topRight,
                child: Text('Forgot Password?', 
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,color: const Color.fromARGB(255, 134, 11, 143)),),
               ),
             ),
            SizedBox(height: 40.h,),
            Center(
              child: ReusableButton(
                height: 50.h,
                width: 300.h,
                circular: 20,
                ontap: () {
                  //authProvider.createAccount(context);
                },
                title: 'Sign_Up'.tr(),
              ),
            ),
             SizedBox(height: 50.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Row(
              children: [
               const Expanded(
                  child: Divider(
                    color: Colors.grey,
                     thickness: 3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Text(
                    'OrSignupWith'.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 3,
                  ),
                ),
              ],
             ),
            ),
            SizedBox(height: 20.h,),
           Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: 
              [
               GestureDetector(
                   onTap: () {
                  //  authProvider.googlecreateAccount(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                       borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                   padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 5.w),
                   height: 50.h,
                   width: 120.w,
                   child:  Center(
                     child: Text('Google',
                     style: TextStyle(fontSize: 20.sp, color: Colors.white),
                     ).tr(),
                   ),             
                  ),
                ),
                 
                 SizedBox(width: 20.w,),
                 GestureDetector(
                   onTap: () {
                //  authProvider.facebokkCreateAccount(context);
                },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 5.w),
                   height: 50.h,
                   width: 120.w,
                   child:  Center(
                     child: Text('Facebook',
                     style: TextStyle(fontSize: 18.sp, color: Colors.white),
                     ).tr(),
                   ),             
                  ),
                ),
              ],
            ),
           ),                                        
        ],
      ),
    );
  }
}