
import 'package:mediconnect/screens/doctor_screens/NextPatientpage/procedtoprescription.dart';
import 'package:mediconnect/screens/doctor_screens/homepage/line.dart';

import 'call.dart';
// import 'package:doctor/NextPatientpage/procedtoprescription.dart';
// import 'package:doctor/homepage/line.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NextPatient extends StatelessWidget {
  const NextPatient({super.key});

  // Simulate fetching data from the backend
  Future<Map<String, dynamic>> fetchPatientData() async {
    final response = await http.get(
      Uri.parse('https://api.example.com/patient_data'), // sample URL
    );

    if (response.statusCode == 200) {
      // Parse the JSON data
      final data = json.decode(response.body);
      return {
        "name": data['name'],
        "age": data['age'],
        "disease": data['disease'],
        "condition": data['condition'],
        "imageUrl": data['imageUrl'],
      };
    } else {
      // Handle errors with fallback data
      throw Exception('Failed to load patient data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchPatientData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Next Patient",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          } else if (snapshot.hasError) {

///////////////////////////// This part is actual code //////////////////////////////////////////////
            return Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Next Patient",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                   SizedBox(height: 100,),
                   Center(child: 
                   Text("Page loading Error", style:TextStyle( fontSize:16))),
                ]));
/////////////////////////////////////////////////////////////////////////////////////////////////////////    


/////////////////////////////////////////// This part Use for test by own ///////////////////////////////////////////////// 

            // const name = "Mr. Bandara" ;
            // const age = '37';
            // const disease ='Fever with Vomiting' ;
            // const condition='Gastrric';
            // const imageUrl = 'https://exampleeeee.com';
            // return Container(
            //   padding: const EdgeInsets.only(left: 10),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         "Next Patient",
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            //       ),
            //       Row(
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.all(2),
            //             child: Image.network(
            //               imageUrl,
            //               height: 120,
            //               width: 120,
            //               fit: BoxFit.cover,
            //               errorBuilder: (context, error, stackTrace) {
            //                 // Show a default icon if image fails to load
            //                 return const Icon(
            //                   Icons.person,
            //                   size: 120,
            //                   color: Colors.grey,
            //                 );
            //               },
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.only(bottom:30),
            //             child: const Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   'Name: $name',
            //                   style: TextStyle(
            //                       fontSize: 16, fontWeight: FontWeight.bold),
            //                 ),
            //                 Text(
            //                   'Age: $age yrs',
            //                   style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
            //                 ),
            //                 Text(
            //                   'Disease: $disease',
            //                   style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
            //                 ),
            //                 Text(
            //                   'Prior/Present condition: $condition',
            //                   style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 40),
            //       Container(
            //         padding: const EdgeInsets.only(left:100 ),
            //         child:  call()),
                    
            //       const SizedBox(height: 20),
            //       Container(
            //         padding: const EdgeInsets.only(left:60 ),
            //         child:
            //       line(Colors.grey, 200, 5),),
            //       const SizedBox(height: 20),

            //       Container(
            //         padding: const EdgeInsets.only(left:10 ),
            //         child:procced(),),
            //     ],
            //   ),
            // );

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          } else if (snapshot.hasData) {
            final patientData = snapshot.data!;
            final name = patientData['name'];
            final age = patientData['age'];
            final disease = patientData['disease'];
            final condition=patientData['condition'];
            final imageUrl = patientData['imageUrl'];

            return Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Next Patient",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: Image.network(
                          imageUrl,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Show a default icon if image fails to load
                            return const Icon(
                              Icons.person,
                              size: 120,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: $name',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Age: $age yrs',
                              style: const TextStyle(fontSize: 10),
                            ),
                            Text(
                              'Disease: $disease',
                              style: const TextStyle(fontSize: 10),
                            ),
                            Text(
                              'prior/present condition: $condition',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.only(left:100 ),
                    child:  call()),
                    
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left:60 ),
                    child:
                  line(Colors.grey, 200, 5),),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.only(left:10 ),
                    child:procced(),),
                ],
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(left: 0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Next Patient",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Center(child: Text("No Patients")),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
