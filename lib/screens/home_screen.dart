import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/forecast_model.dart';
import 'package:weatherapp/utils/date_formatter.dart';
import '../providers/weather_provider.dart';
import '../providers/settings_provider.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart' hide WeatherState;
import '../widgets/current_weather_card.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/weather_detail_item.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_widget.dart';
import 'search_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isUsingCache = false;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadInitialWeather();
    });
  }

  Future<void> _loadInitialWeather() async {
    final provider = context.read<WeatherProvider>();
    final storage = context.read<StorageService>();

    final isCacheValid = await storage.isCacheValid();
    if (isCacheValid) {
      setState(() {
        _isUsingCache = true;
      });
      await provider.loadCachedWeather();
    } else {
      await provider.fetchWeatherByLocation();
    }
  }

  LinearGradient _getBackgroundGradient(String? condition) {
    if (condition == null) {
      return const LinearGradient(
        colors: [kDefaultPrimaryColor, kDefaultBackgroundColor],
      );
    }
    final key = condition.toLowerCase();
    final colors = kWeatherGradients[key] ?? kWeatherGradients['clear'];
    return LinearGradient(
      colors: colors!,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) {
        final weather = provider.currentWeather;
        final condition = weather?.mainCondition.toLowerCase();

        return Container(
          decoration: BoxDecoration(
            gradient: _getBackgroundGradient(condition),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Consumer<SettingsProvider>(
                builder: (context, settings, _) {
                  return _isUsingCache
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.cloud_off,
                              size: 18,
                              color: Colors.yellow,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              settings.translate('offline_mode'),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.yellow[200],
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(); 
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  ),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _isRefreshing = true;
                  _isUsingCache = false;
                });
                await provider.refreshWeather();
                setState(() {
                  _isRefreshing = false;
                });
              },
              child: _buildBody(provider, weather),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(WeatherProvider provider, weather) {
    if (provider.state == WeatherState.loading &&
        weather == null &&
        !_isRefreshing) {
      return const LoadingShimmer();
    }

    if (provider.state == WeatherState.error && weather == null) {
      return Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return ErrorWidgetCustom(
            message: provider.errorMessage,
            onRetry: () => provider.fetchWeatherByLocation(),
          );
        },
      );
    }

    if (weather != null) {
      final dailyForecasts = <ForecastModel>[];
      for (int i = 0; i < provider.forecast.length; i += 8) {
        if (dailyForecasts.length < 5 && i < provider.forecast.length) {
          dailyForecasts.add(provider.forecast[i]);
        }
      }

      return Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: kScreenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CurrentWeatherCard(weather: weather),

                Padding(
                  padding: const EdgeInsets.only(left: kScreenPadding, top: 20),
                  child: Text(
                    settings.translate('hourly_forecast').toUpperCase(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white70),
                  ),
                ),
                HourlyForecastList(forecasts: provider.forecast),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kScreenPadding,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        settings.translate('daily_forecast').toUpperCase(),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: Colors.white70),
                      ),
                      const Spacer(),
                      if (dailyForecasts.isNotEmpty)
                        Text(
                          settings.translate('precipitation'),
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                    ],
                  ),
                ),
                ...dailyForecasts
                    .map((item) => DailyForecastCard(forecast: item))
                    .toList(),

                const SizedBox(height: kScreenPadding),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kScreenPadding,
                    vertical: 10,
                  ),
                  child: Text(
                    settings.translate('weather_details').toUpperCase(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white70),
                  ),
                ),
                _buildWeatherDetails(context, weather),
                const SizedBox(height: kScreenPadding * 2),
              ],
            ),
          );
        },
      );
    }

    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, size: 60, color: Colors.white70),
              const SizedBox(height: 16),
              Text(
                settings.translate('no_weather_data'),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                settings.translate('loading'),
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => provider.fetchWeatherByLocation(),
                child: Text(settings.translate('try_again')),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeatherDetails(BuildContext context, weather) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: kScreenPadding),
          padding: const EdgeInsets.all(kScreenPadding / 2),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(kCardBorderRadius),
          ),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.5,
            children: [
              WeatherDetailItem(
                icon: Icons.water_drop,
                label: settings.translate('humidity'),
                value: '${weather.humidity}%',
              ),
              WeatherDetailItem(
                icon: Icons.air,
                label: settings.translate('wind'),
                value: settings.formatWindSpeed(weather.windSpeed),
              ),
              WeatherDetailItem(
                icon: Icons.compress,
                label: settings.translate('pressure'),
                value: '${weather.pressure} hPa',
              ),
              WeatherDetailItem(
                icon: Icons.visibility,
                label: settings.translate('visibility'),
                value: '${(weather.visibility ?? 0) / 1000} km',
              ),
              WeatherDetailItem(
                icon: Icons.wb_sunny,
                label: settings.translate('sunrise'),
                value: DateFormatter.formatTime(
                  weather.sunrise,
                  is24HourFormat: settings.is24HourFormat,
                ),
              ),
              WeatherDetailItem(
                icon: Icons.nightlight,
                label: settings.translate('sunset'),
                value: DateFormatter.formatTime(
                  weather.sunset,
                  is24HourFormat: settings.is24HourFormat,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
