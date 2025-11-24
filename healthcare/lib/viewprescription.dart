import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/api/loginApi.dart';

class PrescriptionPage extends StatefulWidget {
  final int bookingId;
  PrescriptionPage({super.key, required this.bookingId});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {

  bool _isLoading=true;
  Map<String, dynamic>? _prescription;
  Future<void> fetchPrescription() async {
    try {
      setState(() => _isLoading = true);
    
    final response =
    await dio.get('$baseurl/ViewPrescription/${widget.bookingId}');
    print("Prescription api response: ${response.data}");

    if (response.statusCode == 200 &&
       response.data is List &&
       response.data.isNotEmpty){
      setState((){

        _prescription = Map<String, dynamic>.from(response.data[0]);
      });
       } else {
        throw Exception('No prescription found');
       }
    
    } catch (e) {
      print('Error fetching prescription: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to fetch precription'),
          backgroundColor: Colors.red.shade400,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
       
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchPrescription();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription'),
        backgroundColor:  const Color.fromARGB(255, 188, 103, 222),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color.fromARGB(255, 156, 175, 184)),
            width: double.infinity,
            height: 300,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Date issued:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                Text(_prescription?['Date'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                SizedBox(height: 10,),
                Text('Diagnosis:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                Text(_prescription?['Diagnosis'],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                SizedBox(height: 10,),
                Text('advice:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                Text(_prescription?['Advice'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                SizedBox(height: 10,),
                Text('Next visit date:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                Text(_prescription?['Next_visit_date'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
