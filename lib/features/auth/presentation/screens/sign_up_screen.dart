import 'package:flutter/material.dart';

import '../../../../app/extensions/localization_extension.dart';
import '../../../shared/presentation/utility/validators.dart';
import '../widgets/appLogo.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name = '/signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
 final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
   final TextEditingController _phoneTEController = TextEditingController();
    final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              autovalidateMode: .onUserInteraction,
              onChanged: () {},
              child: Column(
                children: [
                const SizedBox(height: 14,),
                  appLogo(width: 80),
        

                  Text('Create An Account', style: textTheme.titleLarge),
                  SizedBox(height: 6),
                  Text(
                    'Sign Up with your email and Password',
                    style: textTheme.labelLarge,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: .next,
                    keyboardType: .emailAddress,
                    decoration: InputDecoration(
                      hintText: context.localization.email,
                      labelText: context.localization.email,
                    ),
                    validator: (String? value) =>
                        Validators.validateEmail(value),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: .next,
                    keyboardType: .emailAddress,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      labelText: "First Name",
                    ),
                    validator: (String? value) =>
                        Validators.validateInput(value,'Enter your first name'),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: .next,
                    keyboardType: .emailAddress,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      labelText: "Last Name",
                    ),
                    validator: (String? value) =>
                  Validators.validateInput(value,'Enter your last name'),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _cityTEController,
                    textInputAction: .next,
                    keyboardType: .emailAddress,
                    decoration: InputDecoration(
                      hintText: 'City',
                      labelText: 'City',
                    ),
                    validator: (String? value) =>
                       Validators.validateInput(value,'Enter your City'),
                  ),
                  SizedBox(height: 12),
                   TextFormField(
                    controller: _phoneTEController,
                    textInputAction: .next,
                    keyboardType: .phone,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      labelText: 'Phone',
                    ),
                    validator: (String? value) =>
                       Validators.validateInput(value,'Enter your Phone Number'),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _passTEController,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: context.localization.password,
                      labelText: context.localization.password,
                    ),
                    validator: (input) => Validators.validatePassword(input),
                  ),
                  SizedBox(height: 12),
                  FilledButton(
                    onPressed: _onTapSignUpButton,
                    child: Text('Sign up'),
                  ),

                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _onTapSignInButton,
                    child: Text("Have an account? Sign In "),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
   Navigator.pop(context);
  }

  void _onTapSignUpButton() {
     if (_formkey.currentState!.validate()) {
      //TODO: call signUp Api
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _cityTEController.dispose();
    _phoneTEController.dispose();
    super.dispose();
  }
}
