import 'package:flutter/material.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:provider/provider.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  AppLanguage? _appLanguage;
  final List<LanguageModel> _arrayList = [
    LanguageModel('ar', 'Arabic'),
    LanguageModel('zh', 'Chinese'),
    LanguageModel('nl', 'Dutch'),
    LanguageModel('en', 'English'),
    LanguageModel('fr', 'French'),
    LanguageModel('de', 'German'),
    LanguageModel('iw', 'Hebrew'),
    LanguageModel('hi', 'Hindi'),
    LanguageModel('hu', 'Hungarian'),
    LanguageModel('in', 'Indonesian'),
    LanguageModel('it', 'Italian'),
    LanguageModel('ja', 'Japanese'),
    LanguageModel('ko', 'Korean'),
    LanguageModel('pt', 'Portuguese'),
    LanguageModel('ro', 'Romanian'),
    LanguageModel('ru', 'Russian'),
    LanguageModel('es', 'Spanish'),
    LanguageModel('th', 'Thai'),
    LanguageModel('tr', 'Turkish'),
    LanguageModel('ur', 'Urdu'),
    LanguageModel('vi', 'Vietnamese'),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_appLanguage == null) {
      _appLanguage = Provider.of<AppLanguage>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        leading: Center(
          child: Container(
            width: 35,
            height: 35,
            margin: const EdgeInsetsDirectional.only(start: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                ),
                child: Icon(Icons.navigate_before, color: Colors.black),
                onPressed: () => Navigator.pop(context)),
          ),
        ),
        title: Text(AppLocalizations.of(context)!.translate('change_language')!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textDarkColor)),
      ),
      body: Scrollbar(
        isAlwaysShown: (deviceType == DeviceType.MOBILE) ? false : true,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _arrayList.length,
          itemBuilder: (context, index) {
            return listItem(_arrayList[index].title, _arrayList[index].code);
          },
        ),
      ),
    );
  }

  Widget listItem(String title, String countryCode) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
      ], borderRadius: BorderRadius.circular(12), color: Colors.white),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () async {
          await _appLanguage!.changeLanguage(Locale(countryCode));
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Icon(Icons.flag, size: 30, color: textLightColor),
              SizedBox(width: 15),
              Text(countryCode,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: textDarkColor)),
              SizedBox(width: 15),
              Text(title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: textDarkColor)),
              Expanded(child: SizedBox()),
              if (_appLanguage!.appLocale.countryCode == countryCode) ...[
                Icon(Icons.check, color: successColor)
              ]
            ],
          ),
        ),
      ),
    );
  }
}
