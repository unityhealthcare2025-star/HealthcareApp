// import 'package:flutter/material.dart';
// import 'package:healthcare/api/doctorsApi.dart';
// import 'package:healthcare/bookslot.dart';

// class DoctorListPage extends StatelessWidget {
//   final int hospitalId;
//   final String hospitalName;

//   const DoctorListPage({
//     super.key,
//     required this.hospitalId,
//     required this.hospitalName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Doctors - $hospitalName'),
//         backgroundColor: const Color.fromARGB(255, 188, 103, 222),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchDoctorsByHospital(hospitalId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final doctors = snapshot.data;

//           if (doctors == null || doctors.isEmpty) {
//             return const Center(child: Text('No doctors found.'));
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: doctors.length,
//             itemBuilder: (context, index) {
//               final doc = doctors[index];
//               return Card(
//   child: ListTile(
//     title: Text(doc['name'] ?? 'Doctor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//     subtitle: Column(

//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(doc['specialization'] ?? 'Specialization'),
//         Text('Experience: ${doc['experience'] ?? 'Experience'}')
//       ],
//     ),
//     trailing: ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => BookSlot(
//               doctorName: doc['name'],
//               hospitalName: hospitalName, doctorId: doc['id'],
//             ),
//           ),
//         );
//       },
//       child: Text('Book Now'),
//     ),
//   ),
// );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:healthcare/api/doctorsApi.dart';
import 'package:healthcare/bookslot.dart';

class DoctorListPage extends StatelessWidget {
  final int hospitalId;
  final String hospitalName;

  const DoctorListPage({
    super.key,
    required this.hospitalId,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Doctors',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              hospitalName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Trigger refresh
            },
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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchDoctorsByHospital(hospitalId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingWidget();
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString());
            }

            final doctors = snapshot.data;

            if (doctors == null || doctors.isEmpty) {
              return _buildEmptyState();
            }

            return _buildDoctorsList(doctors, context);
          },
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
            'Finding Doctors...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we fetch available doctors',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 50,
                color: Colors.red.shade300,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Failed to Load Doctors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
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
              Icons.medical_services_outlined,
              size: 60,
              color: const Color(0xFF6C5CE7).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Doctors Available',
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
              'There are no doctors currently available at $hospitalName. Please check back later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsList(List<Map<String, dynamic>> doctors, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doc = doctors[index];
        return _buildDoctorCard(doc, context);
      },
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doc, BuildContext context) {
    // Generate random color for avatar based on doctor name
    final Color avatarColor = _getAvatarColor(doc['name'] ?? 'Doctor');
    final String initials = _getInitials(doc['name'] ?? 'Dr. Smith');

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Avatar
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: avatarColor.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: avatarColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: avatarColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Doctor Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Specialization
                  Text(
                    doc['name'] ?? 'Dr. Name',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      doc['specialization'] ?? 'General Physician',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6C5CE7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Experience
                  Row(
                    children: [
                      Icon(
                        Icons.work_outline,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${doc['experience'] ?? '0'} years experience',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Additional info if available
                  if (doc['qualification'] != null) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            doc['qualification'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 12),

                  // Availability indicator
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Available Today',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Book Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookSlot(
                              doctorName: doc['name'],
                              hospitalName: hospitalName,
                              doctorId: doc['id'],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'Book Appointment',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvatarColor(String name) {
    final colors = [
      const Color(0xFF6C5CE7),
      const Color(0xFF8E44AD),
      const Color(0xFFE74C3C),
      const Color(0xFF3498DB),
      const Color(0xFF2ECC71),
      const Color(0xFFF39C12),
    ];
    
    if (name.isEmpty) return colors[0];
    
    final int index = name.codeUnits.fold(0, (prev, element) => prev + element) % colors.length;
    return colors[index];
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