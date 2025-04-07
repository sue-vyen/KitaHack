import 'package:flutter/material.dart';
import '../../screens/results_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationSelectionScreen extends StatefulWidget {
  final String sourceType;
  const LocationSelectionScreen({super.key, required this.sourceType});

  @override
  State<LocationSelectionScreen> createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String? _selectedLocation;
  List<String> _locations = [];

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    final response = await http.get(
      Uri.parse('http://localhost:5000/get_locations?source_type=${widget.sourceType}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _locations = List<String>.from(data['locations']);
      });
    } else {
      // Handle error fetching locations
      print('Failed to fetch locations: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load locations.')),
      );
    }
  }

  Future<void> _detectWaterQuality() async {
    if (_selectedLocation != null) {
      final response = await http.post(
        Uri.parse('http://localhost:5000/detect_quality'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'source_type': widget.sourceType,
          'location': _selectedLocation,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(results: data['results'], analysis: data['analysis']),
          ),
        );
      } else {
        // Handle error detecting quality
        print('Failed to detect quality: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to detect water quality.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Water Source Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose a location:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedLocation,
              hint: const Text('Select a location'),
              items: _locations.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
            ),
            const SizedBox(height: 30), // Increased spacing
            ElevatedButton(
              onPressed: _detectWaterQuality,
              child: const Text('Detect Water Quality'),
            ),
            const SizedBox(height: 8),
            const Text(
              'Click Once and Wait ⏳',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}