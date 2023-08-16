import 'dart:convert';
import 'dart:developer';
import 'package:xuseme/api_services/preference_services.dart';
import 'package:http/http.dart' as http;
import 'package:xuseme/model/inquiry_model.dart';
import '../constant/api_constant.dart';
import '../model/address_model.dart';
import '../model/category_model.dart';
import '../model/sub_category_model.dart';
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
    log("FlutterTesting${jsonEncode(mapData)}");
    log("test1${Uri.parse(ApiConstant.vendorRegistration)}");
    log(tokenIds);
    var response = await http.post(Uri.parse(ApiConstant.vendorRegistration),
        headers: {
          'Authorization': 'Bearer $tokenIds',
        },
        body: mapData);
    log("FlutterTesting$mapData");
    log("FlutterTesting${response.body}");
    return response.body;
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

      log("message${request.fields}");
      log("message${request.files}");
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
  Future<dynamic> updateAddress(String id, Map<String, dynamic> mapData) async {
    var tokenIds = PrefService().getToken();

    var response = http.patch(Uri.parse(ApiConstant.updateUsersAddress + id),
        body: mapData,
        headers: {
          'Authorization': 'Bearer $tokenIds',
        });
    var body;
    response.then((value) {
      log("message${value.body}");
      body = value.body;
    });

    return body;
  }

  /// delete user Address from the server ///

  Future<dynamic> deleteAddress(String addressId) async {
    var data =
        await networkCalls.delete(ApiConstant.deleteUsersAddress + addressId);

    return jsonDecode(data);
  }

  /// Get inquiry From the Server ///

  Future<List<InquiryModel>> userInquiryAddress() async {
    var p = PrefService().getRegId();
    List<InquiryModel> myList = [];
    var data = await networkCalls.get("${ApiConstant.inquiryEndpoint}$p");
    for (var i in jsonDecode(data)) {
      myList.add(InquiryModel.fromJson(i));
    }
    return myList;
  }


  /// Call Inquiry from the server //
  Future<dynamic> callInquiry(Map<String, dynamic> mapData) async {
    var tokenIds = PrefService().getToken();
    var response = await http.post(Uri.parse(ApiConstant.callInquiryEndpoint),
        body: mapData,
        headers: {
          'Authorization': 'Bearer $tokenIds',
        });
    log("message${jsonDecode(response.body)["message"]}");

    return jsonDecode(response.body)["message"];
  }



  /// subShop data get from the server ///

  Future<List<ShopSubCategoryModel>> subShopData() async {
    List<ShopSubCategoryModel> myList = [];
    var data = await networkCalls.get(ApiConstant.subShopEndpoint);
    for (var i in jsonDecode(data)) {
      myList.add(ShopSubCategoryModel.fromJson(i));
    }
    return myList;
  }


  /// Add New Banner on the Server ///

  Future<dynamic> addBanner(partnerId, validity, bannerImage) async {
    var tokenIds = PrefService().getToken();

    var response;
    var uri = Uri.parse(ApiConstant.addBannerEndpoint);
    log("message$uri");
    try {
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $tokenIds';
      //bannerImage
      if (bannerImage != null) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('bannerImage', bannerImage);

        request.files.add(multipartFile);
      }

      request.fields["partnerId"] = partnerId;
      request.fields["validity"] = validity;

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


  ///  get category data from the server ///

  Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> myList = [];
    var data = await networkCalls.get(ApiConstant.grtCategoryEndpoint);
    for (var i in jsonDecode(data)) {
      myList.add(CategoryModel.fromJson(i));
    }
    return myList;
  }



  /// get profile from the server ///
  Future<dynamic> getVendorProfile() async {
    var p = PrefService().getRegId();
    var data = await networkCalls.get("${ApiConstant.vendorGetProfile}$p");
    return jsonDecode(data);
  }
}
