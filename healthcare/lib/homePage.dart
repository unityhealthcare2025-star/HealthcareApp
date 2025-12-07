import 'package:flutter/material.dart';
import 'package:healthcare/DoctorfeedbackRating.dart';
import 'package:healthcare/MyBooking.dart';
import 'package:healthcare/SendComplaint.dart';
import 'package:healthcare/ViewHospitals.dart';
import 'package:healthcare/api/symptomprediction.dart';
import 'package:healthcare/api/viewProfileapi.dart';
import 'package:healthcare/bookslot.dart';
import 'package:healthcare/viewDoctors.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  fetchProfile();
    
  }

//   Map<String,dynamic> ViewProfile = {};
//    bool _isLoading = true;
//    Future<void> fetchProfile() async {
//   setState(() {
//     _isLoading = true;
//   });

//   final data = await fetchprofile(); // call API
//   setState(() {
//     ViewProfile = data; // update state
//     _isLoading = false;
//   });
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       UserAccountsDrawerHeader(
      //         currentAccountPicture: ClipRRect(
      //           borderRadius: BorderRadiusGeometry.circular(50),
      //           child: Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')),
      //         accountName: Text(ViewProfile['UserName']),
      //          accountEmail: Text(ViewProfile['E_mail'])),

      //         ListTile(
      //           tileColor: const Color.fromARGB(255, 239, 241, 243),
      //           title: Text('send Complaints'),
      //           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SendComplaint(),)),
      //         ),
      //         ListTile(
      //           tileColor: const Color.fromARGB(255, 239, 241, 243),
      //           title: Text('Send Feedback and Rating'),
      //           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorFeedbackRating(),)),
      //         )
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'HealthCare Assistant',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 188, 103, 222),
      ),
      body: Column(
        children: [
          // 🔹 Top Full-Width Health Image
          SizedBox(
            width: double.infinity,
            height: 180,
            child: Image.asset('assets/hsptl.png', fit: BoxFit.cover),
          ),

          // 🔹 Grid Cards
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildGridCard(
                    context,
                    icon: Icons.health_and_safety,
                    title: 'Symptom\nPrediction',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SymptomPrediction(),));
                    },
                  ),
                  _buildGridCard(
                    context,
                    icon: Icons.local_hospital,
                    title: 'Nearby\nHospitals',
                    onTap: () {

                     // Navigate to Hospitals
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NearbyHospitalsPage()),
                  );
                    },
                  ),
                  //  _buildGridCard(
                  //   context,
                  //   icon: Icons.medical_services,
                  //   title: 'View Doctors',
                  //   onTap: () {
                  //     // Navigate to Feedback
                  //     Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => DoctorListPage(hospitalId: 1, hospitalName: '',)),
                  // );
                  //   },
                  // ),
                  _buildGridCard(
                    context,
                    icon: Icons.chat,
                    title: 'Send Complaint',
                     onTap: () {
                      // Navigate to Feedback
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SendComplaint()),
                  );
                    },
                    ),
                  _buildGridCard(
                    context,
                    icon: Icons.event_note, 
                    title: 'My Booking',
                     onTap: () {
                      // Navigate to Feedback
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mybooking()),
                  );
                    },)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.deepPurple.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
