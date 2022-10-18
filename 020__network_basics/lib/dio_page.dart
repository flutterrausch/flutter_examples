import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network_basics/SECRETS/secrets.dart';  // see HttpPageManager()
import 'package:jwt_decode/jwt_decode.dart';


Future <String> dioConsoleStuff() async {
  var response;  // Response<Map>? response;
  String retStr;
  BaseOptions authOptions = BaseOptions(
    baseUrl: Secrets.urlPrefix,
  );
  Dio dio = Dio(authOptions);

  dio.interceptors.add(InterceptorsWrapper(
    onError: (error, _) {print(error.message);},  // TODO response code handling
    //onRequest: (request, _) {print("${request.method} ${request.path}");}, // both fail
    //onResponse: (response, _) {print(response.data);}
  ));

  // post auth request
  try {
    response = await dio.post(
      Secrets.authPath,
      data: {"username": Secrets.usr, "password": Secrets.pwd},  // Dio: body -> data
    );
    print(response.toString());  // response.data
    retStr = response.toString();
  } catch (e) {
    debugPrint('caught: ' + e.toString());
    retStr = e.toString();
  }

  // get access token
  Map bodyJsons = response.data;  // no jsonDecode required, dio returns an already decoded map
  final accessToken = bodyJsons['access'];  // jwt string
  debugPrint('accessToken: $accessToken');

  debugPrint('accessJsons = ${Jwt.parseJwt(accessToken)}');
  debugPrint('accessExpiryDate = ${Jwt.getExpiryDate(accessToken)}');
  debugPrint('accessExpired = ${Jwt.isExpired(accessToken)}');



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
