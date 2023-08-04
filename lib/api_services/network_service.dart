
import 'dart:developer';

import 'package:http/http.dart' as http;

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
    var response = await http.get(Uri.parse(url));
    checkAndThrowError(response);
    return response.body;
  }
/// delete api call ///
  Future<dynamic> delete(String url, Map<String, String> map) async {
    log("message: ${Uri.parse(url)}");
    var response = await http.delete(Uri.parse(url),body: map);
    checkAndThrowError(response);
    return response.body;
  }



  /// throwing  error ///

  static void checkAndThrowError(http.Response response) {
    if (response.statusCode != 200) throw Exception(response.body);


  }
}
