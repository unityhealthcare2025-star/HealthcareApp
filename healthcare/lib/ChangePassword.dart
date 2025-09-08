import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

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
                decoration: InputDecoration(
                  labelText: 'Current password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New password',
                  border: OutlineInputBorder(),
                ),
              ),
             
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Retype New password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(onPressed: (){}, child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18),),style:ElevatedButton.styleFrom(
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