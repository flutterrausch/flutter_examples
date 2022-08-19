import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/future_second_page.dart';

const seconds = 5;
Future<int> fetchApiValue() async {
  await Future.delayed(Duration(seconds: seconds));
  return 43;
}

final apiFutureProvider = FutureProvider<int>((ref) => fetchApiValue());  // TODO restarts on each import!
//FutureProvider<int>? apiFutureProvider;
//apiFutureProvider = FutureProvider<int>((ref) => fetchApiValue());
//apiFutureProvider = ((ref) => fetchApiValue());


class FutureTwoPages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future 2 Pages'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Text('Future starts now ($seconds sec) - simulating API access'),
            // const SizedBox(height: 50,),
            // Text('API val ='),
            const SizedBox(height: 50,),
            ElevatedButton(
              child: Text('To 2nd Page'),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => FutureSecondPage()),);},
            )
          ],
        ),
      ),
    );
  }
}
