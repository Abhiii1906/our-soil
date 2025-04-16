import 'package:flutter/foundation.dart';

class BaseNetwork {
  static BaseNetwork _baseNetwork = BaseNetwork._internal();


  BaseNetwork._internal();
  factory BaseNetwork() {
    return _baseNetwork;
  }

  //https://e-shop-backend-production-6461.up.railway.app/api/collections/Categories/records



  static const String _BASE_URL_Release = "https://e-shop-backend-production-6461.up.railway.app/";
  static const String _BASE_URL_Debug = "https://e-shop-backend-production-6461.up.railway.app/";
  static const String BASE_URL_IMAGE ="https://e-shop-backend-production-6461.up.railway.app/";

  //
  static const String _BASE_URL = kDebugMode ? _BASE_URL_Debug : _BASE_URL_Release;

  static const String FailedMessage = 'Connection Failed, Please try Again';
  static const String NetworkError= 'Oh no! Something went wrong';

  //http://10.202.100.187:9004/swagger/
  static const categoriesListURL= "${_BASE_URL}api/collections/Categories/records";


  static Map<String, String> getJsonHeaders() {
    return {
      'content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Map<String, String> getHeaderForLogin() {
    return {"Content-Type": "application/x-www-form-urlencoded", "accept": "application/json"};
  }

  static Map<String, String> getJsonHeaderForLogin() {
    return {"Content-Type": "application/json", "accept": "application/json"};
  }

}