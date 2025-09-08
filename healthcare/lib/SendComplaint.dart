import 'package:flutter/material.dart';

class SendComplaint extends StatelessWidget {
  const SendComplaint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Complaint', style: TextStyle(color:Colors.white )),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 195, 96, 241),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              SizedBox(height: 15),
              TextFormField(
                decoration:  InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 15),
                TextFormField(maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder()
              ),
              ),
              SizedBox(height: 15),
              ElevatedButton(onPressed: (){}, child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18),),style:ElevatedButton.styleFrom(
                backgroundColor: Colors.black,  minimumSize: Size(130, 50),
               ),
              ),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Previous Complaints:', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 24),),
                ],
              ),
              SizedBox(height: 500,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                    tileColor: const Color.fromARGB(255, 211, 215, 218),
                    title: Text('Complaint:'),
                    subtitle: Text('reply'),
                  ),
                );
              },),
              )
            ],
          ),
        ),
        ),
    );
  }
}