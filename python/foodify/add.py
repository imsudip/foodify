import json
import unicodedata


recipes = []
with open('recipesAll.json', 'r') as f:
    r1 = json.load(f)
    recipes.extend(r1)
all_ingredients = []
print(len(recipes))
for item in recipes:
    item['raw_ingredients'] = []
    for ing in item['ingredients']:
        if not ing.startswith('@@T@@'):
            item['raw_ingredients'].append(ing.split(',')[2].strip().lower())
    # make sure there are no duplicates
    item['raw_ingredients'] = list(set(item['raw_ingredients']))
    item['raw_ingredients'].sort()
    all_ingredients.extend(item['raw_ingredients'])

all_ingredients = list(set(all_ingredients))
all_ingredients.sort()
# length of all ingredients
print(len(all_ingredients))
# remove the unicode characters
all_ingredients = [unicodedata.normalize('NFKD', item).encode(
    'ascii', 'ignore').decode('ascii') for item in all_ingredients]
# save all ingredients to a file
with open('all_ingredients.json', 'w') as f:
    json.dump(all_ingredients, f)


with open('recipesMasterAll2.json', 'w') as f:
    json.dump(recipes, f, indent=4)
