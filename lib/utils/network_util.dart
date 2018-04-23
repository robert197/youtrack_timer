import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtil {

  // Singleton
  // static NetworkUtil _instance = new NetworkUtil();
  // NetworkUtil.internal();
  // factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(url)
    .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception();
      }

      return _decoder.convert(response.body);
    }).catchError((error){
      return error;
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http.post(url, headers: headers, body: body, encoding: encoding)
    .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception('Network error');
      }

      return _decoder.convert(response.body);
    }); 
  }

}