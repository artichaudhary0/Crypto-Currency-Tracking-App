import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/themes.dart';
import '../models/local_storage.dart';
import '../pages/home_page.dart';
import '../providers/market_provider.dart';
import '../providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? "dark";

  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  const MyApp({Key? key, required this.theme}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Marketprovider>(
              create: (context) => Marketprovider()),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(
              theme,
            ),
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: const HomePage(),
            );
          },
        ));
  }
}
