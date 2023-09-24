import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:xuseme/services/preference_services.dart';

class NetworkCalls {
  /// post api call ///
  Future<dynamic> post(String url, Object map) async {
    log("message: ${Uri.parse(url)}");
    log("message: $map");
    var response = await http.post(Uri.parse(url), body: map);
    checkAndThrowError(response);
    return response.body;
  }

  /// get api call ///

  Future<dynamic> get(String url) async {
    log("message: ${Uri.parse(url)}");
    var tokenIds = PrefService().getToken();
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $tokenIds',
    });
    checkAndThrowError(response);

    return response.body;
  }

  /// delete api call ///
  Future<dynamic> delete(String url,) async {
    log("message: ${Uri.parse(url)}");
    var tokenIds = PrefService().getToken();
    var response = await http.delete(Uri.parse(url),
        headers: {
      'Authorization': 'Bearer $tokenIds',
    });

    checkAndThrowError(response);
    return response.body;
  }

  /// patch Api call///

  Future<dynamic> patch(String url, Object map) async {
    var tokenIds = PrefService().getToken();
    var response = await http.patch(Uri.parse(url), body: map,
        headers: {
          'Authorization': 'Bearer $tokenIds',
        });



    checkAndThrowError(response);
    return response.body;

  }

  /// throwing  error ///

  static void checkAndThrowError(http.Response response) {
    if (response.statusCode != 200) throw Exception(response.body);
  }
}
