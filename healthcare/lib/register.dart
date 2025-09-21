// import 'package:flutter/material.dart';
// import 'package:healthcare/api/RegApi.dart';
// import 'package:healthcare/login.dart';

// class RegistrationForm extends StatefulWidget {
//   RegistrationForm({super.key});

//   @override
//   State<RegistrationForm> createState() => _RegistrationFormState();
// }

// class _RegistrationFormState extends State<RegistrationForm> {
//   TextEditingController NameController = TextEditingController();

//   TextEditingController GenderController = TextEditingController();

//   TextEditingController DOBController = TextEditingController();

//   TextEditingController E_mailController = TextEditingController();

//   TextEditingController Phone_NoController = TextEditingController();

//   TextEditingController AddressController = TextEditingController();

//   TextEditingController CityController = TextEditingController();

//   TextEditingController StateController = TextEditingController();

//   TextEditingController Pin_CodeController = TextEditingController();

//   final formkey = GlobalKey<FormState>();

//   String? selectedGender;

//   List gender = ['Male', 'Female', 'Others'];
//   DateTime? selectedDate;

//   Future<void> pickDate() async {
//     DateTime? pickeddate = await showDatePicker(
//       context: context,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//       initialDate: DateTime(2000),
//     );
//     if (pickeddate != null) {
//       setState(() {
//         selectedDate = pickeddate;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Create Your Account',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 195, 96, 241),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: formkey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextFormField(
//                     controller: NameController,
//                     validator: (value) {
//                       if (value!.isEmpty || value! == null) {
//                         return "Please Enter Your Name";
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Name',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   //  TextFormField(
//                   //   controller: GenderController,
//                   //   validator: (value) {
//                   //     if(value!.isEmpty || value! == null){
//                   //       return "Please Enter Your Gender";
//                   //     }
//                   //   },
//                   //   decoration: InputDecoration(
//                   //     labelText: 'Gender',
//                   //     border: OutlineInputBorder()
//                   //   ),
//                   // ),
//                   DropdownButtonFormField(
//                     value: selectedGender,
//                     items: gender
//                         .map(
//                           (gender) => DropdownMenuItem(
//                             child: Text(gender),
//                             value: gender,
//                           ),
//                         )
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedGender = value!.toString();
//                       });
//                     },
//                   ),
//                   SizedBox(height: 15),
//                   // TextFormField(
//                   //   controller: DOBController,
//                   //   validator: (value) {
//                   //     if (value!.isEmpty || value! == null) {
//                   //       return "Please Enter Your DOB";
//                   //     }
//                   //   },
//                   //   decoration: InputDecoration(
//                   //     labelText: 'DOB',
//                   //     border: OutlineInputBorder(),
//                   //   ),
//                   // ),
//                   TextFormField(
//                     controller: DOBController,
//                     readOnly: true,
//                     onTap: () async {
//                       FocusScope.of(context).requestFocus(
//                         FocusNode(),
//                       ); // To prevent keyboard from showing
//                       DateTime? pickeddate = await showDatePicker(
//                         context: context,
//                         firstDate: DateTime(1900),
//                         lastDate: DateTime.now(),
//                         initialDate: DateTime(2000),
//                       );
//                       if (pickeddate != null) {
//                         String formattedDate =
//                             "${pickeddate.day}-${pickeddate.month}-${pickeddate.year}";
//                         setState(() {
//                           selectedDate = pickeddate;
//                           DOBController.text = formattedDate;
//                         });
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please select your DOB";
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Date of Birth',
//                       border: OutlineInputBorder(),
//                       suffixIcon: Icon(Icons.calendar_today),
//                     ),
//                   ),

//                   SizedBox(height: 15),
//                   TextFormField(
//                     controller: E_mailController,
//                     validator: (value) {
//                       if (value!.isEmpty || value! == null) {
//                         return "Please Enter Your E-mail";
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'E-mail',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   TextFormField(
//                     controller: Phone_NoController,
//                     validator: (value) {
//                       if (value!.isEmpty || value! == null) {
//                         return "Please Enter Your Phone No";
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Phone_No',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   TextFormField(
//                     controller: AddressController,
//                     validator: (value) {
//                       if (value!.isEmpty || value! == null) {
//                         return "Please Enter Your Address";
//                       }
//                     },
//                     maxLines: 3,
//                     decoration: InputDecoration(
//                       labelText: 'Address',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   TextFormField(
//                     controller: CityController,
//                     validator: (value) {
//                       if (value!.isEmpty || value! == null) {
//                         return "Please Enter Your City";
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'City',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   TextFormField(
//                     controller: StateController,
//                     validator: (value) {
//                       if (value!.isEmpty || value! == null) {
//                         return "Please Enter Your State";
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'State',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   TextFormField(
//                     controller: Pin_CodeController,
//                     validator: (value) {
//                       if (value!.isEmpty || value! == null) {
//                         return "Please Enter Your Pin code";
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Pin_code',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color.fromARGB(217, 0, 0, 0),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadiusGeometry.circular(12),
//                           ),
//                           minimumSize: Size(100, 40),
//                         ),
//                         onPressed: () {
//                           if (formkey.currentState!.validate()) {
//                             Map<String, dynamic> data = {
//                               'UserName': NameController.text,
//                               'Gender': GenderController.text,
//                               'DOB': selectedDate,
//                               'E_mail': E_mailController.text,
//                               'Phone': Phone_NoController.text,
//                               'Address': AddressController.text,
//                               'City': CityController.text,
//                               'State': StateController.text,
//                               'Pincode': Pin_CodeController.text,
//                             };
//                             RegApi(data, context);
//                           }
//                         },
//                         child: Text('Register', style: TextStyle(fontSize: 18)),
//                       ),
//                       SizedBox(width: 18),
//                     ],
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginPage()),
//                       );
//                     },
//                     child: Text('Already have an account? Login'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:healthcare/api/RegApi.dart';
import 'package:healthcare/login.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController NameController = TextEditingController();
  final TextEditingController DOBController = TextEditingController();
  final TextEditingController E_mailController = TextEditingController();
  final TextEditingController Phone_NoController = TextEditingController();
  final TextEditingController AddressController = TextEditingController();
  final TextEditingController CityController = TextEditingController();
  final TextEditingController StateController = TextEditingController();
  final TextEditingController Pin_CodeController = TextEditingController();
  final TextEditingController PaswordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  String? selectedGender;
  DateTime? selectedDate;
  final List<String> gender = ['Male', 'Female', 'Others'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Your Account',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 195, 96, 241),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: NameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    items: gender
                        .map((g) => DropdownMenuItem(
                              value: g,
                              child: Text(g),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: DOBController,
                    readOnly: true,
                    onTap: () async {
                      FocusScope.of(context).unfocus(); // Hide keyboard
                      DateTime? pickeddate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        initialDate: DateTime(2000),
                      );
                      if (pickeddate != null) {
                        String formattedDate =
                            "${pickeddate.day.toString().padLeft(2, '0')}-${pickeddate.month.toString().padLeft(2, '0')}-${pickeddate.year}";
                        setState(() {
                          selectedDate = pickeddate;
                          DOBController.text = formattedDate;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select your DOB";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: E_mailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      // Optional: Add basic email validation
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: Phone_NoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return "Enter a valid 10-digit phone number";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: AddressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: CityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your city";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: StateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your state";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: Pin_CodeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your pin code";
                      }
                      if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                        return "Enter a valid 6-digit pin code";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Pin Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: PaswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                        return "Enter a valid 6-digit password";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(217, 0, 0, 0),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(100, 40),
                        ),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            Map<String, dynamic> data = {
                              'UserName': NameController.text,
                              'Gender': selectedGender,
                              'DOB': selectedDate != null
                                  ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
                                  : null,
                              'E_mail': E_mailController.text,
                              'Phone': Phone_NoController.text,
                              'Address': AddressController.text,
                              'City': CityController.text,
                              'State': StateController.text,
                              'Pincode': Pin_CodeController.text,
                              'Username': E_mailController.text,
                              'Password':PaswordController.text,
                            };
                            RegApi(data, context);
                          }
                        },
                        child: const Text('Register', style: TextStyle(fontSize: 18)),
                      ),
                      const SizedBox(width: 18),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text('Already have an account? Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
