import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveltime3/ui/search_screen.dart';


class ProgramScreen extends StatefulWidget {
  const ProgramScreen({Key? key}) : super(key: key);

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  List _places = [];
  List _places2 =[];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchDomesticPlaces()async {
    QuerySnapshot qn = await _firestoreInstance.collection("domestic").get();

    setState(() {

      for (int i = 0; i < qn.docs.length; i++) {
        _places.add({
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
  @override
  void initState() {
    // TODO: implement initState
    fetchDomesticPlaces();
    fetchInternationalPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column (
      children: [

        Row(
          children: [
            Text('Program',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
            SizedBox(width: 150,),
            Text("Day 1 of ${_places.length-1}"),
          ],

        ),
        Divider(),
        Container(

            width: double.infinity,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(_places[1]["place-img"][0].toString(),))),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Text("Day 1",style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(width: 40.w,),
            Text('Sunday,2 April'),
            SizedBox(width: 20.w,),
            Text("9.00-12.00"),
            
          ],
        ),
        SizedBox(height: 20.h,),
        Text("${_places[1]['place-description'][2]}")

      ],
    );
  }
}
