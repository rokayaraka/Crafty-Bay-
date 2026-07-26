import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/centered_progress_indicator.dart';

import '../../data/models/review_model.dart';
import '../providers/review_provider.dart';
import '../widgets/add_review_section.dart';
import '../widgets/review_card.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final ReviewProvider _reviewProvider = ReviewProvider();

  @override
  void initState() {
    super.initState();
    _reviewProvider.getReviewList(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _reviewProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reviews'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Consumer<ReviewProvider>(
          builder: (context, reviewProvider, _) {
            if (reviewProvider.isLoading) {
              return const CenteredProgressIndicator();
            }

            if (reviewProvider.errorMessage != null) {
              return Center(child: Text(reviewProvider.errorMessage!));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: reviewProvider.reviewList.length,
                    itemBuilder: (context, index) {
                      final ReviewModel reviewModel =
                          reviewProvider.reviewList[index];
                      return ReviewCard(reviewModel: reviewModel);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                AddReviewSection(productId: widget.productId),
              ],
            );
          },
        ),
      ),
    );
  }
}
