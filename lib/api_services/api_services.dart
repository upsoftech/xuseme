import 'dart:convert';
import 'dart:developer';

import '../constant/api_constant.dart';
import 'network_service.dart';

class ApiServices{
  final networkCalls = NetworkCalls();

  /// Login With Mobile Number ///

  Future<dynamic> logInMobile(String mobile,type ) async {
    
    log("message"+mobile+type);
    var data =
    await networkCalls.post(ApiConstant.loginMobile, {"mobile": mobile,"type":type});

    return jsonDecode(data);
  }
}