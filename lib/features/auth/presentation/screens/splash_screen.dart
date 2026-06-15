
import 'package:flutter/material.dart';


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
          Text('version 1.0.0'),
         const SizedBox(height: 20),
        ],
      ),
    );
  }
}

