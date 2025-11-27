import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/DoctorfeedbackRating.dart';
import 'package:healthcare/api/loginApi.dart';
import 'package:healthcare/viewprescription.dart';

class Mybooking extends StatefulWidget {
  const Mybooking({super.key});

  @override
  State<Mybooking> createState() => _MybookingState();
}

class _MybookingState extends State<Mybooking> {
  bool _isLoading = true;

  
  List<Map<String,dynamic>> bookings = [];
  Future<void> fetchbookings() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await dio.get('$baseurl/BookingHistory/$loginid');
      print("Booking API Response: ${response.data}");

      if (response.statusCode == 200){
        final List<dynamic>data = response.data;
        bookings = data.map((e) => Map<String,dynamic>.from(e)).toList();

      } else {
        throw Exception("Failed to load bookings");

      }
    } catch (e) {
      print("Error fetching bookings: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error loading bookings: $e"),
          backgroundColor: Colors.red.shade400,

        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    fetchbookings();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Booking',style: TextStyle(color: Colors.white),
       ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 188, 103, 222),
        ),
        body: 
        ListView.builder(itemCount: bookings.length,itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: const Color.fromARGB(255, 162, 172, 177)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Doctor :${bookings[index]['doctor_name']}', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14),),
                        Container(
                          // height: 20,
                          // width: 50,
                          decoration: BoxDecoration(color: const Color.fromARGB(255, 44, 94, 46),
                          borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(bookings[index]['Status'], style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                
                    Text('date:${bookings[index]['Booking_date']}', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14),),
                    Text('Time: ${bookings[index]['Start_Time']} - ${bookings[index]['End_Time']}', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14),),
         
              SizedBox(height: 5,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       GestureDetector(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PrescriptionPage(bookingId: bookings[index]['id'],),));
                       },
                         child: Container(
                                // height: 60,
                                // width: 100,
                                decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 5, 0),
                                borderRadius: BorderRadius.circular(6)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('View prescription', style: TextStyle(color: Colors.white),),
                                ),
                              ),
                       ),
                       GestureDetector(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorFeedbackRating(doctorid: bookings[index]['doctor_id'],),));
                       },
                         child: Container(
                                // height: 60,
                                // width: 100,
                                decoration: BoxDecoration(color: const Color.fromARGB(255, 218, 181, 62),
                                borderRadius: BorderRadius.circular(6)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Add review', style: TextStyle(color: Colors.white),),
                                ),
                              ),
                       ),
                     ],
                   )
                  ],
                ),
              ),
            ),
          );
          
        },)
    );
  }
}