import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';
import '../../data/models/cart_model.dart';
import '../providers/cart_list_provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItemModel});

  final CartModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetPaths.dummyPng, width: 100),
          ),
          Column(
            spacing: 8,
            crossAxisAlignment: .start,
            mainAxisAlignment: .start,
            children: [
              Row(
                spacing: 50,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        cartItemModel.product.title,
                        style: TextStyle(fontSize: 18, fontWeight: .w700),
                      ),
                      Row(
                        children: [
                          Text('Color: ${cartItemModel.color ?? ''}'),
                          SizedBox(width: 10),
                          Text('Size: ${cartItemModel.size ?? ''}'),
                        ],
                      ),
                    ],
                  ),

                  IconButton(
                    onPressed: _onTapIncDecButton,
                    icon: Icon(Icons.delete_outline),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    '${Constants.takaSign} 100',
                    style: TextStyle(
                      fontWeight: .w700,
                      color: AppColors.themeColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 70),
                  SizedBox(
                    width: 100,
                    child: IncDecButton(
                      maxCount: cartItemModel.product.quantity,
                      minCount: 1,
                      initialValue: cartItemModel.quantity,
                      onChange: (int newValue) {
                        context.read<CartListProvider>().updateCartItemQuantity(
                          cartItemModel.id,
                          newValue,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onTapIncDecButton() {
    //TODO : implement delete cart api
  }
}
