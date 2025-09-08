import 'package:flutter/material.dart';
import 'package:healthcare/login.dart';

class RegistrationForm extends StatelessWidget {
   RegistrationForm({super.key});
  

  TextEditingController NameController = TextEditingController();
  TextEditingController GenderController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  TextEditingController E_mailController = TextEditingController();
  TextEditingController Phone_NoController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController StateController = TextEditingController();
  TextEditingController Pin_CodeController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Your Account',style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 195, 96, 241),
        ),
        body: Padding(padding: const EdgeInsets.all(12.0),
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
                      if(value!.isEmpty || value! == null){
                        return "Please Enter Your Name";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15),
                   TextFormField(
                    controller: GenderController,
                    validator: (value) {
                      if(value!.isEmpty || value! == null){
                        return "Please Enter Your Gender";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15),
                   TextFormField(
                    controller: DOBController,
                    validator: (value) {
                      if(value!.isEmpty || value! == null){
                        return "Please Enter Your DOB";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'DOB',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15),
                   TextFormField(
                    controller: E_mailController,
                    validator: (value) {
                      if(value!.isEmpty || value! == null){
                        return "Please Enter Your E-mail";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15),
                   TextFormField(
                    controller: Phone_NoController,
                    validator: (value) {
                      if(value!.isEmpty || value! == null){
                        return "Please Enter Your Phone No";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone_No',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15),
                   TextFormField(
                    controller: AddressController,
                    validator: (value) {
                      if(value!.isEmpty || value! == null){
                        return "Please Enter Your Address";
                      }
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15),
                   TextFormField(
                    controller: CityController,
                    validator: (value) {
                      if(value!.isEmpty || value! == null){
                        return "Please Enter Your City";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15),
                   TextFormField(
                    controller: StateController,
                    validator: (value) {
                      if(value!.isEmpty || value! == null){
                        return "Please Enter Your State";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15),
                   TextFormField(
                    controller: Pin_CodeController,
                    validator: (value) {
                      if(value!.isEmpty || value! == null){
                        return "Please Enter Your Pin code";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Pin_code',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15),
                     Row(mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         ElevatedButton(
                                           style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(217, 0, 0, 0),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                          minimumSize: Size(100, 40)
                                           ),
                                           onPressed: () {
              
                                           if (formkey.currentState!.validate()) {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                                           }
                                           },
                                           child: Text('Register',style: TextStyle(fontSize: 18),),
                                         ),
                            SizedBox(width: 18),             
                       
                       ],
                     ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  }, child: Text('Already have an account? Login'))
              
                ],
              
              ),
            ),
          ),
        ),),
      
    );
  }
}