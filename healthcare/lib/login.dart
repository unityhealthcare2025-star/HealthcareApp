import 'package:flutter/material.dart';
import 'package:healthcare/bottomNva.dart';
import 'package:healthcare/homePage.dart';
import 'package:healthcare/register.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  TextEditingController userController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 237, 235, 228),
      appBar: AppBar(
        title: Text('LoginPage', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 176, 166, 215),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: userController,
                  validator: (value) {
                    if(value!.isEmpty || value! == null){
                      return "Please enter the username";
                    }if (value.length<5){
                      return "Please enter at least 4 characters";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: PasswordController,
                  validator: (value) {
                    if(value!.isEmpty || value! == null){
                      return "Please enter the Password";
                    }if (value.length<5){
                      return "Please enter at least 5 characters";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(217, 0, 0, 0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                    minimumSize: Size(100, 40)
                  ),
                  onPressed: () { 
                    
                    if (formkey.currentState!.validate()) {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bottomnav()),
                    );
                    }
                    },
                  child: Text('Login',style: TextStyle(fontSize: 18),),
                ),
                 TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationForm(),));
                  }, child: Text('Do not have an account,Register Now'))
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
