import meilisearch
import json

client = meilisearch.Client(
    'http://3.89.98.23', 'ZGQ3MzY2ZDBlNmEyNjJiYTViMTRiMDhj')

json_file = open(r'E:\python proj\foodify\search\images_dict.json')
recipes = json.load(json_file)
client.index('ingredient_images').add_documents(recipes)
