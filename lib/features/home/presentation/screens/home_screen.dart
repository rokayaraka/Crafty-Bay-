
import 'package:flutter/material.dart';
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
            spacing: 16,
            children: [
              ProductSearchBar(),
              HomeCarouselSlider(),
              SectionHeader(headerText: 'Category', onTapSeeAll: () {}),
              HomeCategorySection(),
    ],
          ),
        ),
      ),
    );
  }
}
