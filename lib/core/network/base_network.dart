import 'package:flutter/foundation.dart';

class BaseNetwork {
  static BaseNetwork _baseNetwork = BaseNetwork._internal();


  BaseNetwork._internal();
  factory BaseNetwork() {
    return _baseNetwork;
  }

  //https://e-shop-backend-production-6461.up.railway.app/api/collections/Categories/records

//admin.oursoil.co.in

  static const String _BASE_URL_Release = "https://admin.oursoil.co.in/";
  static const String _BASE_URL_Debug = "https://admin.oursoil.co.in/";
  static const String BASE_URL_IMAGE ="https://admin.oursoil.co.in/";

  //
  static const String _BASE_URL = kDebugMode ? _BASE_URL_Debug : _BASE_URL_Release;

  static const String FailedMessage = 'Connection Failed, Please try Again';
  static const String NetworkError= 'Oh no! Something went wrong';

  //http://10.202.100.187:9004/swagger/
  // static const categoriesListURL= "${_BASE_URL}api/collections/Categories/records";
  static const loginURL = "${_BASE_URL}api/collections/users/auth-with-password";
  static const registerURL = "${_BASE_URL}api/collections/users/records";
  static const categoriesListURL= "${_BASE_URL}api/collections/Categories/records";
  static const productList = "${_BASE_URL}api/collections/Products/records";

  static Map<String, String> getJsonHeaders() {
    return {
      'content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // New Multipart headers
  static Map<String, String> getMultipartHeaders() {
    return {
      'Content-Type': 'multipart/form-data',  // Required for multipart requests
      'Accept': 'application/json',           // You can adjust this depending on your API
    };
  }

  static String getPocketBaseImageUrl({
    required String collectionId,
    required String recordId,
    required String fileName,
  }) {
    return "${_BASE_URL}api/files/$collectionId/$recordId/$fileName";
  }

  static Map<String, String> getHeaderForLogin() {
    return {"Content-Type": "application/x-www-form-urlencoded", "accept": "application/json"};
  }

  static Map<String, String> getJsonHeaderForLogin() {
    return {"Content-Type": "application/json", "accept": "application/json"};
  }

  static String generateUrl({
    required String baseUrl,
     String? id,
    String? sort,
    String? search,
    String? filter,
  }) {
    final queryParameters = <String, String>{};
    if (id != null && id.isNotEmpty) queryParameters['id'] = id;
    if (sort != null && sort.isNotEmpty) queryParameters['sort'] = sort;
    if (search != null && search.isNotEmpty) queryParameters['q'] = search;
    if (filter != null && filter.isNotEmpty) queryParameters['filter'] = filter;

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
    return uri.toString();
  }

}