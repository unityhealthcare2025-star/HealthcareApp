


// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:healthcare/TreatmentRec.dart';
// import 'package:healthcare/api/loginApi.dart';

// class SymptomPrediction extends StatefulWidget {
//   const SymptomPrediction({super.key});

//   @override
//   State<SymptomPrediction> createState() => _SymptomPredictionState();
// }

// class _SymptomPredictionState extends State<SymptomPrediction> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _symptomsController = TextEditingController();

//   bool _isLoading = false;
//   String? _predictedDisease;

//   Future<void> submitSymptoms() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() {
//       _isLoading = true;
//       _predictedDisease = null;
//     });

//     try {
//       final dio = Dio();
//       final response = await dio.post(
//         '$baseurl/chatbot/$loginid/',
//         data: {"symptoms": _symptomsController.text},
//       );

//       // Here we only extract the disease name or first line
//       String fullResponse = response.data['prediction_result'] ?? "";
//       String firstLine = fullResponse.split('\n').first; // take only the first line

//       setState(() {
//         _predictedDisease = firstLine;
//       });
//     } catch (e) {
//       setState(() {
//         _predictedDisease = "Error analyzing symptoms";
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
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
//         title: const Text('Symptom Prediction'),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text("Enter Symptoms:"),
//                 TextFormField(
//                   controller: _symptomsController,
//                   maxLines: 4,
//                   validator: (value) =>
//                       value == null || value.isEmpty ? "Enter symptoms" : null,
//                   decoration: const InputDecoration(
//                     hintText: "e.g., fever, cough...",
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : submitSymptoms,
//                   child: _isLoading
//                       ? const CircularProgressIndicator(
//                           color: Colors.white,
//                         )
//                       : const Text("Analyze"),
//                 ),
//                 const SizedBox(height: 24),
//                 if (_predictedDisease != null &&
//                     !_predictedDisease!.toLowerCase().contains("error")) ...[
//                   Text(
//                     "Predicted Disease:",
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     _predictedDisease!,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TreatmentRecommendationPage(
//                             diseaseName: _predictedDisease!,
//                           ),
//                         ),
//                       );
//                     },
//                     child: const Text("Get Treatment Plan"),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
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
        title: const Text(
          'Symptom Checker',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.deepPurple,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFF5F5F5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.deepPurple.withOpacity(0.2),
            height: 1,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.deepPurple.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Illustration/Icon
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.health_and_safety,
                          size: 40,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Title
                    const Center(
                      child: Text(
                        "How are you feeling today?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        "Describe your symptoms in detail",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Symptoms Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Symptoms Label with Icon
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.sick,
                                  color: Colors.deepPurple,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Your Symptoms",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          
                          // Symptoms Input Field
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.deepPurple.withOpacity(0.3),
                              ),
                            ),
                            child: TextFormField(
                              controller: _symptomsController,
                              maxLines: 5,
                              validator: (value) =>
                                  value == null || value.isEmpty ? "Please enter your symptoms" : null,
                              decoration: InputDecoration(
                                hintText: "e.g., fever, headache, fatigue, cough...",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Tips for better results
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.blue.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.blue.shade700,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "Be specific about your symptoms for better results",
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Analyze Button
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : submitSymptoms,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                elevation: 5,
                                shadowColor: Colors.deepPurple.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )
                                  : const Text(
                                      "Analyze Symptoms",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Results Section
                    if (_predictedDisease != null) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: _predictedDisease!.toLowerCase().contains("error")
                                  ? Colors.red.withOpacity(0.1)
                                  : Colors.green.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          border: Border.all(
                            color: _predictedDisease!.toLowerCase().contains("error")
                                ? Colors.red.withOpacity(0.3)
                                : Colors.green.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Result Header
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: _predictedDisease!.toLowerCase().contains("error")
                                        ? Colors.red.withOpacity(0.1)
                                        : Colors.green.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _predictedDisease!.toLowerCase().contains("error")
                                        ? Icons.error_outline
                                        : Icons.check_circle_outline,
                                    color: _predictedDisease!.toLowerCase().contains("error")
                                        ? Colors.red
                                        : Colors.green,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _predictedDisease!.toLowerCase().contains("error")
                                      ? "Analysis Error"
                                      : "Analysis Complete",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _predictedDisease!.toLowerCase().contains("error")
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            
                            if (!_predictedDisease!.toLowerCase().contains("error")) ...[
                              const SizedBox(height: 20),
                              
                              // Predicted Disease Label
                              const Text(
                                "Predicted Condition:",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              // Disease Name Card
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.deepPurple.withOpacity(0.2),
                                  ),
                                ),
                                child: Text(
                                  _predictedDisease!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.deepPurple,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 20),
                              
                              // Treatment Plan Button
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
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
                                  icon: const Icon(Icons.medical_services),
                                  label: const Text(
                                    "Get Treatment Plan",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.deepPurple,
                                    elevation: 2,
                                    side: BorderSide(
                                      color: Colors.deepPurple.withOpacity(0.5),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ] else ...[
                              const SizedBox(height: 15),
                              Text(
                                _predictedDisease!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}