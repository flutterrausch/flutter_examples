import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network_basics/SECRETS/secrets.dart';  // see HttpPageManager()
import 'package:jwt_decode/jwt_decode.dart';


Future <String> dioConsoleCode() async {
  String retStr = '';

  Response? response;
  BaseOptions options = BaseOptions(baseUrl: Secrets.urlPrefix,);
  var interceptors = InterceptorsWrapper(
      onError: (error, _) {debugPrint(error.message);},  // TODO response code handling class CustomInterceptors extends Interceptor  https://pub.dev/packages/dio
                                                         // or response.status
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
    //retStr += '$response\n\n';
  } catch (e) {  // NTH catch DioError
    debugPrint('caught: $e');
    retStr += '$e\n\n';
  }

  // get accessToken, to send Bearer later with each data request
  final String accessToken;
  if (response != null) {
    final Map bodyJsons = response.data; // dio returns an already decoded map
    accessToken = bodyJsons['access'];  // jwt string
  } else {
    accessToken = '';
  }

  // decode jwt - only needed for token refresh
  debugPrint('accessJsons = ${Jwt.parseJwt(accessToken)}');  // Map<String, dynamic>
  debugPrint('accessExpiryDate = ${Jwt.getExpiryDate(accessToken)}');
  debugPrint('accessExpired = ${Jwt.isExpired(accessToken)}');


  // get monitorings - which values are asked from the athlet in which timeframe (to write to API)
  try {
    options.headers['Authorization'] = 'Bearer $accessToken';
    response = await dio.get(
      Secrets.monitoringsPath,
    );
    retStr += '$response\n\n';
  } catch (e) {
    debugPrint('caught: $e');
    retStr += '$e\n\n';
  }

  final List monsList = response!.data ?? []; // NTH correct null safety?
  for (var monMap in monsList) {
    //print('$monMap');
    //monMap.forEach((k, v) {print('${k}: ${v}');});

    debugPrint(
        'id ${monMap["monitoring_id"]}  end ${monMap["end_date"]}'
    );

  }


  // get monitorings values using accessToken
  try {
    options.headers['Authorization'] = 'Bearer $accessToken';
    response = await dio.get(
      Secrets.monitoringsValuesPath,
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
  const DioConsolePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Dio console'),),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('See debug log, also.'),
              SizedBox(height: 20),
              AsyncWidget(),
            ],
          ),
        )
    );
  }
}


class AsyncWidget extends StatelessWidget {
  const AsyncWidget({super.key});

  @override
  Widget build(context) {
    return FutureBuilder<String>(
        future: dioConsoleCode(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!);  // ignore that it can be null
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}
