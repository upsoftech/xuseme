import 'dart:convert';
import 'dart:developer';
import 'package:xuseme/services/preference_services.dart';
import 'package:http/http.dart' as http;
import 'package:xuseme/model/banner_model.dart';
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

    var data = await networkCalls
        .post(ApiConstant.loginMobile, {"mobile": mobile, "type": type});

    log("LOGIN_SCREEN : $data");
    return jsonDecode(data);
  }

  /// very the otp from the server ///

  Future<dynamic> verifyOtp(String mobile, type, otp) async {

    var data = await networkCalls.post(
        ApiConstant.verifyOtp, {"mobile": mobile, "type": type, "otp": otp});

    log("LOGIN_SCREEN _Verify_Otp : $mobile");
    return jsonDecode(data);
  }



  /// Vendor Registration ///

  Future<dynamic> registerProfile(String? path,name,mobile,
      landline,email,shopName,shopType,address,landmark,
      pincode,latitude,longitude,state,services) async {
    try {
      var tokenIds = PrefService().getToken();


      final Uri apiUrl = Uri.parse("${ApiConstant.baseUrl}/api/user/partner/v1");
      final Map<String, String> headers = {'Authorization': 'Bearer $tokenIds'};

      var request = http.MultipartRequest('POST', apiUrl)
        ..headers.addAll(headers)
        ..fields['name'] = name
        ..fields['mobile'] = mobile
        ..fields['landline'] = landline
        ..fields['email'] = email
        ..fields['type'] = 'partner'
        ..fields['shopName'] = shopName
        ..fields['shopType'] = shopType
        ..fields['address'] = address
        ..fields['landmark'] = landmark
        ..fields['pincode'] =pincode
        ..fields['state'] = state
        ..fields['latitude'] = latitude.toString()
        ..fields['longitude'] = longitude.toString()
        ..fields['services'] = services;

      if(path!=null){
        request.files.add(await http.MultipartFile.fromPath('shopLogo', path));
      }


      var response = await request.send();
      var data = await  http.Response.fromStream(response);

      return jsonDecode(data.body);


    } catch (e) {

      return e;
    }
  }
  Future<dynamic> updatePartner(String? path,name,mobile,
      landline,email,shopName,shopType,address,landmark,
      pincode,latitude,longitude,state,services) async {
    try {
      var tokenIds = PrefService().getToken();
      var id = PrefService().getRegId();


      final Uri apiUrl = Uri.parse("${ApiConstant.baseUrl}/api/user/partner/v1/$id");
      final Map<String, String> headers = {'Authorization': 'Bearer $tokenIds'};

      var request = http.MultipartRequest('PATCH', apiUrl)
        ..headers.addAll(headers)
        ..fields['name'] = name
        ..fields['landline'] = landline
        ..fields['email'] = email
        ..fields['shopName'] = shopName
        ..fields['shopType'] = shopType
        ..fields['address'] = address
        ..fields['landmark'] = landmark
        ..fields['pincode'] =pincode
        ..fields['state'] = state
        ..fields['latitude'] = latitude.toString()
        ..fields['longitude'] = longitude.toString()
        ..fields['services'] = services;

      if(path!=null){
        request.files.add(await http.MultipartFile.fromPath('shopLogo', path));
      }


      var response = await request.send();
      var data = await  http.Response.fromStream(response);

      return jsonDecode(data.body);


    } catch (e) {

      return e;
    }
  }


  /// Get  Banner from the server ///

  Future<dynamic> getBanner() async {
    var data = await networkCalls.get("${ApiConstant.banner}?isApproved=true");

    return jsonDecode(data);
  }
 /// Get Single Banner form the server ///

  Future<dynamic> getSingleBanner() async {
    var data = await networkCalls.get("${ApiConstant.singleBanner}?isApproved=true");

    return jsonDecode(data);
  }


  ///update profile from the server ///

  Future<dynamic> updateUserProfile(name,email, path,latitude,longitude) async {
    var tokenIds = PrefService().getToken();

    var regId = PrefService().getRegId();

    var response;
    var uri = Uri.parse("${ApiConstant.updateProfile}$regId");
    log("message11 : $uri");
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
      request.fields['email'] = email;
      request.fields['latitude'] = latitude.toString();
      request.fields['longitude'] = longitude.toString();


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


    var data = await  http.Response.fromStream(response);

    return jsonDecode(data.body);

  }

  /// get profile from the server ///
  Future<dynamic> getProfile() async {
    var p = PrefService().getRegId();
    var data = await networkCalls.get("${ApiConstant.getProfile}$p");
    return jsonDecode(data);
  }

  /// Add Address from the server //
  Future<dynamic> addAddress(Map<String, dynamic> mapData) async {
    var response = 
      await  http.post(Uri.parse(ApiConstant.addUserAddress), body: mapData);
    
   

    return jsonDecode(response.body);
  }
/// Add Address from the server //
  Future<dynamic> addHelpSupport(Map<String, dynamic> mapData) async {

    var tokenIds = PrefService().getToken();


    var response =
      await  http.post(Uri.parse(ApiConstant.helpEndPoint), body: mapData,
          headers: {
            'Authorization': 'Bearer $tokenIds',
          }
      );



    return jsonDecode(response.body);
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

    var response = await http.patch(Uri.parse(ApiConstant.updateUsersAddress + id),
        body: mapData,
        headers: {
          'Authorization': 'Bearer $tokenIds',
        });
    
    return jsonDecode(response.body);
  }

  /// delete user Address from the server ///

  Future<dynamic> deleteAddress(String addressId) async {
    var data =
        await networkCalls.delete(ApiConstant.deleteUsersAddress + addressId);

    return jsonDecode(data);
  }

  /// Get inquiry From the Server ///

  Future<List<InquiryModel>> userInquiry(String type) async {
    var p = PrefService().getRegId();
    List<InquiryModel> myList = [];
    var data = await networkCalls.get("${ApiConstant.inquiryEndpoint}$p?search=$type");
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

  Future<List<ShopSubCategoryModel>> getShopData(Map<String,dynamic> filter) async {
    List<ShopSubCategoryModel> myList = [];

    const baseUrl = ApiConstant.subShopEndpoint;
    final queryParams = filter;

    var tokenIds = PrefService().getToken();
    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $tokenIds',
    });


    for (var i in jsonDecode(response.body)) {
      myList.add(ShopSubCategoryModel.fromJson(i));
    }
    // log("Partners ${jsonDecode(response.body)}");
    // if(jsonDecode(response.body)["error"].toString().contains("An error")){
    //   log("Partners ${jsonDecode(response.body)["error"]}");
    // }else{
    //
    //
    // }
    return myList;
  }


  /// Add New Banner on the Server ///

  Future<dynamic> addBannerBySelf(partnerId, validity, bannerImage,price) async {
    var tokenIds = PrefService().getToken();


    var uri = Uri.parse(ApiConstant.selfBannerEndpoint);
    log("message$uri");

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
      request.fields["price"] = price;

    var response = await request.send();
    var data = await  http.Response.fromStream(response);

    return jsonDecode(data.body);


  }


  Future<dynamic> addBannerByCompany(partnerId, validity, price) async {
    var tokenIds = PrefService().getToken();


    var uri = Uri.parse(ApiConstant.companyBannerEndpoint);
    log("message$uri");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $tokenIds';

      request.fields["partnerId"] = partnerId;
      request.fields["validity"] = validity;
      request.fields["price"] = price;

    var response = await request.send();
    var data = await  http.Response.fromStream(response);

    return jsonDecode(data.body);

  }

  /// PUBLISH OFFER
  Future<dynamic> publishOffer(partnerId,  offerImage,offer) async {
    var tokenIds = PrefService().getToken();


    var uri = Uri.parse(ApiConstant.offerEndpoint);
    log("message$uri");

    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $tokenIds';
    //bannerImage
    if (offerImage != null) {
      http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('offerImage', offerImage);

      request.files.add(multipartFile);
    }

    request.fields["partnerId"] = partnerId;
    request.fields["offer"] = offer;


    log("message11111${request.fields}");
    var response = await request.send();
    var data = await  http.Response.fromStream(response);

    return jsonDecode(data.body);


  }

  ///  get category data from the server ///

  Future<List<CategoryModel>> getCategory(String query,bool? isPremium) async {
    List<CategoryModel> myList = [];
    var data = await networkCalls.get("${ApiConstant.grtCategoryEndpoint}?search=$query&isPremium=${isPremium??""}");
    for (var i in jsonDecode(data)) {
      myList.add(CategoryModel.fromJson(i));
    }
    return myList;
  }
  ///  get category data from the server ///

  Future<List<BannerModel>> getBannerHistory() async {
    List<BannerModel> myList = [];
    var data = await networkCalls.get(ApiConstant.bannerEndPoint);
    for (var i in jsonDecode(data)) {
      myList.add(BannerModel.fromJson(i));
    }
    return myList;
  }



  /// get profile from the server ///
  Future<dynamic> getVendorProfile() async {
    var p = PrefService().getRegId();
    var data = await networkCalls.get("${ApiConstant.vendorGetProfile}$p");
    return jsonDecode(data);
  }


  /// GET Publish Offer Ad History
  Future<dynamic> getOfferAdHistory(String id ) async {

    var data = await networkCalls.get("${ApiConstant.offerEndpoint}/$id");
    return jsonDecode(data);
  }

  /// delete user Address from the server ///

  Future<dynamic> deleteOffer(String offerId) async {
    var data =
    await networkCalls.delete("${ApiConstant.offerEndpoint}/$offerId");

    return jsonDecode(data);
  }
  /// delete user Address from the server ///

  Future<dynamic> deletePremiumAd(String offerId) async {
    var data =
    await networkCalls.delete("${ApiConstant.bannerEndPoint}/$offerId");

    return jsonDecode(data);
  }



}
