import json
import requests
with open('cat\categoryId.json', 'r') as f:
    data = json.load(f)
# indian = data['indian']
# veg = data['veg']
# dinner = data['dinner']
# dessert = data['dessert']

# indianId = []
# vegId = []
# dinnerId = []
# dessertId = []


# with open(r'firebase\fsDoc.json', 'r') as f:
#     data = json.load(f)


def search(url):
    for i in data:
        if i['url'] == url:
            return i['recipe_id']
    return None


# for i in indian:
#     indianId.append(search(i))

# for i in veg:
#     vegId.append(search(i))

# for i in dinner:
#     dinnerId.append(search(i))

# for i in dessert:
#     dessertId.append(search(i))

# newCat = {
#     'indian': indianId,
#     'veg': vegId,
#     'dinner': dinnerId,
#     'dessert': dessertId
# }

# # save to json
# with open('cat\categoryId.json', 'w') as f:
#     json.dump(newCat, f)


# curl -XPOST -H "Content-type: application/json" -d '{ "key": "value" }' 'https://getpantry.cloud/apiv1/pantry/af7703e1-1ac0-422a-aa97-e40be19caa51/basket/foodify'
# upload newcat to above url

r = requests.post(
    'https://getpantry.cloud/apiv1/pantry/af7703e1-1ac0-422a-aa97-e40be19caa51/basket/foodify', json=data)
