// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:healthcare/TreatmentRec.dart';
// import 'package:healthcare/api/loginApi.dart';

// class symptomPrediction extends StatefulWidget {
//   const symptomPrediction({super.key});

//   @override
//   State<symptomPrediction> createState() => _symptomPredictionState();
// }

// class _symptomPredictionState extends State<symptomPrediction> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _symptomsController = TextEditingController();

//   bool _isLoading = false;
//   String? _predictionResult;
//   // final _formkey=GlobalKey<FormState>();

//   Future<void> submitSymptoms() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() {
//       _isLoading = true;
//       _predictionResult = null;
//     });
//     try {
//       final dio = Dio();
//       final response = await dio.post(
//         '$baseurl/chatbot/$loginid/',
//         data: {
//           "symptoms": _symptomsController.text,
//         },
//       );print(response.data);
//       setState(() {
//         _predictionResult = 
//             response.data['prediction_result'] ?? "No prediction available";
//       });
//       print(response.data);
//     } catch(e) {
//       setState(() {
//         _predictionResult = "Error submitting symptoms";
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//   @override
//   void dispose() {
//     _symptomsController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Symptom prediction'),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding:const EdgeInsets.all(16),
//        child: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("Enter Symptoms:"),
            
//             TextFormField(
//                   controller: _symptomsController,
//                   maxLines: 4,
//                   validator: (value) => 
//                   value == null || value.isEmpty ? "Enter symptoms": null,

//                   decoration: const InputDecoration(
//                     hintText: "e.g, fever,cough...",
                    
//                 ),),
//                  const  SizedBox( height: 16),
//                  ElevatedButton(
//                   onPressed: _isLoading ? null : submitSymptoms,
//                   child:  _isLoading
//                       ? const CircularProgressIndicator()
//                       : const Text("Analyze"),
//                  ),
//                  const SizedBox(height: 24),
//                  if(_predictionResult != null) ...[
//                   Text(
//                     "Diagnosis Result:",
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(_predictionResult!),
//                   if (!_predictionResult!.toLowerCase().contains("error")&&
//                      !_predictionResult!.toLowerCase().contains("no prediction"))
//                      TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => TreatmentRecommendationPage(
//                               diseaseName: _predictionResult!,
//                             ),
//                           ),
//                         );
//                       },
//                       child: const Text("Get Treatment plan"),
//                      ),
                 
//                 ],
        
//        ]
//        ),)

//     ))
//     );
//   }
// }


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/TreatmentRec.dart';
import 'package:healthcare/api/loginApi.dart';

class SymptomPrediction extends StatefulWidget {
  const SymptomPrediction({super.key});

  @override
  State<SymptomPrediction> createState() => _SymptomPredictionState();
}

class _SymptomPredictionState extends State<SymptomPrediction> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _symptomsController = TextEditingController();

  bool _isLoading = false;
  String? _predictedDisease;

  Future<void> submitSymptoms() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _predictedDisease = null;
    });

    try {
      final dio = Dio();
      final response = await dio.post(
        '$baseurl/chatbot/$loginid/',
        data: {"symptoms": _symptomsController.text},
      );

      // Here we only extract the disease name or first line
      String fullResponse = response.data['prediction_result'] ?? "";
      String firstLine = fullResponse.split('\n').first; // take only the first line

      setState(() {
        _predictedDisease = firstLine;
      });
    } catch (e) {
      setState(() {
        _predictedDisease = "Error analyzing symptoms";
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _symptomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Prediction'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter Symptoms:"),
                TextFormField(
                  controller: _symptomsController,
                  maxLines: 4,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter symptoms" : null,
                  decoration: const InputDecoration(
                    hintText: "e.g., fever, cough...",
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : submitSymptoms,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Analyze"),
                ),
                const SizedBox(height: 24),
                if (_predictedDisease != null &&
                    !_predictedDisease!.toLowerCase().contains("error")) ...[
                  Text(
                    "Predicted Disease:",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _predictedDisease!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TreatmentRecommendationPage(
                            diseaseName: _predictedDisease!,
                          ),
                        ),
                      );
                    },
                    child: const Text("Get Treatment Plan"),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
