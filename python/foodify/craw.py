from bs4 import BeautifulSoup
import requests
import re
import pandas as pd
import json
import unicodedata
import random
from scrape2 import get_recipe_data


recipe_links = []
with open(r'cat\n_links2.txt', 'r') as f:
    recipe_links = f.readlines()

api_keys = []
with open('api_key.txt', 'r') as f:
    api_keys = f.readlines()

api_key = api_keys[1]
print(len(recipe_links))
# recipe_links = recipe_links[:1]
recipes = []
errorLinks = []
for link in recipe_links:
    print(link)
    try:
        recipe = get_recipe_data(link, api_key)
        if recipe:
            recipes.append(recipe)
        else:
            errorLinks.append(link)
    except Exception as e:
        print("Error in getting data")
        print(e)
        continue

# save the data to a json file
with open('recipesNew.json', 'w') as f:
    json.dump(recipes, f, indent=4)

# save the error links to a txt file
with open('errorLinksf.txt', 'w') as f:
    for link in errorLinks:
        f.write(link)
