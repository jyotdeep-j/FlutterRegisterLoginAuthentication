// ignore_for_file: override_on_non_overriding_member

import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../components/sht_button_widget.dart';
import '../../components/sht_textinputfield_widget.dart';
import '../../router/routes_name.dart';
import '../../screens/auth/login/forgotResponse/forgotController.dart';
import '../../tripplnr/screens/auth/login/loginController.dart';
import '../../tripplnr/screens/auth/login/sociallogin/googleLoginController.dart';
import '../../tripplnr/session.dart';
import '../../tripplnr/utils/sheard_pref.dart';
import '../../tripplnr/utils/sht_assets.dart';
import '../../tripplnr/utils/sht_colors.dart';
import 'dart:io' show Platform;

import '../../../utils/prefrencefile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //////////////////////// Controllers///////////////// 
  final LoginController _loginController = Get.put(LoginController());
  final ForgotController _forgotController = Get.put(ForgotController());
  final SocialLoginController _socialLoginController =
      Get.put(SocialLoginController());
  final UserViewModel _userViewModel = Get.put(UserViewModel());
  PreferenceUtils preferenceUtils = PreferenceUtils();


///////////////////////////Form Keys for Validation/////////////////
  final _formKey = GlobalKey<FormState>();
  final _popuformKey = GlobalKey<FormState>();

  /////////////////////////Firebase Auth////////////
  final FirebaseAuth auth = FirebaseAuth.instance;


///////////////////// Social Login//////////////////
  GoogleSignIn googleSignIn = GoogleSignIn();



  @override
  void initState() {
    googleSignIn.signOut();
    super.initState();
  }


  ////////////////dispose/delete all controllers to release resources///////////////////
    @override
  void dispose() {
    Get.delete<LoginController>().obs;
    Get.delete<SocialLoginController>().obs;
    Get.delete<ForgotController>().obs;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 310.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(ShtAssets.loginBg))),
                  ),
                  Positioned(
                      top: 30.h,
                      right: 22.w,
                      child: ShtButtonWidget(
                        radius: 10.r,
                        height: 26,
                        width: 50,
                        padding: EdgeInsets.zero,
                        title: 'Skip',
                        color: ShtColors.blackColor.withOpacity(0.1),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.dashboard);
                        },
                      )),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: -1,
                    child: Container(
                        height: 35.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35.r),
                              topRight: Radius.circular(35.r)),
                        )),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 33.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Sign in',
                        style: TextStyle(
                            color: ShtColors.blackColor,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w900)),
                    SizedBox(height: 8.h),
                    Text('Welcome Back to Hotel!',
                        style: TextStyle(
                            color: ShtColors.lightGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 20.h),
                    ShtTextInputField(
                        keyboardType: TextInputType.emailAddress,
                        hintLabel: 'Email',
                        controller: _loginController.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          } else if (!GetUtils.isEmail(value)) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _loginController.setEmail(value);
                        },
                        prefixIcon: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 20.w, end: 16.w, top: 17.h, bottom: 17.h),
                          child: SvgPicture.asset(ShtIcons.emailIcon,
                              color: ShtColors.darkGreyColor,
                              width: 14.w,
                              height: 11.h), // myIcon is a 48px-wide widget.
                        )),
                    SizedBox(height: 10.h),
                    ShtTextInputField(
                        obscureText: true,
                        hintLabel: 'Password',
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[ ]')),
                        ],
                        controller: _loginController.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 6) {
                            return "Password must be of 6 characters";
                          }
                        },
                        onChanged: (value) {
                          _loginController.setPassword(value);
                        },
                        prefixIcon: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 20.w, end: 16.w, top: 17.h, bottom: 17.h),
                          child: SvgPicture.asset(ShtIcons.passwordIcon,
                              color: ShtColors.darkGreyColor,
                              width: 14.w,
                              height: 11.h), // myIcon is a 48px-wide widget.
                        )),
                    GestureDetector(
                      onTap: () {
                        _displayTextInputDialog();
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          child: Text('Forgot Password?',
                              style: TextStyle(
                                  color: ShtColors.blackColor,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500))),
                    ),
                    SizedBox(height: 25.h),
                    ShtButtonWidget(
                        title: 'Login',
                        color: ShtColors.blackColor,
                        height: 48.h,
                        radius: 10.r,
                        onPressed: () {
                          hitApi();
                        }),
                    SizedBox(height: 25.h),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          color: Colors.grey,
                          thickness: 0.7,
                        )),
                        Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            alignment: Alignment.center,
                            child: Text('Or sign in with',
                                style: TextStyle(
                                    color: ShtColors.lightGreyColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500))),
                        const Expanded(
                            child: Divider(
                          color: Colors.grey,
                          thickness: 0.7,
                        )),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            onGoogleLogInButtonClick();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: Image.asset(ShtIcons.googleIcon,
                                width: 75.w, height: 36.h),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            allowUserToSignInWithFB();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: Image.asset(ShtIcons.facebookIcon,
                                width: 75.w, height: 36.h),
                          ),
                        ),
                        Platform.isIOS
                            ? Container(
                                margin:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Image.asset(ShtIcons.appleIcon,
                                    width: 75.w, height: 36.h),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don’t have an Account?',
                            style: TextStyle(
                                color: ShtColors.normalGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.register);
                            },
                            child: Container(
                                height: 20.h,
                                alignment: Alignment.center,
                                child: Text('Sign Up',
                                    style: TextStyle(
                                        color: ShtColors.blackColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500)))),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Obx(
            () => ModalProgressHUD(
              inAsyncCall: _forgotController.isLoading.value,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                title: Text(
                  'Forgot your password ?',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: Text(
                      "Enter your email address to retrieve your password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff989898)),
                    )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Form(
                      key: _popuformKey,
                      child: Container(
                        margin: EdgeInsets.only(top: 15.h),
                        child: ShtTextInputField(
                            height: 70.h,
                            keyboardType: TextInputType.emailAddress,
                            hintLabel: 'Email',
                            controller: _forgotController.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (!GetUtils.isEmail(value)) {
                                return "Please enter valid email";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _forgotController.setEmail(value);
                            },
                            prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 20.w,
                                  end: 16.w,
                                  top: 17.h,
                                  bottom: 17.h),
                              child: SvgPicture.asset(ShtIcons.emailIcon,
                                  color: ShtColors.darkGreyColor,
                                  width: 22.w,
                                  height:
                                      22.h), // myIcon is a 48px-wide widget.
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50.h,
                            margin: const EdgeInsets.only(
                              right: 5,
                            ),
                            decoration: const BoxDecoration(
                                color: Color(0xfffca500),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: TextButton(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              onPressed: () {
                                //  Navigator.pop(context);
                                hitForgotApi();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void hitApi() {
    if (_formKey.currentState!.validate()) {
      _showLoading();
      _loginController.logIn().then((value) {
        Navigator.pop(context);
        if (value.isSuccess()) {
          var user = value.data().data!;
          _userViewModel.saveUser(
              user.name.toString(), user.email.toString(), user.phoneNo);
          PreferenceUtils.setString("token", user.token.toString());
          Session.load().obs;
          Navigator.pushReplacementNamed(
            context,
            RoutesName.dashboard,
          );
        } else {
          final flushbar = Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              borderRadius: BorderRadius.circular(8),
              margin: const EdgeInsets.only(left: 5, right: 5),
              message: value.error(),
              title: "Auth Demo",
              titleColor: Colors.white,
              titleSize: 18,
              blockBackgroundInteraction: true,
              backgroundColor: Colors.red,
              messageColor: Colors.white,
              messageSize: 16,
              duration: const Duration(seconds: 3));
          flushbar.show(context);
        }
      });
    }
  }



  void hitForgotApi() {
    if (_popuformKey.currentState!.validate()) {
      _popuformKey.currentState?.save();
      _showLoading();

      _forgotController.forgot().then((value) async {
        Navigator.pop(context);

        if (value.isSuccess()) {
          Navigator.pop(context);
          Flushbar(
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  borderRadius: BorderRadius.circular(8),
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  message: "Reset password mail has been send your email.",
                  title: "Auth Demo",
                  titleColor: Colors.white,
                  titleSize: 18,
                  blockBackgroundInteraction: true,
                  backgroundColor: Colors.black,
                  messageColor: Colors.white,
                  messageSize: 16,
                  duration: const Duration(milliseconds: 3000))
              .show(context);
        } else {
          final flushbar = Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              borderRadius: BorderRadius.circular(8),
              margin: const EdgeInsets.only(left: 5, right: 5),
              message: value.error(),
              title: "Auth Demo",
              titleColor: Colors.white,
              titleSize: 18,
              blockBackgroundInteraction: true,
              backgroundColor: Colors.red,
              messageColor: Colors.white,
              messageSize: 16,
              duration: const Duration(seconds: 3));
          flushbar.show(context);
        }
      });
    }
  }


 
  void _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: Container(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xfffca500)),
                ),
              ));
        });
  }






}
