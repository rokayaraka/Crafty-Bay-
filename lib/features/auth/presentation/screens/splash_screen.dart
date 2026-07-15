


import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';


import '../../../../l10n/app_localizations.dart';
import '../../../shared/presentation/presentation/main_nav_holder_screen.dart';
import '../../../shared/presentation/widgets/theme_toggle.dart';
import '../widgets/appLogo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
  super.initState();
  _navigateToNextScreen();
  
}
  void _navigateToNextScreen()async{
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushNamedAndRemoveUntil(context, SignUpScreen.name,(predicate)=>false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          themeToggleButton(),
          Center(child: appLogo()),
          Spacer(),
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('${AppLocalizations.of(context)!.version} 1.0.0'),
         const SizedBox(height: 20),
        ],
      ),
    );
  }
}

