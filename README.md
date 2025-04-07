# KitaHack

**Tak Clean Tak Safe**

- SDG 6: Clean Water And Sanitation
- SDG 14: Life Below Water

**_FOR Real-Time Water Monitoring Device files: water_monitoring.dart & main.dart_**
BEFORE YOU RUN water_monitoring.dart:

  1. Get your own Gemini api key from the link below:
  
      --> https://ai.google.dev/gemini-api/docs/api-key
  
  2. Copy and paste the api key into the file:
  
      --> line 5: const geminiApiKey = 'PASTE YOUR API KEY HERE';
     
      --> line 70: final apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key= PASTE YOUR API KEY HERE";


BEFORE YOU RUN main.dart (flutter version):

  1. Get your own Gemini api key from the link below:
  
      --> https://ai.google.dev/gemini-api/docs/api-key
  
  2. Copy and paste the api key into the file:
  
      --> line 6: const geminiApiKey = 'PASTE YOUR API KEY HERE';
     
      --> line 115: final apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=PASTE YOUR API KEY HERE";



**_FOR Area Water Monitoring Device files: backend & lib_**
BEFORE YOU RUN backend:

1. Get your own Gemini api key from the link below:
  
      --> https://ai.google.dev/gemini-api/docs/api-key
  
  2. Copy and paste the api key into the file:

     --> line 7 in _gemini_integration.py_: GEMINI_API_KEY = "Paste_your_own_API_here"

BEFORE YOU RUN lib:

it is expected that the default flutter files are present, and files inside lib are the same as the ones in this folder.

**How to Run The Program?**

1. Execute app.py first: _python app.py_
2. Once you see 'Running on http://127.0.0.1:5000'
3. Open another terminal under the directory 'water_quality_detector_app'
4. Execute with _flutter run_
