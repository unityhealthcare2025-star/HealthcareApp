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
        title: Text('Doctors - $hospitalName'),
        backgroundColor: const Color.fromARGB(255, 188, 103, 222),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchDoctorsByHospital(hospitalId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final doctors = snapshot.data;

          if (doctors == null || doctors.isEmpty) {
            return const Center(child: Text('No doctors found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doc = doctors[index];
              return Card(
  child: ListTile(
    title: Text(doc['name'] ?? 'Doctor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    subtitle: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(doc['specialization'] ?? 'Specialization'),
        Text('Experience: ${doc['experience'] ?? 'Experience'}')
      ],
    ),
    trailing: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookSlot(
              doctorName: doc['name'],
              hospitalName: hospitalName,
            ),
          ),
        );
      },
      child: Text('Book Now'),
    ),
  ),
);
            },
          );
        },
      ),
    );
  }
}
