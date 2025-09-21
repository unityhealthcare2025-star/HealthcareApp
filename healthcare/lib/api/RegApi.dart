import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/api/loginApi.dart';
import 'package:healthcare/login.dart';

Future<void> RegApi(data,context)async{
  try {
  
    Response response=await dio.post('$baseurl/UserRegApiView',data: data);
    print(response.data);
    if (response.statusCode==200) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  } catch (e) {
    print(e);
  }
}