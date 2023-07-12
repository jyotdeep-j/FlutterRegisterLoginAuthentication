
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripplnr/data/network/dio/dio_client.dart';
import 'package:tripplnr/screens/auth/login/RequestLoginModel.dart';
import 'package:tripplnr/screens/auth/signup/signupResponse.dart';
import '../../../../data/network/dio/repoclass/remoteclass.dart';
import '../../../../data/network/dio/repoclass/repo.dart';
import '../../../../data/response/api_response.dart';
import 'forgotResponse.dart';


//  Getx for State Management for keeping business login seperated 
class ForgotController extends GetxController with StateMixin<SignupResponse>{
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final RepoClass _appRepository = RepoClass(RemoteClass(DioClient()));

//////// Text Editing Controllers
  late TextEditingController emailController;

//////////// Local Varaibles//////////////
  String? _email = '';
  String? _password = '';
  var isLoading=false.obs;




/////////////////////////////// Methods/Functions///////////////////
  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController = TextEditingController();
    super.onClose();
  }

  void setEmail(String? email) {
    _email = email;
    update();

  }


      ////////////Api Result///////////////
  ApiResponse result = ApiResponse.empty();

  Future<ApiResponse<ForgotResponse>> forgot() async {
    final email = _email;
    return _appRepository.forgotApi(RequestLoginModel(
    email: email.toString(),
    )).then((value) => value.isSuccess() ?Future.value((value)):Future.value((value)));
  }

}


