import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/services/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';
import 'package:provider/provider.dart';

class SelectLanguage extends StatefulWidget {
  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
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
  AppLanguage? _appLanguage;

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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: _buildBody(deviceType),
        ),
      ),
    );
  }

  Widget _buildBody(DeviceType deviceType) {
    if (deviceType == DeviceType.WEB || deviceType == DeviceType.TABLET) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 30),
          Text(
            AppLocalizations.of(context)!.translate('select_language')!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: textMidColor),
          ),
          SizedBox(height: 15),
          Center(
            child: Container(
              width: WEB_FIXED_WIDTH,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFEEEEEE)),
                  borderRadius: BorderRadius.circular(BORDER_RADIUS),
                  color: Colors.white),
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: textLightColor),
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          SizedBox(height: 5),
          Flexible(
              child: Scrollbar(
            isAlwaysShown: true,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _arrayList.length,
              itemBuilder: (context, index) {
                return _buildListItem(_arrayList[index], deviceType);
              },
            ),
          ))
        ],
      );
    } else if (deviceType == DeviceType.MOBILE) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 30),
          Text(
            AppLocalizations.of(context)!.translate('select_language')!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: textMidColor),
          ),
          SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFEEEEEE)),
                borderRadius: BorderRadius.circular(BORDER_RADIUS),
                color: Colors.white),
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Search',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    color: textLightColor),
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor),
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(height: 5),
          Flexible(
              child: Scrollbar(
            isAlwaysShown: false,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _arrayList.length,
              itemBuilder: (context, index) {
                return _buildListItem(_arrayList[index], deviceType);
              },
            ),
          ))
        ],
      );
    } else
      return screenSizeNotSupported(context);
  }

  Widget _buildListItem(LanguageModel model, DeviceType deviceType) {
    return Center(
      child: Container(
        width: (deviceType != DeviceType.MOBILE) ? 400 : double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Material(
          color: Colors.white,
          child: InkWell(
            hoverColor: hoverColor,
            onTap: () async {
              await _appLanguage!.changeLanguage(Locale(model.code));
              Navigator.pushNamed(context, "/select_theme");
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Icon(Icons.flag, size: 30, color: textMidColor),
                  SizedBox(width: 20),
                  Text(model.code,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: Colors.black)),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(model.title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
