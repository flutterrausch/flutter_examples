import 'dart:convert';

import 'package:flutter/material.dart';


const convertTitle = "dart:convert";

Future<String> convertCode() async {
  String retStr = '';

  // deserialize json to map
  retStr += '* deserialize / decode json to map:\n';  // / parse 
  String jsonString = '{"name":"John", "age":30, "city":"New York"}';
  Map<String, dynamic> user = jsonDecode(jsonString);  // var user behaves same as Map
  retStr += '${user.runtimeType}: $user\n\n';
  
  // serialize map to json
  retStr += '* serialize / encode map to json:\n';
  Map<String, dynamic> users2 = {
    'users':
    [
      {
        'name': 'John',
        'age': 30,
        'city': 'New York'
      },
      {
        'name': 'Tom',
        'age': 25,
        'city': 'Chicago'
      },
    ]
  };
  retStr += '${jsonEncode(users2)}\n\n';
  return retStr;
}


class ConvertPage extends StatelessWidget {
  const ConvertPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(convertTitle),),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 20),
                // Text('See debug log, also.'),
                // SizedBox(height: 20),
                AsyncWidget(),
              ],
            ),
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
        future: convertCode(),
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
