import io
import pandas as pd
import firebase_admin
from firebase_admin import credentials, firestore
import json
cred = credentials.Certificate(r'flight\adminkey.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

all_flights = []
with open(r'flight\csvjson.json', 'r') as f:
    a = json.load(f)
    all_flights = a['flights']


collection_ref = db.collection(u'flights')

# create a new document for each row and add the doc id as the recipe_id column
for i, recipe in enumerate(all_flights):
    doc_ref = collection_ref.document()
    doc_id = doc_ref.id
    recipe['flight_id'] = doc_id
    doc_ref.set(recipe)
    print(i, doc_id, sep='\t')

# save to json file
with open(r'fsDocss.json', 'w') as f:
    json.dump(all_flights, f, indent=4)
