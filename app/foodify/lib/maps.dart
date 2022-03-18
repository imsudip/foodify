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
