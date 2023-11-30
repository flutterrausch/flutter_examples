import 'dart:convert';

import 'package:flutter/material.dart';


const convertTitle = "dart:convert";

Future<String> ConvertCode() async {
  String retStr = '';

  // deserialize json to map
  retStr += '* deserialize json to map:\n';
  String jsonString = '{"name":"John", "age":30, "city":"New York"}';
  Map<String, dynamic> user = jsonDecode(jsonString);
  retStr += 'Name: ${user['name']}\n';
  retStr += 'Age: ${user['age']}\n';
  retStr += 'City: ${user['city']}\n\n';

  // serialize map to json
  retStr += '* serialize map to json:\n';
  Map<String, dynamic> user2 = {
    'name': 'John',
    'age': 30,
    'city': 'New York'
  };
  String jsonString2 = jsonEncode(user2);
  retStr += '$jsonString2\n\n';
  
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
        future: ConvertCode(),
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
