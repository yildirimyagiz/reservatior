import requests
import json

class Phi3Bridge:
    def __init__(self, endpoint="http://localhost:11434/api/generate"):
        self.endpoint = endpoint

    def translate(self, text, target_lang="tr"):
        prompt = f"Translate the following real estate video transcription to {target_lang}. Keep the terminology professional: '{text}'"
        
        payload = {
            "model": "phi3",
            "prompt": prompt,
            "stream": False
        }
        
        try:
            response = requests.post(self.endpoint, json=payload)
            response.raise_for_status()
            return response.json().get('response', '')
        except Exception as e:
            print(f"Phi3 Translation Error: {e}")
            return text # Fallback to original
