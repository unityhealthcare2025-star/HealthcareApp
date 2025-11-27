import 'package:flutter/material.dart';
import 'package:healthcare/ChangePassword.dart';
import 'package:healthcare/DoctorfeedbackRating.dart';
import 'package:healthcare/MyBooking.dart';
import 'package:healthcare/SendComplaint.dart';
import 'package:healthcare/EditProfile.dart';
import 'package:healthcare/ViewHospitals.dart';

import 'package:healthcare/bookslot.dart';
import 'package:healthcare/bottomNva.dart';
import 'package:healthcare/MyProfile.dart';
import 'package:healthcare/homePage.dart';
import 'package:healthcare/login.dart';
import 'package:healthcare/register.dart';
import 'package:healthcare/viewDoctors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  LoginPage(),
    );
  }
}
