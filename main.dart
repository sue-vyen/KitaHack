import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const geminiApiKey = 'PASTE YOUR API KEY HERE';

void main() {
  runApp(
    const WaterMonitoringApp(),
  );
}

class WaterMonitoringApp extends StatelessWidget {
  const WaterMonitoringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real-Time Water Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WaterMonitorScreen(),
    );
  }
}

class WaterMonitorScreen extends StatefulWidget {
  const WaterMonitorScreen({super.key});

  @override
  _WaterMonitorScreenState createState() => _WaterMonitorScreenState();
}

class _WaterMonitorScreenState extends State<WaterMonitorScreen> {
  late StreamSubscription _sensorDataSubscription;
  Map<String, dynamic> _sensorData = {};
  String _analysisResult = 'Waiting for data...';

  @override
  void initState() {
    super.initState();
    _startSensorDataStream();
  }

  @override
  void dispose() {
    _sensorDataSubscription.cancel();
    super.dispose();
  }

  void _startSensorDataStream() {
    final sensorDataStream = generateSensorData();

    _sensorDataSubscription = sensorDataStream.listen((data) {
      setState(() {
        _sensorData = data;
      });

      // Analyze data with Gemini
      analyzeDataWithGemini(data).then((analysisResult) {
        setState(() {
          _analysisResult = analysisResult;
        });
      });
    });
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

  Future<String> analyzeDataWithGemini(Map<String, dynamic> data) async {
    if (geminiApiKey.isEmpty) {
      return 'Gemini API key not provided. Skipping analysis.';
    }
    // Construct the prompt for Gemini
    final prompt = """
Analyze the following water quality data and provide suitable recommendations and solutions:
Timestamp: ${data['timestamp']}
pH: ${data['pH']}
Turbidity: ${data['turbidity']}
Temperature: ${data['temperature']}

Consider the normal ranges for pH (6.5-8.5), turbidity (0-5 NTU), and temperature (15-30°C).
Identify any potential issues and suggest solutions for maintaining water quality.
""";

    // Call Gemini API
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Water Monitor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Real-Time Water Data',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Timestamp: ${_sensorData['timestamp'] ?? 'Loading...'}'),
            const SizedBox(height: 10),
            Text('pH: ${_sensorData['pH']?.toStringAsFixed(2) ?? 'Loading...'}'),
            Text('Turbidity: ${_sensorData['turbidity']?.toStringAsFixed(2) ?? 'Loading...'} NTU'),
            Text('Temperature: ${_sensorData['temperature']?.toStringAsFixed(2) ?? 'Loading...'} °C'),
            const SizedBox(height: 20),
            const Text(
              'Analysis Result',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _analysisResult,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
