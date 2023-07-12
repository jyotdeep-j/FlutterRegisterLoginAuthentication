
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripplnr/data/network/dio/dio_client.dart';
import 'package:tripplnr/screens/auth/login/RequestLoginModel.dart';
import 'package:tripplnr/screens/auth/login/loginResponse.dart';
import '../../../data/network/dio/repoclass/remoteclass.dart';
import '../../../data/network/dio/repoclass/repo.dart';
import '../../../data/response/api_response.dart';


/////////////////////Model View -> with Getx //////////////////////
class LoginController extends GetxController {

   /////////////////////////////Form Keys///////////////
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();


  /////////////////////////////Repository////////////////////////////
  final RepoClass _appRepository = RepoClass(RemoteClass(DioClient()));


  //////////////////////////// Text Editing Controllers//////////////
  late TextEditingController firstController, lastController,emailController,locationController,passwordController,cPasswordController;


///////////////////////////////////Local Variables///////////////////////
  String? _email = '';
  String? _password = '';


//////////////////////////Methods? Functions/////////////////////
  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void setEmail(String? email) {
    _email = email;
    update();
  }

  void setPassword(String? password) {
    _password = password;
    update();
  }

  bool isLoading=false;
  void setLoading(bool value) {
    isLoading=value;
  }

  bool get getLoading {
    return isLoading;
  }

  ApiResponse result = ApiResponse.empty();
  Future<ApiResponse<LoginResponse>> logIn() async {
    final email = _email;
    final password = _password;
    return _appRepository.signIn(RequestLoginModel(
    email: email.toString(), password :password.toString(),
    )).then((value) => value.isSuccess() ?Future.value((value)):Future.value((value)));
  }
}


