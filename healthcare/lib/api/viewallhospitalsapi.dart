import 'dart:convert';
import 'package:healthcare/api/loginApi.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchAllHospitals() async {
  final response = await http.get(
    Uri.parse("$baseurl/allhospitals"),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['hospitals']);
  } else {
    throw Exception('Failed to load hospitals');
  }
}
