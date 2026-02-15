import 'package:flutter/material.dart';
import 'package:healthcare/login.dart';
import 'package:healthcare/api/loginApi.dart';

class IPScreen extends StatefulWidget {
  const IPScreen({super.key});

  @override
  State<IPScreen> createState() => _IPScreenState();
}

class _IPScreenState extends State<IPScreen> {
  final TextEditingController _ipController = TextEditingController();
  bool _isLoading = false;

  void _connectToServer() {
    String ip = _ipController.text.trim();
    
    // Format the IP address
    if (ip.isNotEmpty) {
      if (!ip.startsWith('http://') && !ip.startsWith('https://')) {
        ip = 'http://$ip';
      }
      
      if (ip.endsWith('/')) {
        ip = ip.substring(0, ip.length - 1);
      }

      // Store the base URL globally
      baseurl = ip;

      setState(() {
        _isLoading = true;
      });

      // Navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  
                  // Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.settings_input_component,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  const Text(
                    "Server Configuration",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  Text(
                    "Enter your server IP address",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Input Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // IP Address Field
                        TextField(
                          controller: _ipController,
                          decoration: InputDecoration(
                            labelText: "Server IP Address",
                            hintText: "e.g., 192.168.1.100:8000",
                            prefixIcon: const Icon(Icons.dns, color: Color(0xFF6C5CE7)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color(0xFF6C5CE7),
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Connect Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _connectToServer,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C5CE7),
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.link, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Connect to Server',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Quick Connect Options
                  Wrap(
                    spacing: 10,
                    children: [
                      _buildQuickChip('Localhost', '127.0.0.1:8000'),
                      _buildQuickChip('Local Network', '192.168.1.100:8000'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickChip(String label, String ip) {
    return GestureDetector(
      onTap: () {
        _ipController.text = ip;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}