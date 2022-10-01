import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

import 'package:network_basics/SECRETS/secrets.dart';
// Create your own API secrets.dart like so:
// class Secrets {
//   static const String urlPrefix = 'https://your.api.url';
//   // auth
//   static const String authPath = '/auth/path/';
//   static const String usr = 'username';
//   static const String pwd = 'password';
//   // monitoring
//   static const String monitoringValuesPath = '/some/other/path/';
// }


class HomePageManager {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());

  Future<Response> _doAuth (String url, String usr, String pwd) async {
    final authUrl = Uri.parse(url);
    final headers = {'Content-type': 'application/json'};
    final body = '{"username": "$usr", "password": "$pwd"}';  // TODO validate input

    final response = await post(authUrl, headers: headers, body: body);  // TODO try catch, TODO if 200

    return response;
  }

  String _getAccessToken(Response response) {
    final bodyJsons = jsonDecode(response.body);  // TODO try catch
    final accessToken = bodyJsons['access'];  // jwt string

    // debugPrint('accessJsons = ${Jwt.parseJwt(accessToken)}');
    // debugPrint('accessExpiryDate = ${Jwt.getExpiryDate(accessToken)}');
    // debugPrint('accessExpired = ${Jwt.isExpired(accessToken)}');

    return accessToken;
  }


  Future<String> authGetAccessToken() async {
    return _getAccessToken(await _doAuth(Secrets.urlPrefix+Secrets.authPath, Secrets.usr, Secrets.pwd));
    }

  Future<void> postAuthRequest() async {
    resultNotifier.value = RequestLoadInProgress();

    final response = await _doAuth(Secrets.urlPrefix+Secrets.authPath, Secrets.usr, Secrets.pwd);
    final accessToken = _getAccessToken(response);
    //debugPrint('accessToken = $accessToken');

    _handleResponse(response, accessToken);
  }


  Future<void> getMonitoringValues() async {  // {required String start, required String end}  ?start=2022-01-01&end=2022-12-31
    resultNotifier.value = RequestLoadInProgress();

    final authResponse = await _doAuth(Secrets.urlPrefix+Secrets.authPath, Secrets.usr, Secrets.pwd);
    final accessToken = _getAccessToken(authResponse);
    debugPrint('accessToken = $accessToken');

    final start = '2022-01-01';
    final end = '2022-12-31';
    final url = Uri.parse(Secrets.urlPrefix+Secrets.monitoringValuesPath+'?start='+start+'&end='+end);
    debugPrint(Secrets.urlPrefix+Secrets.monitoringValuesPath+'?start='+start+'&end='+end);
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',};
    final response = await get(url, headers: headers);  // TODO http.get
    debugPrint('response = ' + response.statusCode.toString() + ' ' + response.body);
    final jsons = jsonDecode(response.body);
    print(jsons);  // debugPrint(jsons) throws exception..

    _handleResponse(response, '$start  -  $end');
  }

  // Textfield in app
  void _handleResponse(Response response, String str) {
    if (response.statusCode >= 400) {
      resultNotifier.value = RequestLoadFailure();
    } else {
      resultNotifier.value = RequestLoadSuccess(
          response.statusCode.toString() + '\n\n' +
          str + '\n\n' +
          response.body);
    }
  }
}

class RequestState {
  const RequestState();
}

class RequestInitial extends RequestState {}

class RequestLoadInProgress extends RequestState {}

class RequestLoadSuccess extends RequestState {
  const RequestLoadSuccess(this.body);
  final String body;
}

class RequestLoadFailure extends RequestState {}