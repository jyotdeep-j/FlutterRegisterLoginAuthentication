
/////////////////local  Model for requesting data from Api////////////////

class RequestSignupModel{
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String password;
  late final String cpassword;

  RequestSignupModel(
      {
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.password,
        required this.cpassword,
      });
}




