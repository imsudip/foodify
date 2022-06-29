from bs4 import BeautifulSoup
import requests
import re
import pandas as pd
import json

allRecipes = []
# open firebase\ingredientIndex.json
with open(r'firebase\fsDoc.json') as json_file:
    ingredientIndex = json.load(json_file)


def search(url):
    for i in ingredientIndex:
        if i['url'] == url:
            return i['recipe_id']
    return None


recipe_links = []
for i in range(8):
    url = 'https://myfoodstory.com/category/healthy-recipes/page/' + \
        str(i+1)+'/'
    # scrape the page
    page = requests.get(url)
    soup = BeautifulSoup(page.content, 'html.parser')
    # get all a tags with class 'entry-image-link'
    a_tags = soup.find_all('a', class_='entry-image-link')
    # get the href attribute of each a tag
    for a in a_tags:
        print(a['href'])
        recipe_links.append(a['href'])
recipe_ids = []

# for each recipe link, get the recipe_id from ingredientIndex.json
for link in recipe_links:
    if search(link) is not None:
        recipe_ids.append(search(link))


# save the links to a json file
s = {
    'healthy': recipe_ids
}
with open(r'cat\healthy-recipes.json', 'w') as f:
    json.dump(s, f, indent=4)
