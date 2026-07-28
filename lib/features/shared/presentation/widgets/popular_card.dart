import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

import 'product_model.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({super.key, required this.popularProduct});
final ProductModel popularProduct;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: .circular(8)),
      color: Colors.white,
      shadowColor: AppColors.themeColor.withAlpha(40),
      elevation: 5,
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            Container(
              width: 150,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.themeColor.withAlpha(30),
                borderRadius: .only(
                  topLeft: .circular(8),
                  topRight: .circular(8),
                ),
              ),
              child: Image.network(popularProduct.photos[0], fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 4,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    popularProduct.title,
                    style: TextStyle(fontWeight: .w900, color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        '\$${popularProduct.price}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: .w600,
                          color: AppColors.themeColor,
                        ),
                      ),
                      Wrap(
                        spacing: 4,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          Text('${popularProduct.rating}',
                          style: TextStyle( color: Colors.black),),
                          
                        ],
                      ),
                      Container(
                        padding: .all(4),
                        decoration: BoxDecoration(
                          borderRadius: .circular(4),
                          color: AppColors.themeColor,
                        ),
                        child: Icon(
                          Icons.favorite_border_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
