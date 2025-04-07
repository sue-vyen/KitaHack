import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const geminiApiKey = 'PASTE YOUR API KEY HERE';

void main() async {
  print('Real-time Water Monitoring System');

  final sensorDataStream = generateSensorData();

  await processSensorDataStream(sensorDataStream);
}

Stream<Map<String, dynamic>> generateSensorData() async* {
  // Simulate sensor readings
  final random = DateTime.now().microsecondsSinceEpoch;
  double ph = 7.0;
  double turbidity = 10.0;
  double temperature = 25.0;

  while (true) {
    ph += (random % 3 - 1) * 0.01;
    turbidity += (random % 5 - 2) * 0.1;
    temperature += (random % 2 - 1) * 0.05;

    ph = ph.clamp(0.0, 14.0);
    turbidity = turbidity.clamp(0.0, 100.0);
    temperature = temperature.clamp(0.0, 40.0);

    final data = {
      'timestamp': DateTime.now().toIso8601String(),
      'pH': ph,
      'turbidity': turbidity,
      'temperature': temperature,
    };

    yield data;
    await Future.delayed(const Duration(seconds: 5));
  }
}

Future<void> processSensorDataStream(Stream<Map<String, dynamic>> dataStream) async {
  await for (final data in dataStream) {
    print('Received sensor data: $data');

    // Analyze data with Gemini
    final analysisResult = await analyzeDataWithGemini(data);
    print('Gemini Analysis: $analysisResult');
    implementSolution(analysisResult);
  }
}

Future<String> analyzeDataWithGemini(Map<String, dynamic> data) async {
  if (geminiApiKey.isEmpty) {
    return 'Gemini API key not provided. Skipping analysis.';
  }
  // Construct the prompt for Gemini
  final prompt = """
Analyze the following water quality data and provide potential issues and suitable recommendations:
Timestamp: ${data['timestamp']}
pH: ${data['pH']}
Turbidity: ${data['turbidity']}
Temperature: ${data['temperature']}

Consider the normal ranges for pH (6.5-8.5), turbidity (0-5 NTU), and temperature (15-30°C).
Identify any potential issues and suggest solutions for maintaining water quality.
""";

  final apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=PASTE YOUR API KEY HERE";

  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    'contents': [
      {
        'parts': [
          {'text': prompt}
        ]
      }
    ]
  });

  try {
    final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final analysis = decodedResponse['candidates'][0]['content']['parts'][0]['text'];
      return analysis;
    } else {
      print('Error calling Gemini API: ${response.statusCode} - ${response.body}');
      return 'Error';
    }
  } catch (e) {
    print('Exception calling Gemini API: $e');
    return 'Could not connect to Gemini API.';
  }
}

void implementSolution(String analysisResult) {

}
