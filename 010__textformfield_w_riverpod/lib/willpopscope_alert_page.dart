import 'package:flutter/material.dart';
import 'package:textformfield_w_riverpod/backbutton_dialog.dart';

class WillPopScopeAlertPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => BackButtonDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Backbutton alert'),
        ),
        body: const Center(
          child: Text('Backbutton alert'),
        ),
      ),
    );
  }
}
