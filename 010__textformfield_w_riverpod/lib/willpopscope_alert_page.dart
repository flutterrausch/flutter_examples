import 'package:flutter/material.dart';

class WillPopScopeAlertPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPopAlert(context),
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

Future<bool> onWillPopAlert(context) async {
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to exit an App'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    ),
  )) ?? false;  // if null, return false = disable Backbutton
}
