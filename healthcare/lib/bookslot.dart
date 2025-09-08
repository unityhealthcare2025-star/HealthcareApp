import 'package:flutter/material.dart';


class BookSlot extends StatefulWidget {
  @override
  _BookSlotState createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  // Sample data
  Map<String, List<String>> hospitalDoctorMap = {
    'City Hospital': ['Dr. Smith', 'Dr. Adams'],
    'Green Clinic': ['Dr. Jane', 'Dr. Brian'],
  };

  Map<String, List<String>> doctorAvailability = {
    'Dr. Smith': ['2025-09-04', '2025-09-06'],
    'Dr. Adams': ['2025-09-05', '2025-09-07'],
    'Dr. Jane': ['2025-09-03', '2025-09-04'],
    'Dr. Brian': ['2025-09-06', '2025-09-08'],
  };

  List<String> timeSlots = ['10:00 AM', '11:00 AM', '02:00 PM', '04:00 PM'];

  String? selectedHospital;
  String? selectedDoctor;
  String? selectedDate;
  String? selectedTime;

  List<String> doctors = [];
  List<String> availableDates = [];

  bool showSlots = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book a Doctor Slot",style: TextStyle(color: Colors.white)),
       centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 195, 96, 241),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Hospital Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Select Hospital", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              value: selectedHospital,
              items: hospitalDoctorMap.keys
                  .map((hospital) => DropdownMenuItem(
                        value: hospital,
                        child: Text(hospital),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedHospital = value;
                  doctors = hospitalDoctorMap[value]!;
                  selectedDoctor = null;
                  showSlots = false;
                });
              },
            ),

            SizedBox(height: 16),

            /// Doctor Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Select Doctor",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              value: selectedDoctor,
              items: doctors
                  .map((doctor) => DropdownMenuItem(
                        value: doctor,
                        child: Text(doctor),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDoctor = value;
                  selectedDate = null;
                  selectedTime = null;
                });
              },
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                if (selectedDoctor != null) {
                  setState(() {
                    availableDates = doctorAvailability[selectedDoctor!]!;
                    showSlots = true;
                  });
                }
              },
              child: Text("Show"),
            ),

            SizedBox(height: 20),

            /// Show Date and Time Slots
            if (showSlots && availableDates.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Date:"),
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
                  SizedBox(height: 20),
                  if (selectedDate != null) ...[
                    Text("Select Time:"),
                    Wrap(
                      spacing: 8.0,
                      children: timeSlots.map((time) {
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
                  SizedBox(height: 20),
                  if (selectedDate != null && selectedTime != null)
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Confirm Booking"),
                            content: Text(
                                "You have booked an appointment with $selectedDoctor at $selectedTime on $selectedDate."),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"))
                            ],
                          ),
                        );
                      },
                      child: Text("Book Slot"),
                    )
                ],
              )
          ],
        ),
      ),
    );
  }
}
