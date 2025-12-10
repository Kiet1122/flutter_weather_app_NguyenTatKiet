import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../services/language_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(settings.translate('settings')),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return ListView(
            children: [
              ListTile(
                title: Text(settings.translate('language')),
                subtitle: Text(settings.language.name),
                trailing: PopupMenuButton<AppLanguage>(
                  onSelected: (lang) => settings.setLanguage(lang),
                  itemBuilder: (context) => LanguageService.availableLanguages
                      .map((lang) => PopupMenuItem(
                            value: lang,
                            child: Text(lang.name),
                          ))
                      .toList(),
                ),
              ),
              const Divider(height: 0),
              
              ListTile(
                title: Text(settings.translate('temperature_unit')),
                subtitle: Text(
                  settings.temperatureUnit == TemperatureUnit.celsius
                      ? settings.translate('celsius')
                      : settings.translate('fahrenheit'),
                ),
                trailing: Switch(
                  value: settings.temperatureUnit == TemperatureUnit.fahrenheit,
                  onChanged: (value) {
                    settings.setTemperatureUnit(
                      value ? TemperatureUnit.fahrenheit : TemperatureUnit.celsius,
                    );
                  },
                ),
              ),
              const Divider(height: 0),
              
              ListTile(
                title: Text(settings.translate('wind_speed_unit')),
                subtitle: Text(
                  _getWindSpeedUnitText(settings.windSpeedUnit, settings),
                ),
                trailing: PopupMenuButton<WindSpeedUnit>(
                  onSelected: (unit) => settings.setWindSpeedUnit(unit),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: WindSpeedUnit.ms,
                      child: Text(settings.translate('m_s')),
                    ),
                    PopupMenuItem(
                      value: WindSpeedUnit.kmh,
                      child: Text(settings.translate('km_h')),
                    ),
                    PopupMenuItem(
                      value: WindSpeedUnit.mph,
                      child: Text(settings.translate('mph')),
                    ),
                  ],
                ),
              ),
              const Divider(height: 0),
              
              ListTile(
                title: Text(settings.translate('time_format')),
                subtitle: Text(
                  settings.is24HourFormat 
                      ? settings.translate('24_hour')
                      : settings.translate('12_hour'),
                ),
                trailing: Switch(
                  value: settings.is24HourFormat,
                  onChanged: (value) => settings.set24HourFormat(value),
                ),
              ),
              const Divider(height: 0),
            ],
          );
        },
      ),
    );
  }
  
  String _getWindSpeedUnitText(WindSpeedUnit unit, SettingsProvider settings) {
    switch (unit) {
      case WindSpeedUnit.ms:
        return settings.translate('m_s');
      case WindSpeedUnit.kmh:
        return settings.translate('km_h');
      case WindSpeedUnit.mph:
        return settings.translate('mph');
    }
  }
}