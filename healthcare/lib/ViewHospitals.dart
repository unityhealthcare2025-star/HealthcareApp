// import 'package:flutter/material.dart';
// import 'package:healthcare/api/nearbyhospitalsApi.dart';
// import 'package:location/location.dart';


// class NearbyHospitalsPage extends StatefulWidget {
//   const NearbyHospitalsPage({Key? key}) : super(key: key);

//   @override
//   State<NearbyHospitalsPage> createState() => _NearbyHospitalsPageState();
// }

// class _NearbyHospitalsPageState extends State<NearbyHospitalsPage> {
//   LocationData? _locationData;
//   List<Map<String, dynamic>> _hospitals = [];
//   bool _loading = false;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocationAndHospitals();
//   }

//   Future<void> _getUserLocationAndHospitals() async {
//     setState(() {
//       _loading = true;
//       _error = null;
//     });

//     try {
//       Location location = Location();

//       bool serviceEnabled = await location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await location.requestService();
//         if (!serviceEnabled) throw Exception('Location service not enabled');
//       }

//       PermissionStatus permissionGranted = await location.hasPermission();
//       if (permissionGranted == PermissionStatus.denied) {
//         permissionGranted = await location.requestPermission();
//         if (permissionGranted != PermissionStatus.granted) {
//           throw Exception('Location permission denied');
//         }
//       }

//       _locationData = await location.getLocation();

//       final hospitals = await fetchNearbyHospitals(
//         _locationData!.latitude!,
//         _locationData!.longitude!,
//       );

//       setState(() {
//         _hospitals = hospitals;
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _loading = false;
//         _error = e.toString();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nearby Hospitals', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color.fromARGB(255, 188, 103, 222),
//         centerTitle: true,
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//               ? Center(child: Text('Error: $_error'))
//               : _hospitals.isEmpty
//                   ? const Center(child: Text('No hospitals found nearby.'))
//                   : ListView.builder(
//                       padding: const EdgeInsets.all(12),
//                       itemCount: _hospitals.length,
//                       itemBuilder: (context, index) {
//                         final hospital = _hospitals[index];
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 12.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 162, 172, 177),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Image.asset('assets/hsptl.png', height: 100, width: 100),
//                                   Text(hospital['name'] ?? 'Hospital Name',
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontStyle: FontStyle.italic,
//                                           fontSize: 18)),
//                                   Text('Phone: ${hospital['phone'] ?? 'N/A'}'),
//                                   Text('Email: ${hospital['email'] ?? 'N/A'}'),
//                                   Text('Address: ${hospital['address'] ?? 'N/A'}'),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:healthcare/api/nearbyhospitalsApi.dart';
import 'package:healthcare/viewDoctors.dart';
import 'package:location/location.dart';


class NearbyHospitalsPage extends StatefulWidget {
  const NearbyHospitalsPage({Key? key}) : super(key: key);

  @override
  State<NearbyHospitalsPage> createState() => _NearbyHospitalsPageState();
}

class _NearbyHospitalsPageState extends State<NearbyHospitalsPage> {
  LocationData? _locationData;
  List<Map<String, dynamic>> _hospitals = [];
  List<Map<String, dynamic>> _filteredHospitals = [];
  bool _loading = false;
  String? _error;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _getUserLocationAndHospitals();
  }

  Future<void> _getUserLocationAndHospitals() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      Location location = Location();

      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) throw Exception('Location service not enabled');
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw Exception('Location permission denied');
        }
      }

      _locationData = await location.getLocation();

      final hospitals = await fetchNearbyHospitals(
        _locationData!.latitude!,
        _locationData!.longitude!,
      );

      setState(() {
        _hospitals = hospitals;
        _filteredHospitals = hospitals;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  void _filterHospitals(String query) {
    final lowerQuery = query.toLowerCase();

    final filtered = _hospitals.where((hospital) {
      final name = (hospital['name'] ?? '').toLowerCase();
      final address = (hospital['address'] ?? '').toLowerCase();
      final city = (hospital['city'] ?? '').toLowerCase();
      return name.contains(lowerQuery) || address.contains(lowerQuery) || city.contains(lowerQuery);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredHospitals = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Hospitals', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 188, 103, 222),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: _filterHospitals,
                        decoration: InputDecoration(
                          hintText: 'Search by city or address...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _filteredHospitals.isEmpty
                          ? const Center(child: Text('No hospitals found.'))
                          : ListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount: _filteredHospitals.length,
                              itemBuilder: (context, index) {
                                final hospital = _filteredHospitals[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DoctorListPage(
                                          hospitalId: hospital['id'],
                                          hospitalName: hospital['name'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 162, 172, 177),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset('assets/hsptl.png', height: 100, width: 100),
                                            Text(hospital['name'] ?? 'Hospital Name',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 18)),
                                            Text('Phone: ${hospital['phone'] ?? 'N/A'}'),
                                            Text('Email: ${hospital['email'] ?? 'N/A'}'),
                                            Text('Address: ${hospital['address'] ?? 'N/A'}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}
