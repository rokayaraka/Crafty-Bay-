
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../../carts/data/models/add_to_cart_params.dart';
import '../../../carts/presentation/providers/add_to_cart_provider.dart';
import '../../../shared/presentation/widgets/centered_progress_indicator.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../providers/product_details_provider.dart';
import '../widgets/color_picker.dart';

import '../widgets/price_and_add_to_cart_section.dart';
import '../widgets/product_image_carosol.dart';

import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product-details';

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsProvider _productDetailsProvider =
      ProductDetailsProvider();
  final AddToCartProvider _addToCartProvider = AddToCartProvider();

  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _productDetailsProvider.getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider.value(
      value: _productDetailsProvider,
      child: Scaffold(
        appBar: AppBar(title: Text('Product Details')),
        body: Consumer<ProductDetailsProvider>(
          builder: (context, _, _) {
            if (_productDetailsProvider.getProductDetailsInProgress) {
              return CenteredProgressIndicator();
            }
            if (_productDetailsProvider.errorMessage != null) {
              return Center(child: Text(_productDetailsProvider.errorMessage!));
            }

            final productModel = _productDetailsProvider.productDetails!;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageCarousel(photos: productModel.photos),
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
                                      productModel.title,
                                      style: textTheme.titleMedium?.copyWith(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: IncDecButton(
                                      maxCount: productModel.quantity,
                                      minCount: 1,
                                      initialValue: _quantity,
                                      onChange: (newValue) {},
                                    ),
                                  ),
                                ],
                              ),
                              Wrap(
                                spacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Wrap(
                                    spacing: 4,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      Text('${productModel.rating}'),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Reviews'),
                                  ),
                                  Container(
                                    padding: .all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: .circular(4),
                                      color: AppColors.themeColor,
                                    ),
                                    child: Icon(
                                      Icons.favorite_outline,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Visibility(
                                visible: productModel.colors.isNotEmpty,
                                child: Column(
                                  children: [
                                    _sectionHeader('Color'),
                                    const SizedBox(height: 12),
                                    ColorPicker(
                                      colors: productModel.colors,
                                      onChange: (String selectedColor) {
                                        debugPrint(selectedColor);
                                        _selectedColor = selectedColor;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: productModel.sizes.isNotEmpty,
                                child: Column(
                                  children: [
                                    _sectionHeader('Size'),
                                    const SizedBox(height: 12),
                                    SizePicker(
                                      sizes: productModel.sizes,
                                      onChange: (String selectedSize) {
                                        debugPrint(selectedSize);
                                        _selectedSize = selectedSize;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    _sectionHeader('Description'),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                              Text(
                                productModel.description,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                ChangeNotifierProvider.value(
                  value: _addToCartProvider,
                  child: PriceAndCartSection(onTapAddToCart: _onTapAddToCart),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _onTapAddToCart() async {
    if (await AuthController.isUserLoggedIn() == false) {
      Navigator.pushNamed(context, SignInScreen.name);
      return;
    }

    AddToCartParams params = AddToCartParams(
      productId: widget.productId,
      color: _selectedColor,
      size: _selectedSize,
      quantity: _quantity,
    );

    final isSuccess = await _addToCartProvider.addToCart(params);
    if (isSuccess) {
      showSnackBarMessage(context, 'Added to cart');
    } else {
      showSnackBarMessage(context, _addToCartProvider.errorMessage!);
    }
  }

  Widget _sectionHeader(String header) {
    return Text(
      header,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}