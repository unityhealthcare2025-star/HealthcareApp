import 'package:dio/dio.dart';
import 'package:healthcare/api/loginApi.dart';


  final Dio _dio = Dio();

  Future<void> bookAppointment({
    required int userId,
    required int doctorId,
    required String date,      // format: "2025-10-24"
    required String time,      // format: "10:00 AM" or "14:00"
    required double amount,
  }) async {
    final url = '$baseurl/''/$userId/';
    final dateTime = DateTime.parse('$date ${_convertTo24Hr(time)}');

    try {
      final response = await _dio.post(
        url,
        data: {
          "DOCTOR": doctorId,
          "Booking_date": date,
          "Booking_time": dateTime.toIso8601String(), // required format
          "Payment_mode": "Cash",
          "Amount": amount,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // Add token if needed: 'Authorization': 'Bearer your_token'
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("Booking successful: ${response.data}");
      } else {
        print("Failed to book: ${response.data}");
      }
    } catch (e) {
      print("Booking error: $e");
      rethrow;
    }
  }

  /// Helper to convert AM/PM to 24hr format (Django expects 24h time)
  String _convertTo24Hr(String time) {
    final timeParts = time.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    final minute = int.parse(hourMinute[1]);

    if (timeParts[1].toUpperCase() == 'PM' && hour != 12) {
      hour += 12;
    } else if (timeParts[1].toUpperCase() == 'AM' && hour == 12) {
      hour = 0;
    }

    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

