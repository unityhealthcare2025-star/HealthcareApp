// import 'package:flutter/material.dart';
// import 'package:healthcare/login.dart';

// class UpdateProfile extends StatelessWidget {
//   const UpdateProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Your Profile',style: TextStyle(color: Colors.white)
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 195, 96, 241),
//         ),
//         body: Padding(padding: const EdgeInsets.all(12.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Name',
//                     border: OutlineInputBorder()
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                  TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Gender',
//                     border: OutlineInputBorder()
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                  TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'DOB',
//                     border: OutlineInputBorder()
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                  TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'E-mail',
//                     border: OutlineInputBorder()
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                  TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Phone_No',
//                     border: OutlineInputBorder()
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                  TextFormField(maxLines: 3,
//                   decoration: InputDecoration(
//                     labelText: 'Address',
//                     border: OutlineInputBorder()
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                  TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'City',
//                     border: OutlineInputBorder()
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                  TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'State',
//                     border: OutlineInputBorder()
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                  TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Pin_code',
//                     border: OutlineInputBorder()
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                    Row(mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        ElevatedButton(
//                                          style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(217, 0, 0, 0),
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
//                         minimumSize: Size(100, 40)
//                                          ),
//                                          onPressed: () {
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
//                                          },
//                                          child: Text('Save',style: TextStyle(fontSize: 18),),
//                                        ),
//                           SizedBox(width: 18),             
                     
//                      ],
//                    ),
              
//               ],
            
//             ),
//           ),
//         ),),
      
//     );
//   }
// }
 import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Editable profile data
  final Map<String, TextEditingController> _controllers = {
    'Full Name': TextEditingController(text: 'Coding with T'),
    'Email': TextEditingController(text: 'support@codingwitht.com'),
    'Phone Number': TextEditingController(text: '+92 317 8059528'),
    'Date of Birth': TextEditingController(text: '01 January 2000'),
    'Gender': TextEditingController(text: 'Male'),
    'Address': TextEditingController(text: '123 Flutter St, Code City, Developer Land'),
  };

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Here you'd usually send data to your backend or local storage
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Generate text fields for each entry
                  ..._controllers.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TextFormField(
                        controller: entry.value,
                        decoration: InputDecoration(
                          labelText: entry.key,
                          prefixIcon: Icon(_getIconForTitle(entry.key)),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '${entry.key} is required';
                          }
                          return null;
                        },
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 10),

                  // Save button
                  ElevatedButton.icon(
                    onPressed: _saveProfile,
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
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Email':
        return Icons.email;
      case 'Phone Number':
        return Icons.phone;
      case 'Date of Birth':
        return Icons.cake;
      case 'Gender':
        return Icons.wc;
      case 'Address':
        return Icons.home;
      case 'Full Name':
      default:
        return Icons.person;
    }
  }
}
