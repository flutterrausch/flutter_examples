import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod2/counter_stateprovider_page.dart';
import 'todo_asyncnotifierprovider_page.dart';
import 'todo_notifierprovider_page.dart';
import 'todo_statenotifierprovider_page.dart';
import 'wait_futureprovider_page.dart';

//import 'todo_asyncinit_page.dart';


const String title = 'Riverpod 2';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
                      const SizedBox(height: 40),
                      const Text('Riverpod 2.0:'),

                      const SizedBox(height: 10),
                      PageButton('StateProvider', const CounterStateproviderPage(), context),

                      const SizedBox(height: 10),
                      PageButton('FutureProvider (same)', const WaitFutureproviderPage(), context),

                      const SizedBox(height: 10),
                      PageButton('Todo NotifierProvider', const TodoNotifierproviderPage(), context),

                      const SizedBox(height: 10),
                      PageButton('Todo AsyncNotifierProvider', const TodoAsyncnotifierproviderPage(), context),


                      const SizedBox(height: 40),
                      const Text('Riverpod 1.0 syntax is partly still working:'),
                      const SizedBox(height: 10),
                      PageButton('Todo StateNotifierProvider', const TodoStatenotifierproviderPage(), context),

                      // buggy, don't show:
                      // const SizedBox(height: 10),
                      // PageButton('(Todo async init (bug))', const TodoAsyncInitPage(), context),
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

  const PageButton(this.pageName, this.page, this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(pageName),
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => page),);},
    );
  }
}
