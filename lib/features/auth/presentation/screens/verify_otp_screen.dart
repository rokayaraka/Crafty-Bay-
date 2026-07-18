import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_colors.dart';
import '../../../shared/presentation/widgets/centered_progress_indicator.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/verify_otp_params.dart';
import '../providers/otp_timer_provider.dart';
import '../providers/verify_otp_provider.dart';
import '../widgets/appLogo.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.email});
  static const String name = '/verify-otp';

  final String email;
  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  // ignore: non_constant_identifier_names
  final PinInputController _OtpTEController = PinInputController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final OtpTimerProvider _otpTimerProvider = OtpTimerProvider();
  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _otpTimerProvider),
        ChangeNotifierProvider.value(value: _verifyOtpProvider),
      ],
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
                    Consumer<VerifyOtpProvider>(
                      builder: (context, _, _) {
                        if (_verifyOtpProvider.verifyOtpInProgress) {
                          return CenteredProgressIndicator();
                        }
                        return FilledButton(
                          onPressed: _onTapVerifyOtpButton,
                          child: Text('Verify OTP'),
                        );
                      },
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

  void _onTapVerifyOtpButton() {
    if (_formkey.currentState!.validate()) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    // Implement the logic to verify the OTP here
    final bool isSuccess = await _verifyOtpProvider.verifyOtp(
      VerifyOtpParams(otp: _OtpTEController.text, email: ''),
    );

    if (isSuccess) {
      // Navigate to the next screen or show success message
    } else {
      // Show error message

      showSnackBarMessage(context, _verifyOtpProvider.errorMessage!);
    }
  }

  void _onTapResendOtp() {
    _otpTimerProvider.startTimer();

    //TODO: Resend Otp from api
  }

  @override
  void dispose() {
    _OtpTEController.dispose();
    super.dispose();
  }
}
