import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../providers/review_provider.dart';
import '../screens/add_review_screen.dart';

class AddReviewSection extends StatelessWidget {
  const AddReviewSection({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(16),
      decoration: BoxDecoration(
        borderRadius: .only(topLeft: .circular(8), topRight: .circular(8)),
        color: AppColors.themeColor.withAlpha(30),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            spacing: 5,
            crossAxisAlignment: .start,
            children: [
              Text(
                'Reviews',
                style: TextStyle(fontWeight: .bold, fontSize: 16),
              ),
              Consumer<ReviewProvider>(
                builder: (_, reviewProvider, __) {
                  return Text('(${reviewProvider.reviewList.length})');
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              final bool? isAdded = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) => AddReviewScreen(productId: productId),
                ),
              );

              if (isAdded == true && context.mounted) {
                await context.read<ReviewProvider>().getReviewList(productId);
              }
            },
            child: Container(
              height: 40,
              width: 40,

              decoration: BoxDecoration(
                borderRadius: .circular(50),
                color: AppColors.themeColor,
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
