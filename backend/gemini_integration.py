import os
from dotenv import load_dotenv
from google import genai  # Changed import

load_dotenv()
# GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
GEMINI_API_KEY = "AIzaSyDJ649ckDH_kM_9j2EnXPgpezWsdotDJJ8" # <-- insert your own Genesis AI API key here
print(f"DEBUG: Gemini API Key is: '{GEMINI_API_KEY}'")

def analyze_with_gemini(water_quality_data):
    if not GEMINI_API_KEY:
        return "Error: Gemini API key not configured."

    client = genai.Client(api_key=GEMINI_API_KEY)  # Using the new client

    prompt = f"""
    Analyze the following water quality data and provide a concise summary of the water condition, starting with "Condition: ".
    The list potential problems starting with "Potential Problems:". Finally, list actionable solutions to improve the quality starting with "Actionable Solutions: ".
    
    
    Water Quality Data:
    {water_quality_data}
    """

    try:
        response = client.models.generate_content(
            model="gemini-2.0-flash",  # Using the model from your snippet
            contents=prompt,
        )
        return response.text
    except Exception as e:
        return f"Error communicating with Gemini API: {e}"

if __name__ == '__main__':
    test_data = {"pH": 6.2, "Algae Blooms": "High", "Fish Stocks": "Decreasing", "Pollution Sources": ["Sewage", "Industrial"]}
    analysis = analyze_with_gemini(test_data)
    print(analysis)