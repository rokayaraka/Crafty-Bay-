import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/Dummy data/dummy_product.dart';
import '../../../shared/presentation/presentation/providers/main_nav_holder_provider.dart';
import '../../../shared/presentation/widgets/centered_progress_indicator.dart';
import '../../../shared/presentation/widgets/product_card.dart';
import '../providers/home_sliders_provider.dart';
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
              Consumer<HomeSlidersProvider>(
                builder: (context, homeSlidersProvider, _) {
                  if (homeSlidersProvider.getSlidersInProgress) {
                    return SizedBox(
                      height: 180,
                      child: CenteredProgressIndicator(),
                    );
                  }
                  return HomeCarouselSlider(
                    sliders: homeSlidersProvider.sliders,
                  );
                },
              ),
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
                  children: DummyProduct.dummyProducts
                      .map((product) => ProductCard(productModel: product))
                      .toList(),
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
                    children: DummyProduct.dummyProducts
                      .map((product) => ProductCard(productModel: product))
                      .toList(),
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
                    children: DummyProduct.dummyProducts
                      .map((product) => ProductCard(productModel: product))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
