

import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/shared/presentation/presentation/providers/main_nav_holder_provider.dart';
import 'app_theme.dart';
import 'providers/local_provider.dart';
import 'providers/theme_mode_provider.dart';
import 'routes.dart';

class CraftyBayApp extends StatefulWidget {
  const CraftyBayApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<CraftyBayApp> createState() => _CraftyBayAppState();
}

class _CraftyBayAppState extends State<CraftyBayApp> {
  final ThemeModeProvider _themeModeProvider = ThemeModeProvider();
  final LocalProvider _localeProvider = LocalProvider();

  @override
  void initState() {
    super.initState();
    _themeModeProvider.setDefaultThemeMode();
    _localeProvider.setDefaultLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _themeModeProvider),
        ChangeNotifierProvider.value(value: _localeProvider),
        ChangeNotifierProvider(create: (_) => MainNavHolderProvider())
      ],
      child: Consumer<LocalProvider>(
        builder: (context, localeProvider, _) {
          return Consumer<ThemeModeProvider>(
            builder: (context, themeModeProvider, _) {
              return MaterialApp(
                navigatorKey: CraftyBayApp.navigatorKey,
                title: 'Crafty Bay',
                initialRoute: SplashScreen.name,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeModeProvider.themeMode,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: localeProvider.supportedLocales,
                locale: localeProvider.currentLocale,
              );
            },
          );
        },
      ),
    );
  }
}