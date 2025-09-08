import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DoctorFeedbackRating extends StatefulWidget {
  const DoctorFeedbackRating({super.key});

  @override
  State<DoctorFeedbackRating> createState() => _DoctorFeedbackRatingState();
}

class _DoctorFeedbackRatingState extends State<DoctorFeedbackRating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Feedback and Rating',style: TextStyle(color: Colors.white),
        ),
         centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 195, 96, 241),
      ),
       body: Padding(padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Doctor',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 15),
                 TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Rating',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 15),
                 TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 15),
                   ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(217, 0, 0, 0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                  minimumSize: Size(100, 40)
                ),
                onPressed: () {},
                child: Text('Submit Feedback',style: TextStyle(fontSize: 18),),
              ),
   ]
    
    )
    )
    )
    )
    );
}
}