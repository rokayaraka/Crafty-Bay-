import 'package:flutter/material.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _writeReviewNameController =
      TextEditingController();

  final GlobalKey _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Review'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              spacing: 25,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),

                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextFormField(
                  controller: _writeReviewNameController,

                  maxLines: 10,

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20, left: 10),
                    hintText: 'Write Review',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                FilledButton(onPressed: () {}, child: Text('Submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
