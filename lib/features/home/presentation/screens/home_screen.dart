
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/presentation/providers/main_nav_holder_provider.dart';
import '../../../shared/presentation/widgets/new_card.dart';
import '../../../shared/presentation/widgets/product_card.dart';
import '../../../shared/presentation/widgets/special_card.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/home_category_section.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              ProductSearchBar(),
              HomeCarouselSlider(),
              SectionHeader(
                headerText: 'Category',
                onTapSeeAll: () {
                  context.read<MainNavHolderProvider>().navigateToCategory();
                },
              ),
              HomeCategorySection(),
              SectionHeader(
                headerText: 'Popular',
                onTapSeeAll: () {
                  context.read<MainNavHolderProvider>().navigateToCategory();
                },
              ),

              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  children: [1, 2, 3, 4, 5].map((e) => ProductCard()).toList(),
                ),
              ),
              SectionHeader(
                headerText: 'Special',
                onTapSeeAll: () {
                  context.read<MainNavHolderProvider>().navigateToCategory();
                },
              ),
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  children: [1, 2, 3, 4, 5].map((e) => SpecialCard()).toList(),
                ),
              ),


                  SectionHeader(
                headerText: 'New',
                onTapSeeAll: () {
                  context.read<MainNavHolderProvider>().navigateToCategory();
                },
              ),
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  children: [1, 2, 3, 4, 5].map((e) => NewCard()).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
