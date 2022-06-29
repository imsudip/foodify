import json

all_recipes = []
with open(r'firebase\fsDoc.json', 'r') as f:
    all_recipes = json.load(f)
print(len(all_recipes))
# all_recipes = all_recipes[:150]
indexing = []
for recipe in all_recipes:
    # recipe['calories'] = int(recipe['calories'])
    # recipe['servings'] = int(recipe['servings'])
    # recipe['cuisine'] = [x.strip() for x in recipe['cuisine'].split(',')]
    # recipe['course'] = [x.strip() for x in recipe['course'].split(',')]
    # recipe['diet'] = [x.strip() for x in recipe['diet'].split(',')]

    # make list using 'url','image',title', 'description', 'course', 'servings', 'cuisine', 'diet', 'time', 'calories', 'author',  'instructions', 'raw_ingredients'
    ins = ''
    for i in recipe['instructions']:
        # if i starts with '@@T@@' remove it and add space at the end
        if i.startswith('@@T@@'):
            ins += i[5:] + ' '
        else:
            ins += i + ' '

    s = {
        'recipe_id': recipe['recipe_id'],
        'title': recipe['title'],
        'image': recipe['image'],
        'description': recipe['description'],
        'course': ','.join(recipe['course']),
        'cuisine': ','.join(recipe['cuisine']),
        'diet': ','.join(recipe['diet']),
        'time': recipe['time'],
        'calories': recipe['calories'],
        # make instructions list to string
        'instructions': ins,
        'raw_ingredients': ' '.join(recipe['raw_ingredients']),

    }
    indexing.append(s)

# save to json file
with open(r'firebase\recipeIndex.json', 'w') as f:
    json.dump(indexing, f, indent=4)
