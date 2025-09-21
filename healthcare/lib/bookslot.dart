import 'package:flutter/material.dart';

class BookSlot extends StatefulWidget {
  final String doctorName;
  final String hospitalName;

  const BookSlot({
    super.key,
    required this.doctorName,
    required this.hospitalName,
  });

  @override
  _BookSlotState createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  // Mocked availability — replace with API call if needed
  final Map<String, List<String>> doctorAvailability = {
    'Ajay': ['2025-09-24', '2025-09-25'],
    'Dr. Adams': ['2025-09-26', '2025-09-27'],
    'Dr. Jane': ['2025-09-28', '2025-09-29'],
    'Dr. Brian': ['2025-09-30', '2025-10-01'],
  };

  final List<String> timeSlots = ['10:00 AM', '11:00 AM', '02:00 PM', '04:00 PM'];

  String? selectedDate;
  String? selectedTime;
  List<String> availableDates = [];

  @override
  void initState() {
    super.initState();

    // Preload available dates for this doctor
    availableDates = doctorAvailability[widget.doctorName] ?? [];
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Display doctor and hospital info
            Text("Hospital: ${widget.hospitalName}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 6),
            Text("Doctor: ${widget.doctorName}", style: TextStyle(fontSize: 16)),
            Divider(height: 32),

            /// Select Date
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

            /// Select Time
            if (selectedDate != null) ...[
              Text("Select Time:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
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

            SizedBox(height: 32),

            /// Book Slot Button
            if (selectedDate != null && selectedTime != null)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 188, 103, 222),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
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
