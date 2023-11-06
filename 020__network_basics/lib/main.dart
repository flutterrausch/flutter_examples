import 'package:flutter/material.dart';
import 'package:network_basics/http_page.dart';
import 'package:network_basics/dio_console_page.dart';

const String title = 'Network basics';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.deepPurple,),
      home: Scaffold(
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(title),
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
                      PageButton('Dio console', DioConsolePage(), context),
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
