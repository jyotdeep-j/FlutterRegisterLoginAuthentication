/// success : true
/// data : {"id":4,"name":"abid@123","first_name":null,"last_name":"abid@123","phone_no":null,"social_type":null,"social_id":null,"email":"abid@123.com","status":1,"token":"18|l8OIgRsiyQJA44eL9MwPOz7iFKFyiIgQuuddZBo"}
/// message : "User login successfully."

class LoginResponse {
  LoginResponse({
    bool? success,
    Data? data,
    String? message,}){
    _success = success;
    _data = data;
    _message = message;
  }

  LoginResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (_success != null && _success!) {
      _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }
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



class Data {
  Data({
    num? id,
    String? name,
    dynamic firstName,
    String? lastName,
    dynamic phoneNo,
    dynamic socialType,
    dynamic socialId,
    String? email,
    num? status,
    String? token,}){
    _id = id;
    _name = name;
    _firstName = firstName;
    _lastName = lastName;
    _phoneNo = phoneNo;
    _socialType = socialType;
    _socialId = socialId;
    _email = email;
    _status = status;
    _token = token;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _phoneNo = json['phone_no'];
    _socialType = json['social_type'];
    _socialId = json['social_id'];
    _email = json['email'];
    _status = json['status'];
    _token = json['token'];
  }
  num? _id;
  String? _name;
  dynamic _firstName;
  String? _lastName;
  dynamic _phoneNo;
  dynamic _socialType;
  dynamic _socialId;
  String? _email;
  num? _status;
  String? _token;

  num? get id => _id;
  String? get name => _name;
  dynamic get firstName => _firstName;
  String? get lastName => _lastName;
  dynamic get phoneNo => _phoneNo;
  dynamic get socialType => _socialType;
  dynamic get socialId => _socialId;
  String? get email => _email;
  num? get status => _status;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['phone_no'] = _phoneNo;
    map['social_type'] = _socialType;
    map['social_id'] = _socialId;
    map['email'] = _email;
    map['status'] = _status;
    map['token'] = _token;
    return map;
  }

}