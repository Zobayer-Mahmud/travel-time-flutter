import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traveltime3/ui/login_screen.dart';
import 'package:traveltime3/ui/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration (seconds: 3),()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>LoginScreen())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            Image.asset(
              'images/splashscreen.jpeg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Center(child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container (

                  child:Text('TravelTime',style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold,
                      fontSize: 44.sp,
                      letterSpacing: 4,
                      decoration: TextDecoration.none),),),
                SizedBox(height: 20.h,),
                CircularProgressIndicator(color: Colors.white,),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

