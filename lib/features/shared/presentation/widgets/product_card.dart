import 'package:crafty_bay/features/products/presentation/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../products/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.name,
          arguments: productModel.id,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: .circular(8)),
        color: Colors.white,
        shadowColor: AppColors.themeColor.withAlpha(40),
        elevation: 5,
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withAlpha(30),
                  borderRadius: .only(
                    topLeft: .circular(8),
                    topRight: .circular(8),
                  ),
                ),
                child: Image.network(getProductPhoto(productModel.photos),
                errorBuilder: (_,_,_)=>Image.asset(AssetPaths.dummyPng),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 3,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                     productModel.title,
                      style: TextStyle(fontWeight: .w900, color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          '\$${productModel.price}',
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
                            Text('${productModel.rating}?? 0'),
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
      ),
    );
  }

  //random placeholder image
  String getProductPhoto(List<String> photos) {
    if (photos.isEmpty) {
      return '';
    } else {
      return photos.first;
    }
  }
}
