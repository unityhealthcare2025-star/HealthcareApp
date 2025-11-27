import 'package:healthcare/api/loginApi.dart';
Future<Map<String, dynamic>> fetchprofile() async {
  try {
    final response = await dio.get('$baseurl/ProfileView/$loginid');
    print("Profile API Response: ${response.data}");

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Failed to load profile");
    }
  } catch (e) {
    print("Error fetching profile: $e");
    return {}; // return empty only on error
  }
}
