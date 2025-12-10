import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'services/weather_service.dart';
import 'services/location_service.dart';
import 'services/storage_service.dart';
import 'services/connectivity_service.dart';
import 'services/language_service.dart';
import 'providers/weather_provider.dart';
import 'providers/location_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';

final LocationService _locationService = LocationService();
final StorageService _storageService = StorageService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");

  final WeatherService weatherService = WeatherService();
  final ConnectivityService connectivityService = ConnectivityService();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        Provider<WeatherService>.value(value: weatherService),
        Provider<LocationService>.value(value: _locationService),
        Provider<StorageService>.value(value: _storageService),
        Provider<ConnectivityService>.value(value: connectivityService),

        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(),
          lazy: false,
        ),
        
        ChangeNotifierProvider<WeatherProvider>(
          create: (context) => WeatherProvider(
            weatherService,
            _locationService,
            _storageService,
            connectivityService,
          ),
          lazy: false,
        ),

        ChangeNotifierProvider<LocationProvider>(
          create: (context) => LocationProvider(
            _locationService,
            _storageService,
          ),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return MaterialApp(
          title: settings.translate('app_title'),
          debugShowCheckedModeBanner: false,
          
          theme: ThemeData(
            primaryColor: kDefaultPrimaryColor,
            colorScheme: ColorScheme.fromSeed(
              seedColor: kDefaultPrimaryColor,
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: Colors.black,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              titleMedium: TextStyle(color: Colors.white),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.white,
              centerTitle: true,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: kDefaultPrimaryColor.withOpacity(0.8),
              foregroundColor: Colors.white,
            ),
            snackBarTheme: SnackBarThemeData(
              backgroundColor: Colors.blueGrey[800],
              contentTextStyle: const TextStyle(color: Colors.white),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: kDefaultPrimaryColor,
                  width: 2,
                ),
              ),
              labelStyle: const TextStyle(color: Colors.white70),
              hintStyle: const TextStyle(color: Colors.white54),
            ),
          ),
          
          home: const HomeScreen(),
        );
      },
    );
  }
}