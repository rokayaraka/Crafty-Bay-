import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../providers/review_provider.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key, required this.productId});

  final String productId;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final ReviewProvider _reviewProvider = ReviewProvider();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _reviewProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Review'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                spacing: 20,
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextFormField(
                    controller: _commentController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 20, left: 10),
                      hintText: 'Comment',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Consumer<ReviewProvider>(
                    builder: (context, reviewProvider, _) {
                      if (reviewProvider.isAdding) {
                        return const CircularProgressIndicator();
                      }

                      return FilledButton(
                        onPressed: _onTapSubmit,
                        child: const Text('Submit'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSubmit() async {
    if (await AuthController.isUserLoggedIn() == false) {
      if (!mounted) return;
      Navigator.pushNamed(context, SignInScreen.name);
      return;
    }

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final comment = _commentController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || comment.isEmpty) {
      showSnackBarMessage(context, 'Please fill all review fields');
      return;
    }

    final isSuccess = await _reviewProvider.addReview(
      productId: widget.productId,
       firstName: firstName,
      lastName: lastName,
      comment: comment,
    );

    if (isSuccess) {
      
      
      Navigator.pop(context);
      showSnackBarMessage(context, 'Review submitted successfully');
      return;
    }

    if (!mounted) return;
    showSnackBarMessage(context, _reviewProvider.errorMessage ?? 'Something went wrong!');
  }
}
