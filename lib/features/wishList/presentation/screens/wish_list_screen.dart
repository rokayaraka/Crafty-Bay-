
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/presentation/providers/main_nav_holder_provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  static const String name = '/wish-list-screen';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_,_)=>_backToHome(),
      child: Scaffold(
        appBar: AppBar(title: const Text('WishList'),
        leading: IconButton(onPressed: _backToHome, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: GridView.builder(
          itemCount: 9,
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 0,
          ),
          itemBuilder: (context, index) {
            return const FittedBox(
              //child: ProductCard()
              );
          },
        ),
      ),
    );
  }

  void _backToHome(){
     context.read<MainNavHolderProvider>().backToHome();
  }
}