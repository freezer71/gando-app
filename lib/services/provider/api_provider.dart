import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gando/constants.dart';
import 'package:gando/models/User.dart';
import 'package:gando/models/chat/chat_detail.dart';
import 'package:gando/models/chat/discussion.dart';
import 'package:gando/services/provider/remote_config.dart';
import 'package:gando/views/chat/components/chat_detail.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

import '../../config/constants.dart';

class ApiProvider {
  final box = GetStorage();
  Dio dio = Dio();
  late Response response;
  String connErr = 'check_internet_connection';
  static var client = http.Client();
  final apiToken = CancelToken();

  var token, finalUrl;

  // get token from storage and set headers
  Future<void> _getToken() async {
    if (box.hasData('token') && box.read('token') != null) {
      token = await box.read('token');
      printInfo(info: 'TOKEN============> : $token');
    }
  }

  // TODO : change token to bearer token
  _setHeaders() => {
        'Content-type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $token',
      };

  Future<http.Response> getData(apiUrl) async {
    await _getToken();
    final fullUrl = Uri.parse(API_URL + apiUrl);
    print('URL==$fullUrl');
    return await http.get(fullUrl, headers: _setHeaders());
  }

  Map<String, dynamic> _parseBody(String body) {
    final data = json.decode(body);
    debugPrint("$logTrace response $data");
    return data;
  }

  //get user by id
  Future<User> getUserById({required String idUser}) async {
    http.Response response =
        await getData(RemoteEndpoint.getUserById(id: idUser));
    if (response.statusCode == 200) {
      return User.fromJson(_parseBody(response.body));
    } else {
      throw _parseBody(response.body);
    }
  }

  //upload file
  Future<String> uploadSingleFile({required File file}) async {
    final url = Uri.parse(RemoteEndpoint.uploadSingleFile);
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('upload', file.path));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      List<dynamic> listPhoto = json.decode(respStr);
      return listPhoto.first;
    } else {
      throw "Télechargement du fichier échoué";
    }
  }

  Future<User> editProfilePicture({required Map<String, dynamic> data}) async {
    http.Response response =
        await putData1(apiUrl: RemoteEndpoint.editPictureUser, data: data);
    if (response.statusCode == 200) {
      return User.fromJson(_parseBody(response.body)["data"]);
    } else {
      throw "${_parseBody(response.body)["message"]}";
    }
  }

  Future<bool> delete({required Map<String, dynamic> data}) async {
    http.Response response =
        await deleteData(apiUrl: RemoteEndpoint.deleteUser, data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw "${_parseBody(response.body)["message"]}";
    }
  }

  Future<bool> editPassword({required Map<String, dynamic> data}) async {
    http.Response response =
        await putData1(apiUrl: RemoteEndpoint.editPasswordUser, data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw "${_parseBody(response.body)["message"]}";
    }
  }

  Future<bool> initEditMail({required Map<String, dynamic> data}) async {
    http.Response response =
        await putData1(apiUrl: RemoteEndpoint.initEditMailUser, data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw "${_parseBody(response.body)["message"]}";
    }
  }

  Future<bool> verifyMail({required Map<String, dynamic> data}) async {
    http.Response response =
        await putData1(apiUrl: RemoteEndpoint.verifyMailUser, data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw "${_parseBody(response.body)["message"]}";
    }
  }

  Future<User> editNameAndDescription(
      {required Map<String, dynamic> data}) async {
    http.Response response = await putData1(
        apiUrl: RemoteEndpoint.editNameAndDescriptionUser, data: data);
    if (response.statusCode == 200) {
      return User.fromJson(_parseBody(response.body)["data"]);
    } else {
      throw "${_parseBody(response.body)["message"]}";
    }
  }

  Future<User> editCoordonates({required Map<String, dynamic> data}) async {
    http.Response response =
        await putData1(apiUrl: RemoteEndpoint.editCoordonates, data: data);
    if (response.statusCode == 200) {
      final res = await getData('/user');
      final body = jsonDecode(res.body)['data'];
      if (res.statusCode == 200) {
        return User.fromJson(body);
      } else {
        return User();
      }
    } else {
      throw "${_parseBody(response.body)["message"]}";
    }
  }

  Future<List<Discussion>> getListMessage({required String idUser}) async {
    http.Response response =
        await getData(RemoteEndpoint.getListMessage(id: idUser))
            .timeout(Duration(seconds: 30));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = _parseBody(response.body);
      try {
        return List.from(map['data']).map((x) {
          return Discussion.fromJson(x);
        }).toList();
      } catch (e) {
        rethrow;
      }
    } else {
      throw _parseBody(response.body);
    }
  }

  Future<ChatDetailModel> getMessageDetail(
      {required String discussionId}) async {
    http.Response response = await getData(
        RemoteEndpoint.getMessageDetail(discussionId: discussionId));
    if (response.statusCode == 200) {
      try {
        return ChatDetailModel.fromJson(_parseBody(response.body)["data"][0]);
      } catch (e) {
        rethrow;
      }
    } else {
      throw _parseBody(response.body);
    }
  }

  Future<bool> sendMessage({required Map<String, dynamic> data}) async {
    http.Response response =
        await postData(apiUrl: RemoteEndpoint.sendMessage, data: data);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw "${_parseBody(response.body)["message"]}";
    }
  }

  Future<String> onBoardingAccount({required Map<String, dynamic> data}) async {
    http.Response response =
        await postData(apiUrl: RemoteEndpoint.onBoardingAccount, data: data);
    if (response.statusCode == 200) {
      print("code 200");
      var test = _parseBody(response.body);
      print("test");
      return "true";
    } else {
      throw "${_parseBody(response.body)["message"]}";
    }
  }

  Future<void> verifyOwner({required Map<String, dynamic> data}) async {
    http.Response response =
        await postData(apiUrl: RemoteEndpoint.verifyOwner, data: data);
    if (response.statusCode == 200) {
      // return User.fromJson(_parseBody(response.body)["data"]);
    } else {
      throw UnimplementedError();
    }
  }

  Future<http.Response> putData1(
      {required String apiUrl, required Map<String, dynamic> data}) async {
    await _getToken();
    Map<String, String> headers = {
      ..._setHeaders(),
      'Content-Type': 'application/json; charset=UTF-8',
    };
    return http.put(Uri.parse("$API_URL$apiUrl"),
        headers: headers, body: jsonEncode(data));
  }

  Future<http.Response> deleteData(
      {required String apiUrl, required Map<String, dynamic> data}) async {
    await _getToken();
    Map<String, String> headers = {
      ..._setHeaders(),
      'Content-Type': 'application/json; charset=UTF-8',
    };
    return http.delete(Uri.parse("$API_URL$apiUrl"),
        headers: headers, body: jsonEncode(data));
  }

  Future<http.Response> postData(
      {required String apiUrl, required Map<String, dynamic> data}) async {
    await _getToken();
    Map<String, String> headers = {
      ..._setHeaders(),
      'Content-Type': 'application/json; charset=UTF-8',
    };
    return await http.post(Uri.parse(API_URL + apiUrl),
        body: jsonEncode(data), headers: headers);
  }

  Future<Response> dioConnect(url, data) async {
    finalUrl = "$API_URL$url";
    print('url : $finalUrl');
    print('postData Hello : ${data.toString()}');

    try {
      await _getToken();
      dio.options.headers['accept'] = "application/json";
      dio.options.headers['authorization'] = "Bearer $token";
      dio.options.headers['content-type'] = 'application/x-www-form-urlencoded';
      dio.options.connectTimeout = 30000; // 30s
      dio.options.receiveTimeout = 25000; // 25s

      return await dio.post(finalUrl, data: data, cancelToken: apiToken);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw "Api non trouvé";
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw "Erreur serveur interne";
        } else {
          throw e.response!.data.toString();
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw e.message.toString();
      } else if (e.type == DioErrorType.cancel) {
        throw 'annuler';
      }
      throw Exception(connErr);
    } finally {
      dio.close();
    }
  }

  Future<Response> putData(url, formData) async {
    await _getToken();
    finalUrl = "$API_URL$url";
    print('url : $finalUrl');
    print('postData : ${formData.toString()}');

    try {
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["authorization"] = "Bearer $token";
      dio.options.headers['content-Type'] = 'multipart/form-data';
      dio.options.connectTimeout = 30000; //5s
      dio.options.receiveTimeout = 25000;

      return await dio.put(
        finalUrl,
        data: formData,
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw "Api not found";
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw "Internal Server Error ${e.toString()}";
        } else {
          throw e.response!.data.toString();
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw e.message.toString();
      } else if (e.type == DioErrorType.cancel) {
        throw 'cancel';
      }
      throw Exception(connErr);
    } finally {
      dio.close();
    }
  }

  // add annonce

  Future<Response> addNewAnnonce(url, formData, cancelToken) async {
    await _getToken();
    finalUrl = "$API_URL$url";
    print('url : $finalUrl');
    print('postData : ${formData.toString()}');

    try {
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["authorization"] = "Bearer $token";
      dio.options.headers['content-Type'] = 'multipart/form-data';
      dio.options.connectTimeout = 30000; //5s
      dio.options.receiveTimeout = 25000;

      return await dio.post(finalUrl, data: formData, cancelToken: cancelToken);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw "Api not found";
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw "Internal Server Error ${e.toString()}";
        } else {
          throw e.response!.data['message'].toString();
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw e.message.toString();
      } else if (e.type == DioErrorType.cancel) {
        throw 'cancel';
      }
      throw Exception(connErr);
    } finally {
      dio.close();
    }
  }

  Future<Response> dioGet(url, data) async {
    finalUrl = '$API_URL$url';
    print('url : $finalUrl');
    print('getData : ${data.toString()}');

    try {
      await _getToken();
      dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
      dio.options.headers['accept'] = 'application/json';
      dio.options.headers['authorization'] = 'Bearer $token';
      dio.options.headers['authenticate_client'] =
          '427620db3b5aeffd7da95bff1e02c58e91f2b7c8394cabc1db92aabe2a918ded';
      dio.options.connectTimeout = 30000; //5s
      dio.options.receiveTimeout = 25000;

      return await dio.get(finalUrl,
          queryParameters: data, cancelToken: apiToken);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw "Api non trouvé";
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw "Erreur serveur interne";
        } else {
          throw e.response!.data.toString();
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw e.message.toString();
      } else if (e.type == DioErrorType.cancel) {
        throw 'annuler';
      }
      throw Exception(connErr);
    } finally {
      dio.close();
    }
  }

  //dio get request
  Future get(url) async {
    finalUrl = '$API_URL$url';
    print('url : $finalUrl');

    try {
      await _getToken();
      response = await dio.get(finalUrl,
          options: Options(headers: _setHeaders()), cancelToken: apiToken);
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw "Api non trouvé";
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw "Erreur serveur interne";
        } else {
          throw e.response!.data.toString();
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw e.message.toString();
      } else if (e.type == DioErrorType.cancel) {
        throw 'annuler';
      }
      throw Exception(connErr);
    } finally {
      dio.close();
    }
  }
}
