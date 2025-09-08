import 'dart:math';

import 'package:flutter/material.dart';

class Mybooking extends StatefulWidget {
  const Mybooking({super.key});

  @override
  State<Mybooking> createState() => _MybookingState();
}

class _MybookingState extends State<Mybooking> {
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
        ListView.builder(itemCount: 5,itemBuilder: (context, index) {
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
                        Text('Doctor :', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14),),
                        Container(
                          // height: 20,
                          // width: 50,
                          decoration: BoxDecoration(color: const Color.fromARGB(255, 44, 94, 46),
                          borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Pending', style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                
                    Text('date:', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14),),
                    Text('Time :', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14),),
         
              SizedBox(height: 5,),
                   GestureDetector(onTap: (){},
                     child: Container(
                            // height: 60,
                            // width: 100,
                            decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 8, 1),
                            borderRadius: BorderRadius.circular(6)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('View prescription', style: TextStyle(color: Colors.white),),
                            ),
                          ),
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