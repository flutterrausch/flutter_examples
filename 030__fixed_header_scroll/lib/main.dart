import 'package:flutter/material.dart';
import 'package:fixed_header_scroll/listviewbuilder_page.dart';
import 'package:fixed_header_scroll/singlechildscrollview_page.dart';
import 'package:fixed_header_scroll/header_footer_page.dart';

const title = 'Fixed Header Scroll';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            PageButton('ListViewBuilder - ListTiles only', ListViewBuilderPage(), context),
            PageButton('SingleChildScrollView - any widgets', SingleChildScrollViewPage(), context),
            PageButton('Header & Footer + async data loading', HeaderFooterPage(), context),
          ],
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final String pageName;
  final Widget page;
  final BuildContext context;

  PageButton(this.pageName, this.page, this.context);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(pageName),
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => page),);},
    );
  }
}

class Description extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text('See debug log, and test returning to this page');
  }
}
