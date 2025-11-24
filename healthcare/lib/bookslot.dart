import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:healthcare/api/loginApi.dart';

class BookSlot extends StatefulWidget {
  final String doctorName;
  final String hospitalName;
  final int doctorId;

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

  List<Map<String, dynamic>> rawSlots = []; // Raw response data

  DateTime? selectedDate;
  String? selectedTime;
  int? selectedSlotId;

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

      final response = await _dio.get('$baseurl/availability/${widget.doctorId}');
      print("SLOTS: ${response.data}");

      if (response.statusCode == 200) {
        rawSlots = List<Map<String, dynamic>>.from(response.data);

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching slots: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Filter slots based on selected date’s weekday
  List<Map<String, dynamic>> getSlotsForSelectedDate() {
    if (selectedDate == null) return [];

    int weekday = selectedDate!.weekday; // 1=Mon ... 7=Sun

    return rawSlots.where((slot) {
      int slotDay;

      if (slot["Day_of_week"] is int) {
        slotDay = slot["Day_of_week"];
      } else {
        const dayMap = {
          "monday": 1,
          "tuesday": 2,
          "wednesday": 3,
          "thursday": 4,
          "friday": 5,
          "saturday": 6,
          "sunday": 7,
        };
        slotDay = dayMap[slot["Day_of_week"].toString().toLowerCase()] ?? 1;
      }

      return slotDay == weekday;
    }).map((slot) {
      return {
        "time": "${slot['Start_Time']} - ${slot['End_Time']}",
        "id": slot["id"],
      };
    }).toList();
  }

  /// BOOK APPOINTMENT API
  Future<void> bookslot() async {
    if (selectedSlotId == null || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select date and time")),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final response = await _dio.post(
        '$baseurl/bookdoctor/$loginid',
        data: {
          "SCHEDULEID": selectedSlotId,
          "Booking_date": DateFormat('yyyy-MM-dd').format(selectedDate!),
        },
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: Text("Booking Confirmed!"),
            content: Text(
              "You booked an appointment with ${widget.doctorName} on "
              "${DateFormat('EEEE, MMM dd, yyyy').format(selectedDate!)} "
              "at $selectedTime.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Done"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print("BOOKING ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to book slot"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hospital: ${widget.hospitalName}", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 6),
                  Text("Doctor: ${widget.doctorName}", style: TextStyle(fontSize: 16)),
                  Divider(height: 32),

                  /// DATE PICKER BUTTON
                  Text("Select Date:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 60)),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                          selectedTime = null;
                          selectedSlotId = null;
                        });
                      }
                    },
                    child: Text(
                      selectedDate == null
                          ? "Choose a Date"
                          : DateFormat('yyyy-MM-dd').format(selectedDate!),
                    ),
                  ),

                  SizedBox(height: 24),

                  /// SHOW TIME SLOTS ONLY WHEN DATE IS SELECTED
                  if (selectedDate != null) ...[
                    Text("Select Time:",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    Builder(
                      builder: (_) {
                        final slots = getSlotsForSelectedDate();

                        if (slots.isEmpty) {
                          return Text("No slots available for this day.",
                              style: TextStyle(color: Colors.red));
                        }

                        return Wrap(
                          spacing: 8.0,
                          children: slots.map((slot) {
                            return ChoiceChip(
                              label: Text(slot["time"]),
                              selected: selectedTime == slot["time"],
                              onSelected: (_) {
                                setState(() {
                                  selectedTime = slot["time"];
                                  selectedSlotId = slot["id"];
                                });
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],

                  SizedBox(height: 32),

                  if (selectedDate != null && selectedTime != null)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        onPressed: bookslot,
                        child: Text("Book Slot", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
