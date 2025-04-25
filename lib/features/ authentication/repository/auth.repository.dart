import 'dart:io';

import 'package:e_shop/core/storage/preference_key.dart';
import '../../../common/model/response.model.dart';
import '../../../core/network/api_connection.dart';
import '../../../core/network/base_network.dart';
import '../../../core/network/base_network_status.dart';
import '../../../core/storage/secure_storage.dart';
import '../model/login.response.model.dart';
import '../model/register.response.model.dart';


class AuthRepository {
  final ApiConnection? api;
  AuthRepository({this.api});

  Future<ApiResult> login({String? email, String? password}) async {
    final Map<String, dynamic> body = {
      "identity": email,
      "password": password,
    };
    final result = await api!.apiConnection(
      url:  BaseNetwork.loginURL,
      header: BaseNetwork.getJsonHeaders(),
      method: 'POST',
       parseResponse:  (responseBody) => loginResponseModelFromJson(responseBody),
      body: body,
    );
    if (result.status == ApiStatus.success) {
      LoginResponseModel obj = result.response;
      final pref = Preference();
      pref.setString(Keys.EMAIL, obj.record.email);
      pref.setString(Keys.NAME, obj.record.name);
      pref.setString(Keys.PASSWORD, password!);
      pref.setString(Keys.ROLE, obj.record.role);
      pref.setString(Keys.TOKEN, obj.token);
      pref.setString(Keys.COLLECTION_ID, obj.record.collectionId);
      pref.setString(Keys.USER_ID, obj.record.id);
      pref.setString(Keys.EMAIL, obj.record.email);
      String avatar =  BaseNetwork.getPocketBaseImageUrl(collectionId: obj.record.collectionId,recordId:  obj.record.id,fileName:obj.record.avatar);
      pref.setString(Keys.AVATAR, avatar);
    }
    return result;
  }

  Future<ApiResult> registerUser({
    required String name,
    required String email,
    required String password,
    required String rePassword,
    File? photo,
  }) async {
    if (photo != null) {
      return await api!.apiConnectionMultipart<ResponseModel>(
        BaseNetwork.registerURL,
        BaseNetwork.getMultipartHeaders(),
        'POST',
        (responseBody) => registerResponseModelFromJson(responseBody),
        fields: {
          'name': name,
          'email': email,
          'password': password,
          'passwordConfirm':rePassword
        },
        files: [photo],
      );
    } else {
      return await api!.apiConnection<ResponseModel>(
        url: BaseNetwork.registerURL,
        header: BaseNetwork.getJsonHeaders(),
        method: 'POST',
        body: {
          'name': name,
          'email': email,
          'password': password,
          'passwordConfirm':rePassword,
          'role':'customer'
        },
        parseResponse:  (responseBody) => registerResponseModelFromJson(responseBody),
      );
    }
  }

}