import 'package:flutter/material.dart';
import 'package:healthcare/api/loginApi.dart';
import 'package:healthcare/api/viewProfileapi.dart';  // contains dio, baseurl, loginid

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> profileData;

  const EditProfilePage({super.key, required this.profileData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with API response values
    _controllers = {
      'UserName': TextEditingController(text: widget.profileData['UserName'] ?? ''),
      'E_mail': TextEditingController(text: widget.profileData['E_mail'] ?? ''),
      'Phone': TextEditingController(text: widget.profileData['Phone'].toString() ?? ''),
      'DOB': TextEditingController(text: widget.profileData['DOB'] ?? ''),
      'Gender': TextEditingController(text: widget.profileData['Gender'] ?? ''),
      'Address': TextEditingController(text: widget.profileData['Address'] ?? ''),
      'City': TextEditingController(text: widget.profileData['City'] ?? ''),
      'State': TextEditingController(text: widget.profileData['State'] ?? ''),
      'Pincode': TextEditingController(text: widget.profileData['Pincode'].toString() ?? ''),
    };
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _updateProfile() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isSaving = true);

  final data = {
    "UserName": _controllers['UserName']!.text,
    "E_mail": _controllers['E_mail']!.text,
    "Phone": int.tryParse(_controllers['Phone']!.text) ?? 0,
    "DOB": _controllers['DOB']!.text,
    "Gender": _controllers['Gender']!.text,
    "Address": _controllers['Address']!.text,
    "City": _controllers['City']!.text,
    "State": _controllers['State']!.text,
    "Pincode": int.tryParse(_controllers['Pincode']!.text) ?? 0,
  };

  try {
    final response = await dio.put("$baseurl/ProfileView/$loginid", data: data);

    print("Update API Response: ${response.data}");

    // Treat any 2xx response as success
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Profile updated successfully"),
          backgroundColor: Colors.green.shade600,
        ),
      );
      Navigator.pop(context, true); // return success
    } else {
      throw Exception("Update failed: ${response.data}");
    }
  } catch (e) {
    print("Error updating profile: $e");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Profile update failed"),
        backgroundColor: Colors.red.shade600,
      ),
    );
  } finally {
    setState(() => _isSaving = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),

      body: Stack(
        children: [
          _buildForm(),

          if (_isSaving)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ..._controllers.entries.map((entry) {
                  String key = entry.key;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                      controller: entry.value,
                      readOnly: key == 'E_mail', // email is readonly
                      decoration: InputDecoration(
                        labelText: key,
                        prefixIcon: Icon(_getIconForField(key)),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '$key is required';
                        }
                        return null;
                      },
                    ),
                  );
                }).toList(),

                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed:(){
                    _updateProfile();
                    
                  } ,
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForField(String key) {
    switch (key) {
      case 'E_mail':
        return Icons.email;
      case 'Phone':
        return Icons.phone;
      case 'DOB':
        return Icons.cake;
      case 'Gender':
        return Icons.wc;
      case 'Address':
        return Icons.home;
      case 'City':
        return Icons.location_city;
      case 'State':
        return Icons.map;
      case 'Pincode':
        return Icons.pin;
      case 'UserName':
      default:
        return Icons.person;
    }
  }
}
