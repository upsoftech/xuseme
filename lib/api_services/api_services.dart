import 'dart:convert';
import 'dart:developer';
import 'package:xuseme/api_services/preference_services.dart';
import 'package:http/http.dart' as http;
import '../constant/api_constant.dart';
import '../model/address_model.dart';
import 'network_service.dart';

class ApiServices {
  final networkCalls = NetworkCalls();

  /// Login With Mobile Number ///

  Future<dynamic> logInMobile(String mobile, type) async {
    log("message$mobile" + type);
    var data = await networkCalls
        .post(ApiConstant.loginMobile, {"mobile": mobile, "type": type});
    return jsonDecode(data);
  }

  /// very the otp from the server ///

  Future<dynamic> verifyOtp(String mobile, type, otp) async {
    log("message$mobile" + type);
    var data = await networkCalls.post(
        ApiConstant.verifyOtp, {"mobile": mobile, "type": type, "otp": otp});
    return jsonDecode(data);
  }

  /// Vendor Registration ///

  Future<dynamic> registerProfile(Map<String, dynamic> mapData) async {
    var tokenIds = PrefService().getToken();
    log(ApiConstant.vendorRegistration);
    log(tokenIds);
    var response = await http.post(Uri.parse(ApiConstant.vendorRegistration),
        headers: {
          'Authorization': 'Bearer $tokenIds',
        },
        body: mapData);
    var body;
    log("FlutterTesting${response.body}");
    body = response.body;

    return body;
  }

  /// Get  Banner from the server ///

  Future<dynamic> getBanner() async {
    var data = await networkCalls.get(ApiConstant.banner);

    return jsonDecode(data);
  }

  ///update profile from the server ///

  Future<dynamic> updateUserProfile(name, mobile, email, path) async {
    var tokenIds = PrefService().getToken();

    var regId = PrefService().getRegId();

    var response;
    var uri = Uri.parse("${ApiConstant.updateProfile}$regId");
    log("message$uri");
    try {
      var request = http.MultipartRequest(
          'PATCH', Uri.parse("${ApiConstant.updateProfile}$regId"));
      request.headers['Authorization'] = 'Bearer $tokenIds';

      if (path != null) {
        // http.MultipartFile multipartFile = await
        // http.MultipartFile.fromPath('profileLogo',
        //     path);

        //request.files.add(multipartFile);
      }

      // Add additional string parameter
      request.fields['name'] = name;
      request.fields['mobile'] = mobile;
      request.fields['email'] = email;

      log("message" + request.fields.toString());
      log("message" + request.files.toString());
      // Send the request and get the response
      response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during image upload: $e');
    }

    return response;
  }

  /// get profile from the server ///
  Future<dynamic> getProfile() async {
    var p = PrefService().getRegId();
    var data = await networkCalls.get("${ApiConstant.getProfile}$p");
    return jsonDecode(data);
  }

  /// Add Address from the server //
  Future<dynamic> updateUserAddress(Map<String, dynamic> mapData) async {
    var response =
        http.post(Uri.parse(ApiConstant.addUserAddress), body: mapData);
    var body;
    response.then((value) {
      log("message${value.body}");
      body = value.body;
    });

    return body;
  }

  /// Get Address From the Server ///

  Future<List<AddressModel>> userAddress() async {
    var p = PrefService().getRegId();
    List<AddressModel> myList = [];
    var data = await networkCalls.get("${ApiConstant.getUserAddress}$p");
    for (var i in jsonDecode(data)) {
      myList.add(AddressModel.fromJson(i));
    }
    return myList;
  }

  /// update user address from the server ///
  Future<dynamic> updateAddress(String id,Map<String, dynamic> mapData) async {
    var regIds = PrefService().getRegId();


    var response =
    http.patch(Uri.parse(ApiConstant.updateUsersAddress + id), body: mapData);
    var body;
    response.then((value) {
      log("message${value.body}");
      body = value.body;
    });

    return body;
  }
}
