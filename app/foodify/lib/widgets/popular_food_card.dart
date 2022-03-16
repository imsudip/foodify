import 'package:flutter/material.dart';
import 'package:foodify/services/popular_food_model.dart';
import 'package:foodify/widgets/card.dart';

class PopularFoodCard extends StatelessWidget {
  final PopularFoodModel popularFood;
  const PopularFoodCard({Key? key, required this.popularFood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1.06,
                child: Image.network(
                  popularFood.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  popularFood.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    // ignore: prefer_const_constructors
                    Icon(
                      Icons.alarm,
                      color: Colors.grey,
                      size: 12,
                    ),
                    Text(
                      ' ${popularFood.cookTime} mins',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              popularFood.cuisine,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xC5373737)),
            ),
            Expanded(
              child: Text(
                popularFood.description,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xA9373737)),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }
}
