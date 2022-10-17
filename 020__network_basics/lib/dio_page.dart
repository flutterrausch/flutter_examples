import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network_basics/SECRETS/secrets.dart';  // see HttpPageManager()


Future <String> dioConsoleStuff() async {
  var response;
  BaseOptions authOptions = BaseOptions(
    baseUrl: Secrets.urlPrefix,
    //connectTimeout: 5000,
    //receiveTimeout: 3000,
    //contentType: ContentType.json,
    //headers: {Headers.contentLengthHeader: 10,}
  );
  Dio dio = Dio(authOptions);

  try {
    // response = await dio.get('/');
    // print(response);

    response = await dio.post(
      Secrets.authPath,
      data: {"username": Secrets.usr, "password": Secrets.pwd},
    );
    print(response);

  } catch (e) {
    debugPrint(e.toString());
  }

  return response.toString();
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
