import 'package:flutter/material.dart';
import 'location_selection_screen.dart';

class WaterSourceSelectionScreen extends StatefulWidget {
  const WaterSourceSelectionScreen({super.key});

  @override
  State<WaterSourceSelectionScreen> createState() => _WaterSourceSelectionScreenState();
}

class _WaterSourceSelectionScreenState extends State<WaterSourceSelectionScreen> {
  String? _selectedSourceType;
  final List<String> _sourceTypes = ['river', 'sea', 'lake'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Water Source Type'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose the type of water source:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedSourceType,
              hint: const Text('Select a source'),
              items: _sourceTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSourceType = newValue;
                });
              },
            ),
            const SizedBox(height: 30), // Increased spacing for the hint text
            ElevatedButton(
              onPressed: _selectedSourceType == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationSelectionScreen(
                            sourceType: _selectedSourceType!,
                          ),
                        ),
                      );
                    },
              child: const Text('Next: Select Location'),
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