// import 'package:flutter/material.dart';
// import 'package:healthcare/api/loginApi.dart';
// import 'package:healthcare/bottomNva.dart';
// import 'package:healthcare/homePage.dart';
// import 'package:healthcare/register.dart';

// class LoginPage extends StatelessWidget {
//    LoginPage({super.key});

//   TextEditingController userController = TextEditingController();
//   TextEditingController PasswordController = TextEditingController();
//   final formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: const Color.fromARGB(255, 237, 235, 228),
//       appBar: AppBar(
//         title: Text('LoginPage', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 176, 166, 215),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Center(
//           child: Form(
//             key: formkey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   controller: userController,
//                   validator: (value) {
//                     if(value!.isEmpty || value! == null){
//                       return "Please enter the username";
//                     }if (value.length<5){
//                       return "Please enter at least 4 characters";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'username',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: PasswordController,
//                   validator: (value) {
//                     if(value!.isEmpty || value! == null){
//                       return "Please enter the Password";
//                     }if (value.length<5){
//                       return "Please enter at least 5 characters";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(217, 0, 0, 0),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
//                     minimumSize: Size(100, 40)
//                   ),
//                   onPressed: () { 
                    
//                     if (formkey.currentState!.validate()) {

//                       loginApi(userController.text, PasswordController.text, context);
                      
//                     }
//                     },
//                   child: Text('Login',style: TextStyle(fontSize: 18),),
//                 ),
//                  TextButton(onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationForm(),));
//                   }, child: Text('Do not have an account,Register Now'))
                  
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:healthcare/api/loginApi.dart';
import 'package:healthcare/register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8E44AD),
              Color(0xFF6C5CE7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 80),
            child: Column(
              children: [

                // --- App Title ---
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Login to continue",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                SizedBox(height: 40),

                // --- Card Container ---
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),

                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        
                        // Username field
                        TextFormField(
                          controller: userController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the username";
                            }
                            if (value.length < 4) {
                              return "Enter at least 4 characters";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        // Password field
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the password";
                            }
                            if (value.length < 5) {
                              return "Enter at least 5 characters";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 30),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6C5CE7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                loginApi(
                                  userController.text,
                                  passwordController.text,
                                  context,
                                );
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        // Register link
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegistrationForm(),
                              ),
                            );
                          },
                          child: Text(
                            "Don't have an account? Register Now",
                            style: TextStyle(color: Color(0xFF6C5CE7)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
