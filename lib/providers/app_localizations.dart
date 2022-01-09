import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const LanguagesList = [
  'ar',
  'de',
  'en',
  'es',
  'fr',
  'hi',
  'hu',
  'in',
  'it',
  'iw',
  'ja',
  'ko',
  'nl',
  'pt',
  'ro',
  'ru',
  'th',
  'tr',
  'ur',
  'vi',
  'zh'
];

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);
  late Map<String, String> _localizedStrings;

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
        await rootBundle.loadString('localization/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String? translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return LanguagesList.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocale => _appLocale;

  Future changeLanguage(Locale type) async {
    LanguagesList.forEach((element) {
      if (type == Locale(element)) _appLocale = Locale(element);
    });

    notifyListeners();
  }

  Iterable<Locale> supportedLanguages() {
    List<Locale> localeList = [];

    LanguagesList.forEach((element) {
      localeList.add(Locale(element));
    });
    return localeList;
  }
}
