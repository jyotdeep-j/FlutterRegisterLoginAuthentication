////// Request data from Api////////////////

class RequestLoginModel{
  late final String? email;
  late final String? company;
  late final String? weburl;
  late final String? password;

  RequestLoginModel(
      {
         this.email,
         this.password,
        this.company,
        this.weburl
      });
}