import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/localization_extension.dart';
import '../../../shared/presentation/utility/validators.dart';
import '../../../shared/presentation/widgets/centered_progress_indicator.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/sign_up_params.dart';
import '../providers/sign_up_provider.dart';
import '../widgets/appLogo.dart';
import 'verify_otp_screen.dart';

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

  final SignUpProvider _signUpProvider = SignUpProvider();

  bool _enableButton = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return ChangeNotifierProvider.value(
      value: _signUpProvider,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formkey,
                autovalidateMode: .onUserInteraction,
                onChanged: _checkIfFormValid,
                child: Column(
                  children: [
                    const SizedBox(height: 14),
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
                      validator: (String? value) => Validators.validateInput(
                        value,
                        'Enter your first name',
                      ),
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
                      validator: (String? value) => Validators.validateInput(
                        value,
                        'Enter your last name',
                      ),
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
                          Validators.validateInput(value, 'Enter your City'),
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
                      validator: (String? value) => Validators.validateInput(
                        value,
                        'Enter your Phone Number',
                      ),
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
                    Consumer<SignUpProvider>(
                      builder: (context, _, _) {
                        if (_signUpProvider.signUpInProgress) {
                          return CenteredProgressIndicator();
                        }
                        return FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: _enableButton == false
                                ? Colors.grey
                                : null,
                          ),
                          onPressed: _enableButton ? _onTapSignUpButton : null,
                          child: Text('Sign up'),
                        );
                      },
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
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  void _checkIfFormValid() {
    if (_formkey.currentState!.validate()) {
      _enableButton = true;
    } else {
      _enableButton = false;
    }
    setState(() {});
  }

  void _onTapSignUpButton() {
    if (_formkey.currentState!.validate()) {
      //TODO: call signUp Api
      _signUp();
    }
    //Navigator.pushNamed(context, VerifyOTPScreen.name);
  }

  Future<void> _signUp() async {
    SignUpParams params = SignUpParams(
      email: _emailTEController.text.trim(),
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      city: _cityTEController.text.trim(),
      phone: _phoneTEController.text.trim(),
      password: _passTEController.text,
    );

    final bool isSuccess = await _signUpProvider.signUp(params);
    if (isSuccess) {
      Navigator.pushNamed(context, VerifyOTPScreen.name);
    } else {
      showSnackBarMessage(context, _signUpProvider.errorMessage!);
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
