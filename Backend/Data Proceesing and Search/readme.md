# Data processing and Search implementation for the project

## Data processing

For the data processing, we use python and the following libraries:

- `beautifulsoup4` (for web scraping and parsing)
- `blurhash` (for generating [blurhashes](https://blurha.sh/) for images)
- `blurhash_python` (for generating [blurhashes](https://blurha.sh/) for images)
- `firebase_admin` (for interfacing with the firebase database)
- `meilisearch` (for interfacing with the meilisearch database)
- `pandas` (for data manipulation)
- `Pillow` (for image manipulation)
- `python-dotenv` (for loading environment variables from a .env file)
- `requests` (for making http requests)

### Data processing includes the following steps:

1. Scraping the data from the web
   - Crawiling the website for all recipes
   - scrape the data from each recipe
2. Cleaning the data
   - Remove the unwanted data
   - Remove the duplicates
   - Remove the null values
   - Remove all the incomplete recipes
3. Scraping the ingredients
   - Scraping the ingredients from the recipe
   - Getting the image of the ingredient
   - Cleaning the ingredients
   - Removing the duplicates
   - Attaching image to the ingredient
4. Upload the data to the Firebase
   - Transform the data to the required format
   - Upload the recipes
   - Upload the ingredients

### Recipe Categorisation

After the data is processed, we categorise the recipes into multiple categories.

Check the `cat` folder for more details.

## Search implementation

We used MeiliSearch for the search implementation. MeiliSearch is an open-source search engine that provides a powerful and relevant search experience to your users with instant and typo-tolerant results.

We created Two indexes in MeiliSearch for the search implementation. One for the recipes and another for the ingredients.

### Recipes

Check [recipeIndex.json](firebase/recipeIndex.json) for the final index.
Here is the list of attributes we used for the index:

```json
    {
        "recipe_id": "GYPnmKsyMUm5BKwv09fP",
        "title": "American Chop Suey",
        "image": "https://myfoodstory.com/wp-content/uploads/2022/03/American-Chopsuey-2.jpg",
        "description": "An Indo Chinese .... ",
        "course": "Main Course",
        "cuisine": "Indian Chinese",
        "diet": "Vegan,Vegetarian",
        "time": "30 minutes",
        "calories": 217,
        "instructions": "Fried Noodles Boil the noodles with salt and a teaspoon of oil till al dente.....Sprinkle with spring onion greens and serve hot on top of fried noodles. ",
        "raw_ingredients": "black .... water"
    },
```

### Ingredients

Check [image_dict.json](search/images_dict.json) for the final index.
Here is the list of attributes we used for the index:

```json
    {
        "ingredient": "active dry yeast",
        "image": "/v1563975259/custom_upload/2a05dae33890a18898239c1acfb03757.jpg",
        "id": "6af326a3-498b-48a9-bacb-81d24b4ee4a7"
    },
```
