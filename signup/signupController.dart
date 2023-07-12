
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripplnr/data/network/dio/dio_client.dart';
import 'package:tripplnr/screens/auth/signup/signupResponse.dart';
import '../../../data/network/dio/repoclass/remoteclass.dart';
import '../../../data/network/dio/repoclass/repo.dart';
import '../../../data/response/api_response.dart';
import 'signupModel.dart';

////////////////Model View Class for keeping business login seperated /////////////////
class SignUpController extends GetxController with StateMixin<SignupResponse>{



  ///////////Form Key //////////////////////
  ///
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  
  //////////////////// Repository  /////////////////////////
  final RepoClass _appRepository = RepoClass(RemoteClass(DioClient()));

//////////////////////Text Editing Controllers///////////////////////
  late TextEditingController firstController, lastController,emailController,
      locationController,passwordController,cPasswordController;
 
 ////////////////////////local variables////////////////////////////
  String? _firstname = '';
  String? _lastname = '';
  String? _email = '';
  String? _password = '';
  String? _cpassword = '';


///////////////////////////Methods/Functions//////////////////////
  @override
  void onInit() {
    firstController = TextEditingController();
    lastController = TextEditingController();
    emailController = TextEditingController();
    locationController = TextEditingController();
    passwordController = TextEditingController();
    cPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    firstController = TextEditingController();
    lastController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    cPasswordController = TextEditingController();
    super.onClose();
  }


//////////////////Setters////////////////////////
  void setFirstName(String? firstname) {
    _firstname = firstname;
    update();
  }

  void setLastName(String? lastname) {
    _lastname = lastname;
    update();
  }

  void setEmail(String? email) {
    _email = email;
    update();

  }


  void setPassword(String? password) {
    _password = password;
    update();
  }
  void setCPassword(String? cpassword) {
    _cpassword = cpassword;
    update();
  }
  bool isLoading=false;

  void setLoading(bool value)
  {
    isLoading=value;
  }


  ///////////////////////  Api Result ///////////////////
  ApiResponse result = ApiResponse.empty();



  Future<ApiResponse<SignupResponse>> signUps() async {

    final firstName = _firstname;

    final lastName = _lastname;

    final email = _email;

    final password = _password;

    final cPassword = _cpassword;


    return _appRepository.signUp(RequestSignupModel(
        firstName: firstName.toString(),lastName: lastName.toString() ,email: email.toString(),
        password :password.toString(), cpassword: cPassword.toString(),
    )).then((value) => value.isSuccess() ?Future.value((value)):Future.value((value)));
  }
}


