import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network_basics/SECRETS/secrets.dart';  // see HttpPageManager()
import 'package:jwt_decode/jwt_decode.dart';


Future <String> dioConsoleCode() async {
  String retStr = '';

  var response;  // Response<Map>? response;
  BaseOptions options = BaseOptions(baseUrl: Secrets.urlPrefix,);
  var interceptors = InterceptorsWrapper(
      onError: (error, _) {debugPrint(error.message);},  // TODO response code handling class CustomInterceptors extends Interceptor  https://pub.dev/packages/dio
  //onRequest: (request, _) {print("${request.method} ${request.path}");}, // both fail
  //onResponse: (response, _) {print(response.data);}
  );

  Dio dio = Dio(options);
  dio.interceptors.add(interceptors);

  // post auth request
  try {
    response = await dio.post(
      Secrets.authPath,
      data: {"username": Secrets.usr, "password": Secrets.pwd},  // Dio: body -> data
    );
    //print(response.toString());  // response.data Map
    retStr += '$response\n\n';
  } catch (e) {  // NTH catch DioError
    debugPrint('caught: $e');
    retStr += '$e\n\n';
  }

  // get access token, to send Bearer later
  Map bodyJsons = response.data;  // dio returns an already decoded map
  final accessToken = bodyJsons['access'];  // jwt string
  //debugPrint('accessToken: $accessToken');

  // decode jwt - only needed for token refresh
  debugPrint('accessJsons = ${Jwt.parseJwt(accessToken)}');
  debugPrint('accessExpiryDate = ${Jwt.getExpiryDate(accessToken)}');
  debugPrint('accessExpired = ${Jwt.isExpired(accessToken)}');

  // get monitoring values using accessToken
  try {
    options.headers['Authorization'] = 'Bearer $accessToken';
    response = await dio.get(
      Secrets.monitoringValuesPath,
      queryParameters: {'start': '2022-01-01', 'end': '2022-12-31'},
    );
    retStr += '$response\n\n';
  } catch (e) {
    debugPrint('caught: $e');
    retStr += '$e\n\n';
  }

  return retStr;
}


class DioConsolePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Dio console'),),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('See debug log, also.'),
              const SizedBox(height: 20),
              AsyncWidget(),
            ],
          ),
        )
    );
  }
}


class AsyncWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return FutureBuilder<String>(
        future: dioConsoleCode(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!);  // ignore that it can be null
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        }
    );
  }
}
