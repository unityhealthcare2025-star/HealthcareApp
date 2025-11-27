import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healthcare/api/loginApi.dart';

class DoctorFeedbackRating extends StatefulWidget {
  final String? doctorid;
  DoctorFeedbackRating({super.key, this.doctorid});

  @override
  State<DoctorFeedbackRating> createState() => _DoctorFeedbackRatingState();
}

class _DoctorFeedbackRatingState extends State<DoctorFeedbackRating> {

  double _rating=0;

  final TextEditingController _commentController = TextEditingController();
  

  bool _isSubmitting = false;
  Future <void> SubmitFeedback() async{
    if (_rating == 0){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("please providing a rating"),
          backgroundColor: Colors.orange.shade400,
          ),
      );
      return;
    }
    if (_commentController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("please enter a comment"),
          backgroundColor: Colors.orange.shade400,
          ),
      );
      return;
    }
    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await dio.post(
        '$baseurl/Feedback/$loginid',
        data: {
          'DOCTOR': widget.doctorid,
          'Rating': _rating,
          'Comment': _commentController.text,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Feedback submitted successfully!"),
            backgroundColor: Colors.green.shade400,
            ),
            );
            Navigator.pop(context);
      } else {
        throw Exception('Failed to submit feedback');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red.shade400,
           ),
           );
           
          } finally {
            setState(() {
              _isSubmitting = false;
            });
          }
  }
    @override
    void dispose() {
      _commentController.dispose();
      super.dispose();
    }

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
                
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 45, 
                  glow: true,
                  glowColor: Colors.amber.withOpacity(0.3),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ), 
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  } ,
                ),
                if (_rating > 0) ...[
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber.withOpacity(0.2),
                            Colors.orange.withOpacity(0.2)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_rating.toStringAsFixed(1)} / 5.0',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                
              
                  
                      
                         SizedBox(height: 24),
                 TextFormField(
                  controller: _commentController,
                  maxLines: 5,
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
                onPressed: () {
                  SubmitFeedback();
                },
                child: Text('Submit Feedback',style: TextStyle(fontSize: 18),),
              ),
   ]
              ]
    )
    )
    )
    )
    );
}
}