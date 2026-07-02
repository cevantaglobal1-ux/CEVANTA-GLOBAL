import urllib.request
import re
import json

queries = [
    "sri-lanka-heritage", "diamond-ring", "sri-lanka-tea-estate", "sri-lanka-farmer",
    "cinnamon-sticks", "black-pepper", "manufacturing-facility", "scientist-lab",
    "sri-lanka-community", "blue-sapphire", "yellow-sapphire", "pink-sapphire", "ruby",
    "diamond-bracelet", "wedding-bands", "gemstone-necklace", "raw-cashew", "roasted-cashew",
    "salted-cashew", "spicy-cashew", "black-tea", "green-tea", "white-tea", "fruit-tea",
    "coconut-oil", "desiccated-coconut", "coconut-milk", "coconut-water"
]

def get_unsplash_image(query):
    url = f"https://unsplash.com/s/photos/{query}"
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    try:
        html = urllib.request.urlopen(req).read().decode('utf-8')
        # Find first image match like https://images.unsplash.com/photo-xxx?crop...
        match = re.search(r'(https://images\.unsplash\.com/photo-[a-zA-Z0-9\-]+)\?', html)
        if match:
            # Return URL with specific size
            return match.group(1) + "?auto=format&fit=crop&w=800&q=80"
    except Exception as e:
        pass
    return ""

results = {}
for q in queries:
    results[q] = get_unsplash_image(q)

print(json.dumps(results, indent=2))
