
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/bottomNva.dart';

Dio dio=Dio();
int? loginid ;
final baseurl= 'http://192.168.1.137:5000';
Future<void> loginApi(username,password,context)async{
  try {
    Response response= await dio.post('$baseurl/userlogin', data: { 'Username':username,'Password': password});
    print(response.data);
    loginid=response.data['userid'];
    if (response.statusCode==200 || response.statusCode == 201) {
      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bottomnav()),
                    );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid credentials"), duration: Duration(seconds: 3),));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid credentials"), duration: Duration(seconds: 3),));
    
  }
}