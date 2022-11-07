
import json
recipes = []
# with open('recipes1_1.json', 'r') as f:
#     r1 = json.load(f)
#     recipes.extend(r1)
# with open('recipes1_2.json', 'r') as f:
#     r2 = json.load(f)
#     recipes.extend(r2)


# print(len(recipes))
# count = 0
# for item in recipes:
#     if item['video_id'] != '':
#         count += 1
# print(count)

# with open('recipesAll.json', 'w') as f:
#     json.dump(recipes, f, indent=4)

ingredients = []
with open('all_ingredients.json', 'r') as f:
    ingredients = json.load(f)


d = {}
# open ingre_with_images_sorted.json
with open('ingre_with_images_sorted.json', 'r') as f:
    d = json.load(f)

# remove the keys that have value of ""
d2 = {}
for key in d.keys():
    if d[key] == "":
        continue
    d2[key] = d[key]

d = d2


# check how may elements in ingrdients is common with keys in d
count = 0
for item in ingredients:
    if item in d.keys():
        count += 1
    else:
        print(item)
print(count)
print(len(d))
print(len(ingredients))
