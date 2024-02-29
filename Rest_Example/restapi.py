import requests
import os

# Definiere die URL für den Flughafenabruf
airport_url = "https://airport-info.p.rapidapi.com/airport"
# Definiere die URL für den Übersetzungsdienst
translator_text_url = "https://aibit-translator.p.rapidapi.com/api/v1/translator/text"
translator_json_url = "https://aibit-translator.p.rapidapi.com/api/v1/translator/json"

rapidapi_airport_host = "airport-info.p.rapidapi.com"
rapidapi_trnsltr_host = "aibit-translator.p.rapidapi.com"

# Hole den API-Schlüssel aus einer Umgebungsvariable
rapidapi_key = os.environ.get('RAPIDAPI_KEY')

# Definiere die Header für die Anfrage
headers = {
    'X-Rapidapi-Key': rapidapi_key,
    'X-Rapidapi-Host': rapidapi_airport_host
}

# Definiere die Parameter für den Flughafenabruf
params = {
    'iata': 'VIE'
}

# Sende die GET-Anfrage für den Flughafen
response = requests.get(airport_url, headers=headers, params=params)
print("Flughafeninfo:")
print(response.json())

# Definiere die Parameter für die Textübersetzung
text_translation_payload = {
    'from': 'de',
    'to': 'en',
    'text': 'Willkommen auf meinem YouTube Kanal'
}

# Anpassung des Hosts
headers['X-Rapidapi-Host'] = rapidapi_trnsltr_host
# Füge den Content-Type hinzu
headers['Content-Type'] = 'application/x-www-form-urlencoded'

# Sende die POST-Anfrage für die Textübersetzung
response = requests.post(translator_text_url, headers=headers, data=text_translation_payload)
print("\nTextübersetzung:")
print(response.json())

# Definiere die Parameter für die JSON-Übersetzung
json_translation_payload = {
    'from': 'de',
    'to': 'en',
    'json': '{ "title": "Willkommen auf meinem YouTube Kanal", "author": "CustAndCode" }'
}

# Sende die POST-Anfrage für die JSON-Übersetzung
response = requests.post(translator_json_url, headers=headers, data=json_translation_payload)
print("\nJSON-Übersetzung:")
print(response.json())
