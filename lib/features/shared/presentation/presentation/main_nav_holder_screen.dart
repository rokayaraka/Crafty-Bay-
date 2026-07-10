
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../wishList/presentation/screens/wish_list_screen.dart';
import '../../../Category/presentation/screens/category_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../carts/presentation/screens/cart_screen.dart';
import 'providers/main_nav_holder_provider.dart';

class MainNavHolderScreen extends StatefulWidget {
  const MainNavHolderScreen({super.key});

  static const String name = '/main_nav_holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    
    CartScreen(),
    WishListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNavHolderProvider>(
      builder: (context, mainNavHolderProvider, _) {
        return Scaffold(
          body: _screens[mainNavHolderProvider.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: mainNavHolderProvider.currentIndex,
            unselectedItemColor: Colors.grey,
            selectedItemColor: AppColors.themeColor,
            showUnselectedLabels: true,
            onTap: mainNavHolderProvider.changeIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_outlined),
                label: 'Carts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: 'Wishlist',
              ),
            ],
          ),
        );
      },
    );
  }
}
