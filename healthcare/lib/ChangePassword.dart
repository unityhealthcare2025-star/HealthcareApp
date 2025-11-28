import 'package:flutter/material.dart';
import 'package:healthcare/api/loginApi.dart';

class ChangePassword extends StatefulWidget {
   ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
final TextEditingController _currentPasswordController =
TextEditingController();

final TextEditingController _newPasswordController =
TextEditingController();

final TextEditingController _retypePasswordController =
TextEditingController();

final _formKey = GlobalKey<FormState>();

 bool _isSubmitting = false;

 bool _showCurrentPassword = false;

 bool _showNewPassword = false;

 bool _showRetypePassword = false;

 Future<void> _changePassword() async {
  // if (!_formKey.currentState!.validate()) return;
   
   if (_newPasswordController.text != _retypePasswordController.text){
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("New password and retype password do not match")),
    
);
 return;
   }
   setState(() => _isSubmitting = true);
   try {
    final response = await dio.post(
    '$baseurl/ChangePassword/$loginid',
    data: {
      "old_password": _currentPasswordController.text,
      "new_password": _newPasswordController.text,
      "confirm_password": _retypePasswordController.text,
    },
    );
    if (response.statusCode == 200 || response.statusCode == 201){
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text("Password changed successfully")),
         );
         Navigator.pop(context);
        
   } else {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text("Failed to change password: ${response.data.toString()}")),
    );
    }
    
   } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Error: $e")),
    );

   } finally {
    setState(() => _isSubmitting = false);
   }
 }

 @override
 void dispose() {
  _currentPasswordController.dispose();
  _newPasswordController.dispose();
  _retypePasswordController.dispose();
  super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 112, 88, 176),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Current password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New password',
                  border: OutlineInputBorder(),
                ),
              ),
             
              SizedBox(height: 20,),
              TextFormField(
                controller: _retypePasswordController,
                decoration: InputDecoration(
                  labelText: 'Retype New password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(onPressed: (){
                _changePassword();

              }, child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18),),style:ElevatedButton.styleFrom(
                backgroundColor: Colors.black,  minimumSize: Size(130, 50),
               ),
              ),
          
            ],
          ),
        ),

      ),
    );
  }
}