import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/destinations_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TripComApp());
}

class TripComApp extends StatelessWidget {
  const TripComApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DestinationsProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'TripCom',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.isDarkMode 
                ? ThemeMode.dark 
                : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
