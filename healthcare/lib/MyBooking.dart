// import 'dart:math';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:healthcare/DoctorfeedbackRating.dart';
// import 'package:healthcare/api/loginApi.dart';
// import 'package:healthcare/viewprescription.dart';

// class Mybooking extends StatefulWidget {
//   const Mybooking({super.key});

//   @override
//   State<Mybooking> createState() => _MybookingState();
// }

// class _MybookingState extends State<Mybooking> {
//   bool _isLoading = true;

  
//   List<Map<String,dynamic>> bookings = [];
//   Future<void> fetchbookings() async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       final response = await dio.get('$baseurl/BookingHistory/$loginid');
//       print("Booking API Response: ${response.data}");

//       if (response.statusCode == 200){
//         final List<dynamic>data = response.data;
//         bookings = data.map((e) => Map<String,dynamic>.from(e)).toList();

//       } else {
//         throw Exception("Failed to load bookings");

//       }
//     } catch (e) {
//       print("Error fetching bookings: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Error loading bookings: $e"),
//           backgroundColor: Colors.red.shade400,

//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     fetchbookings();
//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Booking',style: TextStyle(color: Colors.white),
//        ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 188, 103, 222),
//         ),
//         body: 
//         ListView.builder(itemCount: bookings.length,itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Container(
//               decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: const Color.fromARGB(255, 162, 172, 177)),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
                    
//                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Doctor :${bookings[index]['doctor_name']}', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14),),
//                         Container(
//                           // height: 20,
//                           // width: 50,
//                           decoration: BoxDecoration(color: const Color.fromARGB(255, 44, 94, 46),
//                           borderRadius: BorderRadius.circular(6)
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(bookings[index]['Status'], style: TextStyle(color: Colors.white),),
//                           ),
//                         )
//                       ],
//                     ),
                
//                     Text('date:${bookings[index]['Booking_date']}', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14),),
//                     Text('Time: ${bookings[index]['Start_Time']} - ${bookings[index]['End_Time']}', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 14),),
         
//               SizedBox(height: 5,),
//                    Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                        GestureDetector(onTap: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => PrescriptionPage(bookingId: bookings[index]['id'],),));
//                        },
//                          child: Container(
//                                 // height: 60,
//                                 // width: 100,
//                                 decoration: BoxDecoration(color: const Color.fromARGB(255, 8, 5, 0),
//                                 borderRadius: BorderRadius.circular(6)
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text('View prescription', style: TextStyle(color: Colors.white),),
//                                 ),
//                               ),
//                        ),
//                        GestureDetector(onTap: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorFeedbackRating(doctorid: bookings[index]['doctor_id'],),));
//                        },
//                          child: Container(
//                                 // height: 60,
//                                 // width: 100,
//                                 decoration: BoxDecoration(color: const Color.fromARGB(255, 218, 181, 62),
//                                 borderRadius: BorderRadius.circular(6)
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text('Add review', style: TextStyle(color: Colors.white),),
//                                 ),
//                               ),
//                        ),
//                      ],
//                    )
//                   ],
//                 ),
//               ),
//             ),
//           );
          
//         },)
//     );
//   }
// }
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/DoctorfeedbackRating.dart';
import 'package:healthcare/api/loginApi.dart';
import 'package:healthcare/viewprescription.dart';

class Mybooking extends StatefulWidget {
  const Mybooking({super.key});

  @override
  State<Mybooking> createState() => _MybookingState();
}

class _MybookingState extends State<Mybooking> {
  bool _isLoading = true;
  List<Map<String, dynamic>> bookings = [];

  Future<void> fetchbookings() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await dio.get('$baseurl/BookingHistory/$loginid');
      print("Booking API Response: ${response.data}");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        bookings = data.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        throw Exception("Failed to load bookings");
      }
    } catch (e) {
      print("Error fetching bookings: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text("Error loading bookings: $e")),
            ],
          ),
          backgroundColor: Colors.red.shade400,
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

  @override
  void initState() {
    super.initState();
    fetchbookings();
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      case 'cancelled':
        return Icons.cancel;
      case 'completed':
        return Icons.task_alt;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Bookings',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchbookings,
          ),
        ],
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
            : bookings.isEmpty
                ? _buildEmptyState()
                : _buildBookingsList(),
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
            'Loading Your Bookings...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we fetch your appointment history',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.calendar_today_outlined,
              size: 60,
              color: const Color(0xFF6C5CE7).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Bookings Found',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'You haven\'t made any appointments yet. Book your first appointment with a doctor today!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text('Book Appointment'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildBookingCard(booking, index);
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking, int index) {
    final status = booking['Status'] ?? 'Pending';
    final statusColor = _getStatusColor(status);
    final statusIcon = _getStatusIcon(status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with doctor name and status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Avatar with initial
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      _getInitials(booking['doctor_name'] ?? 'Dr'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Doctor Name and Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['doctor_name'] ?? 'Doctor Name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Booking #${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: statusColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        size: 14,
                        color: statusColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Date and Time Row
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
              ),
              child: Row(
                children: [
                  // Date
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: const Color(0xFF6C5CE7),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              booking['Booking_date'] ?? 'N/A',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Time
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: const Color(0xFF6C5CE7),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              '${booking['Start_Time'] ?? '--'} - ${booking['End_Time'] ?? '--'}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                // View Prescription Button
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.description,
                    label: 'Prescription',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrescriptionPage(
                            bookingId: booking['id'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // Add Review Button
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.star,
                    label: 'Add Review',
                    color: Colors.amber,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorFeedbackRating(
                            doctorid: booking['doctor_id'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Booking ID for reference
            Center(
              child: Text(
                'Booking ID: ${booking['id']}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'DR';
    
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    
    if (name.length >= 2) {
      return name.substring(0, 2).toUpperCase();
    }
    
    return name[0].toUpperCase();
  }
}