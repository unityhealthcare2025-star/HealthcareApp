import 'package:dio/dio.dart';
import 'package:healthcare/api/loginApi.dart';

Future<void> feedbackApi(DOCTOR,Rating,Comment)async{
  try {
     Response response=await dio.post('$baseurl/usersfeedback',data: {
      
    });
  } catch (e) {
    
  }
}