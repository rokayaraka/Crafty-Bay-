import 'package:flutter/material.dart';
import '../widgets/add_review_section.dart';
import '../widgets/review_card.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,

              itemBuilder: (context, index) {
                return ReviewCard();
              },
            ),
          ),
          const SizedBox(height: 20),
          AddReviewSection(),
        ],
      ),
    );
  }
}
