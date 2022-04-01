import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:intl/intl.dart';
import 'package:traveltime3/const/mycolor.dart';
import 'package:traveltime3/ui/program_screen.dart';

class PlaceDetailScreen extends StatefulWidget {
 // const PlaceDetailScreen({Key? key}) : super(key: key);
  var _place;
  PlaceDetailScreen(this._place);
  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {

 var _dotpostion=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
            shrinkWrap: true,
          children:[
            Column(
            children: [
             Stack(
               children: [

                 SizedBox(
                   height: 180.h,
                   width: MediaQuery.of(context).size.width,
                   child: CarouselSlider(
                     items: widget._place['place-img']
                         .map<Widget>((item)=>Padding(
                       padding: const EdgeInsets.only(left: 3,right: 3),
                       child: Container(

                         /*height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,*/
                         width: double.infinity,

                         decoration: BoxDecoration(

                             image: DecorationImage(

                                 image: NetworkImage(item),
                                 fit: BoxFit.fill

                               //fit: BoxFit.fitHeight,

                             )
                         ),
                       ),
                     ),
                     ).toList(),
                     options: CarouselOptions(
                         autoPlay: false,
                         enlargeCenterPage: false,
                         viewportFraction: 1,
                         enlargeStrategy: CenterPageEnlargeStrategy.height,
                         onPageChanged: (val, carouselPageChangedReason){
                           setState(() {
                             _dotpostion=val;
                           });
                         }
                     ),
                   ),
                 ),
                 IconButton(
                   onPressed: ()=>Navigator.pop(context),
                   icon: Icon(Icons.arrow_back,size: 30, color: Colors.black,),
                 ),
               ],
             ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),

                  )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 5.h,),
                    Center(child: DotsIndicator(dotsCount: widget._place["place-img"].length==0?1:widget._place["place-img"].length,
                      position: _dotpostion.toDouble(),
                      decorator: DotsDecorator(
                        color: Mycolors.deep_orange.withOpacity(0.5),
                        activeColor: Mycolors.deep_orange,
                        size: Size(6, 6),
                        activeSize: Size(8, 8),
                        spacing: EdgeInsets.all(4),

                      ),
                    ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined,size: 15,),
                              SizedBox(width: 8.w,),
                              Text(DateFormat.yMMMEd().format(widget._place["start-date"].toDate())),
                              //Text(DateFormat.yMMMEd().format(_places[index]["start-date"])),
                            //  Text("${widget._place["start-date"]}".toString()),
                              SizedBox(width: 10.w,),
                             Text('--'),
                              SizedBox(width: 10.w,),
                             // Text("${widget._place["end-date"]}".toString()),
                              Text(DateFormat.yMMMEd().format(widget._place["end-date"].toDate())),

                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Text("${widget._place["place"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                          ),

                          Text('${widget._place["short-description"]}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black.withOpacity(.4)
                          ),),
                          SizedBox(height: 15.h,),
                          Divider(
                            thickness: 2,
                          ),
                          Column(
                            children: [
                              Text('${widget._place["place-description"]}'),
                              SizedBox(height: 10.h,),
                            ],
                          ),
                          Container(
                            child: Column(
                              children: [
                               ProgramScreen()
                              ],
                            ),
                          ),

                          SizedBox(height: 10.h,),
                          TextButton(
                            onPressed: (){},
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red
                              ),

                              child: Center(
                                child: Text("Booked",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: Colors.white),),
                              ),
                            ),
                          ),



                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),]
        ),
      ),
    );
  }
}
