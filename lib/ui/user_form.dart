import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:traveltime3/const/customButton.dart';
import 'package:traveltime3/const/myTextField.dart';
import 'package:traveltime3/ui/home_screen.dart';


class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  List<String> gender =['Male', 'Female', 'Other'];

  Future<void> _selectDateFromPicker (BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year),
      firstDate:  DateTime(DateTime.now().year-30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text= "${picked.day}/${picked.month}/${picked.year}";
      });
  }
  sendUserDataToDB()async{

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(currentUser!.email).set({
      "name":_nameController.text,
      "phone":_phoneController.text,
      "dob":_dobController.text,
      "gender":_genderController.text,
      "age":_ageController.text,
    }).then((value) => Navigator.push(context, MaterialPageRoute
      (builder: (_)=>HomeScreen()))).catchError((error)=>Fluttertoast.showToast(msg: "something is wrong. $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(


        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(

            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                Text('Submit the form to continue', style: TextStyle(
                  fontSize:24.sp,
                ),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14.sp,

                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                myTextField('Enter your Name', TextInputType.text, _nameController),
                SizedBox(height: 10.h,),
                myTextField('Enter your phone number', TextInputType.number, _phoneController),
                SizedBox(height: 10.h,),
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    ),
                    hintText: "Date of Birth",
                    suffixIcon: IconButton(
                      onPressed: ()=> _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 5.h,),
                TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    ),
                    hintText: "Choose your gender",
                    suffixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child:  Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                myTextField("Enter your age", TextInputType.number, _ageController),
                SizedBox(
                  height: 50.h,
                ),
                customButton("Continue", (){
                  sendUserDataToDB();
                })

              ],
            ),
          ),
        ),
      ),
    );
  }
}
