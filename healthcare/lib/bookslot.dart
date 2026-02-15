// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:intl/intl.dart';
// import 'package:healthcare/api/loginApi.dart';

// class BookSlot extends StatefulWidget {
//   final String doctorName;
//   final String hospitalName;
//   final int doctorId;

//   const BookSlot({
//     super.key,
//     required this.doctorName,
//     required this.hospitalName,
//     required this.doctorId,
//   });

//   @override
//   _BookSlotState createState() => _BookSlotState();
// }

// class _BookSlotState extends State<BookSlot> {
//   final Dio _dio = Dio();

//   bool _isLoading = true;

//   List<Map<String, dynamic>> rawSlots = []; // Raw response data

//   DateTime? selectedDate;
//   String? selectedTime;
//   int? selectedSlotId;

//   @override
//   void initState() {
//     super.initState();
//     fetchAvailableSlots();
//   }

//   Future<void> fetchAvailableSlots() async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });

//       final response = await _dio.get('$baseurl/availability/${widget.doctorId}');
//       print("SLOTS: ${response.data}");

//       if (response.statusCode == 200) {
//         rawSlots = List<Map<String, dynamic>>.from(response.data);

//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching slots: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   /// Filter slots based on selected date’s weekday
//   List<Map<String, dynamic>> getSlotsForSelectedDate() {
//     if (selectedDate == null) return [];

//     int weekday = selectedDate!.weekday; // 1=Mon ... 7=Sun

//     return rawSlots.where((slot) {
//       int slotDay;

//       if (slot["Day_of_week"] is int) {
//         slotDay = slot["Day_of_week"];
//       } else {
//         const dayMap = {
//           "monday": 1,
//           "tuesday": 2,
//           "wednesday": 3,
//           "thursday": 4,
//           "friday": 5,
//           "saturday": 6,
//           "sunday": 7,
//         };
//         slotDay = dayMap[slot["Day_of_week"].toString().toLowerCase()] ?? 1;
//       }

//       return slotDay == weekday;
//     }).map((slot) {
//       return {
//         "time": "${slot['Start_Time']} - ${slot['End_Time']}",
//         "id": slot["id"],
//       };
//     }).toList();
//   }

//   /// BOOK APPOINTMENT API
//   Future<void> bookslot() async {
//     if (selectedSlotId == null || selectedDate == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please select date and time")),
//       );
//       return;
//     }

//     try {
//       setState(() {
//         _isLoading = true;
//       });

//       final response = await _dio.post(
//         '$baseurl/bookdoctor/$loginid',
//         data: {
//           "SCHEDULEID": selectedSlotId,
//           "Booking_date": DateFormat('yyyy-MM-dd').format(selectedDate!),
//         },
//       );

//       if (response.statusCode == 200) {
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (_) => AlertDialog(
//             title: Text("Booking Confirmed!"),
//             content: Text(
//               "You booked an appointment with ${widget.doctorName} on "
//               "${DateFormat('EEEE, MMM dd, yyyy').format(selectedDate!)} "
//               "at $selectedTime.",
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 },
//                 child: Text("Done"),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print("BOOKING ERROR: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Failed to book slot"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Book Appointment", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Hospital: ${widget.hospitalName}", style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 6),
//                   Text("Doctor: ${widget.doctorName}", style: TextStyle(fontSize: 16)),
//                   Divider(height: 32),

//                   /// DATE PICKER BUTTON
//                   Text("Select Date:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 12),
//                   ElevatedButton(
//                     onPressed: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime.now().add(Duration(days: 60)),
//                       );

//                       if (pickedDate != null) {
//                         setState(() {
//                           selectedDate = pickedDate;
//                           selectedTime = null;
//                           selectedSlotId = null;
//                         });
//                       }
//                     },
//                     child: Text(
//                       selectedDate == null
//                           ? "Choose a Date"
//                           : DateFormat('yyyy-MM-dd').format(selectedDate!),
//                     ),
//                   ),

//                   SizedBox(height: 24),

//                   /// SHOW TIME SLOTS ONLY WHEN DATE IS SELECTED
//                   if (selectedDate != null) ...[
//                     Text("Select Time:",
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     SizedBox(height: 10),

//                     Builder(
//                       builder: (_) {
//                         final slots = getSlotsForSelectedDate();

//                         if (slots.isEmpty) {
//                           return Text("No slots available for this day.",
//                               style: TextStyle(color: Colors.red));
//                         }

//                         return Wrap(
//                           spacing: 8.0,
//                           children: slots.map((slot) {
//                             return ChoiceChip(
//                               label: Text(slot["time"]),
//                               selected: selectedTime == slot["time"],
//                               onSelected: (_) {
//                                 setState(() {
//                                   selectedTime = slot["time"];
//                                   selectedSlotId = slot["id"];
//                                 });
//                               },
//                             );
//                           }).toList(),
//                         );
//                       },
//                     ),
//                   ],

//                   SizedBox(height: 32),

//                   if (selectedDate != null && selectedTime != null)
//                     Center(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                           padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                         ),
//                         onPressed: bookslot,
//                         child: Text("Book Slot", style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
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

  /// Filter slots based on selected date's weekday
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
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              const Expanded(child: Text("Please select date and time")),
            ],
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                const SizedBox(width: 8),
                const Text(
                  "Booking Confirmed!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildDialogInfoRow(
                  icon: Icons.person,
                  label: "Doctor",
                  value: widget.doctorName,
                ),
                const SizedBox(height: 8),
                _buildDialogInfoRow(
                  icon: Icons.calendar_today,
                  label: "Date",
                  value: DateFormat('EEEE, MMM dd, yyyy').format(selectedDate!),
                ),
                const SizedBox(height: 8),
                _buildDialogInfoRow(
                  icon: Icons.access_time,
                  label: "Time",
                  value: selectedTime ?? "",
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF6C5CE7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print("BOOKING ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text("Failed to book slot")),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildDialogInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF6C5CE7).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: const Color(0xFF6C5CE7)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              children: [
                TextSpan(
                  text: "$label: ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Appointment",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color(0xFF6C5CE7).withOpacity(0.05),
            ],
          ),
        ),
        child: _isLoading
            ? _buildLoadingWidget()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor & Hospital Info Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C5CE7).withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6C5CE7).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.local_hospital,
                                  color: Color(0xFF6C5CE7),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hospital",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Text(
                                      widget.hospitalName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6C5CE7).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.person_outline,
                                  color: Color(0xFF6C5CE7),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Doctor",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Text(
                                      widget.doctorName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),

                    /// Date Selection Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C5CE7).withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.calendar_today, color: Color(0xFF6C5CE7), size: 20),
                              SizedBox(width: 8),
                              Text(
                                "Select Date",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C5CE7),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 60)),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: const Color(0xFF6C5CE7),
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(0xFF6C5CE7),
                                      ),
                                      buttonTheme: const ButtonThemeData(
                                        textTheme: ButtonTextTheme.primary,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                setState(() {
                                  selectedDate = pickedDate;
                                  selectedTime = null;
                                  selectedSlotId = null;
                                });
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: selectedDate != null 
                                      ? const Color(0xFF6C5CE7) 
                                      : Colors.grey.shade300,
                                  width: selectedDate != null ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.event,
                                    color: selectedDate != null 
                                        ? const Color(0xFF6C5CE7) 
                                        : Colors.grey.shade400,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      selectedDate == null
                                          ? "Choose appointment date"
                                          : DateFormat('EEEE, MMMM dd, yyyy').format(selectedDate!),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: selectedDate != null 
                                            ? Colors.black87 
                                            : Colors.grey.shade600,
                                        fontWeight: selectedDate != null 
                                            ? FontWeight.w500 
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF6C5CE7),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Time Slots Section
                    if (selectedDate != null) ...[
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C5CE7).withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.access_time, color: Color(0xFF6C5CE7), size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "Available Time Slots",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6C5CE7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            Builder(
                              builder: (_) {
                                final slots = getSlotsForSelectedDate();

                                if (slots.isEmpty) {
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.red.shade200,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.info_outline, color: Colors.red.shade400),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            "No slots available for this day.",
                                            style: TextStyle(
                                              color: Colors.red.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: slots.map((slot) {
                                    bool isSelected = selectedTime == slot["time"];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedTime = slot["time"];
                                          selectedSlotId = slot["id"];
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected 
                                              ? const Color(0xFF6C5CE7) 
                                              : Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                            color: isSelected 
                                                ? const Color(0xFF6C5CE7) 
                                                : Colors.grey.shade300,
                                            width: isSelected ? 2 : 1,
                                          ),
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                    color: const Color(0xFF6C5CE7).withOpacity(0.3),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 2),
                                                  )
                                                ]
                                              : null,
                                        ),
                                        child: Text(
                                          slot["time"],
                                          style: TextStyle(
                                            color: isSelected 
                                                ? Colors.white 
                                                : Colors.grey.shade700,
                                            fontWeight: isSelected 
                                                ? FontWeight.bold 
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    /// Book Button
                    if (selectedDate != null && selectedTime != null)
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C5CE7),
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shadowColor: const Color(0xFF6C5CE7).withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: bookslot,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_outline),
                                SizedBox(width: 8),
                                Text(
                                  "Confirm Booking",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C5CE7)),
                strokeWidth: 3,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Loading Available Slots...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we fetch doctor availability',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
