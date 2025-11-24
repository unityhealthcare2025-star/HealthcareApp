import 'package:dio/dio.dart';
import 'package:healthcare/api/loginApi.dart';

final Dio _dio = Dio();

Future<void> bookAppointment({
  required int userId,
  required int doctorId,
  required String date,
  required String time,
  required double amount,
}) async {
  final url = '$baseurl/''/$loginid/';
  final dateTime = DateTime.parse('$date ${_convertTo24Hr(time)}');

   try{
    final response = await _dio.post(
      url,
      data: {
        "DOCTOR": doctorId,
        "Booking_date": date,
        "Booking_time": dateTime.toIso8601String(),
        "Payment_mode": "Cash",
        "Amount": amount,

      },
      options: Options(
        headers: {
          'content-Type': 'application/json',

        },
      ),
    );
    if (response.statusCode == 201 || response.statusCode == 200){
      print("Booking succesful: ${response.data}");

    }
    else{
      print("Failed to book: ${response.data}");
    }
   }catch (e) {
    print("Booking error: $e");
    rethrow;
   }
}
String _convertTo24Hr(String time) {
  final timeparts = time.split(' ');
  final hourMinute = timeparts[0].split(':');
  int hour = int.parse(hourMinute[0]);
  final minute = int.parse(hourMinute[1]);

  if(timeparts[1].toUpperCase() == 'PM' && hour != 12){
    hour += 12;
  } else if(timeparts[1].toUpperCase() == 'AM' && hour == 12){
    hour = 0;
  }
 return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2,'0')}';
}