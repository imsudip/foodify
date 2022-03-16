import 'package:flutter/material.dart';


class RecipeDetailScreen extends StatelessWidget {
  String ingredients = '''3 Onions - sliced thin,20 gram Garlic - ground to paste,1 tablespoon Garam masala powder,4 Tomatoes - finely chopped,2 tablespoon Red Chilli powder,20 gram Ginger - ground to paste,4 Green Chillies - slit at the center,Ghee - as needed,Salt - to taste,1/2 cup Hung Curd (Greek Yogurt),Salt - as required,1 tablespoon Red Chilli powder,2 tablespoon Coriander Powder (Dhania),4 cups Basmati rice,1/2 cup Coriander (Dhania) Leaves - finely chopped,1 kg Chicken - with bone,1 teaspoon Turmeric powder (Haldi),Sunflower Oil - as needed,1/2 cup Mint Leaves (Pudina) - finely chopped''';
  String recipe ='''To begin making the Chicken Biryani recipe, we will first begin with the rice preparation.
To cook basmati rice separately, wash and soak the basmati rice in water for 20 minutes.Meanwhile add about 3 litres of water in a large vessel and bring it to boil.Once water starts to boil, add about 1 teaspoon of cooking oil and 1 teaspoon of salt.
Add the soaked and drained rice, stir gently once and cook for about 3 to 5 minutes (I usually take it off heat by 3-1/2 minutes).Keep an eye on rice as some brands of basmati rice cooks very fast and some takes time.
My rice was cooked in 5 minutes.
Drain the water immediately and spread the rice on a large plate.In a deep bottomed pan, heat oil on medium flame,  add 1 sliced onion and fry it until brown (don’t burn the onions).
Remove browned onion from oil and keep it aside.
This will be used for garnishing and to make the layers.The next step is to marinate the chicken for the Chicken Dum Biryani Recipe.Clean and wash the chicken thoroughly.In a mixing bowl, marinate the chicken with thick curd, red chili powder, turmeric powder and salt.Marinate for at least 30 minutes.
In a large pan, add oil and heat on medium flame, add the remaining sliced onions and saute for 3 minutes or until the onions turn translucent.
Next add ginger-garlic paste and saute till the raw smell goes off.Add slit green chilies and mix for a minute.To this add chopped tomatoes and saute till tomatoes turn slightly mushy.Once the tomatoes are mushy add red chili powder, coriander powder and salt and saute it for about 2 minutes.Add 3 tablespoons of both coriander and mint leaves and mix.Finally, add  the marinated chicken for the biryani and mix well.
Cook until chicken is fully cooked.
Once chicken is cooked, if you find there is excess water, increase the flame and thicken the masala.
We need the masala just to coat the chicken.Take a large wide, deep vessel, add ghee and spread it to coat all the bottom and sides of the pan, reduce the flame to low.
Add about 2 full tablespoons of the thick chicken biryani masala and spread it all over the bottom.Next, add cooked basmati rice over the chicken biryani masala and gently spread the rice to cover the chicken.
Use a tea spoon and remove the top oily layer from masala and drizzle over the rice, this will add flavours to the rice and also give colour.Repeat the layering process until you have used up all rice and chicken.
Over the top sprinkle coriander and mint leaves and browned onions and close with a lid.Ensure the flame is low and place a heavy weight on top of lid to trap the steam inside to cook the Chicken Dum Biryani recipe.
Leave the dum biryani aside for 10 minutes until all the flavors seep through.Scoop out the Chicken Dum Biryani from the edges of the pan, making sure not to break the rice grains.Serve Chicken Dum Biryani Recipe with Pickled onions, Burani Raita and Mirchi Ka Salan Recipe (Chillies in Tangy Spicy Peanut Sesame Curry) for Sunday afternoon lunch.''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          
          
          children: [
            Container(
              //child: ClipRRect(child: Image.asset("images/bg.jpeg"),
              //set the bottom right radius to 20
              //borderRadius: BorderRadius.only(bottomRight: Radius.circular(140),),
              
              
              //set the height 45% of the screen
              height: 359,
              //Add the image "images/bg.jpeg" as a background image
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg.jpeg"),
                  fit: BoxFit.cover,
                  
                ),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(140),),
                //Add boxshadow to the container
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.31),
                    blurRadius: 17,
                    offset: Offset(0, 8),
                  ),
                ],
              ),

      
              ),
              //Add a textbox with the name of the food
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20 ,vertical: 10),
                child: Column (
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       Text("Chicken Dum Biryani Recipe", 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold ,),
                
                ),
                
                //Add a padding of 20
                const SizedBox(height: 20,),
                //Add a textbox with the description of the food
                Text("Mixed rice dish, optional spices, optional vegetables, meats or seafood. Can be served with plain yogurt. ",style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal , color: const Color(0xff373737).withOpacity(0.6)),),
                //Add a padding of 20
                const SizedBox(height: 20,),
                Row
                (children:const [ 
                  Image(image: AssetImage("images/Ingredients.png"),height: 20, width: 20,),
                  const SizedBox(width: 6,),
                  Text("Ingredients", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                ]
                
                ),
                //Add a padding of 10
                const SizedBox(height: 5,),
                //Add a textbox with the ingredients of the food
                Text(ingredients.replaceAll(",", " ⬤ "),style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal , color: const Color(0xff373737).withOpacity(0.98)),),
                //Add a padding of 20
                const SizedBox(height: 20,),
                Row
                (children:const [ 
                  Image(image: AssetImage("images/recipe.png"),height: 20, width: 20,),
                  const SizedBox(width: 6,),
                  Text("Recipe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                ]
                
                ),
                //Add a padding of 10
                const SizedBox(height: 5,),
                //Add a textbox with the recipe of the food
                Text("⬤ "+recipe.replaceAll("\n","\n⬤ "),style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal , color: const Color(0xff373737).withOpacity(0.98)),),
                ],),
              )
              
          ],
        ),
      )
    );
  }
}