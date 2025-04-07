import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> results;
  final String analysis;

  const ResultsScreen({super.key, required this.results, required this.analysis});

  // Helper function to determine box border color based on condition
  Color _getConditionColor(String condition) {
    if (condition.toLowerCase().contains('bad') || condition.toLowerCase().contains('unsafe')) {
      return Colors.red;
    } else if (condition.toLowerCase().contains('warning') || condition.toLowerCase().contains('moderate')) {
      return Colors.orange;
    } else if (condition.toLowerCase().contains('safe') || condition.toLowerCase().contains('good') || condition.toLowerCase().contains('high') || condition.toLowerCase().contains('low')) {
      return Colors.green;
    } else {
      return Colors.grey; // Default color
    }
  }

  // Helper function to determine box background color based on condition
  Color _getConditionBackgroundColor(String condition) {
    if (condition.toLowerCase().contains('bad') || condition.toLowerCase().contains('unsafe')) {
      return Colors.red.withOpacity(0.1);
    } else if (condition.toLowerCase().contains('warning') || condition.toLowerCase().contains('moderate')) {
      return Colors.orange.withOpacity(0.1);
    } else if (condition.toLowerCase().contains('safe') || condition.toLowerCase().contains('good') || condition.toLowerCase().contains('high') || condition.toLowerCase().contains('low')) {
      return Colors.green.withOpacity(0.1);
    } else {
      return Colors.grey.withOpacity(0.1); // Default color
    }
  }

  // Helper function to format pollutants
  String _formatPollutants(List? pollutants) {
    if (pollutants != null && pollutants.isNotEmpty) {
      return pollutants.join(', ');
    }
    return 'None detected';
  }

  @override
  Widget build(BuildContext context) {
    String dissolvedOxygen = results['Dissolved Oxygen']?.toString() ?? 'N/A';
    List? pollutants = results['Pollutants'] as List?;
    String turbidity = results['Turbidity']?.toString() ?? 'N/A';
    String ph = results['pH']?.toString() ?? 'N/A';
    String temperature = results['Temperature']?.toString() ?? 'N/A';
    String salinity = results['Salinity']?.toString() ?? 'N/A';
    String algaeBlooms = results['Algae Blooms']?.toString() ?? 'N/A';
    String oxygenLevels = results['Oxygen Levels']?.toString() ?? 'N/A';
    String waterClarity = results['Water Clarity']?.toString() ?? 'N/A';
    String nutrientLevels = results['Nutrient Levels']?.toString() ?? 'N/A';
    String plasticPollution = results['Plastic Pollution']?.toString() ?? 'N/A';
    String coralBleachingRisk = results['Coral Bleaching Risk']?.toString() ?? 'N/A';
    String coralReefHealth = results['Coral Reef Health']?.toString() ?? 'N/A';
    String iceMeltRate = results['Ice Melt Rate']?.toString() ?? 'N/A';
    String oceanAcidification = results['Ocean Acidification']?.toString() ?? 'N/A';
    String fishStocks = results['Fish Stocks']?.toString() ?? 'N/A';
    String pollutionSources = results['Pollution Sources']?.toString() ?? 'N/A';
    String invasiveSpecies = results['Invasive Species']?.toString() ?? 'N/A';
    String sedimentation = results['Sedimentation']?.toString() ?? 'N/A';
    String aquaticVegetation = results['Aquatic Vegetation']?.toString() ?? 'N/A';
    String waterLevels = results['Water Levels']?.toString() ?? 'N/A';
    String algaeGrowth = results['Algae Growth']?.toString() ?? 'N/A';
    String microplasticConcentration = results['Microplastic Concentration']?.toString() ?? 'N/A';
    String seaLevelRise = results['Sea Level Rise']?.toString() ?? 'N/A';

    // Split the Gemini analysis into sections
    List<String> analysisSections = analysis.split('\n\n');
    String summary = '';
    String condition = '';
    List<String> potentialProblems = [];
    List<String> actionableSolutions = [];

    for (var section in analysisSections) {
      if (section.toLowerCase().startsWith('water quality analysis summary')) {
        summary = section.substring('Water Quality Analysis Summary:'.length).trim();
      } else if (section.toLowerCase().startsWith('condition:')) {
        condition = section.substring('Condition:'.length).trim();
      } else if (section.toLowerCase().startsWith('potential problems:')) {
        final problems = section.substring('Potential Problems:'.length).trim().split('\n');
        potentialProblems = problems.where((p) => p.isNotEmpty).toList();
      } else if (section.toLowerCase().startsWith('actionable solutions:')) {
        final solutions = section.substring('Actionable Solutions:'.length).trim().split('\n');
        actionableSolutions = solutions.where((s) => s.isNotEmpty).toList();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Water Quality Results:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Dissolved Oxygen 🫧: $dissolvedOxygen'),
            Text('Pollutants 💀: ${_formatPollutants(pollutants)}'),
            Text('Turbidity 🌬️: $turbidity'),
            Text('pH 🧪: $ph'),
            if (temperature != 'N/A') Text('Temperature 🔥: $temperature °C'),
            if (salinity != 'N/A') Text('Salinity 🧂: $salinity PSU'),
            if (algaeBlooms != 'N/A') Text('Algae Blooms 🦠: $algaeBlooms'),
            if (oxygenLevels != 'N/A') Text('Oxygen Levels 🫁: $oxygenLevels'),
            if (waterClarity != 'N/A') Text('Water Clarity 👓: $waterClarity'),
            if (nutrientLevels != 'N/A') Text('Nutrient Levels 🌱: $nutrientLevels'),
            if (plasticPollution != 'N/A') Text('Plastic Pollution 🗑️: $plasticPollution'),
            if (coralBleachingRisk != 'N/A') Text('Coral Bleaching Risk 🌡️: $coralBleachingRisk'),
            if (coralReefHealth != 'N/A') Text('Coral Reef Health 🐠: $coralReefHealth'),
            if (iceMeltRate != 'N/A') Text('Ice Melt Rate 🧊: $iceMeltRate'),
            if (oceanAcidification != 'N/A') Text('Ocean Acidification 🍋: $oceanAcidification'),
            if (fishStocks != 'N/A') Text('Fish Stocks 🐟: $fishStocks'),
            if (pollutionSources != 'N/A') Text('Pollution Sources 🏭: $pollutionSources'),
            if (invasiveSpecies != 'N/A') Text('Invasive Species 👾: $invasiveSpecies'),
            if (sedimentation != 'N/A') Text('Sedimentation ⛰️: $sedimentation'),
            if (aquaticVegetation != 'N/A') Text('Aquatic Vegetation 🌿: $aquaticVegetation'),
            if (waterLevels != 'N/A') Text('Water Levels 🌊: $waterLevels'),
            if (algaeGrowth != 'N/A') Text('Algae Growth 藻: $algaeGrowth'),
            if (microplasticConcentration != 'N/A') Text('Microplastic Concentration <0xF0><0x9F><0xAA><0xB3>: $microplasticConcentration'),
            if (seaLevelRise != 'N/A') Text('Sea Level Rise ⬆️: $seaLevelRise'),
            const SizedBox(height: 20),
            const Text(
              'Gemini AI Analysis and Solutions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: _getConditionColor(condition), width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
                color: _getConditionBackgroundColor(condition),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Water Quality Analysis Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text('Condition: $condition', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(summary),
                ],
              ),
            ),
            const SizedBox(height: 15),
            if (potentialProblems.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Potential Problems',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: potentialProblems.map((problem) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• '), // Bullet point
                              Expanded(
                                child: Text(problem.trim()),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 15),
            if (actionableSolutions.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Actionable Solutions',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: actionableSolutions.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        String solution = entry.value.trim();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text('$index. $solution'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}