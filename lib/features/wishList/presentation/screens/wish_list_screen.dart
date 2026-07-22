
import 'package:crafty_bay/features/shared/presentation/widgets/centered_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/presentation/providers/main_nav_holder_provider.dart';
import '../../../shared/presentation/widgets/product_card.dart';
import '../providers/wishlist_provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static const String name = '/wish-list-screen';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
   final WishListProvider _wishListProvider = WishListProvider();
  final ScrollController _scrollController = ScrollController();
    @override
  void initState() {
    super.initState();
    _wishListProvider.getWishlistData();
    _scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if ((_wishListProvider.isLoading == false) &&
        _scrollController.position.extentAfter < 300) {
      _wishListProvider.getWishlistData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_,_)=>_backToHome(),
      child: ChangeNotifierProvider.value(
        value: _wishListProvider,
        child: Scaffold(
          appBar: AppBar(title: const Text('WishList'),
          leading: IconButton(onPressed: _backToHome, icon: Icon(Icons.arrow_back_ios)),
          ),
          body: Consumer<WishListProvider>(
            builder: (context,wishListProvider,_) {
                if (wishListProvider.isInitialLoading) {
                return const CenteredProgressIndicator();
              }
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: 9,
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) {
                          return FittedBox(
                          child: Stack(
                            children: [
                              ProductCard(
                                productModel: wishListProvider
                                    .productList[index]
                                    .productModel,
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    _onTapRemoveItem(
                                      wishListProvider.productList[index].cartId,
                                    );
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close_outlined),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

   void _onTapRemoveItem(String itemId) {}

  void _backToHome() {
    context.read<MainNavHolderProvider>().backToHome();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}