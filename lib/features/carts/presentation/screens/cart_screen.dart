import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/presentation/presentation/providers/main_nav_holder_provider.dart';
import '../providers/cart_list_provider.dart';
import '../widgets/cart_item.dart';
import '../widgets/total_price_and_checkout_section.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String name = '/carts_screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartListProvider _cartListProvider = CartListProvider();

  initState() {
    super.initState();
    _cartListProvider.getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _cartListProvider,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (_, _) => _backToHome(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Carts'),
            leading: IconButton(
              onPressed: _backToHome,
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Consumer<CartListProvider>(
            builder: (context, _, _) {
              if (_cartListProvider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (_cartListProvider.errorMessage != null) {
                return Center(child: Text(_cartListProvider.errorMessage!));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _cartListProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          cartItemModel: _cartListProvider.cartItems[index],
                        );
                      },
                    ),
                  ),
                  TotalPriceAndCheckoutSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _backToHome() {
    context.read<MainNavHolderProvider>().backToHome();
  }
}
