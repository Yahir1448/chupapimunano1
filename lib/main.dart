import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login.dart';
import 'providers/movie_provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;

  const MyApp({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider(isDarkMode)),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'ChupapiMuñaño Video',
            initialRoute: '/login',
            routes: {
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/home': (context) => const MainApp(themeProvider: themeProvider),
            },
            theme: ThemeData(
              primaryColor:
                  const Color(0xFF1A2A6C), // Tema fijo para Login y Register
              scaffoldBackgroundColor: const Color(0xFF1A2A6C),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1A2A6C),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white70),
                titleLarge:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              cardColor: const Color(0xFF0F1C3D),
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFF00A8E8),
                onPrimary: Colors.white,
                surface: Color(0xFF0F1C3D),
              ).copyWith(secondary: const Color(0xFF00A8E8)),
            ),
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  final ThemeProvider themeProvider;

  const MainApp({Key? key, required this.themeProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: themeProvider.isDarkModeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'ChupapiMuñaño Video',
          initialRoute: '/home',
          routes: {
            '/home': (context) => const HomeScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/details': (context) => const DetailsScreen(),
          },
          theme: isDark
              ? ThemeData(
                  primaryColor: const Color(0xFF0A0F23),
                  scaffoldBackgroundColor: const Color(0xFF0A0F23),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF0A0F23),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(color: Colors.white),
                    bodyMedium: TextStyle(color: Colors.white70),
                    titleLarge: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  cardColor: const Color(0xFF141A3A),
                  colorScheme: const ColorScheme.dark(
                    primary: Color(0xFF005B8C),
                    onPrimary: Colors.white,
                    surface: Color(0xFF141A3A),
                  ),
                )
              : ThemeData(
                  primaryColor: const Color(0xFF1A2A6C),
                  scaffoldBackgroundColor: const Color(0xFF1A2A6C),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF1A2A6C),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(color: Colors.white),
                    bodyMedium: TextStyle(color: Colors.white70),
                    titleLarge: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  cardColor: const Color(0xFF0F1C3D),
                  colorScheme: const ColorScheme.dark(
                    primary: Color(0xFF00A8E8),
                    onPrimary: Colors.white,
                    surface: Color(0xFF0F1C3D),
                  ).copyWith(secondary: const Color(0xFF00A8E8)),
                ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
