import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../common/model/response.model.dart';
import '../utils/logger.dart';
import 'base_network.dart';
import 'base_network_status.dart';

class ApiConnection {
  Future<ApiResult> apiConnection<T>({
      required String url,
      required Map<String, String> header,
      required String method,
      required Function parseResponse,
        dynamic body,
      }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: header,
      );
      final statusCode = response.statusCode;
      debugLog(response.body, name: 'BoSS');
      debugLog(statusCode.toString(), name: 'Status Code');

      if (statusCode == ApiStatusCode.SUCCESS) {
        return ApiResult<T>(
          status: ApiStatus.success,
          response: parseResponse(response.body),
        );
      } else if (statusCode == ApiStatusCode.UNAUTHORIZED) {
        return ApiResult<ResponseModel>(
          status: ApiStatus.unAuthorized,
          response: responseModelFromJson(response.body)!,
        );
      } else {
        return ApiResult<ResponseModel>(
          status: ApiStatus.badRequest,
          response: responseModelFromJson(response.body)!,
        );
      }
    } on SocketException {
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: BaseNetwork.FailedMessage),
      );
    } catch (e, stackTrace) {
      debugLog(e.toString(), stackTrace: stackTrace);
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: 'Something went wrong! $e', status:500),
      );
    }
  }

  Future<ApiResult> apiConnectionPatch<T>(
      String url,
      Map<String, String> header,
      Function parseResponse, {
        dynamic body,
      }) async {
    try {
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode(body),
        headers: header,
      );
      final statusCode = response.statusCode;
      debugLog(response.body, name: 'BoSS');
      debugLog(statusCode.toString(), name: 'Status Code');

      if (statusCode == ApiStatusCode.SUCCESS) {
        return ApiResult<T>(
          status: ApiStatus.success,
          response: parseResponse(response.body),
        );
      } else if (statusCode == ApiStatusCode.UNAUTHORIZED) {
        return ApiResult<ResponseModel>(
          status: ApiStatus.unAuthorized,
          response: responseModelFromJson(response.body)!,
        );
      } else {
        return ApiResult<ResponseModel>(
          status: ApiStatus.badRequest,
          response: responseModelFromJson(response.body)!,
        );
      }
    } on SocketException {
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: BaseNetwork.FailedMessage),
      );
    } catch (e, stackTrace) {
      debugLog(e.toString(), stackTrace: stackTrace);
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: 'Something went wrong! $e', status: 500),
      );
    }
  }

  Future<ApiResult> deleteApiConnection<T>(
      String url,
      Map<String, String> header,
      Function parseResponse,
      ) async {
    debugLog(url, name: 'URL');
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: BaseNetwork.getJsonHeaders(),
      );
      final statusCode = response.statusCode;
      debugLog(response.body, name: 'BoSS');
      debugLog(statusCode.toString(), name: 'Status Code');

      if (statusCode == ApiStatusCode.SUCCESS) {
        return ApiResult<T>(
          status: ApiStatus.success,
          response: parseResponse(response.body),
        );
      } else if (statusCode == ApiStatusCode.UNAUTHORIZED) {
        return ApiResult<ResponseModel>(
          status: ApiStatus.unAuthorized,
          response: responseModelFromJson(response.body)!,
        );
      } else {
        return ApiResult<ResponseModel>(
          status: ApiStatus.badRequest,
          response: responseModelFromJson(response.body)!,
        );
      }
    } on SocketException {
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: BaseNetwork.FailedMessage),
      );
    } catch (e, stackTrace) {
      debugLog(e.toString(), stackTrace: stackTrace);
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: 'Something went wrong! $e', status:500),
      );
    }
  }

  Future<ApiResult> getApiConnection<T>({
    required String url,
    required  Map<String, String> header,
    required Function parseResponse,
  }
      ) async {
    debugLog(url, name: 'URL');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: BaseNetwork.getJsonHeaders(),
      );
      final statusCode = response.statusCode;
      debugLog(response.body, name: 'BoSS');
      debugLog(statusCode.toString(), name: 'Status Code');

      if (statusCode == ApiStatusCode.SUCCESS) {
        return ApiResult<T>(
          status: ApiStatus.success,
          response: parseResponse(response.body),
        );
      } else if (statusCode == ApiStatusCode.UNAUTHORIZED) {
        return ApiResult<ResponseModel>(
          status: ApiStatus.unAuthorized,
          response: responseModelFromJson(response.body)!,
        );
      } else {
        return ApiResult<ResponseModel>(
          status: ApiStatus.badRequest,
          response: responseModelFromJson(response.body)!,
        );
      }
    } on SocketException {
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: BaseNetwork.FailedMessage),
      );
    } catch (e, stackTrace) {
      debugLog(e.toString(), stackTrace: stackTrace);
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: 'Something went wrong! $e', status: 500),
      );
    }
  }

  Future<ApiResult> apiConnectionMultipart<T>(
      String url,
      Map<String, String> header,
      String method,
      Function parseResponse, {
        Map<String, dynamic> fields = const {},
        List<File> files = const [],
      }) async {
    try {
      final request = http.MultipartRequest(method, Uri.parse(url));
      request.headers.addAll(header);
      fields.forEach((key, value) => request.fields[key] = value.toString());

      for (final file in files) {
        final multipartFile = await http.MultipartFile.fromPath('image', file.path);
        request.files.add(multipartFile);
      }

      final response = await http.Response.fromStream(await request.send());
      final statusCode = response.statusCode;
      debugLog(request.fields.toString(), name: '$url');
      debugLog(request.files.toString(), name: '$url');
      debugLog(response.body, name: '$url');

      if (statusCode == ApiStatusCode.SUCCESS) {
        return ApiResult<T>(
          status: ApiStatus.success,
          response: parseResponse(response.body),
        );
      } else if (statusCode == ApiStatusCode.UNAUTHORIZED) {
        return ApiResult<ResponseModel>(
          status: ApiStatus.unAuthorized,
          response: responseModelFromJson(response.body)!,
        );
      } else {
        return ApiResult<ResponseModel>(
          status: ApiStatus.badRequest,
          response: responseModelFromJson(response.body)!,
        );
      }
    } on SocketException {
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: BaseNetwork.FailedMessage),
      );
    } catch (e, stackTrace) {
      debugLog(e.toString(), stackTrace: stackTrace);
      return ApiResult<ResponseModel>(
        status: ApiStatus.failed,
        response: ResponseModel(message: 'Something went wrong! \n$e', status: 500),
      );
    }
  }
}