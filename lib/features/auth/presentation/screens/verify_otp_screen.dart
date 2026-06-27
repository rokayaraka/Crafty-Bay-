
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_colors.dart';
import '../providers/otp_timer_provider.dart';
import '../widgets/appLogo.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});
  static const String name = '/verify-otp';

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final PinInputController _OtpTEController = PinInputController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final OtpTimerProvider _otpTimerProvider = OtpTimerProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpTimerProvider.startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return ChangeNotifierProvider.value(
      value: _otpTimerProvider,
      child: Scaffold(
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

                    Text('Verify Your OTP ', style: textTheme.titleLarge),
                    SizedBox(height: 6),
                    Text(
                      'Enter your OTP that has been sent your email',
                      style: textTheme.labelLarge,
                    ),
                    SizedBox(height: 20),
                    MaterialPinField(
                      length: 4,
                      pinController: _OtpTEController,
                      keyboardType: .number,
                      theme: MaterialPinTheme(
                        fillColor: Colors.transparent,
                        focusedFillColor: Colors.transparent,
                        focusedBorderColor: AppColors.themeColor,
                        completeFillColor: AppColors.themeColor,
                      ),
                    ),

                    SizedBox(height: 20),
                    FilledButton(
                      onPressed: _onTapSignInButton,
                      child: Text('Verify OTP'),
                    ),

                    const SizedBox(height: 16),
                    Consumer<OtpTimerProvider>(
                      builder: (context, _, _) {
                        if (_otpTimerProvider.secondsLeft == 0) {
                          return TextButton(
                            onPressed: _onTapResendOtp,
                            child: Text("Resend OTP"),
                          );
                        } else {
                          return RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: 'Resend OTP After  '),

                                TextSpan(
                                  text: ' ${_otpTimerProvider.secondsLeft}s',
                                  style: TextStyle(color: AppColors.themeColor),
                                ),
                              ],
                            ),
                          );
                        }
                      },
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
    if (_formkey.currentState!.validate()) {
      //TODO: call signIn Api
    }
  }

  void _onTapResendOtp() {
    _otpTimerProvider.startTimer();
  }

  @override
  void dispose() {
    _OtpTEController.dispose();
    super.dispose();
  }
}
