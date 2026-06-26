import 'package:flutter/material.dart';

import '../../../../app/extensions/localization_extension.dart';
import '../../../shared/presentation/utility/validators.dart';
import '../widgets/appLogo.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String name = '/signIn';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();

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
                  const SizedBox(height: 80),
                  appLogo(width: 100),
                  const SizedBox(height: 20),

                  Text('Welcome Back', style: textTheme.titleLarge),
                  SizedBox(height: 6),
                  Text(
                    'Sign In with your email and Password',
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
                    controller: _passTEController,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: context.localization.password,
                      labelText: context.localization.password,
                    ),
                    validator: (input) => Validators.validatePassword(input),
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: _onTapSignInButton,
                    child: Text('Sign In'),
                  ),

                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _onTapSignUpButton,
                    child: Text("Don't have an account? Sign Up "),
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
    if (_formkey.currentState!.validate()) {
      //TODO: call signIn Api
    }
  }

  void _onTapSignUpButton() {}

  @override
  void dispose() {
    _emailTEController.dispose();
    _passTEController.dispose();
    super.dispose();
  }
}
