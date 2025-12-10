import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../providers/weather_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late LocationProvider _locationProvider;
  bool _showRecentSearches = true;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _locationProvider = context.read<LocationProvider>();

    _focusNode.addListener(() {
      setState(() {
        _showRecentSearches = !_focusNode.hasFocus;
      });
    });
  }

  void _searchCity() {
    final cityName = _controller.text.trim();
    if (cityName.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });

      _locationProvider.addRecentSearch(cityName);

      context
          .read<WeatherProvider>()
          .fetchWeatherByCity(cityName)
          .then((_) {
            if (mounted) {
              setState(() {
                _isSearching = false;
              });
              Navigator.pop(context);
            }
          })
          .catchError((error) {
            if (mounted) {
              setState(() {
                _isSearching = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $error'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          });
    }
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {});
  }

  void _selectCity(String cityName) {
    _controller.text = cityName;
    _searchCity();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(settings.translate('search_city')),
            actions: [
              if (_isSearching)
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Consumer<LocationProvider>(
              builder: (context, locationProvider, _) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(kScreenPadding),
                    child: Column(
                      children: [
                        TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            labelText: settings.translate('enter_city_name'),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _controller.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: _clearSearch,
                                  )
                                : null,
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                          ),
                          onSubmitted: (_) => _searchCity(),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),

                        const SizedBox(height: 20),

                        if (locationProvider.favoriteCities.isNotEmpty) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              settings.translate('favorite_cities'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: locationProvider.favoriteCities.length,
                              itemBuilder: (context, index) {
                                final city =
                                    locationProvider.favoriteCities[index];
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: InputChip(
                                    label: Text(city),
                                    avatar: const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    onPressed: () => _selectCity(city),
                                    onDeleted: () => locationProvider
                                        .removeFavoriteCity(city),
                                    deleteIcon: const Icon(
                                      Icons.close,
                                      size: 16,
                                    ),
                                    backgroundColor: Colors.blue.withOpacity(
                                      0.2,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                        ],

                        if (_showRecentSearches &&
                            locationProvider.recentSearches.isNotEmpty) ...[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      settings.translate('recent_searches'),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (locationProvider
                                        .recentSearches
                                        .isNotEmpty)
                                      TextButton(
                                        onPressed: () {
                                          locationProvider.recentSearches
                                              .clear();
                                          locationProvider.notifyListeners();
                                        },
                                        child: Text(
                                          'Clear all',
                                          style: TextStyle(
                                            color: Colors.red[300],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        locationProvider.recentSearches.length,
                                    itemBuilder: (context, index) {
                                      final city = locationProvider
                                          .recentSearches[index];
                                      return Card(
                                        margin: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        color: Colors.white.withOpacity(0.1),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.history,
                                            color: Colors.white70,
                                          ),
                                          title: Text(
                                            city,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () => _selectCity(city),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  locationProvider
                                                          .favoriteCities
                                                          .contains(city)
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color:
                                                      locationProvider
                                                          .favoriteCities
                                                          .contains(city)
                                                      ? Colors.amber
                                                      : Colors.white70,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  if (locationProvider
                                                      .favoriteCities
                                                      .contains(city)) {
                                                    locationProvider
                                                        .removeFavoriteCity(
                                                          city,
                                                        );
                                                  } else {
                                                    locationProvider
                                                        .addFavoriteCity(city);
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        if (_showRecentSearches &&
                            locationProvider.recentSearches.isEmpty &&
                            locationProvider.favoriteCities.isEmpty) ...[
                          Expanded(
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 80,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      settings.translate('no_recent_searches'),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0,
                                      ),
                                      child: Text(
                                        settings.translate('search_for_cities'),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _controller.text = 'London';
                                        _searchCity();
                                      },
                                      icon: const Icon(Icons.explore),
                                      label: const Text('Try: London'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue
                                            .withOpacity(0.3),
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: _controller.text.isNotEmpty && !_isSearching
              ? FloatingActionButton.extended(
                  onPressed: _searchCity,
                  icon: const Icon(Icons.search),
                  label: Text(settings.translate('search_city')),
                  backgroundColor: Colors.blue,
                )
              : null,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
