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
  int? selectedHospitalId; // Holds selected hospital ID

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

    setState(() {
      isLoading = true;
    });

final success = await complaintApi(subject, description, selectedHospitalId!,);

    setState(() {
      isLoading = false;
    });

    if (success) {
      subjectController.clear();
      descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint sent successfully')),
      );

      // Refresh complaints list
      await _loadComplaints();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to send complaint')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Complaint',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 195, 96, 241),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<int>(
                  value: selectedHospitalId,
                  decoration: const InputDecoration(
                    labelText: 'Select Hospital',
                    border: OutlineInputBorder(),
                  ),
                  items: hospitals.map((hospital) {
                    return DropdownMenuItem<int>(
                      value: hospital['id'],
                      child: Text(hospital['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedHospitalId = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a hospital' : null,
                ),
                const SizedBox(height: 15),

                const SizedBox(height: 15),
                TextFormField(
                  controller: subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter subject'
                      : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  maxLines: 3,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter description'
                      : null,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _sendComplaint,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(130, 50),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Previous Complaints:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: complaints.length,
                  itemBuilder: (context, index) {
                    final item = complaints[index];
                    final subject = item['Subject'] ?? 'No Subject';
                    final reply = item['Response'] ?? 'No reply yet';

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: const Color.fromARGB(255, 211, 215, 218),
                        title: Text('Subject: $subject'),
                        subtitle: Text('Reply: $reply'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
