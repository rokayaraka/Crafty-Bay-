
import 'package:flutter/material.dart';
import '../../../../app/app_colors.dart';
import '../screens/add_review_screen.dart';


class AddReviewSection extends StatelessWidget {
  const AddReviewSection({super.key});

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
              Text('(1000)', style: TextStyle(fontWeight: .w600, fontSize: 16)),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddReviewScreen()),
              );
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
