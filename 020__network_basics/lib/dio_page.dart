import 'package:flutter/material.dart';
import 'package:network_basics/dio_class.dart';

class DioPage extends StatelessWidget {
  final dioClass = DioClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Dio'),),
        body: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Wrap(
                spacing: 50,
                alignment: WrapAlignment.center,
                children: [

                  ElevatedButton(
                    onPressed: dioClass.getHttp,
                    child: Text('getHttp'),
                  ),


                ],
              ),
            ),

          ],
        )
    );
  }
}
