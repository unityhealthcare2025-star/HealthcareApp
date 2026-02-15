

// import 'package:flutter/material.dart';
// import 'package:healthcare/api/nearbyhospitalsApi.dart';
// import 'package:healthcare/viewDoctors.dart';
// import 'package:location/location.dart';


// class NearbyHospitalsPage extends StatefulWidget {
//   const NearbyHospitalsPage({Key? key}) : super(key: key);

//   @override
//   State<NearbyHospitalsPage> createState() => _NearbyHospitalsPageState();
// }

// class _NearbyHospitalsPageState extends State<NearbyHospitalsPage> {
//   LocationData? _locationData;
//   List<Map<String, dynamic>> _hospitals = [];
//   List<Map<String, dynamic>> _filteredHospitals = [];
//   bool _loading = false;
//   String? _error;
//   String _searchQuery = '';

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
//         _filteredHospitals = hospitals;
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _loading = false;
//         _error = e.toString();
//       });
//     }
//   }

//   void _filterHospitals(String query) {
//     final lowerQuery = query.toLowerCase();

//     final filtered = _hospitals.where((hospital) {
//       final name = (hospital['name'] ?? '').toLowerCase();
//       final address = (hospital['address'] ?? '').toLowerCase();
//       final city = (hospital['city'] ?? '').toLowerCase();
//       return name.contains(lowerQuery) || address.contains(lowerQuery) || city.contains(lowerQuery);
//     }).toList();

//     setState(() {
//       _searchQuery = query;
//       _filteredHospitals = filtered;
//     });
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
//               : Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextField(
//                         onChanged: _filterHospitals,
//                         decoration: InputDecoration(
//                           hintText: 'Search by city or address...',
//                           prefixIcon: const Icon(Icons.search),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: _filteredHospitals.isEmpty
//                           ? const Center(child: Text('No hospitals found.'))
//                           : ListView.builder(
//                               padding: const EdgeInsets.all(12),
//                               itemCount: _filteredHospitals.length,
//                               itemBuilder: (context, index) {
//                                 final hospital = _filteredHospitals[index];
//                                 return GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => DoctorListPage(
//                                           hospitalId: hospital['id'],
//                                           hospitalName: hospital['name'],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(bottom: 12.0),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: const Color.fromARGB(255, 162, 172, 177),
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(12.0),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Image.asset('assets/hsptl.png', height: 100, width: 100),
//                                             Text(hospital['name'] ?? 'Hospital Name',
//                                                 style: const TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontStyle: FontStyle.italic,
//                                                     fontSize: 18)),
//                                             Text('Phone: ${hospital['phone'] ?? 'N/A'}'),
//                                             Text('Email: ${hospital['email'] ?? 'N/A'}'),
//                                             Text('Address: ${hospital['address'] ?? 'N/A'}'),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),
//                   ],
//                 ),
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
        title: const Text(
          'Nearby Hospitals',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: const Color(0xFF6C5CE7),
        elevation: 0,
        centerTitle: true,
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
            onPressed: _getUserLocationAndHospitals,
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
        child: _loading
            ? _buildLoadingWidget()
            : _error != null
                ? _buildErrorWidget()
                : Column(
                    children: [
                      _buildSearchBar(),
                      Expanded(
                        child: _filteredHospitals.isEmpty
                            ? _buildEmptyState()
                            : _buildHospitalsList(),
                      ),
                    ],
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
            'Finding hospitals near you...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This may take a few seconds',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
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
              'Oops! Something Went Wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _getUserLocationAndHospitals,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
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
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        onChanged: _filterHospitals,
        decoration: InputDecoration(
          hintText: 'Search by hospital name, city, or address...',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.search, color: const Color(0xFF6C5CE7)),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey.shade400),
                  onPressed: () {
                    _filterHospitals('');
                    FocusScope.of(context).unfocus();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
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
              Icons.local_hospital_outlined,
              size: 60,
              color: const Color(0xFF6C5CE7).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _searchQuery.isEmpty ? 'No Hospitals Found' : 'No Matching Hospitals',
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
              _searchQuery.isEmpty
                  ? 'We couldn\'t find any hospitals near your location. Try adjusting your search or check back later.'
                  : 'No hospitals match "$_searchQuery". Try a different search term.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _filterHospitals('');
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.clear),
              label: const Text('Clear Search'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF6C5CE7),
                elevation: 0,
                side: BorderSide(color: const Color(0xFF6C5CE7).withOpacity(0.3)),
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
        ],
      ),
    );
  }

  Widget _buildHospitalsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredHospitals.length,
      itemBuilder: (context, index) {
        final hospital = _filteredHospitals[index];
        return _buildHospitalCard(hospital);
      },
    );
  }

  Widget _buildHospitalCard(Map<String, dynamic> hospital) {
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
      child: Container(
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
        child: Column(
          children: [
            // Hospital Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Image.asset(
                      'assets/hsptl.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF6C5CE7).withOpacity(0.1),
                          child: Center(
                            child: Icon(
                              Icons.local_hospital,
                              size: 50,
                              color: const Color(0xFF6C5CE7).withOpacity(0.3),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Distance Badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: const Color(0xFF6C5CE7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${(hospital['distance'] ?? 0.0).toStringAsFixed(1)} km',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6C5CE7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Hospital Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          hospital['name'] ?? 'Hospital Name',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (hospital['rating'] != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                hospital['rating'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Address
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          hospital['address'] ?? 'Address not available',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Contact Info Row
                  // Row(
                  //   children: [
                  //     if (hospital['phone'] != null && hospital['phone'] != 'N/A') ...[
                  //       Expanded(
                  //         child: _buildContactChip(
                  //           icon: Icons.phone,
                  //           label: 'Call',
                  //           color: Colors.green,
                  //           onTap: () {
                  //             // Add phone call functionality
                  //           },
                  //         ),
                  //       ),
                  //       const SizedBox(width: 8),
                  //     ],
                  //     if (hospital['email'] != null && hospital['email'] != 'N/A') ...[
                  //       Expanded(
                  //         child: _buildContactChip(
                  //           icon: Icons.email,
                  //           label: 'Email',
                  //           color: Colors.blue,
                  //           onTap: () {
                  //             // Add email functionality
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ],
                  // ),
                  
                  const SizedBox(height: 12),
                  
                  // View Doctors Button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
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
                        borderRadius: BorderRadius.circular(12),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.medical_services,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'View Doctors',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildContactChip({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: color,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}