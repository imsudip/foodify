import blurhash
import requests
import json
from PIL import Image

recipes = []
with open('recipesMasterAll2.json', 'r') as f:
    r1 = json.load(f)
    recipes.extend(r1)

print(len(recipes))

a = []
# open a.txt and read the lines
with open('a.txt', 'r') as f:
    for line in f:
        a.append(line)

bh = []
ar = []
for i in range(len(a)):
    # if i%2==0 then it is a blurhash else it is a recipe
    if i % 2 == 0:
        bh.append(a[i])
    else:
        ar.append(a[i])
print(len(bh))
print(len(ar))

#  populate the recipes with blurhash
for i in range(len(bh)):
    recipes[i]['blurhash'] = bh[i]

# populate the recipes with the ar
for i in range(len(ar)):
    recipes[i]['aspect_ratio'] = ar[i]


for i, recipe in enumerate(recipes):
    print(i)
    if recipe['image'] == '':
        continue
    # check if recipe have key blurhash
    if 'blurhash' in recipe:
        print('blurhash already exists')
        continue
    try:
        # get the image and encode it
        r = requests.get(recipe['image'])
        # save the image to a "tmp"
        with open('tmp.jpg', 'wb') as f:
            f.write(r.content)
        # open tmp.jpg
        with Image.open('tmp.jpg') as img:
            width, height = img.size
            ar = width/height
            # make it upto 2 decimal places
            ar = round(ar, 2)
        # encode the image
        bh = blurhash.encode('tmp.jpg', 6, 4)
        # save the hash
        recipe['blurhash'] = bh
        recipe['aspect_ratio'] = ar
        print(recipe['blurhash'])
        print(recipe['aspect_ratio'])
    except Exception as e:
        recipe['blurhash'] = ""
        recipe['aspect_ratio'] = 0.0
        print(e)
        continue


# save the recipes to a json file
with open('recipesAll_with_bh_ri.json', 'w') as f:
    json.dump(recipes, f)
