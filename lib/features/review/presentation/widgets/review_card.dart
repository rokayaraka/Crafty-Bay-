import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/circle_icon_button.dart';
import '../../data/models/review_model.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.reviewModel});

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                CircleIconButton(icon: Icons.person, onTap: () {}),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewModel.user.firstName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        reviewModel.product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                         Text(
                        reviewModel.rating.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(reviewModel.comment, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
