import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'futureprovider_page.dart';
import 'todo_asyncinit_page.dart';
import 'todo_notifierprovider.dart';
import 'todo_statenotifierprovider.dart';


const String title = 'Riverpod 2';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.deepPurple,),
      home: const Scaffold(
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
                      PageButton('FutureProvider 2.0 (same)', const FutureProviderPage(), context),

                      const SizedBox(height: 10),
                      PageButton('Todo NotifierProvider 2.0', const TodoNotifierproviderPage(), context),

                      const SizedBox(height: 40),
                      PageButton('(Todo StateNotifierProvider)', const TodoStatenotifierproviderPage(), context),

                      const SizedBox(height: 10),
                      PageButton('(Todo async init (bug))', const TodoAsyncInitPage(), context),
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
