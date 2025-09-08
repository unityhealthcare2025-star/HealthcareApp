import 'package:flutter/material.dart';
import 'package:healthcare/ChangePassword.dart';
import 'package:healthcare/EditProfile.dart';
import 'package:healthcare/login.dart';

class ProfileScreen extends StatelessWidget {
  // User data (can come from a model or backend)
  final String name = 'Coding with T';
  final String email = 'support@codingwitht.com';
  final String phone = '+92 317 8059528';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User info section
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(email, style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 2),
                        Text(phone, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Action ListTiles
          Column(
            children: [
              ListTile(
                trailing: Icon(Icons.arrow_right_outlined),
                leading: const Icon(Icons.person),
                title: const Text('Edit Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                  // TODO: Navigate to View Profile Screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("View Profile tapped")),
                  );
                },
              ),

              // const Divider(height: 0),
              ListTile(
                trailing: Icon(Icons.arrow_right_outlined),
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassword()),
                  );

                  // TODO: Navigate to Change Password Screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Change Password tapped")),
                  );
                },
              ),

              // const Divider(height: 0),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),(route) => false,
                            );

                            
                            // TODO: Navigate to login or welcome screen
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
