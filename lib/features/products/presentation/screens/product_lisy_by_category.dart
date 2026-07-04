import 'package:crafty_bay/features/shared/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductLisyByCategory extends StatefulWidget {
  const ProductLisyByCategory({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  static const String name = '/products-list-by-category';

  final String categoryId;
  final String categoryName;

  @override
  State<ProductLisyByCategory> createState() => _ProductLisyByCategoryState();
}

class _ProductLisyByCategoryState extends State<ProductLisyByCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: GridView.builder(
        itemCount: 15,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 3,
        ),
        itemBuilder: (context, index) {
          return FittedBox(child: ProductCard());
        },
      ),
    );
  }
}
