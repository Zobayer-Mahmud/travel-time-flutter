import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:traveltime3/const/mycolor.dart';

import 'package:traveltime3/ui/login_screen.dart';
import 'package:traveltime3/ui/user_form.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController =TextEditingController();
  TextEditingController _passwordController =TextEditingController();
  //TextEditingController _passwordController2 =TextEditingController();
  bool _obsecureText = true;
  signUp()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>UserForm()));
      }
      else{
        Fluttertoast.showToast(msg: "Something is wrong");
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak.");

      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.");

      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         SizedBox(height: 40.h,),
          Expanded(
            child: Container(
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.w,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Icon(Icons.person_add_alt_1_outlined,color: Colors.cyan,size: 40,),
                              Text("Welcome Buddy!",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,


                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Text('Register new user',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xffBBBBBB),
                                ),),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(color: Mycolors.deep_orange,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(Icons.email_outlined,
                                color:Colors.white,size: 20.w,),
                            ),
                            SizedBox(width: 15.h,),
                            Expanded(child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Enter your Email",
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: Mycolors.deep_orange,

                                ),
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 41.w,
                              decoration: BoxDecoration(
                                  color: Mycolors.deep_orange,
                                  borderRadius: BorderRadius.circular(12.r)
                              ),
                              child: Icon(Icons.lock_outline,size: 20.w,color: Colors.white,),
                            ),
                            SizedBox(width: 10.w,),
                            Expanded(child: TextField(
                              controller: _passwordController,
                              obscureText: _obsecureText,
                              decoration: InputDecoration(
                                hintText: 'Password must be  6 character.',
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF414041),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: Mycolors.deep_orange,
                                ),
                                suffixIcon: _obsecureText == true ?
                                IconButton(onPressed: (){
                                  setState(() {
                                    _obsecureText=false;
                                  });
                                }, icon: Icon(
                                  Icons.remove_red_eye,
                                  size: 20.w,),
                                ):IconButton(onPressed: (){
                                  setState(() {
                                    _obsecureText=true;
                                  });
                                }, icon: Icon(Icons.visibility_off,size: 20.w,),
                                ),

                              ),
                            ),
                            ),

                          ],
                        ),
                        SizedBox(height: 50.h,),
                        SizedBox(width:  1.sw,
                          height: 56.h,
                          child: ElevatedButton(
                            onPressed: (){
                              signUp();


                            },
                            child: Text('Continue', style: TextStyle(
                                color: Colors.white, fontSize: 18.sp),),

                            style: ElevatedButton.styleFrom(
                                primary: Mycolors.deep_orange,
                                elevation: 3
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h,),
                        Center(
                          child: Wrap(
                            children: [

                              Text("Already have an account? ",style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              ),
                              GestureDetector(
                                child: Text("Sign In",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Mycolors.deep_orange,
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder:(context)=> LoginScreen() ));
                                },
                              )
                            ],),
                        ),
                      ],
                    ),
                  )
              ),
            ),),
        ],
      ),
    );
  }
}
