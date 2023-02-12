

import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;

import '../../config/constants.dart';

class ApiProvider {

  Dio dio = Dio();
  late Response response;
  String connErr = 'check_internet_connection';
  static var client = http.Client();
  final apiToken = CancelToken();

  var token, finalUrl;

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };

  Future<Response> dioConnect(url, data) async {
    finalUrl = '$API_URL$url';
    print('url : $finalUrl');
    print('postData : $data');
    try {
      dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
      dio.options.headers['accept'] = 'application/json';
      dio.options.headers['authorization'] = 'Bearer $token';
      dio.options.headers['authenticate_client'] = '427620db3b5aeffd7da95bff1e02c58e91f2b7c8394cabc1db92aabe2a918ded';
      dio.options.connectTimeout = 30000; //5s
      dio.options.receiveTimeout = 25000;

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
}