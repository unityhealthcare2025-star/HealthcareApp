import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TreatmentRecommendationPage extends StatefulWidget {
  final String diseaseName;

  const TreatmentRecommendationPage({super.key, required this.diseaseName});

  @override
  State<TreatmentRecommendationPage> createState() =>
      _TreatmentRecommendationPageState();
}

class _TreatmentRecommendationPageState
    extends State<TreatmentRecommendationPage> {
  String? _treatmentPlan;
  bool _isLoading = true;

  final String _apiKey = "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"; // Replace with your key

  @override
  void initState() {
    super.initState();
    _fetchTreatmentPlan();
  }

  Future<void> _fetchTreatmentPlan() async {
    final url = Uri.parse("https://openrouter.ai/api/v1/chat/completions");

    final prompt = """
You are a medical assistant.
The predicted disease is: ${widget.diseaseName}.
Provide a structured treatment plan including:
1. Home remedies
2. Common over-the-counter medicines (if safe)
3. Lifestyle advice
4. When the patient should visit a doctor
Format it clearly so it can be displayed directly on a screen. 
Do not use * or markdown symbols.
Keep it simple and easy to read.
""";

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
          "HTTP-Referer": "http://localhost",
          "X-Title": "HealthAI Assistant",
        },
        body: jsonEncode({
          "model": "openai/gpt-4.1-mini",
          "messages": [
            {"role": "system", "content": "You are a helpful medical assistant."},
            {"role": "user", "content": prompt}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content =
            data["choices"][0]["message"]["content"] ?? "No response received.";

        setState(() {
          _treatmentPlan = content.replaceAll("*", ""); // remove asterisks
        });
      } else {
        setState(() {
          _treatmentPlan = "API Error: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _treatmentPlan = "Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildTreatmentPlan() {
    if (_treatmentPlan == null) return const SizedBox();

    // Split lines for readability
    final lines = _treatmentPlan!.split("\n").where((line) => line.trim().isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines
          .map((line) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  line,
                  style: const TextStyle(fontSize: 15),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Treatment Recommendation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Predicted Disease:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.diseaseName, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    const Text(
                      "Treatment Plan:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTreatmentPlan(),
                    const SizedBox(height: 20),
                    Text(
                      "Disclaimer: This is AI-generated advice. Please consult a healthcare professional.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
