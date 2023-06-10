import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MessageBox extends StatelessWidget {
  final Map<String, dynamic> map;
  MessageBox({super.key, required this.map});
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return map['type'] == 'text' 
    ? 
    Container(
      height: 60.h,
      width: 1.sw,
      alignment: map['sendby'] == _auth.currentUser!.email
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
        margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: Text(
          map['message'],
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    )
     :
     Container(
       height:  200.h,
       width: 1.sw,
       padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
       alignment: map['sendby'] == _auth.currentUser!.email 
          ? Alignment.centerRight
          : Alignment.centerLeft,
          child: InkWell(
            onTap: () =>
            
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ShowImage(imageUrl: map['message']))),
            
            child: Container(
              height: 200.h,
              width: 0.7.sw,
              decoration: BoxDecoration(border: Border.all()),
              alignment:  map['message'] !=  "" ? null : Alignment.center,
              child: map['message'] != ""
                 ? 
                 Image.network(map['message'],
                 fit: BoxFit.fill,)
                 :
                 const CircularProgressIndicator(),
            ),
          ),

     );
  }
}
class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({ required this.imageUrl ,Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        color: Colors.black,
        child: Center(child: Image.network(imageUrl)),
      ),      
    );
  }
}


