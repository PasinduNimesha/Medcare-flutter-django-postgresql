// import 'package:doctor/homepage/addtodaysplanbutton.dart';
// import 'package:doctor/homepage/nextpatent.dart';
// import 'package:doctor/homepage/todaytaskcontainer.dart';
import 'package:flutter/material.dart';
import 'package:mediconnect/screens/doctor_screens/homepage/addtodaysplanbutton.dart';
import 'package:mediconnect/screens/doctor_screens/homepage/nextpatent.dart';
import 'package:mediconnect/screens/doctor_screens/homepage/todaytaskcontainer.dart';
import 'elevatedbutton.dart';
import 'viewdrop.dart';
import 'confrimbutton.dart';
import 'available.dart';
import 'line.dart';
import 'numofpatient.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: prefer_final_fields
  String _currentLocation = "maharagama"; // Ensure this is set to a valid initial value if needed

  void _updateLocation(String? newLocation) { //for confrim pre-planed buttton in top wigit
    setState(() {
      _currentLocation = newLocation ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(   // set title bar "Home"
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(   // add all things in on scroll 
        padding: const EdgeInsets.only(top: 0, left: 16.0, right: 18.0),
        child: Column(  // main child column
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hello\nDr. Smith",  // its's changed when api using  name of the doctor
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 1),
              ),
            ),
            Row(
              children: [
                elevationbutton("Overview"), // overview button
                const SizedBox(width: 6.0),
                elevationbutton("Productivity"), // productivity button
              ],
            ),
            const SizedBox(height: 10,), //this use for spacing
            Container(  //start shadow box widgit
              padding: const EdgeInsets.only(top:10,left:30 ,right: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child:Center(child: 
               Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "I'm now in ",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                      ),
                      const SizedBox(width:6 ,),
                      MyDropdownButton(initialLocation: _currentLocation,
                      onChanged: _updateLocation,
                      ),
                    ],
                  ),
                  Row(
                         children: [
                  const SizedBox(width: 150,), 
                      confrim(_currentLocation),
        ],
      ),
                ],
              ),
              ),
            ),
            const SizedBox(height: 10,),
            available(),
            const SizedBox(height: 10,),
            line(Colors.grey, 200.0, 5.0),
            const SizedBox(height: 10,),
            const Nextpatent(),
             const SizedBox(height: 5,),
            numberofpatient(),
            const SizedBox(height: 0),
            line(Colors.black, 400.0, 8.0),
            const SizedBox(height: 5,),
            const Align(
                alignment: Alignment.centerLeft, // Aligns to the left
                       child: Text(
                 "Today's Plan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                           fontSize: 20,
                          ),
                                ),
                          ),
            const TodayTaskContainer(confirmButtonStatus:false),
            const AddTodaysTask(),
          ],
        ),
      ),
    );
  }
}
