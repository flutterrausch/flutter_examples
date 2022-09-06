import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textformfield_w_riverpod/on_changed_page.dart';
import 'package:textformfield_w_riverpod/controller_page.dart';
import 'package:textformfield_w_riverpod/state_provider_page.dart';
import 'package:textformfield_w_riverpod/form_state_provider_page.dart';
import 'package:textformfield_w_riverpod/future_one_page.dart';
import 'package:textformfield_w_riverpod/willpopscope_page.dart';
import 'package:textformfield_w_riverpod/willpopscope_alert_page.dart';
import 'package:textformfield_w_riverpod/details_setstate_page.dart';
import 'package:textformfield_w_riverpod/consumerstateful_page.dart';
import 'package:textformfield_w_riverpod/details_riverpod_page.dart';
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
        body: Column(
          children: [
            Expanded(  // make it scrollable
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [

                      const Text('Textfield basics:'),
                      PageButton('OnChanged', OnChangedPage(), context),
                      PageButton('TextEditingController', ControllerPage(), context),
                      const SizedBox(height: 20),

                      const Text('Riverpod:'),
                      PageButton('StateProvider', StateProviderPage(), context),
                      PageButton('Form StateProvider', FormStateProviderPage(), context),
                      ElevatedButton(
                        child: const Text('Future 1p push, back=cancel'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FutureOnePage()),)
                            .then((valFromPage) {  // receive data from subpage
                              debugPrint('completion = $valFromPage');
                              return const Text('hallo');
                            }
                          );
                        },
                      ),
                      //PageButton('Future 2p', FutureTwoPages(), context),
                      const SizedBox(height: 20),

                      const Text('Backbutton using WillPopScope:'),
                      PageButton('Backbutton disabled', WillPopScopePage(), context),
                      PageButton('Backbutton alert', WillPopScopeAlertPage(), context),
                      const SizedBox(height: 20),

                      const Text('∑ DetailsScreen:'),
                      PageButton('Details setState', const DetailsSetstatePage(), context),
                      PageButton('Riverpod ConsumerStateful basics', ConsumerStatefulPage(), context),
                      PageButton('Details riverpod', DetailsRiverpodPage(), context),

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

class Description extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Text('See debug log, and test returning to this page');
  }
}
