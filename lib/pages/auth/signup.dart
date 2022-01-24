import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/pages/auth/utls.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/services/auth_services.dart';
// import 'package:food_app/providers/auth_service.dart';
import 'package:food_app/utils/toast_utls.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';
import 'package:provider/provider.dart';
import 'package:food_app/models/user_model.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);
    // final authService = Provider.of<AuthService>(context);

    void onSubmit() async {
      if (_formkey.currentState!.validate()) {
        try {
          // model.User? user = await authService.createUserWithEmailAndPassword(
          //     emailController.text, passwordController.text);
          model.User? user = await AuthServices.register({
            'email': emailController.text,
            'password': passwordController.text,
            'phone': phoneController.text,
            'name': nameController.text
          });
          print(user);
          if (user != null) {
            ToastUtils.toastSucessfull("Sing up Sucessfull");
            Navigator.pop(context);
          }
        } on FirebaseAuthException catch (error) {
          ToastUtils.toastFailed(AuthUtils.errorMessage(error.code));
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
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
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1), blurRadius: 10)
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
        ),
        body: _buildBody(deviceType, onSubmit));
  }

  Widget _buildBody(DeviceType deviceType, onSubmit) {
    if (deviceType == DeviceType.WEB || deviceType == DeviceType.TABLET) {
      return SignupWebAndTablet(
        context: context,
      );
    } else if (deviceType == DeviceType.MOBILE) {
      return Scrollbar(
        isAlwaysShown: false,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .translate('create_your_account')!,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: primaryColor),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            labelText: AppLocalizations.of(context)!
                                .translate('your_name'),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: textLightColor),
                          ),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textDarkColor),
                          textCapitalization: TextCapitalization.words),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        validator: (value) => AuthUtils.validateEmail(value!),
                        onSaved: (newValue) => emailController.text = newValue!,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          labelText:
                              AppLocalizations.of(context)!.translate('email'),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: textLightColor),
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textDarkColor),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: phoneController,
                        validator: (value) => AuthUtils.validatePhone(value!),
                        onSaved: (value) => phoneController.text = value!,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          labelText:
                              AppLocalizations.of(context)!.translate('phone'),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: textLightColor),
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textDarkColor),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        onSaved: (newValue) =>
                            passwordController.text = newValue!,
                        validator: (value) =>
                            AuthUtils.validatePasswrod(value!),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          labelText: AppLocalizations.of(context)!
                              .translate('password'),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: textLightColor),
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textDarkColor),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) => AuthUtils.validateConfirmPassword(
                            value!, passwordController.text),
                        onSaved: (newValue) =>
                            confirmPasswordController.text = newValue!,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          labelText: AppLocalizations.of(context)!
                              .translate('confirm_password'),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: textLightColor),
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textDarkColor),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 15)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(BORDER_RADIUS),
                            )),
                            elevation: MaterialStateProperty.all(12),
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: Colors.white))),
                        child: Text(
                            AppLocalizations.of(context)!
                                .translate('btn_signup')!,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: Colors.white)),
                        onPressed: () async => onSubmit(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!
                            .translate('or_signup_with_social_account')!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: textMidColor),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 12)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(BORDER_RADIUS),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(facebookColor),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(color: Colors.white))),
                              child: Image.asset(
                                  "assets/images/icon_facebook.png",
                                  width: 24,
                                  height: 24),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 12)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(BORDER_RADIUS),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(twitterColor),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(color: Colors.white))),
                              child: Image.asset(
                                  "assets/images/icon_twitter.png",
                                  width: 24,
                                  height: 24),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: textMidColor),
                              text: AppLocalizations.of(context)!
                                  .translate('already_have_account'),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: primaryColor),
                              text: AppLocalizations.of(context)!
                                  .translate('btn_login'),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            )),
      );
    } else
      return screenSizeNotSupported(context);
  }
}

class SignupWebAndTablet extends StatelessWidget {
  const SignupWebAndTablet({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: WEB_FIXED_WIDTH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .translate('create_your_account')!,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: primaryColor),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            labelText: AppLocalizations.of(context)!
                                .translate('your_name'),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: textLightColor),
                          ),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textDarkColor),
                          textCapitalization: TextCapitalization.words),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          labelText:
                              AppLocalizations.of(context)!.translate('email'),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: textLightColor),
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textDarkColor),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          labelText: AppLocalizations.of(context)!
                              .translate('password'),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: textLightColor),
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textDarkColor),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 20)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(BORDER_RADIUS),
                            )),
                            elevation: MaterialStateProperty.all(12),
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: Colors.white))),
                        child: Text(
                            AppLocalizations.of(context)!
                                .translate('btn_signup')!,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: Colors.white)),
                        onPressed: () => Navigator.pushNamed(context, "/home"),
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!
                            .translate('or_signup_with_social_account')!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: textMidColor),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 15)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(BORDER_RADIUS),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(facebookColor),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(color: Colors.white))),
                              child: Image.asset(
                                  "assets/images/icon_facebook.png",
                                  width: 24,
                                  height: 24),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 15)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(BORDER_RADIUS),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(twitterColor),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(color: Colors.white))),
                              child: Image.asset(
                                  "assets/images/icon_twitter.png",
                                  width: 24,
                                  height: 24),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: textMidColor),
                              text: AppLocalizations.of(context)!
                                  .translate('already_have_account'),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: primaryColor),
                              text: AppLocalizations.of(context)!
                                  .translate('btn_login'),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            )));
  }
}
