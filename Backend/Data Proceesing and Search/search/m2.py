import meilisearch
import json
import os
from dotenv import load_dotenv

load_dotenv()
key = os.getenv('MEILI_MASTER_KEY')
client = meilisearch.Client(
    'https://meilisearch-on-koyeb-imsudip.koyeb.app', key)

json_file = open(
    r'C:\Users\sudip\Documents\old flutter proj\foodify\python\foodify\firebase\recipeIndex.json')
recipes = json.load(json_file)
client.index('recipes').add_documents(recipes)
