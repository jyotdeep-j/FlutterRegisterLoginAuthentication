import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../components/sht_button_widget.dart';
import '../../components/sht_textinputfield_widget.dart';
import '../../screens/auth/signup/signupController.dart';
import '../../utils/sht_assets.dart';
import '../../utils/sht_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final SignUpController _signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
        SizedBox(height: 50.h,),
                Center(
                  child: Container(

                    margin: EdgeInsets.symmetric(horizontal: 33.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Sign up',
                            style: TextStyle(
                                color: ShtColors.blackColor,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w900)),
                        SizedBox(height: 8.h),
                        Text('Access with sign up!',
                            style: TextStyle(
                                color: ShtColors.lightGreyColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 15.h),
                        ShtTextInputField(
                            keyboardType: TextInputType.text,
                            hintLabel: 'First Name',
                            controller: _signUpController.firstController,
                            onChanged: (value) {
                              _signUpController.setFirstName(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your firstname";
                              }
                              return null;
                            },
                            prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 20.w, end: 16.w, top: 17.h, bottom: 17.h),
                              child: SvgPicture.asset(ShtIcons.userIcon,
                                  color: ShtColors.darkGreyColor,
                                  width: 14.w,
                                  height: 11.h), // myIcon is a 48px-wide widget.
                            )),
                        SizedBox(height: 5.h),
                        ShtTextInputField(
                            keyboardType: TextInputType.text,
                            hintLabel: 'Last Name',
                            controller: _signUpController.lastController,
                            onChanged: (value) {
                              _signUpController.setLastName(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your lastname";
                              }
                              return null;
                            },
                            prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 20.w, end: 16.w, top: 17.h, bottom: 17.h),
                              child: SvgPicture.asset(ShtIcons.userIcon,
                                  color: ShtColors.darkGreyColor,
                                  width: 14.w,
                                  height: 11.h), // myIcon is a 48px-wide widget.
                            )),
                        SizedBox(height: 5.h),
                        ShtTextInputField(
                            keyboardType: TextInputType.emailAddress,
                            hintLabel: 'Email',
                            controller: _signUpController.emailController,
                            onChanged: (value) {
                              _signUpController.setEmail(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (!GetUtils.isEmail(value)) {
                                return "Please enter valid email";
                              }
                              return null;
                            },
                            prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 20.w, end: 16.w, top: 17.h, bottom: 17.h),
                              child: SvgPicture.asset(ShtIcons.emailIcon,
                                  color: ShtColors.darkGreyColor,
                                  width: 14.w,
                                  height: 11.h), // myIcon is a 48px-wide widget.
                            )),
                        SizedBox(height: 5.h),
                        ShtTextInputField(
                            obscureText: true,

                            hintLabel: 'Password',
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],
                            controller: _signUpController.passwordController,
                            onChanged: (value) {
                              _signUpController.setPassword(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              } else if (value.length < 6) {
                                return "Password must be of 6 characters";
                              }
                              return null;
                            },
                            prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 20.w, end: 16.w, top: 17.h, bottom: 17.h),
                              child: SvgPicture.asset(ShtIcons.passwordIcon,
                                  color: ShtColors.darkGreyColor,
                                  width: 14.w,
                                  height: 11.h), // myIcon is a 48px-wide widget.
                            )),
                        SizedBox(height: 5.h),
                        ShtTextInputField(
                            obscureText: true,
                            hintLabel: 'Confirm Password',
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp('[ ]')),
                            ],

                            onChanged: (value) {
                              _signUpController.setCPassword(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your confirm password";
                              }
                              if (_signUpController.passwordController.text !=
                                  value) {
                                return "Password & Confirm Password doesn't match.";
                              }
                              return null;
                            },
                            controller: _signUpController.cPasswordController,
                            prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 20.w, end: 16.w, top: 17.h, bottom: 17.h),
                              child: SvgPicture.asset(ShtIcons.passwordIcon,
                                  color: ShtColors.darkGreyColor,
                                  width: 14.w,
                                  height: 11.h), // myIcon is a 48px-wide widget.
                            )),
                        SizedBox(height: 10.h),

                        ShtButtonWidget(
                            color: ShtColors.blackColor,
                            title: 'Sign Up',
                            height: 48.h,
                            radius: 10.r,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              hitApi();
                            }),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(child: Divider(color: Colors.grey,thickness: 0.7,)),

                            Text('Already have an Account?',
                                style: TextStyle(
                                    color: ShtColors.normalGreyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500)),

                            SizedBox(
                              width: 5.w,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 20.h,
                                  child: Text('Log In',
                                      style: TextStyle(
                                          color: ShtColors.blackColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500))),

                            ),
                            const Expanded(child: Divider(color: Colors.grey,thickness: 0.7,)),

                          ],
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SignUpController>();
    super.dispose();
  }

  void hitApi() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      _showLoading();

      _signUpController.signUps().then((value) {
           Navigator.pop(context);
        if (value.isSuccess()) {
          Navigator.pop(context);
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
              child:   Container(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color> (Color(0xfffca500)),
                ),
              ));
        });
  }
}
