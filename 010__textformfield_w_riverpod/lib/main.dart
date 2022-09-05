import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/on_changed_page.dart';
import 'package:textformfield_w_riverpod/controller_page.dart';
import 'package:textformfield_w_riverpod/state_provider_page.dart';
import 'package:textformfield_w_riverpod/form_state_provider_page.dart';
import 'package:textformfield_w_riverpod/future_one_page.dart';
import 'package:textformfield_w_riverpod/willpopscope_page.dart';
import 'package:textformfield_w_riverpod/willpopscope_alert_page.dart';
//import 'package:textformfield_w_riverpod/third_screen.dart';
//import 'package:textformfield_w_riverpod/future_two_pages.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    //Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TextFormField w Riverpod',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Textfields w Riverpod'),
        ),
        body: Center(
          child: Column(
            children: [
              PageButton('OnChanged', OnChangedPage(), context),
              PageButton('TextEditingController', ControllerPage(), context),
              PageButton('StateProvider', StateProviderPage(), context),
              PageButton('Form StateProvider', FormStateProviderPage(), context),

              ElevatedButton(
                child: Text('Future 1p push, back=cancel'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FutureOnePage()),)
                    .then((valFromPage) {  // receive data from subpage
                      print('completion = $valFromPage');
                      return Text('hallo');
                    }
                  );
                },
              ),

              PageButton('Backbutton disabled', WillPopScopePage(), context),
              PageButton('Backbutton alert', WillPopScopeAlertPage(), context),
              //PageButton('3rd screen', ThirdScreen(), context),

              //PageButton('Future 2p', FutureTwoPages(), context),
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
