import 'package:crafty_bay/app/providers/local_provider.dart';
import 'package:crafty_bay/app/providers/theme_mode_provider.dart';
import 'package:crafty_bay/features/auth/presentation/screens/splash_screen.dart';
import 'package:crafty_bay/features/shared/presentation/presentation/providers/main_nav_holder_provider.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_theme.dart';
import 'routes.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class CraftyBayApp extends StatefulWidget {
  const CraftyBayApp({super.key});

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
         ChangeNotifierProvider(create: (_)=>MainNavHolderProvider()),
      
      ],
      child: Consumer<LocalProvider>(
        builder: (context, localeProvider,_) {
          return Consumer<ThemeModeProvider>(
            builder: (context, themeModeProvider, _) {
              return MaterialApp(
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
                supportedLocales:localeProvider.supportedLocales,
                locale:localeProvider.currentLocale,
              );
            },
          );
        }
      ),
    );
  }
}
