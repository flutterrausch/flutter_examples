import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network_basics/SECRETS/secrets.dart';  // see HttpPageManager()
import 'package:jwt_decode/jwt_decode.dart';


Future <String> dioConsoleStuff() async {
  String retStr;

  var response;  // Response<Map>? response;
  BaseOptions options = BaseOptions(baseUrl: Secrets.urlPrefix,);
  var interceptors = InterceptorsWrapper(
      onError: (error, _) {print(error.message);},  // TODO response code handling
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
    retStr = response.toString();
  } catch (e) {  // NTH catch DioError
    debugPrint('caught: ' + e.toString());
    retStr = e.toString();
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
    retStr = response.toString();
  } catch (e) {
    debugPrint('caught: ' + e.toString());
    retStr = e.toString();
  }

  return retStr;
}


class DioPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Dio'),),
        body: Center(
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text('Dio Page'),
                  const SizedBox(height: 50),
                  AsyncWidget(),
                ],
              ),
            ),
          ),
        )
    );
  }
}


class AsyncWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return FutureBuilder<String>(
        future: dioConsoleStuff(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!);  // ignore that it can be null
          } else {
            return const CircularProgressIndicator();
          }
        }
    );
  }
}
