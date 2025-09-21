import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/api/loginApi.dart';
import 'package:healthcare/bottomNva.dart';

Future<void> complaintApi(userid,subject,description)async{
   try {
  
    Response response=await dio.post('$baseurl/usersendComplaints',data: {
      
    });
    print(response.data);
   
  } catch (e) {
    print(e);
  }
}