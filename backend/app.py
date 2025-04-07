from flask import Flask, request, jsonify
from flask_cors import CORS
from water_quality_data import water_data
from gemini_integration import analyze_with_gemini

app = Flask(__name__)
CORS(app) # Enable Cross-Origin Resource Sharing for local development

@app.route('/get_locations', methods=['GET'])
def get_locations():
    source_type = request.args.get('source_type')
    if source_type in water_data:
        return jsonify({'locations': list(water_data[source_type].keys())})
    return jsonify({'error': 'Invalid water source type'}), 400

@app.route('/detect_quality', methods=['POST'])
def detect_quality():
    data = request.get_json()
    source_type = data.get('source_type')
    location = data.get('location')

    if not source_type or not location:
        return jsonify({'error': 'Missing source type or location'}), 400

    if source_type in water_data and location in water_data[source_type]:
        water_quality_results = water_data[source_type][location]
        gemini_response = analyze_with_gemini(water_quality_results)
        print(f"DEBUG - Gemini Response:\n{gemini_response}")
        return jsonify({'results': water_quality_results, 'analysis': gemini_response})
    else:
        return jsonify({'error': 'Invalid source type or location'}), 404

if __name__ == '__main__':
    app.run(debug=True, port=5000)