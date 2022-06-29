import json
import unicodedata
wild = [
    'chopped',
    'crushed',
    'diced',
    'filtered',
    'ground',
    'minced',
    'peeled',
    'pitted',
    'sliced',
    'dried',
    'sifted',
    'slivered',
    'finely',
    'freshly',
    'fresh',
    'frozen',
    'grated',
    'large',
    'packed',
    'a pinch',
    'a few',
    'of',
    'small'
]

ingredients = []
all_ingredients = []
# open all_ingredients.json
with open('all_ingredients.json', 'r') as f:
    all_ingredients = json.load(f)

# if wildcard is in the ingredient, remove it
for item in all_ingredients:
    for w in wild:
        if w in item:
            item = item.replace(w, '')
    item = item.strip()
    # check if the ingredient is in plural form
    if item.endswith('s'):
        ingredients.append(item[:-1].strip())
    else:
        ingredients.append(item)
i1 = []
for i, item in enumerate(ingredients):
    # if the whole item is present in another ingredient, remove it
    for j in range(i+1, len(ingredients)):
        if item in ingredients[j]:
            i1.append(ingredients[j])
i1 = list(set(i1))
i1.sort()
print(len(i1))

# reomve the i1 ingredients from ingredients
for item in i1:
    if item in ingredients:
        ingredients.remove(item)

ingredients = list(set(ingredients))
ingredients.sort()
print(len(ingredients))

with open('all_ingredients2.json', 'w') as f:
    json.dump(ingredients, f, indent=4)
