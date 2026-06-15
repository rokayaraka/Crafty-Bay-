import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/providers/theme_mode_provider.dart';

// ignore: camel_case_types
class themeToggleButton extends StatelessWidget {
  const themeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context,themeModeprovider,_) {
        return DropdownButton<ThemeMode>(
          value: themeModeprovider.themeMode,
          items: [
            DropdownMenuItem(
              value: .light,
              child: Text('Light')),
              DropdownMenuItem(
              value: .dark,
              child: Text('Dark')),
              DropdownMenuItem(
              value: .system,
              child: Text('System')),
          ],
          onChanged: (newMode){
            themeModeprovider.changeThemeMode(newMode!);
          },
        );
      }
    );
  }
}