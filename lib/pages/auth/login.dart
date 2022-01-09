import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/models/user_model.dart' as model;
import 'package:food_app/pages/auth/utls.dart';
import 'package:food_app/providers/app_localizations.dart';
import 'package:food_app/configs/colors.dart';
import 'package:food_app/configs/configs.dart';
import 'package:food_app/configs/my_class.dart';
import 'package:food_app/providers/auth_service.dart';
import 'package:food_app/utils/toast_utls.dart';
import 'package:food_app/widgets/resolution_not_supported.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = MyClass.getDeviceType(MediaQuery.of(context).size);
    final authService = Provider.of<AuthService>(context);
    void onSubmit() async {
      if (_formkey.currentState!.validate()) {
        try {
          model.User? user = await authService.signInwithEmailAndPassword(
              emailController.text, passwordController.text);
          if (user != null) {
            ToastUtils.toastSucessfull("Login Sucessfull");
            Navigator.of(context).pushReplacementNamed('/home');
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
          actions: [
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!.translate('btn_skip')!,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor)),
                  Icon(Icons.navigate_next, color: primaryColor, size: 24)
                ],
              ),
              onPressed: () => Navigator.pushNamed(context, "/home"),
            )
          ],
        ),
        body: _buildBody(deviceType, onSubmit));
  }

  Widget _buildBody(DeviceType deviceType, Function onSubmit) {
    if (deviceType == DeviceType.MOBILE) {
      return loginMobile(
        formkey: _formkey,
        context: context,
        emailController: emailController,
        passwordController: passwordController,
        onSubmit: onSubmit,
      );
    } else if (deviceType == DeviceType.WEB ||
        deviceType == DeviceType.TABLET) {
      return loginWebAndTablet(
          formkey: _formkey,
          context: context,
          emailController: emailController,
          passwordController: passwordController);
    } else
      return screenSizeNotSupported(context);
  }
}

class loginWebAndTablet extends StatelessWidget {
  const loginWebAndTablet({
    Key? key,
    required GlobalKey<FormState> formkey,
    required this.context,
    required this.emailController,
    required this.passwordController,
  })  : _formkey = formkey,
        super(key: key);

  final GlobalKey<FormState> _formkey;
  final BuildContext context;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formkey,
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
                            .translate('log_into_your_account')!,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: primaryColor),
                      ),
                      SizedBox(height: 30),
                      emailField(
                          emailController: emailController, context: context),
                      SizedBox(height: 20),
                      paswordField(
                          passwordController: passwordController,
                          context: context),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 20))),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .translate('btn_forgot_password')!,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor)),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/forgot_password");
                          },
                        ),
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
                                .translate('btn_login')!,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: Colors.white)),
                        onPressed: () {
                          Navigator.pushNamed(context, "/home");
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!
                            .translate('or_login_with_social_account')!,
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
                                  .translate('dont_have_account'),
                            ),
                            TextSpan(text: ' '),
                            TextSpan(
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: primaryColor),
                              text: AppLocalizations.of(context)!
                                  .translate('btn_signup'),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, "/signup");
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
            ),
          )),
    );
  }
}

class loginMobile extends StatelessWidget {
  const loginMobile(
      {Key? key,
      required GlobalKey<FormState> formkey,
      required this.context,
      required this.emailController,
      required this.passwordController,
      required this.onSubmit})
      : _formkey = formkey,
        super(key: key);

  final GlobalKey<FormState> _formkey;
  final BuildContext context;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: false,
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .translate('log_into_your_account')!,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: primaryColor),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                        controller: emailController,
                        // validator: (val) => val!.isNotEmpty
                        //     ? null
                        //     : AppLocalizations.of(context)!
                        //         .translate("please_input_email"),
                        // onSaved: (value) {
                        //   emailController.text = value!;
                        // },
                        validator: (value) {
                          return AuthUtils.validateEmail(value!);
                        },
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          labelText: AppLocalizations.of(context)!
                              .translate('username_email'),
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
                      controller: passwordController,
                      // validator: (val) => val!.isNotEmpty
                      //     ? null
                      //     : AppLocalizations.of(context)!
                      //         .translate("please_input_pasword"),
                      // onSaved: (value) {
                      //   passwordController.text = value!;
                      // },
                      validator: (value) {
                        return AuthUtils.validatePasswrod(value!);
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        labelText:
                            AppLocalizations.of(context)!.translate('password'),
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
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 20))),
                        child: Text(
                            AppLocalizations.of(context)!
                                .translate('btn_forgot_password')!,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor)),
                        onPressed: () {
                          Navigator.pushNamed(context, "/forgot_password");
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 15)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(BORDER_RADIUS),
                          )),
                          elevation: MaterialStateProperty.all(12),
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.white))),
                      child: Text(
                          AppLocalizations.of(context)!.translate('btn_login')!,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.white)),
                      onPressed: () {
                        onSubmit();
                        // Navigator.pushReplacementNamed(context, "/home");
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)!
                          .translate('or_login_with_social_account')!,
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
                            child: Image.asset("assets/images/icon_twitter.png",
                                width: 24, height: 24),
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
                                .translate('dont_have_account'),
                          ),
                          TextSpan(text: ' '),
                          TextSpan(
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                color: primaryColor),
                            text: AppLocalizations.of(context)!
                                .translate('btn_signup'),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, "/signup");
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
  }
}

class paswordField extends StatelessWidget {
  const paswordField({
    Key? key,
    required this.passwordController,
    required this.context,
  }) : super(key: key);

  final TextEditingController passwordController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      validator: (val) => val!.isNotEmpty
          ? null
          : AppLocalizations.of(context)!.translate("please_input_password"),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        labelText: AppLocalizations.of(context)!.translate('password'),
        labelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: textLightColor),
      ),
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: textDarkColor),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
    );
  }
}

class emailField extends StatelessWidget {
  const emailField({
    Key? key,
    required this.emailController,
    required this.context,
  }) : super(key: key);

  final TextEditingController emailController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: emailController,
        validator: (val) => val!.isNotEmpty
            ? null
            : AppLocalizations.of(context)!.translate("please_input_email"),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          labelText: AppLocalizations.of(context)!.translate('username_email'),
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              color: textLightColor),
        ),
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: textDarkColor),
        textCapitalization: TextCapitalization.words);
  }
}
