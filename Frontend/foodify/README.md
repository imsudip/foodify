# Foodify Frontend Application

![ratings](https://PlayBadges.pavi2410.me/badge/ratings?id=com.softperks.foodify&pretty&style=for-the-badge) ![downloads](https://PlayBadges.pavi2410.me/badge/downloads?id=com.softperks.foodify&pretty&style=for-the-badge)

The frontend Application is built using [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/).

You can check out the app on

<a href='https://play.google.com/store/apps/details?id=com.softperks.foodify&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'  ><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width=40%/></a>

## App Processes

### Authentication

Authentication is done using Firebase Authentication. The user can sign in using Google or Email and Password.

### Search

Search is done by interfacing with the MeiliSearch database. The search is done using the `title` and `description` of the recipe.

### Saved Recipes

The user can save the recipes for later use. The saved recipes are stored in the Firebase Firestore database and are synced across all the devices.

### Recipe Sharing

The user can generate a shareable link for the recipe. The link can be shared with anyone. The link will open the recipe in the app.

The link is generated using Firebase Dynamic Links. The link is generated using the `recipe_id` of the recipe.

### Recipe Recommendations from the ingredients

The user can also get the recipe recommendations based on the ingredients they have in their kitchen. The user can select the ingredients they have and the app will provide the user with the recipes that can be made using those ingredients.
The process of getting the recipe recommendations is done by the [Backend](https://github.com/imsudip/foodify_recomentation_system) and the results are fetched from the Firebase Firestore database.

### Recommended Recipes

This section is present on the home screen of the app. The recommended recipes are calculated based on the `Food Preference` of the user and past recipes that the user has saved. The recommended recipes are calculated using the `Collaborative Filtering` algorithm.

### Profile

While onboarding, the user is asked to provide their name and a profile picture and some basic information about them. That includes `Gender`, `Age`, `Height`, `Weight`, `Activity Level` and `Food Preference`. This information is used to calculate the `Daily Calorie Intake` for the user and also to provide the user with the `Recommended Recipes` based on their `Food Preference`.

This information is stored in the Firebase Firestore database and can be updated by the user at any time.

### Recipe Details

The user can view the details of the recipe by clicking on the recipe card. The recipe details include the `Ingredients`, `Steps` and `Nutrition Information` of the recipe.

### Nutrition Information

The nutrition information includes `Calories`, `Fat`, `Carbohydrates`, `Protein`, `Fiber`, `Sodium`, `Sugar`, `Cholesterol` and `Vitamin A` and other nutrients.

### Recipe Ingredients

The recipe ingredients are fetched from the Firebase Firestore database and are displayed in the app along with their buying links from [Amazon fresh](https://www.amazon.in/alm/storefront?almBrandId=ctnow).

### Recipe Categories

There are various categories of recipes present in the app. The user can select the category of the recipe they want to see. The categories are fetched from the Firebase Firestore database.

## Screenshots

<img src="https://raw.githubusercontent.com/imsudip/foodify/main/resources/xtra/screenshots/s1.jpg" width=32% /> <img src="https://raw.githubusercontent.com/imsudip/foodify/main/resources/xtra/screenshots/s2.jpg" width=32% /> <img src="https://raw.githubusercontent.com/imsudip/foodify/main/resources/xtra/screenshots/s3.jpg" width=32% /> <img src="https://raw.githubusercontent.com/imsudip/foodify/main/resources/xtra/screenshots/s4.jpg" width=32% /> <img src="https://raw.githubusercontent.com/imsudip/foodify/main/resources/xtra/screenshots/s5.jpg" width=32% /> <img src="https://raw.githubusercontent.com/imsudip/foodify/main/resources/xtra/screenshots/s6.jpg" width=32% />

## Used Packages

```yaml
bottom_bar_page_transition: ^2.0.0
calendar_appbar: ^0.0.6
carousel_slider: ^4.0.0
cloud_firestore: ^3.1.10
cupertino_icons: ^1.0.2
dot_navigation_bar: ^1.0.1+4
eva_icons_flutter: ^3.1.0
firebase_auth: ^3.3.11
firebase_core: ^1.13.1
firebase_storage:
flutter_typeahead: ^4.0.0
fraction: ^4.0.1
get: ^4.3.8
google_fonts: ^3.0.1
google_sign_in: ^5.2.4
hive_flutter: ^1.1.0
http: ^0.13.4
iconsax: ^0.0.8
image_picker: ^0.8.5
like_button: ^2.0.4
loadmore: ^2.0.1
lottie: ^1.2.2
meilisearch: ^0.5.2
octo_image: ^1.0.1
readmore: ^2.1.0
url_launcher: ^6.0.20
cached_network_image: ^3.2.0
morpheus: ^1.2.3
firebase_dynamic_links: ^4.2.6
share_plus: ^4.0.7
path_provider: ^2.0.11
flutter_dotenv: ^5.0.2
```
