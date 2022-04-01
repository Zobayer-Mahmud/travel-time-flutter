import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveltime3/ui/domestic_screen.dart';
import 'package:traveltime3/ui/international_screen.dart';
import 'package:traveltime3/ui/login_screen.dart';
import 'package:traveltime3/ui/place_details_screen.dart';
import 'package:traveltime3/ui/search_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _firestoreInstance = FirebaseFirestore.instance;
  /*var _firebaseAuth=*/
  List _places = [];
  List _places2 =[];
  fetchDomesticPlaces()async {
    QuerySnapshot qn = await _firestoreInstance.collection("domestic").get();

    setState(() {

      for (int i = 0; i < qn.docs.length; i++) {
        _places.add({
          "place": qn.docs[i]["place"],
          "place-description": qn.docs[i]["place-description"],
          "place-img": qn.docs[i]["place-img"],
         /* "start-date":qn.docs[i]["start-date"].toDate(),
          "end-date":qn.docs[i]["end-date"].toDate(),*/
          "start-date":qn.docs[i]["start-date"],
          "end-date":qn.docs[i]["end-date"],
          "short-description":qn.docs[i]["short-description"],

        });

      }
    });
    return qn.docs;
  }
  fetchInternationalPlaces()async {
    QuerySnapshot qn = await _firestoreInstance.collection("international").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _places2.add({
          "place": qn.docs[i]["place"],
          "place-description": qn.docs[i]["place-description"],
          "place-img": qn.docs[i]["place-img"],
          "start-date":qn.docs[i]["start-date"].toDate(),
          "end-date":qn.docs[i]["end-date"].toDate(),
          "short-description":qn.docs[i]["short-description"],
        });

      }
    });
    return qn.docs;
  }
  signOut() async{
    await FirebaseAuth.instance.signOut();
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
      ).then((value) => Fluttertoast.showToast(msg: 'Logged out Successfully'));
    });
  }
 /* Future logout() async {
    await _firebaseAuth.signOut().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()),(route) => false)));
  }*/
  @override
  void initState() {
    fetchDomesticPlaces();
    fetchInternationalPlaces();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Time',style: TextStyle(fontSize: 20.sp,
            color: Colors.black,
        fontWeight: FontWeight.bold,
        letterSpacing: 4),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  signOut();
                },
                child: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body:SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w,right: 10.w),
            child: Column(
              children: [


               TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: "Search place , destination",

                      hintStyle: TextStyle(fontSize: 15.sp),
                    ),


                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (_)=>SearchScreen()));
                    },

                  ),


                  SizedBox(height: 5.h),
                  //for Domestic Items


                Row(
                  children: [
                  Text('Domestic Places',style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20.sp),),
                    SizedBox(width: 100.w,),
                    TextButton(onPressed: (){
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  DomesticScreen())
                      );
                    });
                    }, child: Row(
                      children: [
                        Text('See All',style: TextStyle(fontSize: 16.sp),),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                    ),
                ],),
                Expanded(

                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _places.length,


                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,

                    ),
                    itemBuilder: (_,index){
                      return GestureDetector(
                        onTap: ()=> Navigator.push(context,
                            MaterialPageRoute(builder: (_)=>PlaceDetailScreen(_places[index]))),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(
                                  aspectRatio: 1.5,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(_places[index]["place-img"][0],)),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5.h,),
                                    Text("${_places[index]["place"]}",
                                      style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                                    Text("${_places[index]["short-description"]}",),

                                    SizedBox(height: 5.h,),

                                    Row(

                                      children: [
                                        Icon(Icons.calendar_today_outlined,size: 15,),
                                        SizedBox(width: 8.w,),
                                        Text(DateFormat.yMMMEd().format(_places[index]["start-date"].toDate())),
                                      ],
                                    ),
                                  ],
                                ),
                              )


                            ],
                          ),

                        ),
                      );
                    },
                  ),
                ),
//for international products
                Row(
                  children: [
                    Text('International Places',style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20.sp),),
                    SizedBox(width: 70.w,),
                    TextButton(onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  InternationalScreen())
                      );
                  }, child: Row(
                      children: [
                        Text('See All',style: TextStyle(fontSize: 16.sp),),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                    ),
                  ],),
                Expanded(

                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _places2.length,


                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,

                    ),
                    itemBuilder: (_,index){
                      return GestureDetector(
                        onTap: ()=> Navigator.push(context,
                            MaterialPageRoute(builder: (_)=>PlaceDetailScreen(_places2[index]))),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(
                                  aspectRatio: 1.5,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(_places2[index]["place-img"][0],)),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5.h,),
                                    Text("${_places2[index]["place"]}",
                                      style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5.h,),
                                    Text("${_places2[index]["short-description"]}",),

                                    SizedBox(height: 8.h,),

                                    Row(

                                      children: [
                                        Icon(Icons.calendar_today_outlined,size: 15,),
                                        SizedBox(width: 8.w,),
                                        Text(DateFormat.yMMMEd().format(_places2[index]["start-date"])),
                                      ],
                                    ),
                                  ],
                                ),
                              )

                            ],
                          ),

                        ),
                      );
                    },
                  ),
                ),




              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
