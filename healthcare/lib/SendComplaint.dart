
// import 'package:flutter/material.dart';
// import 'package:healthcare/api/complaintApi.dart';

// class SendComplaint extends StatefulWidget {
//   const SendComplaint({super.key});

//   @override
//   State<SendComplaint> createState() => _SendComplaintState();
// }

// class _SendComplaintState extends State<SendComplaint> {
//   final TextEditingController subjectController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   List<Map<String, dynamic>> hospitals = [];
//   List<Map<String, dynamic>> complaints = [];
//   int? selectedHospitalId;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadComplaints();
//   }

//   Future<void> _loadComplaints() async {
//     final data = await getComplaintsApi(context);
//     setState(() {
//       complaints = List<Map<String, dynamic>>.from(data['complaints'] ?? []);
//       hospitals = List<Map<String, dynamic>>.from(data['hos'] ?? []);
//     });
//   }

//   Future<void> _sendComplaint() async {
//     if (!_formKey.currentState!.validate()) return;
//     final subject = subjectController.text.trim();
//     final description = descriptionController.text.trim();

//     setState(() => isLoading = true);

//     final success = await complaintApi(subject, description, selectedHospitalId!);

//     setState(() => isLoading = false);

//     if (success) {
//       subjectController.clear();
//       descriptionController.clear();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Complaint sent successfully')),
//       );
//       await _loadComplaints();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to send complaint')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Send Complaint'),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,// hunter green
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Dropdown for hospitals
//                 DropdownButtonFormField<int>(
//                   value: selectedHospitalId,
//                   decoration: InputDecoration(
//                     labelText: 'Select Hospital',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   items: hospitals.map((hospital) {
//                     return DropdownMenuItem<int>(
//                       value: hospital['id'],
//                       child: Text(hospital['name']),
//                     );
//                   }).toList(),
//                   onChanged: (value) => setState(() => selectedHospitalId = value),
//                   validator: (value) =>
//                       value == null ? 'Please select a hospital' : null,
//                 ),
//                 const SizedBox(height: 15),

//                 // Subject
//                 TextFormField(
//                   controller: subjectController,
//                   decoration: InputDecoration(
//                     labelText: 'Subject',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value == null || value.trim().isEmpty ? 'Please enter subject' : null,
//                 ),
//                 const SizedBox(height: 15),

//                 // Description
//                 TextFormField(
//                   maxLines: 4,
//                   controller: descriptionController,
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   validator: (value) =>
//                       value == null || value.trim().isEmpty ? 'Please enter description' : null,
//                 ),
//                 const SizedBox(height: 20),

//                 // Submit Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: isLoading ? null : _sendComplaint,
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: Colors.deepPurpleAccent, // hunter green
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: isLoading
//                         ? const CircularProgressIndicator(color: Color.fromARGB(255, 16, 2, 2))
//                         : const Text(
//                             'Submit',
//                             style: TextStyle(fontSize: 18),
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Previous Complaints Header
//                 Row(
//                   children: const [
//                     Text(
//                       'Previous Complaints',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurple,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),

//                 // Previous complaints list
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: complaints.length,
//                   itemBuilder: (context, index) {
//                     final item = complaints[index];
//                     final subject = item['Subject'] ?? 'No Subject';
//                     final reply = item['Response'] ?? 'No reply yet';
//                     return Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       margin: const EdgeInsets.symmetric(vertical: 6),
//                       color: Colors.grey[200],
//                       child: ListTile(
//                         title: Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
//                         subtitle: Text('Reply: $reply'),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:healthcare/api/complaintApi.dart';

class SendComplaint extends StatefulWidget {
  const SendComplaint({super.key});

  @override
  State<SendComplaint> createState() => _SendComplaintState();
}

class _SendComplaintState extends State<SendComplaint> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> hospitals = [];
  List<Map<String, dynamic>> complaints = [];
  int? selectedHospitalId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadComplaints();
  }

  Future<void> _loadComplaints() async {
    final data = await getComplaintsApi(context);
    setState(() {
      complaints = List<Map<String, dynamic>>.from(data['complaints'] ?? []);
      hospitals = List<Map<String, dynamic>>.from(data['hos'] ?? []);
    });
  }

  Future<void> _sendComplaint() async {
    if (!_formKey.currentState!.validate()) return;
    final subject = subjectController.text.trim();
    final description = descriptionController.text.trim();

    setState(() => isLoading = true);

    final success = await complaintApi(subject, description, selectedHospitalId!);

    setState(() => isLoading = false);

    if (success) {
      subjectController.clear();
      descriptionController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              const Text('Complaint sent successfully'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      await _loadComplaints();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              const Text('Failed to send complaint'),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Complaint',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadComplaints,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color(0xFF6C5CE7).withOpacity(0.05),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Header Icon
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.support_agent,
                      size: 40,
                      color: Color(0xFF6C5CE7),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                const Text(
                  "We're here to help",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C5CE7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please share your concerns with us",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 30),

                // Complaint Form Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C5CE7).withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Hospital Dropdown
                      DropdownButtonFormField<int>(
                        value: selectedHospitalId,
                        decoration: InputDecoration(
                          labelText: 'Select Hospital',
                          labelStyle: const TextStyle(color: Color(0xFF6C5CE7)),
                          prefixIcon: const Icon(
                            Icons.local_hospital,
                            color: Color(0xFF6C5CE7),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF6C5CE7),
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        items: hospitals.map((hospital) {
                          return DropdownMenuItem<int>(
                            value: hospital['id'],
                            child: Text(
                              hospital['name'],
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => selectedHospitalId = value),
                        validator: (value) =>
                            value == null ? 'Please select a hospital' : null,
                      ),
                      const SizedBox(height: 20),

                      // Subject Field
                      TextFormField(
                        controller: subjectController,
                        decoration: InputDecoration(
                          labelText: 'Subject',
                          labelStyle: const TextStyle(color: Color(0xFF6C5CE7)),
                          prefixIcon: const Icon(
                            Icons.title,
                            color: Color(0xFF6C5CE7),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF6C5CE7),
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty ? 'Please enter subject' : null,
                      ),
                      const SizedBox(height: 20),

                      // Description Field
                      TextFormField(
                        maxLines: 5,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: const TextStyle(color: Color(0xFF6C5CE7)),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Icon(
                              Icons.description,
                              color: Color(0xFF6C5CE7),
                            ),
                          ),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF6C5CE7),
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty ? 'Please enter description' : null,
                      ),
                      const SizedBox(height: 25),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _sendComplaint,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C5CE7),
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shadowColor: const Color(0xFF6C5CE7).withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.send),
                                    SizedBox(width: 8),
                                    Text(
                                      'Submit Complaint',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Previous Complaints Section
                if (complaints.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C5CE7).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.history,
                            color: Color(0xFF6C5CE7),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Previous Complaints',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C5CE7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Previous complaints list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      final item = complaints[index];
                      final subject = item['Subject'] ?? 'No Subject';
                      final reply = item['Response'] ?? 'No reply yet';
                      final isReplied = item['Response'] != null && item['Response'].toString().isNotEmpty;
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6C5CE7).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.feedback_outlined,
                                      size: 16,
                                      color: Color(0xFF6C5CE7),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      subject,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isReplied 
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.orange.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      isReplied ? 'Replied' : 'Pending',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: isReplied ? Colors.green : Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.reply,
                                      size: 16,
                                      color: isReplied ? Colors.green.shade600 : Colors.orange.shade600,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        reply,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isReplied ? Colors.grey.shade800 : Colors.grey.shade600,
                                          fontStyle: isReplied ? FontStyle.normal : FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ] else ...[
                  // Empty state for complaints
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.inbox,
                          size: 60,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No Complaints Yet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your submitted complaints will appear here',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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