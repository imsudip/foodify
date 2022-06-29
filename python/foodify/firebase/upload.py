import io
import pandas as pd
import firebase_admin
from firebase_admin import credentials, firestore
import json
cred = credentials.Certificate('firebase\AdminKey.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

all_recipes = []
with open(r'recipesAll_with_bh_ri22222.json', 'r') as f:
    all_recipes = json.load(f)

collection_ref = db.collection(u'recipesNew')

# create a new document for each row and add the doc id as the recipe_id column
for i, recipe in enumerate(all_recipes):
    doc_ref = collection_ref.document()
    doc_id = doc_ref.id
    recipe['recipe_id'] = doc_id
    doc_ref.set(recipe)
    print(i, doc_id, sep='\t')

# save to json file
with open(r'firebase\fsDoc.py', 'w') as f:
    json.dump(all_recipes, f, indent=4)
