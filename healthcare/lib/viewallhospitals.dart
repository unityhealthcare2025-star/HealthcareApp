import 'package:flutter/material.dart';
import 'package:healthcare/api/viewallhospitalsapi.dart';
import 'package:healthcare/viewDoctors.dart';

class AllHospitalsPage extends StatefulWidget {
  const AllHospitalsPage({Key? key}) : super(key: key);

  @override
  State<AllHospitalsPage> createState() => _AllHospitalsPageState();
}

class _AllHospitalsPageState extends State<AllHospitalsPage> {
  List<Map<String, dynamic>> _hospitals = [];
  List<Map<String, dynamic>> _filteredHospitals = [];
  bool _loading = false;
  String? _error;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadHospitals();
  }

  Future<void> _loadHospitals() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final hospitals = await fetchAllHospitals();

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
      return name.contains(lowerQuery) ||
          address.contains(lowerQuery) ||
          city.contains(lowerQuery);
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
          'All Hospitals',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF6C5CE7),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadHospitals,
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6C5CE7),
              ),
            )
          : _error != null
              ? Center(child: Text(_error!))
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
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: _filterHospitals,
        decoration: InputDecoration(
          hintText: 'Search by hospital name, city, or address...',
          prefixIcon:
              const Icon(Icons.search, color: Color(0xFF6C5CE7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        "No Hospitals Found",
        style: TextStyle(fontSize: 18),
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C5CE7).withOpacity(0.1),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hospital['name'] ?? 'Hospital',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hospital['address'] ?? 'Address not available',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              hospital['city'] ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "View Doctors",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
