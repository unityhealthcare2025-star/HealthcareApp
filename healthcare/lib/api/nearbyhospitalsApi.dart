import 'package:healthcare/api/loginApi.dart';

Future<List<Map<String, dynamic>>> fetchNearbyHospitals(double lat, double lon) async {
    try {
      final response = await dio.get(
        '$baseurl/nearby-hospitals',
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
        
        },
      );
      print(response.data);

      if (response.statusCode == 200) {
        final List data = response.data['hospitals'];
        return data.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load hospitals');
      }
    } catch (e) {
      throw Exception('Error fetching hospitals: $e');
    }
  }