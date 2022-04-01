import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:traveltime3/ui/place_details_screen.dart';
import 'package:intl/intl.dart';
class DomesticScreen extends StatefulWidget {
  const DomesticScreen({Key? key}) : super(key: key);

  @override
  State<DomesticScreen> createState() => _DomesticScreenState();
}

class _DomesticScreenState extends State<DomesticScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Domestic Places',style: TextStyle(fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            ),),
        //centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('domestic')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading"),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(

                        children: snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                        return Card(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          elevation: 5,
                          child: Container(
                            height: 140.h,
                            width: double.infinity,
                            child: ListTile(

                              title: Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    Text(data['place'],style: TextStyle(
                                      fontWeight: FontWeight.bold,fontSize: 20.sp,
                                    ),),
                                    SizedBox(height: 5.h,),
                                    Text(data['short-description']),
                                    SizedBox(height: 5.h,),

                                    Row(
                                      children: [
                                        Text("\$${data['cost'].toString()}"),
                                        SizedBox(width: 10.w,),
                                        Text("${data['day'].toString()} Days"),



                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              leading:Expanded (
                                flex:5 ,
                                  child:Container(
                                    padding: EdgeInsets.only(top: 3),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(data['place-img'][0],fit: BoxFit.fill,),)),
                        ),
                              trailing: Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward,size: 30,),
                                  onPressed: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>PlaceDetailScreen(data)));
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
