import 'package:flutter/material.dart';
import 'package:kgpapp/DarkThemeProvider.dart';
import 'package:kgpapp/color_schemes.g.dart';
import 'package:kgpapp/widgets/RoutePage.dart';
import 'package:kgpapp/widgets/LoginScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) {
      return themeChangeProvider;
    }, child: Consumer<DarkThemeProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return MaterialApp(
          routes:{
            '/': (context ) => LoginScreen(themeChangeProvider: themeChangeProvider),
            '/authenticated': (context) => RoutePage(themeChangeProvider: themeChangeProvider),
          },
          themeMode: value.darkTheme ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme:
              ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        );
      },
    ));
  }
}
