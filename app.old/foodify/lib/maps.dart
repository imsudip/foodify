const Map<String, String> DIETICONS = {
  "Vegetarian": 'vegetarian',
  "High Protein Vegetarian": 'veg protein',
  "Non Vegeterian": 'meat',
  "Eggetarian": 'egg',
  "Diabetic Friendly": 'diabetic friendly',
  "High Protein Non Vegetarian": 'nonveg protein',
  "No Onion No Garlic (Sattvic)": 'Sattvic',
  "Vegan": 'vegan',
  "Gluten Free": 'gluten-free',
  "Sugar Free Diet": 'no-sugar'
};

const Map<String, String> COURSEICONS = {
  "Lunch": 'lunch',
  "Side Dish": 'side dish',
  "Snack": 'snacks',
  "Dinner": 'dinner',
  "Dessert": 'dessert',
  "Appetizer": 'appetizers',
  "Main Course": 'main course',
  "South Indian Breakfast": 'breakfast',
  "World Breakfast": 'breakfast',
  "North Indian Breakfast": 'breakfast',
  "Indian Breakfast": 'breakfast',
  "Breakfast": 'breakfast'
};

String getCourseIcon(String course) {
  return 'courses/' + (COURSEICONS[course] ?? 'main course');
}

String getDietIcon(String diet) {
  return 'diets/' + (DIETICONS[diet] ?? 'vegetarian');
}

const Map<String, List<String>> coursesNames = {
  "Lunch": ['Lunch'],
  "Side Dish": ['Side Dish'],
  "Snack": ['Snack'],
  "Dinner": ['Dinner'],
  "Dessert": ['Dessert'],
  "Appetizer": ['Appetizer'],
  "Main Course": ['Main Course'],
  "Breakfast": [
    'South Indian Breakfast',
    'World Breakfast',
    'North Indian Breakfast',
    'Indian Breakfast'
  ],
};
const List<String> mainCuisines = [
  "Continental",
  "Indian",
  "North Indian Recipes",
  "South Indian Recipes",
  "Italian Recipes",
  "Bengali Recipes",
  "Maharashtrian Recipes",
  "Fusion",
  "Mexican",
  "Chinese",
];

const Map<String, List<String>> secondaryCuisine = {
  "Mughlai": ['Mughlai'],
  "Karnataka": [
    'North Karnataka',
    'South Karnataka',
    'Coastal Karnataka',
    'Udupi',
    'Coorg'
  ],
  "Tamil Nadu": ['Tamil Nadu'],
  "Rajasthani": ['Rajasthani'],
  "Gujarati Recipes": ['Gujarati Recipes'],
  "Thai": ['Thai'],
  "Punjabi": ['Punjabi'],
  "French": ['French'],
  "Kashmiri": ['Kashmiri'],
  "Asian": [
    'North East India Recipes',
    'Himachal',
    'Uttar Pradesh',
    'Lucknowi',
    'Haryana',
    'Afghan',
    'Uttarakhand-North Kumaon',
    'Malaysian',
    'Caribbean',
    'Pakistani',
    'Japanese',
    'Sri Lankan',
    'Bihari',
    'Hyderabadi',
    'Oriya Recipes',
    'Kashmiri',
    'Arab',
    'Korean',
    'Jharkhand',
    'Jewish',
    'Burmese',
    'Sichuan',
    'Malvani'
  ],
  "International": [
    'Mediterranean',
    'Sindhi',
    'Konkan',
    'Awadhi',
    'Parsi Recipes',
    'Indo Chinese',
    'Mangalorean',
    'Middle Eastern',
    'French',
    'Chettinad',
    'Goan Recipes',
    'Andhra',
    'Greek',
    'Vietnamese',
    'Indonesian',
    'Nepalese',
    'American',
    'World Breakfast',
    'Sichuan',
    'British',
    'Nagaland',
    'Shandong',
    'Kongunadu',
    'Hunan'
  ],
};
