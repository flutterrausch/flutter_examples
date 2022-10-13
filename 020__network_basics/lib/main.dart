import 'package:flutter/material.dart';
import 'package:network_basics/http_page.dart';
import 'package:network_basics/dio_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DioPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Network basics'),
        ),
        body: Column(
          children: [
            Expanded(  // make it scrollable
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [

                      const SizedBox(height: 20),
                      PageButton('Http', HttpPage(), context),

                      const SizedBox(height: 20),
                      PageButton('Dio', DioPage(), context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}

class PageButton extends StatelessWidget {
  final String pageName;
  final Widget page;
  final BuildContext context;

  const PageButton(this.pageName, this.page, this.context);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(pageName),
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => page),);},
    );
  }
}
