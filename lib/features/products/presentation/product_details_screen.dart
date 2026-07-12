
import 'package:crafty_bay/features/review/presentation/screens/review_screen.dart';
import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../shared/presentation/widgets/inc_dec_button.dart';
import 'widgets/color_picker.dart';
import 'widgets/price_and_add_to_cart_section.dart';
import 'widgets/product_image_carosol.dart';
import 'widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = 'product_details_screen';

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductImageCarosol(),
              
                  Padding(
                    padding: .symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Adidas Snekar New Edition 2026 Black',
                                style: textTheme.titleMedium?.copyWith(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              child: IncDecButton(
                                maxcount: 20,
                                mincount: 1,
                                initialValue: 1,
                                onChange: (newValue) {},
                              ),
                            ),
                          ],
                        ),
              
                        Wrap(
                          crossAxisAlignment: .center,
                          spacing: 8,
                          children: [
                            Wrap(
                              spacing: 4,
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                Text('4.5'),
                              ],
                            ),
                            TextButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewScreen()));
                            }, child: Text('Reviews')),
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
                        const SizedBox(height: 12),
                        _sectionHeader('Colors'),
                        const SizedBox(height: 12),
                        ColorPicker(
                          colors: ['Red', "Yellow", "white", "Blue"],
                          onChange: (String selectedColor) {
                            print(selectedColor);
                          },
                        ),
                        const SizedBox(height: 12),
                        _sectionHeader('Size'),
                        const SizedBox(height: 12),
                        SizePicker(
                          sizes: ['S', "L", "M", "XL"],
                          onChange: (String selectedColor) {
                            print(selectedColor);
                          },
                        ),
                        const SizedBox(height: 12),
                        _sectionHeader('Description'),
                        const SizedBox(height: 8),
                        Text(
                          '''Footwear covering the foot and ankle (or higher) to provide extra protection, warmth, or rugged durability''',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16,)
                
                ],
              ),
            ),
          ),
       
        PriceAndAddToCartSection(),
       
        ],
      ),
    );
  }

  Widget _sectionHeader(String header) {
    return Text(header, style: TextStyle(fontSize: 18, fontWeight: .w500));
  }
}
