
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/centered_progress_indicator.dart';
import '../../../shared/presentation/widgets/product_card.dart';
import '../providers/product_list_provider.dart';

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
  final ProductListProvider _productListProvider = ProductListProvider();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _productListProvider.getProductData();
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (_productListProvider.isLoading == false &&
        _scrollController.position.extentBefore < 300) {
      _productListProvider.getProductData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _productListProvider,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.categoryName)),
        body: Consumer<ProductListProvider>(
          builder: (context, productListProvider, _) {
            if (productListProvider.isInitialLoading) {
              return CenteredProgressIndicator();
            }
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    itemCount: productListProvider.productList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 3,
                    ),
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: ProductCard(
                          productModel: productListProvider.productList[index],
                        ),
                      );
                    },
                  ),
                ),
                if (productListProvider.isLoadingMore)
                  LinearProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}
