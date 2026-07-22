
import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/verify_otp_screen.dart';
import '../features/products/presentation/screens/product_details_screen.dart';
import '../features/products/presentation/screens/product_lisy_by_category.dart';
import '../features/shared/presentation/presentation/main_nav_holder_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget widget = SizedBox();
    switch (settings.name) {
      case SplashScreen.name:
        widget = SplashScreen();
        break;
      case SignInScreen.name:
        widget = SignInScreen();
        break;
      case SignUpScreen.name:
        widget = SignUpScreen();
        break;
      case VerifyOTPScreen.name:
        final email = settings.arguments as String;
        widget = VerifyOTPScreen(email: email);
        break;
      case MainNavHolderScreen.name:
        widget = MainNavHolderScreen();
        break;
      case ProductLisyByCategory.name:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widget = ProductLisyByCategory(
          categoryId: args['categoryId'],
          categoryName: args['categoryName'],
        );
        break;
      case ProductDetailsScreen.name:
        final productId = settings.arguments as String;
        widget = ProductDetailsScreen(productId: productId);
        break;
    }

    return MaterialPageRoute(builder: (context) => widget);
  }
}
