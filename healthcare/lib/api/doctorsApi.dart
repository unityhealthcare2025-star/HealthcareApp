import 'package:healthcare/api/loginApi.dart';

Future<List<Map<String, dynamic>>> fetchDoctorsByHospital(int hospitalId) async {
  try {
    final response = await dio.get('$baseurl/doctors-by-hospital/$hospitalId');
    print(response.data);
    if (response.statusCode == 200) {
      final List data = response.data['doctors'];
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  } catch (e) {
    throw Exception('Error fetching doctors: $e');
  }}