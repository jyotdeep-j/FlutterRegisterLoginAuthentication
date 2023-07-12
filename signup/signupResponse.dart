import 'dart:convert';
/// success : true

/// message : "User register successfully."

SignupResponse signupResponseFromJson(String str) => SignupResponse.fromJson(json.decode(str));
String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());
class SignupResponse {
  SignupResponse({
      bool? success,
      Data? data,
      String? message,}){
    _success = success;
    _data = data;
    _message = message;
}

  SignupResponse.fromJson(dynamic json) {
    _success = json['success'];

    if (_success != null && _success!) {
      _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }
    //_data: json['data']==null?json['data']:Data.fromJson(json['data']);

    _message = json['message'];
  }
  bool? _success;
  Data? _data;
  String? _message;

  bool? get success => _success;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// token : "7|sBQ222vnXXyujVN2jzExvkfgdsdfasfgsdgsdfgfg//sdfsaf"
/// name : "iapp"

// Data dataFromJson(String str) => Data.fromJson(json.decode(str));
// String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      dynamic token,
      String? name,}){
    _token = token;
    _name = name;
}

  Data.fromJson(dynamic json) {
    _token = json['token'];
    _name = json['name'];
  }
  dynamic _token;
  String? _name;

  dynamic get token => _token;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['name'] = _name;
    return map;
  }

}