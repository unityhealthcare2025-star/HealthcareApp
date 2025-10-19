import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/api/loginApi.dart';
import 'package:healthcare/bottomNva.dart';
Future<bool> complaintApi(subject, description, int hospitalId) async {
  try {
    Response response = await dio.post('$baseurl/usersendComplaints/$loginid', data: {
      'Subject': subject,
      'Description': description,
          'HOSPITAL': hospitalId,  // 🔥 add this line

    });
    print(response.data);
    return response.statusCode == 200 || response.statusCode == 201;
  } catch (e) {
    print(e);
    return false;
  }
}
Future<Map<String, dynamic>> getComplaintsApi(BuildContext context) async {
  try {
    Response response = await dio.get('$baseurl/usersendComplaints/$loginid');
    print(response.data);

    if (response.statusCode == 200) {
      // response.data is a Map with keys 'complaints' and 'hos'
      final data = response.data as Map<String, dynamic>;
      return data;
    } else {
      return {};
    }
  } catch (e, stacktrace) {
    print('GetComplaints API error: $e');
    print(stacktrace);
    return {};
  }
}
