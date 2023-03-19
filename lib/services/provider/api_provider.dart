

import 'package:dio/dio.dart';
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
    if(box.hasData('token') && box.read('token') != null) {
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

  Future<http.Response> postData(apiUrl, data) async {
    await _getToken();
    final fullUrl = Uri.parse(API_URL + apiUrl);
    print('URL==$fullUrl');
    printInfo(info: 'DATA====>>  $data');
    return await http.post(fullUrl, body: data, headers: _setHeaders());
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
          throw e.response!.data.toString() ;
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


  Future<Response> putData(url, formData) async{
    await _getToken();
    finalUrl = "$API_URL$url";
    print('url : $finalUrl');
    print('postData : ${formData.toString()}');

    try{
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
          throw e.response!.data.toString() ;
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

  Future<Response> addNewAnnonce(url, formData, cancelToken) async{
    await _getToken();
    finalUrl = "$API_URL$url";
    print('url : $finalUrl');
    print('postData : ${formData.toString()}');

    try{
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["authorization"] = "Bearer $token";
      dio.options.headers['content-Type'] = 'multipart/form-data';
      dio.options.connectTimeout = 30000; //5s
      dio.options.receiveTimeout = 25000;

      return await dio.post(
          finalUrl,
          data: formData,
          cancelToken: cancelToken
      );
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw "Api not found";
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw "Internal Server Error ${e.toString()}";
        } else {
          throw e.response!.data.toString() ;
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
      dio.options.headers['authenticate_client'] = '427620db3b5aeffd7da95bff1e02c58e91f2b7c8394cabc1db92aabe2a918ded';
      dio.options.connectTimeout = 30000; //5s
      dio.options.receiveTimeout = 25000;

      return await dio.get(finalUrl, queryParameters: data, cancelToken: apiToken);
    } on DioError catch (e) {

      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw "Api non trouvé";
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw "Erreur serveur interne";
        } else {
          throw e.response!.data.toString() ;
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
      response = await dio.get(finalUrl, options: Options(headers: _setHeaders()), cancelToken: apiToken);
      return response.data;
    } on DioError catch (e) {

      if (e.type == DioErrorType.response) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == STATUS_NOT_FOUND) {
          throw "Api non trouvé";
        } else if (statusCode == STATUS_INTERNAL_ERROR) {
          throw "Erreur serveur interne";
        } else {
          throw e.response!.data.toString() ;
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