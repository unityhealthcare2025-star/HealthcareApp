import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:healthcare/api/loginApi.dart';

class BookSlot extends StatefulWidget {
  final String doctorName;
  final String hospitalName;
  final int doctorId; // Assuming you pass doctor ID to query API

  const BookSlot({
    super.key,
    required this.doctorName,
    required this.hospitalName,
    required this.doctorId,
  });

  @override
  _BookSlotState createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  final Dio _dio = Dio();

  bool _isLoading = true;
  List<String> availableDates = [];
  Map<String, List<String>> availableTimeSlots = {}; // Map<Date, List<Time>>

  String? selectedDate;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    fetchAvailableSlots();
  }

  Future<void> fetchAvailableSlots() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Example API URL — replace with your actual endpoint
      final response = await _dio.get(
        '$baseurl/availability/${widget.doctorId}',
      );print(response.data);

      if (response.statusCode == 200) {
        // Expecting response data format like:
        // {
        //   "dates": ["2025-10-24", "2025-10-25"],
        //   "slots": {
        //     "2025-10-24": ["10:00 AM", "11:00 AM"],
        //     "2025-10-25": ["02:00 PM", "04:00 PM"]
        //   }
        // }
        final data = response.data;
        setState(() {
          availableDates = List<String>.from(data['dates']);
          availableTimeSlots = Map<String, List<String>>.from(
            data['slots'].map((key, value) => MapEntry(key, List<String>.from(value))),
          );
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load availability');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // You can handle errors here (show SnackBar, dialog etc.)
      print('Error fetching slots: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Appointment", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 195, 96, 241),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hospital: ${widget.hospitalName}", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  Text("Doctor: ${widget.doctorName}", style: TextStyle(fontSize: 16)),
                  Divider(height: 32),

                  Text("Select Date:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),

                  if (availableDates.isEmpty)
                    Text("No available dates for this doctor.", style: TextStyle(color: Colors.red)),
                  if (availableDates.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      children: availableDates.map((date) {
                        return ChoiceChip(
                          label: Text(date),
                          selected: selectedDate == date,
                          onSelected: (_) {
                            setState(() {
                              selectedDate = date;
                              selectedTime = null;
                            });
                          },
                        );
                      }).toList(),
                    ),

                  SizedBox(height: 24),

                  if (selectedDate != null) ...[
                    Text("Select Time:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: (availableTimeSlots[selectedDate] ?? []).map((time) {
                        return ChoiceChip(
                          label: Text(time),
                          selected: selectedTime == time,
                          onSelected: (_) {
                            setState(() {
                              selectedTime = time;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],

                  SizedBox(height: 32),

                  if (selectedDate != null && selectedTime != null)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 188, 103, 222),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          // TODO: call booking API here
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Confirm Booking"),
                              content: Text(
                                "You have booked an appointment with ${widget.doctorName} "
                                "at $selectedTime on $selectedDate.",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // close dialog
                                    Navigator.pop(context); // return to previous page
                                  },
                                  child: Text("OK"),
                                )
                              ],
                            ),
                          );
                        },
                        child: Text("Book Slot"),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
