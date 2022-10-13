import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:network_basics/SECRETS/secrets.dart';  // see HttpPageManager()

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
                  Text('Dio Page'),
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
        future: asyncFetch(),
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

Future <String> asyncFetch() async {
  var response;
  BaseOptions authOptions = BaseOptions(
    baseUrl: Secrets.urlPrefix,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  try {
    response = await Dio().get('http://www.google.com');
    print(response);
  } catch (e) {
    debugPrint(e.toString());
  }

  //await Future.delayed(Duration(seconds: 2));
  return response.toString();
}

