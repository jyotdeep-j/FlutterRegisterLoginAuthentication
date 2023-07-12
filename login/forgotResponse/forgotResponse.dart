/// msg : "Reset password link sent on your email id."
/// success : true
/// data : []
/////////////////////////Forgot Response//////////////
class ForgotResponse {
  ForgotResponse({
    String? msg,
    bool? success,
  }){
    _msg = msg;
    _success = success;
}

  ForgotResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _success = json['success'];

  }
  String? _msg;
  bool? _success;

  String? get msg => _msg;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['success'] = _success;

    return map;
  }

}