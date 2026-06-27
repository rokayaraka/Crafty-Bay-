import 'package:flutter/material.dart';

class ProductSearchBar extends StatefulWidget {
  const ProductSearchBar({super.key});

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        prefixIconColor: Colors.grey.shade500,
        fillColor: Colors.grey.withAlpha(50),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        border: OutlineInputBorder(
          borderSide: .none,
          borderRadius: .circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: .none,
          borderRadius: .circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: .none,
          borderRadius: .circular(10),
        ),
      ),
    );
  }
}
