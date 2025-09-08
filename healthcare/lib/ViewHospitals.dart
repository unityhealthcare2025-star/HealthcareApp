import 'package:flutter/material.dart';

class ViewHospitals extends StatelessWidget {
  const ViewHospitals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('View nearby Hospital',style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 188, 103, 222),
        ),
        body: Padding(padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'city',
                  border: OutlineInputBorder()
                ),
              ),
               SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'pincode',
                  border: OutlineInputBorder()
                ),
              ),
               SizedBox(height: 15),
              ElevatedButton(onPressed: (){}, child: Text("Search",style: TextStyle(color: Colors.white,fontSize: 18),),style:ElevatedButton.styleFrom(
              backgroundColor: Colors.black,                minimumSize: Size(130, 50),
             ),
            ),
            SizedBox(height: 500,
              child: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: const Color.fromARGB(255, 162, 172, 177)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/hsptl.png', height: 100,width: 100,),
                          Text('Medical College', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18),),
                          Text('Phone: 9876543123'),
                          Text('Email: abc@gmail.com'),
                          Text('Address: Medical College, Calicut')
                        ],
                      ),
                    ),
                  ),
                );
              },),
            )
            ])
        )));
  
  }
}