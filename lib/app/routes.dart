
import 'package:crafty_bay/features/shared/presentation/presentation/main_nav_holder_screen.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/verify_otp_screen.dart';

class AppRoutes{
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    Widget widget = SizedBox();
    switch(settings.name){
      case SplashScreen.name:
        widget = SplashScreen();
        break;
      case SignInScreen.name:
      widget=SignInScreen();
      case SignUpScreen.name:
      widget = SignUpScreen();
      case VerifyOTPScreen.name:
      widget = VerifyOTPScreen();
      case MainNavHolderScreen.name:
      widget  = MainNavHolderScreen();

    }

    return MaterialPageRoute(builder: (context)=>widget);
  }
}